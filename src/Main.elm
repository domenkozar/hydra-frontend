module Main exposing (..)

import Html.App as Html
import Task
import Http
import Json.Decode as Json
import Json.Decode exposing ((:=))

import Msg exposing (..)
import Models exposing (..)
import Update exposing (..)
import View exposing (..)


init : ( AppModel, Cmd Msg )
init = ( initialModel, Cmd.batch [ title "Projects"
                                 , doInit ] )


doInit : Cmd Msg
doInit =
  Task.perform FetchFail FetchSucceed (Http.get decodeInit "/api/init")

decodeInit : Json.Decoder (String)
decodeInit = Json.succeed "a"
--  Json.list (Json.succeed Event
--    |: ("id" := Json.int)
--    |: ("title" := Json.string)
--  )

main : Program Never
main =
  Html.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

subscriptions : AppModel -> Sub Msg
subscriptions model =
  Sub.none
