module Trello.Card exposing (Card, get, getForMember)

{-| Represents Trello [Card](https://developers.trello.com/v1.0/reference#card-object) objest type and query.


# Object type

@docs Card


# Functions

@docs get, getForMember

-}

import Http
import Json.Decode exposing (andThen, succeed, string, bool, float, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)
import Date exposing (Date, fromString)
import Trello
import Trello.Authorize exposing (Auth)
import Trello.Label exposing (Label)


{-| Card structure
-}
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
    , pos : Float
    , shortLink : String
    , shortUrl : String
    , subscribed : Bool
    , url : String
    }


{-| Requests Trello API to get card
-}
get : Auth -> (Result Http.Error Card -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/cards/"
        ++ id
        |> Trello.get auth decoder toMsg


{-| Requests Trello API to get cards for meneber with id
-}
getForMember : Auth -> (Result Http.Error (List Card) -> msg) -> String -> Cmd msg
getForMember auth toMsg id =
    "/members/"
        ++ id
        ++ "/cards/"
        |> Trello.get auth (list decoder) toMsg


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
        |> optional "idAttachmentCover" string ""
        |> required "manualCoverAttachment" bool
        |> required "labels" (list Trello.Label.decoder)
        |> required "idLabels" (list string)
        |> required "name" string
        |> required "pos" float
        |> required "shortLink" string
        |> required "shortUrl" string
        |> required "subscribed" bool
        |> required "url" string


date : Decoder (Maybe Date)
date =
    string
        |> andThen (\s -> s |> fromString |> Result.toMaybe |> succeed)
