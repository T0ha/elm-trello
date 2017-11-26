module Trello exposing (..)

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

        url =
            baseUrl ++ path ++ Trello.Authorize.qs auth qs
    in
        Http.get url decoder
            |> Http.send toMsg
