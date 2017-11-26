module TrelloTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Json.Decode exposing (decodeString)
import Date
import Result

import Trello.Organization
import Trello.Member
import Trello.Board
import Trello.Card
import Trello.Label
import Trello.TrelloList
import Trello.CheckList


suite : Test
suite =
    describe "Testing JSON parsing" 
    [ test "Organization JSON from example" <|
        (\_ -> organisationJSONExample)

    , test "Member JSON from example" <|
        (\_ -> memberJSONExample)

    , test "Card JSON from example" <|
        (\_ -> cardJSONExample)

    , test "Label JSON from example" <|
        (\_ -> labelJSONExample)

    , test "List JSON from example" <|
        (\_ -> listJSONExample)

    , test "CheckList JSON from example" <|
        (\_ -> checkListJSONExample)
 ]


organisationJSONExample : Expectation
organisationJSONExample =
    let 
        json = """{
            "id": "538627f73cbb44d1bfbb58f0",
            "name": "trelloinc",
            "displayName": "Trello Inc",
            "desc": "Trello.",
            "descData": null,
            "idBoards": [
                "4f7a0080554c5d054c598a9b",
                "4d5ea62fd76aa1136000000c",
                "4e9447b45504d8000025e533",
                "58c9bd28df3ad86346df87b5",
                "58d404bca430d63349042918",
                "58f5ddcdc85dc4460b3a5d32",
                "59355d99e863b0de27f1d3d8",
                "59398d2370f240bbb199399d"
                ],
            "idEnterprise": null,
            "invited": false,
            "invitations": [

                 ],
             "memberships": [
                 {
                     "id": "538627f73cbb44d1bfbb58f1",
                     "idMember": "4d5eb12cd76aa113600000c9",
                     "memberType": "admin",
                     "unconfirmed": false
                },
                {
                    "id": "53b1a1f8a128e74250f8d0b9",
                    "idMember": "4d68050a81bb57af1e006960",
                    "memberType": "admin",
                    "unconfirmed": false
                },
                {
                    "id": "53da3738d5e44eafceb802e1",
                    "idMember": "4e6655412f872f6c9305b71d",
                    "memberType": "normal",
                    "unconfirmed": false
                },
                {
                    "id": "53da5e8572a469607aa8c7d8",
                    "idMember": "4f820a995a03e8e82d134ac4",
                    "memberType": "normal",
                    "unconfirmed": false
                },
                {
                    "id": "5951237e0f10c6eb9b2476ad",
                    "idMember": "595123526d9a31740725bcc3",
                    "memberType": "normal",
                    "unconfirmed": false
                }
            ],
            "prefs": {
                "permissionLevel": "public",
                "orgInviteRestrict": [

                ],
            "externalMembersDisabled": false,
            "associatedDomain": "trello.com",
            "googleAppsVersion": 2,
            "boardVisibilityRestrict": {
                "private": "org",
                "org": "org",
                "public": "org"
                }
              },
            "powerUps": [
                100
                ],
            "products": [
                100
                ],
            "billableMemberCount": null,
            "activeBillableMemberCount": null,
            "url": "https://trello.com/trelloinc",
            "website": null,
            "logoHash": "da3ff465abd3a3e1b687c52ff803af74",
            "premiumFeatures": [
                "export",
                "observers",
                "removal",
                "activity",
                "deactivated",
                "googleApps",
                "superAdmins",
                "inviteOrg",
                "restrictVis",
                "disableExternalMembers",
                "goldMembers",
                "csvExport",
                "shortExportHistory",
                "tags",
                "plugins",
                "starCounts",
                "readSecrets",
                "enterpriseUI"
                ]
            }
            """

        organisation = 
                { id = "538627f73cbb44d1bfbb58f0"
                , name = "trelloinc"
                , displayName = "Trello Inc"
                , desc = "Trello."
                , idBoards = [
                    "4f7a0080554c5d054c598a9b",
                    "4d5ea62fd76aa1136000000c",
                    "4e9447b45504d8000025e533",
                    "58c9bd28df3ad86346df87b5",
                    "58d404bca430d63349042918",
                    "58f5ddcdc85dc4460b3a5d32",
                    "59355d99e863b0de27f1d3d8",
                    "59398d2370f240bbb199399d"
                    ]
                    , invited = False
                    , invitations = []
                    , memberships = 
                        [
                            { id = "538627f73cbb44d1bfbb58f1"
                            , idMember = "4d5eb12cd76aa113600000c9"
                            , memberType = Trello.Member.Admin
                            , unconfirmed = False
                            }, 
                            { id = "53b1a1f8a128e74250f8d0b9"
                            , idMember = "4d68050a81bb57af1e006960"
                            , memberType = Trello.Member.Admin
                            , unconfirmed = False
                            },
                            { id = "53da3738d5e44eafceb802e1"
                            , idMember = "4e6655412f872f6c9305b71d"
                            , memberType = Trello.Member.Normal
                            , unconfirmed = False
                            },
                            { id = "53da5e8572a469607aa8c7d8"
                            , idMember = "4f820a995a03e8e82d134ac4"
                            , memberType = Trello.Member.Normal
                            , unconfirmed = False
                            },
                            { id = "5951237e0f10c6eb9b2476ad"
                            , idMember = "595123526d9a31740725bcc3"
                            , memberType = Trello.Member.Normal
                            , unconfirmed = False
                            }
                            ]
                        , powerUps = [
                    100
                    ]
                , billableMemberCount = 0
                -- TODO: "activeBillableMemberCount": null,
                , url = "https://trello.com/trelloinc"
                , website = ""
                -- TODO: "logoHash": "da3ff465abd3a3e1b687c52ff803af74",
            }
    in
        json
        |> decodeString Trello.Organization.decoder
        |> Expect.equal (Ok organisation)

memberJSONExample : Expectation
memberJSONExample =
    let 
        json = """{
            "id": "50095233f62adbe04d935195",
            "avatarHash": "10e3fec8aee92d177b22290b7cff669d",
            "bio": "",
            "bioData": null,
            "confirmed": true,
            "fullName": "Taco",
            "idPremOrgsAdmin": [

              ],
            "initials": "T",
            "memberType": "normal",
            "products": [

              ],
            "status": "disconnected",
            "url": "https://trello.com/taco",
            "username": "taco",
            "avatarSource": null,
            "email": null,
            "gravatarHash": null,
            "idBoards": [
                  "5824e427857eea92ad0a93fc",
                  "58f7becd7a76210902b2f846",
                  "50e1d37994dd425b620035ff",
                  "51227842c0cb5a7d740002cb",
                  "512e491a6d7fc071590043a6",
                  "58f7b25fcf2a8696f734edfc",
                  "58fa50037361735963976675",
                  "592db6c67e4c126659137b88",
                  "592f28ad8271344b504b016d"
                  ],
            "idEnterprise": null,
            "idOrganizations": [

                  ],
            "idEnterprisesAdmin": [

                  ],
            "loginTypes": null,
            "oneTimeMessagesDismissed": null,
            "prefs": null,
            "trophies": [

                  ],
            "uploadedAvatarHash": null,
            "premiumFeatures": [

                  ],
            "idBoardsPinned": null           
                  }"""

        out = 
            { id = "50095233f62adbe04d935195"
            , avatarHash = "10e3fec8aee92d177b22290b7cff669d"
            , bio = ""
            -- "bioData": null,
            , confirmed = True
            , fullName = "Taco"
            , idPremOrgsAdmin = []
            , initials = "T"
            , memberType = Trello.Member.Normal
            --, products = []
            -- status = "disconnected",
            , url = "https://trello.com/taco"
            , username = "taco"
            , avatarSource = ""
            , email = ""
            , gravatarHash = ""
            , idBoards = 
                [ "5824e427857eea92ad0a93fc"
                , "58f7becd7a76210902b2f846"
                , "50e1d37994dd425b620035ff"
                , "51227842c0cb5a7d740002cb"
                , "512e491a6d7fc071590043a6"
                , "58f7b25fcf2a8696f734edfc"
                , "58fa50037361735963976675"
                , "592db6c67e4c126659137b88"
                , "592f28ad8271344b504b016d"
                ]
            -- , idEnterprise = "",
            , idOrganizations = []
            , idEnterprisesAdmin = []
            -- , loginTypes = null,
            -- "prefs": null,
            -- , uploadedAvatarHash = null
            --, "idBoardsPinned": null
            }
    in
        json
        |> decodeString Trello.Member.decoder
        |> Expect.equal (Ok out)


boardJSONExample : Expectation
boardJSONExample =
    let 
        json =
            """
            {
                "id": "586e8f681d4fe9b06a928307",
                "name": "Best Test Board!",
                "desc": "",
                "descData": null,
                "closed": false,
                "idOrganization": "586e8d7b1af892b26d5b76b1",
                "pinned": false,
                "url": "https://trello.com/b/d2EnEWSY/best-test-board",
                "shortUrl": "https://trello.com/b/d2EnEWSY",
                "prefs": {
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
}
            """

        out = 
            { id = "586e8f681d4fe9b06a928307"
            , name = "Best Test Board!"
            , desc = ""
            , descData = ""
            , closed = False
            , idOrganization = "586e8d7b1af892b26d5b76b1"
            , pinned = False
            , url = "https://trello.com/b/d2EnEWSY/best-test-board"
            , shortUrl = "https://trello.com/b/d2EnEWSY"
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
            }, -}
            {- labelNames = {
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
            -}
            }
    in
        json
        |> decodeString Trello.Board.decoder
        |> Expect.equal (Ok out)


cardJSONExample : Expectation
cardJSONExample =
    let 
        json =
            """
            {
                "id": "560bf4dd7139286471dc009c",
                "badges": {
                    "votes": 0,
                    "viewingMemberVoted": false,
                    "subscribed": true,
                    "fogbugz": "",
                    "checkItems": 0,
                    "checkItemsChecked": 0,
                    "comments": 0,
                    "attachments": 2,
                    "description": false,
                    "due": null,
                    "dueComplete": false
              },
              "checkItemStates": [

              ],
              "closed": false,
              "dueComplete": false,
              "dateLastActivity": "2017-06-26T17:39:49.583Z",
              "desc": "",
              "descData": null,
              "due": null,
              "email": null,
              "idBoard": "560bf4298b3dda300c18d09c",
              "idChecklists": [

              ],
              "idList": "560bf44ea68b16bd0fc2a9a9",
              "idMembers": [
                  "556c8537a1928ba745504dd8"
                  ],
              "idMembersVoted": [

              ],
              "idShort": 9,
              "idAttachmentCover": "5944a06460ed0bee471ad8e0",
              "manualCoverAttachment": false,
              "labels": [
                  {
                      "id": "560bf42919ad3a5dc29f33c5",
                      "idBoard": "560bf4298b3dda300c18d09c",
                      "name": "Visited",
                      "color": "green",
                      "uses": 15
                    }
                ],
             "idLabels": [
                    "560bf42919ad3a5dc29f33c5"
                    ],
             "name": "Grand Canyon National Park",
             "pos": 16384,
             "shortLink": "nqPiDKmw",
             "shortUrl": "https://trello.com/c/nqPiDKmw",
             "subscribed": true,
             "url": "https://trello.com/c/nqPiDKmw/9-grand-canyon-national-park"
            }
            """

        out =
            { id = "560bf4dd7139286471dc009c"
            {- , badges = {
                    votes = 0,
                    viewingMemberVoted = false,
                    subscribed = true,
                    fogbugz = "",
                    checkItems = 0,
                    checkItemsChecked = 0,
                    comments = 0,
                    attachments = 2,
                    description = false,
                    due = null,
                    dueComplete = false
              -}
              --, checkItemStates = []
              , closed = False
              , dueComplete = False
              , dateLastActivity = Result.toMaybe <| Date.fromString "2017-06-26T17:39:49.583Z"
              , desc = ""
              -- , descData = null
              , due = Nothing
              , email = ""
              , idBoard = "560bf4298b3dda300c18d09c"
              , idChecklists = []
              , idList = "560bf44ea68b16bd0fc2a9a9"
              , idMembers = [
                  "556c8537a1928ba745504dd8"
                  ]
              , idMembersVoted = []
              , idShort = 9
              , idAttachmentCover = "5944a06460ed0bee471ad8e0"
              , manualCoverAttachment = False
              , labels = [
                  { id = "560bf42919ad3a5dc29f33c5"
                  , idBoard = "560bf4298b3dda300c18d09c"
                  , name = "Visited"
                  --, color = "green"
                  , uses = 15
                  }
                ]
             , idLabels = [
                    "560bf42919ad3a5dc29f33c5"
                    ]
             , name = "Grand Canyon National Park"
             , pos = 16384
             , shortLink = "nqPiDKmw"
             , shortUrl = "https://trello.com/c/nqPiDKmw"
             , subscribed = True
             , url = "https://trello.com/c/nqPiDKmw/9-grand-canyon-national-park"

            }
    in
        json
        |> decodeString Trello.Card.decoder
        |> Expect.equal (Ok out)


labelJSONExample : Expectation
labelJSONExample =
    let 
        json =
            """
            {
                "id": "560bf42919ad3a5dc29f33c5",
                "idBoard": "560bf4298b3dda300c18d09c",
                "name": "Visited",
                "color": "green",
                "uses": 15
            }
            """

        out = 
            { id = "560bf42919ad3a5dc29f33c5"
                , idBoard = "560bf4298b3dda300c18d09c"
                , name = "Visited"
                -- , color = "green"
                , uses = 15
            }
    in
        json
        |> decodeString Trello.Label.decoder
        |> Expect.equal (Ok out)


listJSONExample : Expectation
listJSONExample =
    let 
        json =
            """
            {
                "id": "560bf48efe2771efe9b45997",
                "name": "Washington",
                "closed": false,
                "idBoard": "560bf4298b3dda300c18d09c",
                "pos": 1638399,
                "subscribed": false
            }
            """

        out = 
            { id = "560bf48efe2771efe9b45997"
            , name = "Washington"
            , closed = False
            , idBoard = "560bf4298b3dda300c18d09c"
            , pos = 1638399
            , subscribed = False
            }
    in
        json
        |> decodeString Trello.TrelloList.decoder
        |> Expect.equal (Ok out)



checkListJSONExample : Expectation
checkListJSONExample =
    let 
        json =
            """
            {
                "id": "5914b2923876e144b5cb6974",
                "name": "Awesomeness to come",
                "idBoard": "4d5ea62fd76aa1136000000c",
                "idCard": "5914b27920508fcb6bfd525f",
                "pos": 16384,
                "checkItems": [
                    {
                        "state": "complete",
                        "idChecklist": "5914b2923876e144b5cb6974",
                        "id": "5914b29abcbe09ab9478d156",
                        "name": "Custom Fields in CSV exports",
                        "nameData": null,
                        "pos": 16867
                    },
                    {
        "state": "incomplete",
        "idChecklist": "5914b2923876e144b5cb6974",
        "id": "5914b2a1ee4421b88542b59a",
        "name": "Custom Fields on mobile",
        "nameData": null,
        "pos": 34254
    },
    {
        "state": "incomplete",
        "idChecklist": "5914b2923876e144b5cb6974",
        "id": "5914b2b2e01e5b17afedf6fc",
        "name": "Working well across multiple boards",
        "nameData": null,
        "pos": 51540
    }
    ]
            }
            """

        out = 
            { id = "5914b2923876e144b5cb6974"
            , name = "Awesomeness to come"
            , idBoard = "4d5ea62fd76aa1136000000c"
            , idCard = "5914b27920508fcb6bfd525f"
            , pos = 16384
            , checkItems = 
                [
                { state = Trello.CheckList.Complete
                , idChecklist = "5914b2923876e144b5cb6974"
                , id = "5914b29abcbe09ab9478d156"
                , name = "Custom Fields in CSV exports"
                -- , nameData = null
                , pos = 16867
                },
                { state = Trello.CheckList.Incomplete
                , idChecklist = "5914b2923876e144b5cb6974"
                , id = "5914b2a1ee4421b88542b59a"
                , name = "Custom Fields on mobile"
                --, nameData = null
                , pos = 34254
                },
                { state = Trello.CheckList.Incomplete
                , idChecklist = "5914b2923876e144b5cb6974"
                , id = "5914b2b2e01e5b17afedf6fc"
                , name = "Working well across multiple boards"
                -- , nameData = null
                , pos = 51540
                }
                ]
            }
    in
        json
        |> decodeString Trello.CheckList.decoder
        |> Expect.equal (Ok out)
