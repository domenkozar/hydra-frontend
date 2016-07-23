module Pages.Jobset exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Models exposing (..)
import Msg exposing (Msg)
import Page exposing (..)
import Utils exposing (..)


jobsetView : Jobset -> List (Html Msg)
jobsetView jobset =
    renderHeader "Jobset" (Just jobset.name) Nothing
      ++ if List.isEmpty [] then
          render404 "No evaluations yet."
         else
          []
