module Model (Model, model) where

model : Model
model =
  Model 50 50 []

type alias Model =
  { numberOfRows : Int
  , numberOfCols : Int
  , coordsLife   : List (Int, Int)
  }
