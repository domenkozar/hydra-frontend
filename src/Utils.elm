module Utils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Msg exposing (..)
import Page exposing (Page)
import Urls exposing (onClickPage)


fontAwesome : String -> Html Msg
fontAwesome className =
    fontAwesomeAttrs className []


fontAwesomeAttrs : String -> List (Attribute a) -> Html a
fontAwesomeAttrs className attrs =
    i
        ([ class ("fa fa-" ++ className)
         , attribute "aria-hideen" "true"
         , style [("margin-right", "6px")]
         ]
            ++ attrs
        )
        []


optionalTag : Bool -> Html Msg -> Html Msg
optionalTag doInclude html =
    if doInclude then
        html
    else
        text ""


statusLabels : Int -> Int -> Int -> List (Html Msg)
statusLabels succeeded failed queued =
  [ optionalTag (succeeded > 0)
      (span [ class "label label-success"
            , title "Jobs succeeded" ]
          [ text (toString succeeded) ]
      )
  , optionalTag (failed > 0)
      (span []
          [ text " " ]
      )
  , optionalTag (failed > 0)
      (span [ class "label label-danger"
            , title "Jobs failed" ]
          [ text (toString failed) ]
      )
  , optionalTag (queued > 0)
      (span []
          [ text " " ]
      )
  , optionalTag (queued > 0)
      (span [ class "label label-default"
            , title "Jobs in queue" ]
          [ text (toString queued) ]
      )
  ]

render404 : String -> List (Html Msg)
render404 reason =
    [ p [ class "text-center lead well" ]
        [ text reason ]
    ]


renderHeader : String -> Maybe String -> Maybe Page.Page -> List (Html Msg)
renderHeader name subname page =
    let
        subnameHtml = case subname of
          Nothing -> []
          Just s -> [ small [ style [ ( "margin-left", "10px" ) ]]
                            [ text s ]]
        pageHtml =  case page of
          Nothing -> []
          Just p -> [ button
              ([ type' "submit"
              , class "btn btn-primary"
              , style [ ( "margin-left", "10px" ) ]
              ] ++ (onClickPage p))
              [ fontAwesome "plus-circle fa-lg"
              , text "New"
              ]
          ]
    in
        [ h1
            [ style [ ( "margin-bottom", "30px" ) ] ]
            ([ text name ] ++ subnameHtml ++ pageHtml)
        ]
