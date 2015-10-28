module View (view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Signal
import Update exposing (Action)
import Model exposing (Model)

import Debug

view : Signal.Address Action -> Model -> Html
view address model =
  div 
    [] 
    [ viewTable address model
    , node "link" 
      [ rel "stylesheet"
      , type' "text/css" 
      , href "theme.css" 
      ]
      []
    ]


viewTable : Signal.Address Action -> Model -> Html
viewTable address model =
  table 
    []
    [ tbody 
      [] 
      (viewTableRows address model) 
    ]

viewTableRows : Signal.Address Action -> Model -> List Html
viewTableRows address model =
  let
    rows =
      []

    currentRow rows =
      model.numberOfRows - (List.length rows)

    createAnotherRow rows =
      if List.length rows == model.numberOfRows then
        rows
      else
        rows
          |> (::) (viewTableRow (currentRow rows) address model)
          |> createAnotherRow
  in
    createAnotherRow rows


viewTableRow : Int -> Signal.Address Action -> Model -> Html
viewTableRow rowInd address model =
  tr
    [ id ("row" ++ (toString rowInd)) ]
    (viewTableCells rowInd address model)


viewTableCells : Int -> Signal.Address Action -> Model -> List Html
viewTableCells rowInd address model =
  let
    cols =
      []

    currentCol cols =
      model.numberOfCols - (List.length cols)

    createAnotherCol cols =
      if List.length cols == model.numberOfCols then
        cols
      else
        cols
          |> (::) (viewTableCell rowInd (currentCol cols) address model)
          |> createAnotherCol
  in
    createAnotherCol cols


viewTableCell : Int -> Int -> Signal.Address Action -> Model -> Html
viewTableCell rowInd colInd address model =
  let
    classes = 
      classList
        [ ("col" ++ (toString colInd), True)
        , ("alive",     alive)
        , ("not-alive", not alive)
        ]

    coords = 
      (rowInd, colInd)

    alive =
      model.coordsLife
        |> List.member coords
  in
    td 
      [ classes ]
      []
