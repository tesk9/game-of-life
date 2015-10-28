module Update (update, Action(..)) where

import Effects exposing (Effects, Never)

import Model exposing (Model)
import Debug

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)
    SetLifeBeginning beginningCoords ->
      ({ model | coordsLife <- (beginningCoords :: model.coordsLife) }, Effects.none)
    Reproduce ->
      let
        getLivingNeighbors : (Int, Int) -> List (Int, Int)
        getLivingNeighbors (x,y) =
          if (List.member (x + 1, y + 1) model.coordsLife) then
            [ (x + 1, y)
            , (x - 1, y)
            ]
          else if (List.member (x, y + 2) model.coordsLife) then
            [ (x, y + 1) ]
          else if (List.member (x + 2, y) model.coordsLife) then
            [ (x + 1, y) ]
          else
            []

        limitToGridSize : (Int, Int) -> Bool
        limitToGridSize (x,y) =
            x > 0 && x <= model.numberOfRows && y > 0 && y <= model.numberOfCols

        newCoordsLife : List (Int, Int)
        newCoordsLife =
          model.coordsLife
            |> List.concatMap getLivingNeighbors
            |> List.filter limitToGridSize
      in
        ({ model | coordsLife <- newCoordsLife }, Effects.none)

type Action
  = NoOp
  | SetLifeBeginning (Int, Int)
  | Reproduce