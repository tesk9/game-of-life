module View (view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal
import Update exposing (Action(..))
import Model exposing (Model)


view : Signal.Address Action -> Model -> Html
view address model =
  div 
    [] 
    [ viewTitle
    , viewTable address model
    , node "link" 
      [ rel "stylesheet"
      , type' "text/css" 
      , href "theme.css" 
      ]
      []
    , viewStartButton address model
    ]


viewTitle : Html
viewTitle =
  h2 [] [ text "Game of Life in Elm" ]


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
      [ classes 
      , onClick address (SetLifeBeginning coords)
      ]
      []


viewStartButton : Signal.Address Action -> Model -> Html
viewStartButton address model =
  button [ onClick address (Reproduce 0) ] [ text "Begin" ]
