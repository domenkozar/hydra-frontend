module Utils exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json
import Material.Elevation as Elevation
import Material.Button as Button
import Material.Icon as Icon
import Material.Options as Options
import Msg exposing (..)
import Urls exposing (..)
import Models exposing (..)


menuIcon : String -> Html Msg
menuIcon name =
  Icon.view name [ Options.css "width" "40px" ]


onPreventDefaultClick : msg -> Attribute msg
onPreventDefaultClick message =
  onWithOptions "click" { defaultOptions | preventDefault = True } (Json.succeed message)


onClickPage : Page -> List (Attribute Msg)
onClickPage page =
  [ style [("pointer", "cursor")]
  , href (pageToURL page)
  , onPreventDefaultClick (NewPage page)
  ]


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
    [ Options.div
      [ Elevation.e2
      , Options.css "padding" "40px"
      , Options.center
      ]
      [ text reason ]
    ]


renderHeader : AppModel -> String -> Maybe String -> Maybe Page -> List (Html Msg)
renderHeader model name subname page =
    let
        subnameHtml = case subname of
          Nothing -> []
          Just s -> [ small [ style [ ( "margin-left", "10px" ) ]]
                            [ text s ]]
        pageHtml =  case page of
          Nothing -> []
          Just p -> [
            Button.render Mdl [2] model.mdl
              [ Button.fab
              , Button.colored
              , Button.onClick (NewPage p)
              , Options.css "margin-left" "20px"
              ]
              [ Icon.i "add"]
          ]
    in
        [ h1
            [ style [ ( "margin-bottom", "30px" ) ] ]
            ([ text name ] ++ subnameHtml ++ pageHtml)
        ]
