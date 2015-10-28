module Model (Model, model) where

model : Model
model =
  Model 50 50 [(10,2), (2,3), (1,1)]

type alias Model =
  { numberOfRows : Int
  , numberOfCols : Int
  , coordsLife   : List (Int, Int)
  }
