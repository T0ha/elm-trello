module Trello.Label exposing (..)

import Json.Decode exposing (string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)


type alias Label =
    { id : String
    , idBoard : String
    , name : String
    -- , color : Color
    , uses : Int
}

decoder : Decoder Label
decoder =
    decode Label
    |> required "id" string
    |> required "idBoard" string
    |> required "name" string
    --|> required "color" Color
    |> required "uses" int
