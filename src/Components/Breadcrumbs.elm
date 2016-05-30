module Components.Breadcrumbs exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import List
import Msg exposing (..)
import Page exposing (..)
import Models exposing (..)


type alias Breadcrumb =
    { name : String
    , page : Maybe Page
    }


renderBreadcrumbs : List Breadcrumb -> Html Msg
renderBreadcrumbs breadcrumbs =
    let
        render breadcrumb =
            case breadcrumb.page of
                Just page ->
                    li []
                        [ a
                            [ pointer
                            , onClick (NewPage page)
                            ]
                            [ text breadcrumb.name ]
                        ]

                Nothing ->
                    li [ class "active" ]
                        [ text breadcrumb.name ]
    in
        if List.length breadcrumbs == 1 then
            text ""
        else
            ol [ class "breadcrumb" ]
                (List.map render breadcrumbs)


breadCrumbs : AppModel -> Html Msg
breadCrumbs model =
    let
        home =
            [ Breadcrumb "Home" (Just Home) ]

        breadcrumbs =
            case model.currentPage of
                Home ->
                    []

                NewProject ->
                    [ Breadcrumb "New Project" Nothing ]

                Project project ->
                    [ Breadcrumb project Nothing ]

                Jobset project jobset ->
                    [ Breadcrumb project (Just (Page.Project project))
                    , Breadcrumb jobset Nothing
                    ]
    in
        renderBreadcrumbs (home ++ breadcrumbs)
