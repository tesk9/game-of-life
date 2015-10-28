module Model (Model, init) where

import Effects exposing (Effects, Never)

type alias Model =
  { numberOfRows    : Int
  , numberOfCols    : Int
  , coordsLife      : List (Int, Int)
  , prevClockTime   : Maybe Int
  , frameDuration   : Int
  }


init : (Model, Effects a)
init =
  (Model 20 20 [] Nothing 1, Effects.none)