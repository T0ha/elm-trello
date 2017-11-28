module Trello.Authorize exposing (Auth, Expiration(..), ResponseType, Scope(..), appendQS, defaultAuth, parse, authorize)

{-| This module handles [authorization routines](https://developers.trello.com/v1.0/reference#api-key-tokens) for Trello. It is used to obtain request token and append auth data to request on subsequent calls.


# Types

@docs Auth, Expiration, ResponseType, Scope


# Authorization

@docs authorize, parse, defaultAuth


# Querying

@docs appendQS

-}

import Navigation
import QueryString as QS


{-| Expiration period for Trello session
-}
type Expiration
    = Never
    | Hour
    | Day
    | Month


{-| Token return type
-}
type ResponseType
    = Token
    | Fragment


{-| Trello internal authorization type.
Don't update it directly! Use helpers, pls.
-}
type alias Auth =
    { key : String
    , token : Maybe String
    , returnUrl : String
    , scope : List Scope
    , expiration : Expiration
    , name : String
    , responce_type : ResponseType
    }


{-| Authorization access type. Account means modifying user acccount
-}
type Scope
    = Read
    | Write
    | Account


{-| Creates basic Auth structure for further usage.
-}
defaultAuth : String -> String -> Auth
defaultAuth key returnUrl =
    { key = key
    , returnUrl = returnUrl
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

        scope s =
            case s of
                Read ->
                    "read"

                Write ->
                    "write"

                Account ->
                    "account"

        scopes =
            auth.scope
                |> List.map scope
                |> String.join ","

        responce_type =
            case auth.responce_type of
                Token ->
                    "token"

                Fragment ->
                    "fragment"
    in
        "https://trello.com/1/authorize?"
            ++ "expiration="
            ++ expiration
            ++ "&scope="
            ++ scopes
            ++ "&responce_type="
            ++ responce_type
            ++ "&key="
            ++ auth.key
            ++ "&return_url="
            ++ auth.returnUrl


{-| Sends authorize request to Trello.
-}
authorize : Auth -> Cmd msg
authorize auth =
    Navigation.load (authorizeUrl auth)


{-| Parses redirect URL and gets token.
-}
parse : Navigation.Location -> Auth -> Result String Auth
parse location auth =
    case String.split "=" location.hash of
        [] ->
            Ok auth

        _ :: [ token ] ->
            Ok { auth | token = Just token }

        _ ->
            Err "Token parse error"


{-| Adds authorization data to query string for requesting Trello.
-}
appendQS : Auth -> QS.QueryString -> QS.QueryString
appendQS auth qs =
    qs
        |> QS.add "key" auth.key
        |> QS.add "token" (Maybe.withDefault "" auth.token)
