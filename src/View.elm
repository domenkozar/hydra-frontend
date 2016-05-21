module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Maybe
import List

import Msg exposing (..)
import Models exposing (..)
import Views.Project exposing (projectView)
import Views.Navbar exposing (navbarView)


view : AppModel -> Html Msg
view model =
  div
    []
    [ navbarView model
    , div
      [ class "container" ]
      -- TODO: breadcrumbs
      ([ alertView model.alert
      , h1
          []
          [ text "Projects"]
      , br [] []
      ] ++ (List.map projectView model.projects) ++
      [ footer
        [ class "text-center" ]
        [ small
          []
          [ a
              [ href "http://nixos.org/hydra/" ]
              [ text "Hydra" ]
          , em
              []
              [ text " 0.1.1234.abcdef"]
          , text " (using nix-1.12pre1234_abcdef)"]
        ]
      ])
    ]

alertView : Maybe Alert -> Html Msg
alertView alert =
  case alert of
    Nothing -> div [] []
    Just value ->
      div
      [ class ("alert alert-" ++ value.kind) ]
      [ text ("Error: " ++ value.msg) ]
