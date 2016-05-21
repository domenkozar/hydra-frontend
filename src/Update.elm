module Update exposing (..)

import Models exposing (..)
import Msg exposing (..)


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update action model =
  case action of
    FetchSucceed init ->
      ( model, Cmd.none )

    FetchFail msg ->
      ( model, Cmd.none )
