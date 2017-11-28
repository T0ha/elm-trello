module Trello.CheckList exposing (CheckList, ChecklistItem, ChecklistItemState(..), get)

{-| Represents Trello [Label](https://developers.trello.com/v1.0/reference#checklist-object) objest type and query.


# Object type

@docs CheckList, ChecklistItem, ChecklistItemState


# Functions

@docs get

-}

import Http
import Date exposing (Date)
import Json.Decode exposing (andThen, succeed, fail, string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)
import Trello
import Trello.Authorize exposing (Auth)


{-| CheckList structure
-}
type alias CheckList =
    { id : String
    , name : String
    , idBoard : String
    , idCard : String
    , pos : Int
    , checkItems : List ChecklistItem
    }


{-| Checklist item structure
-}
type alias ChecklistItem =
    { state : ChecklistItemState
    , idChecklist : String
    , id : String
    , name : String

    -- "nameData": null,
    , pos : Int
    }


{-| Checklist item states
-}
type ChecklistItemState
    = Complete
    | Incomplete


{-| Requests Trello API to get checklist
-}
get : Auth -> (Result Http.Error CheckList -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/checklists/"
        ++ id
        |> Trello.get auth decoder toMsg


decoder : Decoder CheckList
decoder =
    decode CheckList
        |> required "id" string
        |> required "name" string
        |> required "idBoard" string
        |> required "idCard" string
        |> required "pos" int
        |> required "checkItems" (list checklistItem)


checklistItem : Decoder ChecklistItem
checklistItem =
    decode ChecklistItem
        |> required "state" checklistItemState
        |> required "idChecklist" string
        |> required "id" string
        |> required "name" string
        |> required "pos" int


checklistItemState : Decoder ChecklistItemState
checklistItemState =
    let
        toState s =
            case s of
                "complete" ->
                    succeed Complete

                "incomplete" ->
                    succeed Incomplete

                _ ->
                    fail <| "Incorrect state value " ++ s
    in
        string
            |> andThen toState
