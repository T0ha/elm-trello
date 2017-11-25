module Trello.Label exposing (..)


import Http
import Json.Decode exposing (string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)

import Trello
import Trello.Authorize exposing (Auth)



type alias Label =
    { id : String
    , idBoard : String
    , name : String
    -- , color : Color
    , uses : Int
}


get : Auth -> (Result Http.Error Label -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/labels/" ++ id
    |> Trello.get auth decoder toMsg


decoder : Decoder Label
decoder =
    decode Label
    |> required "id" string
    |> required "idBoard" string
    |> required "name" string
    --|> required "color" Color
    |> required "uses" int
