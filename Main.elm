import Html exposing (div, button, text)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp

import Model exposing (model)
import Update exposing (update)
import View exposing (view)


main =
  StartApp.start { model = model, view = view, update = update }
