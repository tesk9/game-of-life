module Update (update, Action(..)) where

import Model exposing (Model)

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    SetLifeBeginning beginningCoords ->
      { model | coordsLife <- (beginningCoords :: model.coordsLife) }

type Action
  = NoOp
  | SetLifeBeginning (Int, Int)