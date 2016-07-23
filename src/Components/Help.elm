module Components.Help exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (Msg)
import Utils exposing (fontAwesomeAttrs)


{-| Uses ports to communicate with jQuery and initialize twitter
    bootstrap popover plugin. Each help element is a questionmark
    icon which on popover shows some help text.
-}
popoverHelp : String -> Html Msg
popoverHelp msg =
    span [ style [("margin", "0 6px")] ]
        [ fontAwesomeAttrs "question-circle fa-lg"
            [ style [ ( "color", "#0088CC" ) ]
            , attribute "data-toggle" "popover"
            , attribute "data-placement" "auto top"
            , attribute "data-trigger" "hover"
            , attribute "data-content" msg
            , attribute "title" "Help"
            ]
        ]

projectHelp : Html Msg
projectHelp =
    popoverHelp ""

jobsetHelp : Html Msg
jobsetHelp =
    popoverHelp "Jobsets evaluate a Nix expression and provide an overview of successful/failed builds."


evaluationHelp : Html Msg
evaluationHelp =
    popoverHelp ""


buildHelp : Html Msg
buildHelp =
    popoverHelp ""


buildStepHelp : Html Msg
buildStepHelp =
    popoverHelp ""
