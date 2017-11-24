module Trello.Member exposing (..)

import Json.Decode exposing (field, andThen, succeed, string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)

type Role = Admin 
          | Normal

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


decoder : Decoder Member
decoder = 
    decode Member
    |> required "id" string
    |> required "avatarHash" string
    |> optional "avatarSource" string ""
    |> required "url" string
    |> required "username" string
    |> required "bio" string
    |> required "confirmed" bool
    |> optional "email" string ""
    |> required "fullName" string
    |> optional "gravatarHash" string ""
    |> required "idBoards" (list string)
    |> required "idOrganizations" (list string)
    |> required "idEnterprisesAdmin" (list string)
    |> required "idPremOrgsAdmin" (list string)
    |> required "initials" string
    --|> required "loginTypes" list 
    |> required "memberType" role 


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
