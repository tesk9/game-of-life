import Effects exposing (Never)
import Task exposing (Task)
import StartApp as StartApp

import Model exposing (init)
import Update exposing (update)
import View exposing (view)

import Time exposing (delay, millisecond)

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  delay (500 * millisecond) app.tasks

