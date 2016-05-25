module ExtraEvents exposing (..)

import Json.Decode as Json
import Html exposing (..)
import Html.Events exposing (..)


onEscape : msg -> Attribute msg
onEscape msg =
  on "keydown" (Json.map (always msg) (Json.customDecoder keyCode isEscape))


isEscape : Int -> Result String ()
isEscape code =
  case code of
    13 -> Ok ()
    _ -> Err "not the right key code"
