module LiveSearch exposing (update, view, search, Msg)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String

import Models exposing (..)
import ExtraEvents exposing (onEscape)


type Msg
  = SearchInput String
  | SearchEscape


compareCaseInsensitve : String -> String -> Bool
compareCaseInsensitve s1 s2 = String.contains (String.toLower s1) (String.toLower s2)


{-| Filter project by Project name or Jobset name
-}
searchProject : String -> Project -> Project
searchProject searchstring project =
   let
     projectFilteredJobsets = { project | jobsets = List.map (filterByName searchstring) project.jobsets }
     hasJobsets = List.any (\j -> j.isShown) projectFilteredJobsets.jobsets
     newproject = filterByName searchstring project
   in if newproject.isShown -- if project matches, display all jobsets
      then { newproject | jobsets = List.map (\j -> { j | isShown = True} ) newproject.jobsets }
      else if hasJobsets -- if project doesn't match, only display if any of jobsets match
           then { projectFilteredJobsets | isShown = True }
           else newproject


filterByName : String ->  { b | name : String, isShown : Bool } ->  { b | name : String, isShown : Bool }
filterByName searchstring project =
  if compareCaseInsensitve searchstring project.name
  then { project | isShown = True }
  else { project | isShown = False }


{-| Filter any record by isShown field

    TODO: recursively apply all lists in the structure
-}
search : List { a | isShown : Bool } -> List { a | isShown : Bool }
search projects = List.filter (\x -> x.isShown) projects


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update msg model =
  case msg of
    SearchInput searchstring ->
      let
        newprojects = List.map (searchProject searchstring) model.projects
      in ( { model | projects = newprojects
                   , searchString = searchstring }, Cmd.none )

    -- on Escape, clear search bar and return all projects/jobsets
    SearchEscape ->
      ( { model | searchString = ""
                , projects = List.map (searchProject "") model.projects }, Cmd.none )


view : AppModel -> Html Msg
view model =
  div
    [ class "form-group" ]
    [ input
      [ type' "text"
      , class "form-control"
      , placeholder "Search"
      , onInput SearchInput
      , onEscape SearchEscape
      , value model.searchString
      ]
      [ ]
    ]
