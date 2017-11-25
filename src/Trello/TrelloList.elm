module Trello.TrelloList exposing (..)

import Http
import Date exposing (Date)
import Json.Decode exposing (string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)

import Trello
import Trello.Authorize exposing (Auth)


type alias TrelloList =
    { id : String
    , name : String
    , closed : Bool
    , idBoard : String
    , pos : Int
    , subscribed : Bool
    }


get : Auth -> (Result Http.Error TrelloList -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/lists/" ++ id
    |> Trello.get auth decoder toMsg


decoder : Decoder TrelloList
decoder = 
    decode TrelloList
    |> required "id" string
    |> required "name" string
    |> required "closed" bool
    |> required "idBoard" string
    |> required "pos" int
    |> required "subscribed" bool
