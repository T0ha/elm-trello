module Checklist exposing (..)

type alias Checklist =
    { id : String
    , name : String
    , idBoard : String
    , idCard : String
    , pos : Integer
    , checkItems : List ChecklistItem
    }

type alias ChecklistItem =
    {
        , state : ChecklistItemState
        , idChecklist : String
        , id : String
        , name : String
        -- "nameData": null,
        , pos : Integer
    }

type ChecklistItemState = Complete | Incomplete
