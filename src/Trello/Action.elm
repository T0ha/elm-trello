module Action exposing (..)

type alias Action =
    { id : String
    , idMemberCreator : String
  "data": {
    "list": {
      "name": "Professional",
      "id": "54a17e9db559f0356ce022e4"
    },
    "board": {
      "shortLink": "BdarzfKF",
      "name": "Life Goals",
      "id": "54a17d76d4a5072e3931736b"
    },
    "card": {
      "shortLink": "gplJv6dx",
      "idShort": 2,
      "name": "Increase revenue by 10%",
      "id": "54a1844d304d9736e54d2546",
      "due": "2017-12-12T17:00:00.000Z"
    },
    "old": {
      "due": "2017-05-01T16:00:00.000Z"
    }
  },
  , type : ActionType
  , date : Time
  , memberCreator : Member
  }
  {- TODO:
  "display": {
    "translationKey": "action_changed_a_due_date",
    "entities": {
      "card": {
        "type": "card",
        "due": "2017-12-12T17:00:00.000Z",
        "id": "54a1844d304d9736e54d2546",
        "shortLink": "gplJv6dx",
        "text": "Increase revenue by 10%"
      },
      "date": {
        "type": "date",
        "date": "2017-12-12T17:00:00.000Z"
      },
      "memberCreator": {
        "type": "member",
        "id": "5191197f9433cf5507006338",
        "username": "brian",
        "text": "Brian Cervino"
      }
    }
  -}

type ActionType = AddAdminToBoard
                | AddAdminToOrganization
                | AddAdminToBoard
                | AddAdminToOrganization
                | AddAttachmentToCard
                | AddBoardsPinnedToMember
                | AddChecklistToCard
                | AddLabelToCard
                | AddMemberToBoard
                | AddMemberToCard
                | AddMemberToOrganization
                | AddToOrganizationBoard
                | CommentCard
                | ConvertToCardFromCheckItem
                | CopyBoard
                | CopyCard
                | CopyChecklist
                | CreateLabel
                | CopyCommentCard
                | CreateBoard
                | CreateBoardInvitation
                | CreateBoardPreference
                | CreateCard
                | CreateChecklist
                | CreateList
                | CreateOrganization
                | CreateOrganizationInvitation
                | DeleteAttachmentFromCard
                | DeleteBoardInvitation
                | DeleteCard
                | DeleteCheckItem
                | DeleteLabel
                | DeleteOrganizationInvitation
                | DisablePlugin
                | DisablePowerUp
                | EmailCard
                | EnablePlugin
                | EnablePowerUp
                | MakeAdminOfBoard
                | MakeAdminOfOrganization
                | MakeNormalMemberOfBoard
                | MakeNormalMemberOfOrganization
                | MakeObserverOfBoard
                | MemberJoinedTrello
                | MoveCardFromBoard
                | MoveCardToBoard
                | MoveListFromBoard
                | MoveListToBoard
                | RemoveAdminFromBoard
                | RemoveAdminFromOrganization
                | RemoveBoardsPinnedFromMember
                | RemoveChecklistFromCard
                | RemoveFromOrganizationBoard
                | RemoveLabelFromCard
                | RemoveMemberFromBoard
                | RemoveMemberFromCard
                | RemoveMemberFromOrganization
                | UnconfirmedBoardInvitation
                | UnconfirmedOrganizationInvitation
                | UpdateBoard
                | UpdateCard
                | UpdateCheckItem
                | UpdateCheckItemStateOnCard
                | UpdateChecklist
                | UpdateLabel
                | UpdateList
                | UpdateMember
                | UpdateOrganization
                | VoteOnCard
