module Trello.Organization exposing (Organization, Membership, get, getForMember)

{-| Represents Trello [Organization](https://developers.trello.com/v1.0/reference#organisation-object) object type and query.


# Object types

@docs Organization, Membership


# Functions

@docs get, getForMember

-}

import Http
import Date exposing (Date)
import Json.Decode exposing (string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)
import Trello
import Trello.Authorize exposing (Auth)
import Trello.Member exposing (Member)


{-| Organization structure
-}
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


{-| Structure describing Organization Member
-}
type alias Membership =
    { id : String
    , idMember : String
    , memberType : Trello.Member.Role
    , unconfirmed : Bool
    }


{-| Requests Trello API to get organisation
-}
get : Auth -> (Result Http.Error Organization -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/organizations/"
        ++ id
        |> Trello.get auth decoder toMsg


{-| Requests Trello API to get organizations for member by its id
-}
getForMember : Auth -> (Result Http.Error (List Organization) -> msg) -> String -> Cmd msg
getForMember auth toMsg memberId =
    "/members/"
        ++ memberId
        ++ "/organizations"
        |> Trello.get auth (list decoder) toMsg


{-| Decoder for Label JSON
-}
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
