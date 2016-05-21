module Msg exposing (..)

import Http
import Models exposing (..)


type Msg
  = FetchSucceed (String)
  | FetchFail Http.Error
