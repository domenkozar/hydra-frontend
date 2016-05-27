module Page exposing (..)

{-| Main type representing current url/page
-}

type Page
  = Home
  | Project String
  | Jobset String String
