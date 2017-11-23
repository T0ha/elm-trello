module Trello.Authorize exposing (..)

import Navigation


type Expiration = Never
                | Hour
                | Day
                | Month 


type ResponseType = Token | Fragment


type alias Auth =
    { key : String
    , token : Maybe String
    , returnUrl : String
    , scope : List Scope
    , expiration : Expiration
    , name : String
    , responce_type : ResponseType
    }


type Scope = Read
           | Write
           | Account


defaultAuth : String -> Auth
defaultAuth key =
    { key = key
    , returnUrl = "http://localhost:8000"
    , scope = []
    , expiration = Never
    , token = Nothing
    , name = ""
    , responce_type = Token
    }

authorizeUrl : Auth -> String 
authorizeUrl auth = 
    let 
        expiration =
            case auth.expiration of
                Never -> 
                    "never"
                Hour ->
                    "1hour"
                Day ->
                    "1day"
                Month ->
                    "30days"

        scope s = case s of
            Read ->
                "read"
            Write ->
                "write"
            Account ->
                "account"

        scopes = auth.scope 
                 |> List.map scope
                 |> String.join ","
        responce_type = case auth.responce_type of
            Token ->
                "token"
            Fragment ->
                "fragment"
    in
        "https://trello.com/1/authorize?"
        ++ "expiration=" ++ expiration 
        ++ "&scope=" ++ scopes
        ++ "&responce_type=" ++ responce_type
        ++ "&key=" ++ auth.key 
        ++ "&return_url=" ++ auth.returnUrl

authorize : Auth -> Cmd msg
authorize auth =
    Navigation.load (authorizeUrl auth)

parse : Navigation.Location -> Auth -> Result String Auth
parse location auth =
    case String.split "=" location.hash of
        [] ->
            Ok auth
        _ :: [token] ->
                Ok {auth | token = Just token}
        _ ->
            Err "Token parse error"
