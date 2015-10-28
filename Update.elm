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
      (model, Effects.none)

type Action
  = NoOp
  | SetLifeBeginning (Int, Int)
  | Reproduce