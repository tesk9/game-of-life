module Model (Model, model) where

model : Model
model =
  Model 20 20 []

type alias Model =
  { numberOfRows : Int
  , numberOfCols : Int
  , coordsLife   : List (Int, Int)
  }
