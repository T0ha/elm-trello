module Trello exposing (..)

import Http
import Json.Decode exposing (Decoder)
import Trello.Authorize exposing (Auth)


baseUrl : String
baseUrl =
    "https://api.trello.com/1"


get : Auth -> Decoder t -> (Result Http.Error t -> msg) -> String -> Cmd msg
get auth decoder toMsg path =
    let
        url =
            baseUrl ++ path ++ "TODO:"
    in
        Http.get url decoder
            |> Http.send toMsg
