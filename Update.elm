module Update (update, Action(..)) where

import Effects exposing (Effects, Never)

import Model exposing (Model)

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)
    SetLifeBeginning beginningCoords ->
      ({ model | coordsLife <- (beginningCoords :: model.coordsLife) }, Effects.none)
    Reproduce time ->
      let
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

        limitToGridSize (x,y) =
            x > 0 && x <= model.numberOfRows && y > 0 && y <= model.numberOfCols

        newCoordsLife =
          model.coordsLife
            |> List.concatMap getLivingNeighbors
            |> List.filter limitToGridSize

        newModel =
          { model | coordsLife <- newCoordsLife }
      in
        (newModel, Effects.tick Reproduce)


type Action
  = NoOp
  | SetLifeBeginning (Int, Int)
  | Reproduce Float
