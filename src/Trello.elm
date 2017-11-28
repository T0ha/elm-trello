module Trello exposing (..)

{-| Helper module used by other modules internally.
-}

import Http
import Json.Decode exposing (Decoder)
import QueryString as QS
import Trello.Authorize exposing (Auth)


baseUrl : String
baseUrl =
    "https://api.trello.com/1"


get : Auth -> Decoder t -> (Result Http.Error t -> msg) -> String -> Cmd msg
get auth decoder toMsg path =
    let
        qs =
            QS.empty
                |> Trello.Authorize.appendQS auth
                |> QS.render

        url =
            baseUrl ++ path ++ qs
    in
        Http.get url decoder
            |> Http.send toMsg
