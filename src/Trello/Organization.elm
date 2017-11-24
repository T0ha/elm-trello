module Trello.Organization exposing (..)

import Http
import Date exposing (Date)
import Json.Decode exposing (string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)

import Trello
import Trello.Authorize exposing (Auth)
import Trello.Member exposing (Member)

type alias Organization =
    { id : String
    , billableMemberCount : Int
    , name : String
    , desc : String
    , displayName : String
    , idBoards : List String
    , invited : Bool
    , invitations : List String
    , memberships : List Membership
    , powerUps : List Int
    , website : String
    , url : String
    }

type alias Membership =
    { id : String
    , idMember : String
    , memberType : Trello.Member.Role
    , unconfirmed : Bool
    }


get : Auth -> (Result Http.Error Organization -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/organisations/" ++ id
    |> Trello.get auth decoder toMsg


decoder : Decoder Organization
decoder = 
    decode Organization
    |> required "id" string
    |> optional "billableMemberCount" int 0
    |> required "name" string
    |> required "desc" string
    |> required "displayName" string
    |> required "idBoards" (list string)
    |> required "invited" bool
    |> required "invitations" (list string)
    |> required "memberships" (list membershipDecoder)
    |> required "powerUps" (list int)
    |> optional "website" string ""
    |> required "url" string

membershipDecoder : Decoder Membership
membershipDecoder =
    decode Membership
    |> required "id" string
    |> required "idMember" string
    |> required "memberType" Trello.Member.role
    |> required "unconfirmed" bool
