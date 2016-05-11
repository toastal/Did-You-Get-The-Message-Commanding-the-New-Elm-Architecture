# Did You Get The Message?
### Commanding the New Elm Architecture


* * *


## What is Elm?

Elm is a ~~functional reactive programming~~ command-and-subscribe-based, functional language built from the ground up to a be the best language for making UIs.

But before we go more into that...


* * *


## How Did We Get Here?


* * *


## jQuery

For better or worse, it changed the game.


- - -

## What Failed and Why Did We Move On

- State was stored in the DOM
- To get state, we'd requery that DOM
- Querying the DOM is slow
- State had to be stored in the DOM
- Or we'd call an API to get brand new DOM
- No single source of truth


* * *


## React's `setState`

React's built-in state management... state no longer tied to the DOM


- - -


## What Failed and Why Did We Move On

- Somewhat controlled, but ultimately imperative and mutative API
- Like jQuery, the data is tied to the 'element'
- Component 'owning' data isn't so cool
- Performance cost of not using pure render
- Passing around state/props to components is a bear
- No single source of truth


* * *


## Myriad of Flux Libraries

A story of stores... state belongs outside the components, data flows one way


- - -


## The real winner here was Redux

- Single state atom
- Encourages you not to use local state (ignore most parts of React)
- Query stores, not state


* * *


## Where did Redux get its inspiration?


* * *


## The Elm Architecture

Literally.


* * *


## The 2016 Front-End Developer Toolkit

| JavaScript    | Elm                     |
| ------------- | ----------------------- |
| Babel         | Elm *(compiler)*        |
| Redux         | Elm *(design pattern)*  |
| Flow          | Elm *(type annotation)* |
| Ramda, Lodash | Elm *(stdlib)*          |
| React         | elm-html\*              |
| ESLint        | elm-format              |
| Mocha, et.al  | elm-test                |

\* For rendering stateless components only


* * *


![That important meme image]


* * *


## Babel

`elm-make` compiles to ECMAScript 5 so it's compatible with all the things you care about.


* * *


## Flow

Elm's a strong statically-typed language with type inference.


- - -


### This fails

```elm
import Html exposing (Html, text)

exclaim : String -> String
exclaim string =
   string ++ "!"

view : String -> Html String
view string =
  text (exclaim string)

main : Html String
main =
  view 42
```


* * *


## Ramda / Lodash & Stateless Components

The core library has utility functions for Lists, Arrays, Sets, Dictionaries, Strings, Signals, Maybes...

`elm-html` supports all your virtual DOM needs

*Note: doesn't support higher-kinded polymorphism*


- - -


## Wow it has composition too

```elm
import Html exposing (Html, h2, text)
import String

exclaim : String -> String
exclaim string =
   string ++ "!"

view : List String -> Html
view =
  let
    heading string = h2 [] [ text string ]
  in
    heading << String.join " " << List.map exclaim

main : Html
main =
  view ["Hello", "Darkness", "My",  "Old", "Friend"]
```

* * *


## What if Redux was only a design pattern instead of a whole library?


- - -


## The (New) Elm Architecture

```elm
-- Model aka State

-- View aka stateless component
-- Sends commands (dispatches actions)
view : Model -> Html Msg

-- Reducer
update : Msg -> Model -> Model
```


* * *


## Live coding???

string reverser + string shouter

```elm
import Html exposing (Html, Attribute, div, input, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
```


- - -


## The cheat (in case I stumble)

```elm
import Html exposing (Html, Attribute, div, input, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String


type alias Model =
 { reverse : String
 , shout : String
 }


init =
  { reverse = ""
  , shout = ""
  }


type Msg
  = Reverse String
  | Shout String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Reverse val ->
      { model | reverse = val }

    Shout val ->
      { model | shout = val }

    _ ->
      model


view : Model -> Html Msg
view { reverse, shout } =
  div []
    [ input [ placeholder "Reverse me", onInput Reverse ] []
    , div [] [ text <| String.reverse reverse ]
    , input [ placeholder "Shout me", onInput Shout ] []
    , div [] [ text <| String.toUpper shout ]
    ]


main =
  Html.beginnerProgram
    { model = init
    , update = update
    , view = view
    }
```
