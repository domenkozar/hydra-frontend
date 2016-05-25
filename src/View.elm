module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Maybe
import List

import Msg exposing (..)
import Models exposing (..)
import LiveSearch
import Views.Project exposing (projectView)
import Views.Navbar exposing (navbarView)
import Utils exposing (..)


view : AppModel -> Html Msg
view model =
  let
    projects = List.map projectView (LiveSearch.search model.projects)
  in div
    []
    [ navbarView model
    , div
      [ class "container" ]
      -- TODO: breadcrumbs
      ([ alertView model.alert
      , h1
          []
          [ text "Projects "
          , button
              [ type' "submit"
              , class "btn btn-primary" ]
              [ fontAwesome "plus-circle fa-lg"
              , text " New" ]
          ]
      , br [] []
      ] ++ if List.isEmpty projects
           then [ p
                    [ class "text-center lead" ]
                    [ text "Zero projects. Maybe add one?" ] ]
           else projects ++
      [ footer
        [ class "text-center" ]
        [ small
          []
          [ a
              [ href "http://nixos.org/hydra/" ]
              [ text "Hydra " ]
          , span
              []
              [ text model.hydraConfig.hydraVersion ]
          , p
              []
              [ a
                  [ href "http://nixos.org/nix/" ]
                  [ text "Nix " ]
              , span
                  []
                  [ text model.hydraConfig.nixVersion ]
              ]
          ]
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
