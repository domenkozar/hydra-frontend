module Msg exposing (..)

import Http


type LoginType
  = Hydra
  | Google

type Msg
  = FetchSucceed (String)
  | FetchFail Http.Error
  | LoginUserClick (LoginType)
  | LogoutUserClick
  | PreferencesClick
