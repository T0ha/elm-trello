module Card exposing (..)

type alias Card = 
    { id : String
    {- "badges": {
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
    -- , checkItemStates : List String
    -}
    , closed : Boolean
    , dueComplete : Boolean
    , dateLastActivity : Time
    , desc : String
    -- "descData": null,
    , due : Time
    , email : String
    , idBoard : String
    , idChecklists : List String
    , idList : String
    , idMembers : List String
    , idMembersVoted : List String
    , idShort : Integer
    , idAttachmentCover : String
    , manualCoverAttachment : Boolean
    , labels : List Label
    , idLabels : List String
    , name : String
    , pos : Integer
    , shortLink : String
    , shortUrl : String
    , subscribed : Boolean
    , url : String
    }
