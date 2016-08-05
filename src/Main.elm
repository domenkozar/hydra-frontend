module Main exposing (..)

import Http
import Task
import Json.Decode as Json
import Json.Decode exposing ((:=))
import Navigation

import Msg exposing (..)
import Models exposing (..)
import Page exposing (Page)
import Update exposing (..)
import View exposing (..)
import Urls exposing (urlParser)


init : Result String Page -> ( AppModel, Cmd Msg )
init result =
    let
        ( model, cmds ) =
            urlUpdate result initialModel
    in
        model ! [ doInit, cmds ]


doInit : Cmd Msg
doInit =
    Task.perform FetchFail FetchSucceed (Http.get decodeInit "/api/init")


decodeInit : Json.Decoder (String)
decodeInit =
    Json.succeed "a"



--  Json.list (Json.succeed Event
--    |: ("id" := Json.int)
--    |: ("title" := Json.string)
--  )


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    Navigation.program (Navigation.makeParser urlParser)
        { init = init
        , update = update
        , view = view
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
