module Trello.Card exposing (..)

import Http
import Json.Decode exposing (andThen, succeed, string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)
import Date exposing (Date, fromString)

import Trello
import Trello.Authorize exposing (Auth)
import Trello.Label exposing (Label)


type alias Card = 
    { id : String
    {- "badges": {
        "votes": 0,
        "viewingMemberVoted": false,
        "subscribed": true,
        "fogbugz": "",
        "checkItems": 0,
        "checkItemsChecked": 0,
        "comments": 0,
        "attachments": 2,
        "description": false,
        "due": null,
        "dueComplete": false
    },
    -- , checkItemStates : List String
    -}
    , closed : Bool
    , dueComplete : Bool
    , dateLastActivity : Maybe Date
    , desc : String
    -- "descData": null,
    , due : Maybe Date
    , email : String
    , idBoard : String
    , idChecklists : List String
    , idList : String
    , idMembers : List String
    , idMembersVoted : List String
    , idShort : Int
    , idAttachmentCover : String
    , manualCoverAttachment : Bool
    , labels : List Label
    , idLabels : List String
    , name : String
    , pos : Int
    , shortLink : String
    , shortUrl : String
    , subscribed : Bool
    , url : String
    }


get : Auth -> (Result Http.Error Card -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/organisations/" ++ id
    |> Trello.get auth decoder toMsg

decoder : Decoder Card
decoder = 
    decode Card
    |> required "id" string
    |> required "closed" bool
    |> required "dueComplete" bool
    |> required "dateLastActivity" date
    |> required "desc" string
    |> optional "due" date Nothing
    |> optional "email" string ""
    |> required "idBoard" string
    |> required "idChecklists" (list string)
    |> required "idList" string
    |> required "idMembers" (list string)
    |> required "idMembersVoted" (list string)
    |> required "idShort" int
    |> required "idAttachmentCover" string
    |> required "manualCoverAttachment" bool
    |> required "labels" (list Trello.Label.decoder)
    |> required "idLabels" (list string)
    |> required "name" string
    |> required "pos" int
    |> required "shortLink" string
    |> required "shortUrl" string
    |> required "subscribed" bool
    |> required "url" string

date : Decoder (Maybe Date)
date =
    string
    |> andThen (\s -> s |> fromString |> Result.toMaybe |> succeed)
