module Organizations exposing (..)

import Date exposing (Date)

import Member exposing (Member)

type alias Organizations =
    { id : String
    , billableMemberCount : Integer
    , desc : String
    , displayName : String
    , idBoards : List String
    , invited : Boolean
    , invitations : List String
    , memberships : List Member
    , powerUps : List Integer
    , website : String
    , url : String
    }
