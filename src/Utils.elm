module Utils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Msg exposing (..)


glyphicon : String -> Html Msg
glyphicon kind
  = span
      [ class ("glyphicon glyphicon-" ++ kind)
      , attribute "aria-hiden" "true"
      ]
      []


optionalTag : Bool -> Html Msg -> Html Msg
optionalTag doInclude html
  = if doInclude
    then html else text ""
