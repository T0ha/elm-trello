module Trello.Member exposing (..)

type Role = Admin 
          | Normal

type alias Member = 
    { id : String
    , avatarHash : String
    , avatarSource : String
    , bio : String
    , confirmed : Bool
    , email : String
    , fullName : String
    , gravatarHash : String
    , idBoards : List String
    , idOrganisations : List String
    , idEnterprisesAdmin : List String
    , idPremOrgsAdmin : List String
    , initials : String
    -- , loginTypes : List 
    , memberType : Role 
    }
