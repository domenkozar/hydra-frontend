module Views.Project exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List

import Msg exposing (..)
import Models exposing (Project)
import Page exposing (Page)
import LiveSearch
import Utils exposing (..)
import Components.Help exposing (..)


projectsView : List Project -> List (Html Msg)
projectsView projects =
    let
      newprojects = List.map renderProject (LiveSearch.search projects)
    in
    [ h1
        [ style [("margin-bottom", "30px")]]
        [ text "Projects "
        , button
            [ type' "submit"
            , class "btn btn-primary" ]
            [ fontAwesome "plus-circle fa-lg"
            , text " New" ]
        ]
    ] ++ if List.isEmpty newprojects
         then render404 "Zero projects. Maybe add one?"
         else newprojects

projectView : Project -> List (Html Msg)
projectView project = [renderProject project]


renderProject : Project -> Html Msg
renderProject project =
  div
    [ class "panel panel-default" ]
    [ a
      [ class "panel-heading clearfix btn-block"
      , onClick (NewPage (Page.Project project.name)) ]
      [ span
        [ class "lead" ]
        [ text (project.name ++ " ") ]
      , small
        [ class "hidden-xs"]
        [ text ("(" ++ project.description ++ ")") ]
      , div
        [ attribute "aria-label" "..."
        , class "btn-group pull-right"
        , attribute "role" "group" ]
        [ div [ class "btn-group", attribute "role" "group" ]
          [ button
            [ attribute "aria-expanded" "false"
            , attribute "aria-haspopup" "true"
            , class "btn btn-primary dropdown-toggle"
            , attribute "data-toggle" "dropdown"
            , type' "button" ]
            [ text "Actions          "
            , span
              [ class "caret" ]
              []
            ]
          , ul
            [ class "dropdown-menu" ]
            [ li
              []
              [ a
                [ href "#" ]
                [ fontAwesomeAttrs "trash fa-lg" [ style [("color", "red")]]
                , text " Delete the project"
                ]
              ]
            , li
              []
              [ a
                [ href "#" ]
                [ fontAwesomeAttrs "plus-circle fa-lg" [ style [("color", "green")]]
                , text " Add a jobset"
                ]
              ]
            ]
          ]
        , button
          [ class "btn btn-default"
          , type' "button" ]
          [ text "Configuration "
          , fontAwesome "cog fa-lg"
          ]
        ]
      ]
    , if List.isEmpty project.jobsets
      then p [ class "text-center", style [("margin", "20px")]] [text "No Jobsets configured yet."]
      else table
        [ class "table table-hover" ]
        ([ thead
              []
              [ tr
                  []
                  [ th
                    [ style [("width", "15%"), ("min-width", "85px")]]
                    [ strong []
                      [ text "Jobset"
                      , popoverJobsetHelp
                      ]
                    ]
                  , th
                    [ style [("width", "40%")]]
                    [ strong []
                      [ text "Description" ]
                    ]
                  , th
                    [ style [("width", "15%")]]
                    [ strong []
                      [ text "Build status" ]
                    ]
                  , th
                    [ style [("width", "30%")]]
                    [ strong []
                      [ text "Last evaluation" ]
                    ]

                  ]
              ]
        ] ++ ([tbody [] (List.map (\jobset ->
          tr
            []
            [ td []
              [ a
                [ href jobset.id ]
                [ text jobset.name ]
              ]
            , td []
              [ text jobset.description ]
            , td
                []
                [ optionalTag (jobset.succeeded > 0)
                   (span
                    [ class "label label-success" ]
                    [ text (toString jobset.succeeded) ])
                , optionalTag (jobset.failed > 0)
                    (span
                    []
                    [ text " " ])
                , optionalTag (jobset.failed > 0)
                    (span
                    [ class "label label-danger" ]
                    [ text (toString jobset.failed) ])
                , optionalTag (jobset.queued > 0)
                    (span
                    []
                    [ text " " ])
                , optionalTag (jobset.queued > 0)
                    (span
                    [ class "label label-default" ]
                    [ text (toString jobset.queued) ])
              ]
            , td []
              [ text jobset.lastEvaluation ]
            ]) (LiveSearch.search project.jobsets))])
        )
    ]
