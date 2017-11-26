module Trello.Board exposing (..)

import Http
import Json.Decode exposing (string, bool, int, list, Decoder)
import Json.Decode.Pipeline exposing (required, optional, decode)
import Trello
import Trello.Authorize exposing (Auth)


type alias Board =
    { id : String
    , name : String
    , desc : String
    , descData : String
    , closed : Bool
    , idOrganization : String
    , pinned : Bool
    , url : String
    , shortUrl : String
    }



{- "prefs": {
     "permissionLevel": "org",
     "voting": "disabled",
     "comments": "disabled",
     "invitations": "admins",
     "selfJoin": true,
     "cardCovers": true,
     "cardAging": "pirate",
     "calendarFeedEnabled": false,
     "background": "58cac0e474e47e3ff248cc47",
     "backgroundImage": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/1940x900/e55fff446a627e377b4e9ab9d7fcb552/boulder.jpg.png",
     "backgroundImageScaled": [
       {
         "width": 140,
         "height": 100,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/140x100/27e2b3c47f9a4776398ce51713295f2a/boulder.jpg.png"
       },
       {
         "width": 256,
         "height": 192,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/256x192/c397db11033a0e700b78ad70d8df8f34/boulder.jpg.png"
       },
       {
         "width": 480,
         "height": 480,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/480x480/abdad371090525973507a4f1d05330bb/boulder.jpg.png"
       },
       {
         "width": 960,
         "height": 960,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/960x960/ef29a1b58721eabcecdbefea70721d8e/boulder.jpg.png"
       },
       {
         "width": 1024,
         "height": 1024,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/1024x1024/6ffd7ac942b9a13b21ad28ade1ae708b/boulder.jpg.png"
       },
       {
         "width": 1940,
         "height": 900,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/1940x900/e55fff446a627e377b4e9ab9d7fcb552/boulder.jpg.png"
       },
       {
         "width": 1280,
         "height": 1280,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/1280x1280/13458f1524dd1a06a9ee2284932c1f56/boulder.jpg.png"
       },
       {
         "width": 1920,
         "height": 1920,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/1920x1920/81e98622f09850d488e3fc533b7e72fc/boulder.jpg.png"
       },
       {
         "width": 1940,
         "height": 900,
         "url": "https://trello-backgrounds.s3.amazonaws.com/5589c3ea49b40cedc28cf70e/1940x900/c29d61a839e47a350bfbded036eefc3e/boulder.jpg"
       }
     ],
     "backgroundTile": false,
     "backgroundBrightness": "light",
     "canBePublic": true,
     "canBeOrg": true,
     "canBePrivate": true,
     "canInvite": true
   },
   "labelNames": {
     "green": "",
     "yellow": "",
     "orange": "",
     "red": "",
     "purple": "",
     "blue": "",
     "sky": "Test Label 1",
     "lime": "Test Label 2",
     "pink": "",
     "black": "New Label!"
   }
-}


get : Auth -> (Result Http.Error Board -> msg) -> String -> Cmd msg
get auth toMsg id =
    "/boards/"
        ++ id
        |> Trello.get auth decoder toMsg


decoder : Decoder Board
decoder =
    decode Board
        |> required "id" string
        |> required "name" string
        |> required "desc" string
        |> optional "descData" string ""
        |> required "closed" bool
        |> required "idOrganization" string
        |> required "pinned" bool
        |> required "url" string
        |> required "shortUrl" string
