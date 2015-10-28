module Update (update, Action(..)) where

import Model exposing (Model)
import Debug

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    SetLifeBeginning beginningCoords ->
      { model | coordsLife <- (beginningCoords :: model.coordsLife) }
    Reproduce ->
      Debug.log "Repro" model

type Action
  = NoOp
  | SetLifeBeginning (Int, Int)
  | Reproduce