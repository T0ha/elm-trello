# elm-trello
This is a wrapper for [Trello REST API](https://developers.trello.com/v1.0/reference).

``` shell
elm package install T0ha/elm-trello
```

To use it just add this to your code:
``` elm
import Trello
import Trello.Auth

type alias Model =
    {
    ...
    , trello : Trello.Auth
    ...
    }

initModel : Model
initModel = 
    {
    ...
    , trello = Trello.Auth "<your-trello-key>"

init = 
    initModel ! [
    Trello.Auth
        ]

```
