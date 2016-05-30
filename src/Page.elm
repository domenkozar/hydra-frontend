module Page exposing (..)

import Html
import Html.Attributes exposing (style)


{-| Main type representing current url/page
-}
type Page
    = Home
    | Project String
    | NewProject
    | Jobset String String


{-| typically used to simuate a link
-}
pointer : Html.Attribute a
pointer =
    style [ ( "cursor", "pointer" ) ]
