port module Update exposing (..)

import Navigation

import Models exposing (..)
import Msg exposing (..)
import LiveSearch
import Page exposing (..)
import Urls exposing (pageToURL, pageToTitle)


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update msg model =
  case msg of

    FetchSucceed init ->
      ( model, popoverInit ())

    FetchFail msg ->
      ( model, popoverInit ())

    LoginUserClick loginType ->
        let
          -- TODO: well, actually do the login proceedure
          user =
            { id = "domenkozar"
            , name = "Domen Kožar"
            , email = "domen@dev.si"
            , roles = []
            , recieveEvaluationErrors = False
            }
        in case loginType of
          Hydra ->
            ( { model | user = Just user }, Cmd.none )
          Google ->
            ( { model | user = Just user }, Cmd.none )

    LogoutUserClick ->
      -- TODO: well, should we cleanup something?
      ( { model | user = Nothing}, Cmd.none )

    PreferencesClick ->
      ( model, Cmd.none )

    LiveSearchMsg searchmsg ->
      let
        (newmodel, cmds) = LiveSearch.update searchmsg model
      in (newmodel, Cmd.map LiveSearchMsg cmds)

    NewPage page ->
      ( model, Navigation.newUrl (pageToURL page))


urlUpdate : Result String Page -> AppModel -> (AppModel, Cmd b)
urlUpdate result model =
  case Debug.log "urlUpdate" result of
    Err _ ->
      -- TODO: render alert box here
      ( model, Cmd.none )

    Ok page ->
      ( { model | currentPage = page }, title (pageToTitle page) )



-- Ports

-- initialize jquery popover elements
port popoverInit : () -> Cmd msg

port title : String -> Cmd msg
