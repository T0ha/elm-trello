module Trello.Label exposing (Label, get, decoder)

{-| Represents Trello [Label](https://developers.trello.com/v1.0/reference#label-object) object type and query.


# Object type

@docs Label


# Functions

@docs get


# JSON Decoder

@docs decoder

-}

import Http
import Json.Decode exposing (string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)
import Trello
import Trello.Authorize exposing (Auth)


{-| Label structure
-}
type alias Label =
    { id : String
    , idBoard : String
    , name : String

    -- , color : Color
    , uses : Int
    }


{-| Requests Trello API to get label
-}
get : Auth -> (Result Http.Error Label -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/labels/"
        ++ id
        |> Trello.get auth decoder toMsg


{-| Decoder for Label JSON
-}
decoder : Decoder Label
decoder =
    decode Label
        |> required "id" string
        |> required "idBoard" string
        |> required "name" string
        --|> required "color" Color
        |> required "uses" int
