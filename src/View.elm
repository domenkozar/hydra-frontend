module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Maybe
import List

import Msg exposing (Msg)
import Models exposing (..)
import Views.Project exposing (projectView, projectsView, newProjectView)
import Views.Navbar exposing (navbarView)
import Page exposing (..)
import Utils exposing (..)


view : AppModel -> Html Msg
view model =
  div
    []
    [ navbarView model
    , div
      [ class "container" ]
      -- TODO: breadcrumbs
      [ (alertView model.alert)
      , div
          [ class "row" ]
          (pageToView model)
      , footer
        [ class "text-center"
        , style [("margin-top", "30px")] ]
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
      ]
    ]


pageToView : AppModel -> List (Html Msg)
pageToView model =
  case model.currentPage of
    Home ->
      projectsView model.projects
    Project name ->
      case List.head (List.filter (\p -> p.name == name) model.projects) of
        Just project -> projectView project
        Nothing -> render404 ("Project " ++ name ++ " does not exist.")
    NewProject ->
      newProjectView model
    Jobset project jobset ->
      []


alertView : Maybe Alert -> Html Msg
alertView alert =
  case alert of
    Nothing -> div [] []
    Just value ->
      let
        kind = case value.kind of
          Danger -> "danger"
          Success -> "success"
          Info -> "info"
          Warning -> "warning"
      in div
           [ class ("alert alert-" ++ kind) ]
           [ text ("Error: " ++ value.msg) ]
