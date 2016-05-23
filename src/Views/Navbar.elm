module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Msg exposing (..)
import Models exposing (AppModel)
import Utils exposing (..)


navbarView : AppModel -> Html Msg
navbarView model =
  let
    dropdownText = case model.user of
      Nothing ->
        [ text "Sign in" ]
      Just user ->
        [ fontAwesome "user fa-lg"
        , text (" " ++ user.name)
        ]
    dropdownButtons = case model.user of
      Nothing ->
        [ li
            []
            [ a
                [ onClick (LoginUserClick Google) ]
                [ text "using Google" ]
            ]
        , li
            []
            [ a
                [ onClick (LoginUserClick Hydra) ]
                [ text "using Hydra"]
            ]
        ]
      Just user ->
        [ li
            []
            [ a
                [ onClick PreferencesClick ]
                [ fontAwesome "edit fa-lg"
                , text " Preferences" ]
            ]
        , li
            []
            [ a
                [ onClick LogoutUserClick ]
                [ fontAwesomeAttrs "power-off fa-lg" [ style [("color", "red")]]
                , text " Sign out" ]

            ]
        ]

  in nav
    [ class "navbar navbar-fixed-top navbar-default"
    , attribute "role" "navigation"
    ]
    [ div
        [ class "container" ]
        [ div
            [ class "navbar-header" ]
            [ button
              [ class "navbar-toggle"
              , attribute "data-target" ".navbar-ex1-collapse"
              , attribute "data-toggle" "collapse"
              , type' "button"
              ]
              [ span
                  [ class "sr-only" ]
                  [ text "Toggle navigation" ]
              , span
                  [ class "icon-bar" ]
                  []
              , span
                  [ class "icon-bar" ]
                  []
              , span
                  [ class "icon-bar" ]
                  []
              ]
            , a
              [ class "navbar-brand"
              , href "c.uri_for(c.controller('Root').action_for('index'))"
              , style [("padding", "0")]
              ]
              [ if model.hydraConfig.logo == ""
                then text "Hydra"
                else img
                       [ src model.hydraConfig.logo
                       , alt "Hydra Logo"
                       , class "logo"
                       , style [("height", "37px"), ("margin", "5px")]
                       ]
                       []
              ]
            ]
        , div
            [ class "collapse navbar-collapse navbar-ex1-collapse" ]
            [ ul
                [ class "nav navbar-nav" ]
                [ li [ class "dropdown" ]
                    [ a
                        [ attribute "aria-expanded" "false"
                        , attribute "aria-haspopup" "true"
                        , class "dropdown-toggle"
                        , attribute "data-toggle" "dropdown"
                        , href "#"
                        , attribute "role" "button"
                        ]
                        [ text "Building "
                        , span
                            [ class "label label-primary" ]
                            [ text (toString model.queueStats.numBuilding) ]
                        , text " out of "
                        , span
                            [ class "label label-default" ]
                            [ text (toString model.queueStats.numWaiting) ]
                        , span
                            []
                            [ text " " ]
                        , span
                            [ class "caret" ]
                            []
                        ]
                    , ul [ class "dropdown-menu" ]
                        [ li
                            []
                            [ a [ href "#" ]
                                [ text "Builds in progress "
                                , span
                                    [ class "label label-primary" ]
                                    [ text (toString model.queueStats.numBuilding) ]
                                ]
                            ]
                        , li
                            []
                            [ a
                                [ href "#" ]
                                [ text "Queue summary "
                                , span
                                    [ class "label label-default" ]
                                    [ text (toString model.queueStats.numWaiting) ]
                                ]
                            ]
                        , li
                            []
                            [ a
                                [ href "#" ]
                                [ text "Machines summary "
                                , span
                                    [ class "label label-info" ]
                                    [ text (toString model.queueStats.numMachines) ]
                                ]
                            ]
                        , li
                            [ attribute "role" "separator"
                            , class "divider" ]
                            []
                        , li
                            []
                            [ a
                                [ href "#" ]
                                [ text "Latest evaluations" ]
                            ]
                        , li
                            []
                            [ a
                                [ href "#" ]
                                [ text "Latest builds" ]
                            ]
                        , li
                            []
                            [ a
                                [ href "#" ]
                                [ text "Latest steps" ]
                            ]
                        ]
                    ]
                ]
            , ul
              [ class "nav navbar-nav navbar-right" ]
              [ li
                  [ class "dropdown" ]
                  [ a
                      [ attribute "aria-expanded" "false"
                      , attribute "aria-haspopup" "true"
                      , class "dropdown-toggle"
                      , attribute "data-toggle" "dropdown"
                      , href "#"
                      , attribute "role" "button" ]
                      (dropdownText
                       ++ [ span
                            [ class "caret" ]
                            []
                      ])
                  , ul
                      [ class "dropdown-menu" ]
                      dropdownButtons
                  ]
              ]
            , Html.form
                [ class "nav navbar-form navbar-right"
                , attribute "role" "search"
                ]
                [ div
                  [ class "form-group" ]
                  [ input
                    [ type' "text"
                    , class "form-control"
                    , placeholder "Search" ]
                    []
                  ]
                , button
                    [ type' "submit"
                    , class "btn btn-default" ]
                    [ fontAwesome "search fa-lg" ]
                ]
            ]
        ]
    ]
