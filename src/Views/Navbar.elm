module Views.Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Msg exposing (..)
import Models exposing (AppModel)


navbarView : AppModel -> Html Msg
navbarView model =
  nav
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
                            [ text "123" ]
                        , text " out of "
                        , span
                            [ class "label label-default" ]
                            [ text "23045" ]
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
                                    [ text "123" ]
                                ]
                            ]
                        , li
                            []
                            [ a
                                [ href "#" ]
                                [ text "Queue summary "
                                , span
                                    [ class "label label-default" ]
                                    [ text "23045" ]
                                ]
                            ]
                        , li
                            []
                            [ a
                                [ href "#" ]
                                [ text "Machines summary "
                                , span
                                    [ class "label label-info" ]
                                    [ text "12" ]
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
                [ li [ class "dropdown" ]
                    [ a
                        [ attribute "aria-expanded" "false"
                        , attribute "aria-haspopup" "true"
                        , class "dropdown-toggle"
                        , attribute "data-toggle" "dropdown"
                        , href "#"
                        , attribute "role" "button" ]
                        [ text "Sign in "
                        , span [ class "caret" ]
                            []
                        ]
                    , ul [ class "dropdown-menu" ]
                        [ li
                            []
                            [ a [ href "#" ]
                                [ text "using Google" ]
                            ]
                        , li
                            []
                            [ a
                                [ href "#" ]
                                [ text "using Hydra"]
                            ]
                        ]
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
                    [ text "Submit" ]
                ]
            ]
        ]
    ]
