module TrelloList exposing (..)

type alias TrelloList =
    { id : String
    , name : String
    , closed : Boolean
    , idBoard : String
    , pos : Integer
    , subscribed : Boolean
    }
