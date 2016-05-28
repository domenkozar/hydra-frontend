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


pointer : Html.Attribute a
pointer = style [("cursor", "pointer")]
