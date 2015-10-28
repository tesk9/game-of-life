import Effects exposing (Never)
import Task exposing (Task)
import StartApp as StartApp

import Model exposing (init)
import Update exposing (update)
import View exposing (view)


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
  app.tasks

