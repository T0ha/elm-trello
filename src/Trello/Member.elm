module Trello.Member exposing (..)

{-| Represents Trello [Member](https://developers.trello.com/v1.0/reference#member-object) object type and query.


# Object type

@docs Member, Role


# Functions

@docs get, role, decoder, getForOrganization

-}

import Http
import Json.Decode exposing (field, andThen, succeed, string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)
import Trello
import Trello.Authorize exposing (Auth)


{-| Member structure
-}
type alias Member =
    { id : String
    , avatarHash : String
    , avatarSource : String
    , url : String
    , username : String
    , bio : String
    , confirmed : Bool
    , email : String
    , fullName : String
    , gravatarHash : String
    , idBoards : List String
    , idOrganizations : List String
    , idEnterprisesAdmin : List String
    , idPremOrgsAdmin : List String
    , initials : String

    -- , loginTypes : List
    , memberType : Role
    }


{-| Member type (role) enumerable
-}
type Role
    = Admin
    | Normal


{-| Requests Trello API to get member
-}
get : Auth -> (Result Http.Error Member -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/members/"
        ++ id
        |> Trello.get auth decoder toMsg


{-| Requests Trello API to get members for organization by its id
-}
getForOrganization : Auth -> (Result Http.Error (List Member) -> msg) -> String -> Cmd msg
getForOrganization auth toMsg organizationId =
    "/organizations/"
        ++ organizationId
        ++ "/members"
        |> Trello.get auth (list decoder) toMsg


decoder : Decoder Member
decoder =
    decode Member
        |> required "id" string
        |> optional "avatarHash" string ""
        |> optional "avatarSource" string ""
        |> optional "url" string ""
        |> required "username" string
        |> optional "bio" string ""
        |> required "confirmed" bool
        |> optional "email" string ""
        |> optional "fullName" string ""
        |> optional "gravatarHash" string ""
        |> optional "idBoards" (list string) []
        |> optional "idOrganizations" (list string) []
        |> optional "idEnterprisesAdmin" (list string) []
        |> optional "idPremOrgsAdmin" (list string) []
        |> required "initials" string
        --|> required "loginTypes" list
        |> optional "memberType" role Normal


{-| Role JSON decoder
-}
role : Decoder Role
role =
    let
        toRole r =
            case r of
                "admin" ->
                    succeed Admin

                _ ->
                    succeed Normal
    in
        string
            |> andThen toRole
