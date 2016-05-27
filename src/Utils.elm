module Utils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Msg exposing (..)


fontAwesome : String -> Html Msg
fontAwesome className
  = fontAwesomeAttrs className []


fontAwesomeAttrs : String -> List (Attribute a) -> Html a
fontAwesomeAttrs className attrs
   = i ([ class ("fa fa-" ++ className)
       , attribute "aria-hideen" "true" ] ++ attrs)
       []

optionalTag : Bool -> Html Msg -> Html Msg
optionalTag doInclude html
  = if doInclude
    then html else text ""


render404 : String -> List (Html Msg)
render404 reason =
  [ p
    [ class "text-center lead"]
    [ text reason ]
  ]
