module Model (Model, init, AnimationState(..)) where

import Effects exposing (Effects, Never)

type alias Model =
  { numberOfRows    : Int
  , numberOfCols    : Int
  , coordsLife      : List (Int, Int)
  , state           : AnimationState
  }


init : (Model, Effects a)
init =
  (Model 20 20 [] Stable, Effects.none)


type AnimationState
  = Animating
  | Stable