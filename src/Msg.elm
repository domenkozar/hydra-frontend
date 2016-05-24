module Msg exposing (..)

import Http

import LiveSearch


type LoginType
  = Hydra
  | Google

type Msg
  = FetchSucceed String
  | FetchFail Http.Error
  | LoginUserClick LoginType
  | LogoutUserClick
  | PreferencesClick
  | LiveSearchMsg LiveSearch.Msg
