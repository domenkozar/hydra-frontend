module Pages.Project exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Maybe
import List
import Components.LiveSearch exposing (search)
import Components.Help exposing (..)
import Msg exposing (..)
import Models exposing (Project, AppModel)
import Page exposing (Page)
import Urls exposing (onClickPage)
import Utils exposing (..)


projectsView : List Project -> List (Html Msg)
projectsView projects =
    let
        newprojects =
            List.map renderProject (search projects)
    in
        renderHeader "Projects" Nothing (Just Page.NewProject)
            ++ if List.isEmpty newprojects then
                render404 "Zero projects. Maybe add one?"
               else
                newprojects


projectView : Project -> List (Html Msg)
projectView project =
    [ renderProject project ]


newProjectView : AppModel -> List (Html Msg)
newProjectView model =
    [ h1 [ style [ ( "margin-bottom", "30px" ) ] ]
        [ text "Add a new project" ]
    , Html.form [ class "row col-xs-6" ]
        [ div [ class "form-group" ]
            [ label []
                [ text "Identifier" ]
            , input
                [ class "form-control"
                , placeholder "e.g. hydra"
                , type' "text"
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label []
                [ text "Display Name" ]
            , input
                [ class "form-control"
                , placeholder "e.g. Hydra"
                , type' "text"
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label []
                [ text "Description" ]
            , input
                [ class "form-control"
                , placeholder "e.g. Builds Nix expressions and provides insight about the process"
                , type' "text"
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label []
                [ text "Homepage" ]
            , input
                [ class "form-control"
                , placeholder "e.g. https://github.com/NixOS/hydra"
                , type' "text"
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label []
                [ text "Owner" ]
            , input
                [ class "form-control"
                , type' "text"
                , value (Maybe.withDefault "" (Maybe.map (\u -> u.id) model.user))
                ]
                []
            ]
        , div [ class "checkbox" ]
            [ label []
                [ input
                    [ type' "checkbox"
                    , checked True
                    ]
                    []
                , text "Is visible on the project list?"
                ]
            ]
        , div [ class "checkbox" ]
            [ label []
                [ input
                    [ type' "checkbox"
                    , checked True
                    ]
                    []
                , text "Is enabled?"
                ]
            ]
        , button
            [ type' "submit"
            , class "btn btn-primary btn-lg"
            , style [ ( "margin-top", "30px" ) ]
            , onClick ClickCreateProject
            ]
            [ fontAwesome "plus-circle fa-lg"
            , text " Create project"
            ]
        ]
    ]


renderProject : Project -> Html Msg
renderProject project =
    div [ class "panel panel-default" ]
        [ div
            [ class "panel-heading clearfix btn-block" ]
            [ a (onClickPage (Page.Project project.name))
               [
               span [ class "lead" ]
                  [ text (project.name ++ " ") ]
              , small [ class "hidden-xs" ]
                  [ text ("(" ++ project.description ++ ")") ]
                  ]
            , div
                [ attribute "aria-label" "..."
                , class "btn-group pull-right"
                , attribute "role" "group"
                ]
                [ div [ class "btn-group"
                , attribute "role" "group"
                 ]
                    [ button
                        [ attribute "aria-expanded" "false"
                        , attribute "aria-haspopup" "true"
                        , class "btn btn-primary dropdown-toggle"
                        , attribute "data-toggle" "dropdown"
                        , type' "button"
                        ]
                        [ span [ class "caret" ] []
                        , text " Actions"
                        ]
                    , ul [ class "dropdown-menu" ]
                        [ li []
                            [ a [ href "#" ]
                                [ fontAwesomeAttrs "trash fa-lg" [ style [ ( "color", "red" ) ] ]
                                , text " Delete the project"
                                ]
                            ]
                        , li []
                            [ a [ href "#" ]
                                [ fontAwesomeAttrs "plus-circle fa-lg" [ style [ ( "color", "green" ) ] ]
                                , text " Add a jobset"
                                ]
                            ]
                        ]
                    ]
                , button
                    [ class "btn btn-default"
                    , onClick ClickCreateProject -- TODO: wrong msg
                    , type' "button"
                    ]
                    [ fontAwesome "cog fa-lg"
                    , text "Configuration"
                    ]
                ]
            ]
        , if List.isEmpty project.jobsets then
            p [ class "text-center", style [ ( "margin", "20px" ) ] ] [ text "No Jobsets configured yet." ]
          else
            table [ class "table table-hover" ]
                ([ thead []
                    [ tr []
                        [ th [ style [ ( "width", "15%" ), ( "min-width", "85px" ) ] ]
                            [ strong []
                                [ text "Jobset"
                                , jobsetHelp
                                ]
                            ]
                        , th [ style [ ( "width", "40%" ) ] ]
                            [ strong []
                                [ text "Description" ]
                            ]
                        , th [ style [ ( "width", "15%" ) ] ]
                            [ strong []
                                [ text "Build status" ]
                            ]
                        , th [ style [ ( "width", "30%" ) ] ]
                            [ strong []
                                [ text "Last evaluation" ]
                            ]
                        ]
                    ]
                 ]
                    ++ ([ tbody []
                            (List.map
                                (\jobset ->
                                    tr []
                                        [ td []
                                            [ a
                                                (onClickPage (Page.Jobset project.name jobset.id))
                                                [ text jobset.name ]
                                            ]
                                        , td []
                                            [ text jobset.description ]
                                        , td []
                                            [ optionalTag (jobset.succeeded > 0)
                                                (span [ class "label label-success"
                                                      , title "Builds succeeded" ]
                                                    [ text (toString jobset.succeeded) ]
                                                )
                                            , optionalTag (jobset.failed > 0)
                                                (span []
                                                    [ text " " ]
                                                )
                                            , optionalTag (jobset.failed > 0)
                                                (span [ class "label label-danger"
                                                      , title "Builds failed" ]
                                                    [ text (toString jobset.failed) ]
                                                )
                                            , optionalTag (jobset.queued > 0)
                                                (span []
                                                    [ text " " ]
                                                )
                                            , optionalTag (jobset.queued > 0)
                                                (span [ class "label label-default"
                                                      , title "Builds in queue" ]
                                                    [ text (toString jobset.queued) ]
                                                )
                                            ]
                                        , td []
                                            [ text jobset.lastEvaluation ]
                                        ]
                                )
                                (search project.jobsets)
                            )
                        ]
                       )
                )
        ]
