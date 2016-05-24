module ExtraEvents exposing (..)

import Json.Decode as Json
import Html exposing (..)
import Html.Events exposing (..)


onKeyPress : (Int -> msg) -> Attribute msg
onKeyPress tagger =
  on "keyup" (Json.map tagger keyCode)
