## Did You Get The Message?
### Commanding the New Elm Architecture

<a href="http://elm-lang.org/"><img alt="Elm logo" title="Elm" src="images/elm-logo.svg" style="height:16vh;vertical-align:middle;border:0;box-shadow:none"></a>

Kyle J. Kress - @toastal


* * *


## What is Elm?

Elm is a ~~functional reactive programming~~ concurent functional programming language built from the ground up to a be the best language for building UIs.

But before we go more into that...


* * *


## How Did We Get Here?


* * *


<h2><img alt="jQuery" title="jQuery" src="images/jquery-logo.svg" style="height:15vh;vertical-align:middle;border:0;box-shadow:none"></h2>

For better or worse, it changed the game.


- - -


## What failed
### & why did we move on

- State was stored in the DOM
- To get state, we'd requery that DOM
- Querying the DOM is slow
- State had to be stored in the DOM
- Or we'd call an API to get brand new DOM
- No single source of truth


* * *


## <img alt="React" title="React" src="images/react-logo.svg" style="height:1.1em;vertical-align:middle;border:0;box-shadow:none">'s `setState`

React's built-in state management... state no longer tied to the DOM


- - -


## What failed
### & why did we move on

- Somewhat controlled, but ultimately imperative and mutative API
- Like jQuery, the data is tied to the 'element'
- Component 'owning' data isn't so cool
- Performance cost of not using pure render
- Passing around state/props to components is a bear
- No single source of truth


* * *


## Myriad of <img alt="Flux" title="Flux" src="images/flux-logo.svg" style="height:1.8em;vertical-align:middle;border:0;box-shadow:none"> Libraries

A story of stores... state belongs outside the components, data flows one way


- - -


## The real winner here was Redux

- Encourages you not to use local state
- ...Ignoring most parts of React and using React just to render stateless components
- Query stores, never component state
- Single state atom

* * *


## Where did <img alt="Redux" title="Redux" src="images/redux-logo.svg" style="height:1.1em;vertical-align:middle;border:0;box-shadow:none"> get its inspiration?


* * *


<img alt="Elm logo" title="Elm" src="images/elm-logo.svg" style="height:16vh;vertical-align:middle;border:0;box-shadow:none">

## The Elm Architecture

Literally.


* * *


### The 2016 Front-End Developer Toolkit

| JavaScript               | Elm                     |
| ------------------------ | ----------------------- |
| Babel                    | Elm *(compiler)*        |
| Redux                    | Elm *(design pattern)*  |
| Flow                     | Elm *(type annotation)* |
| Immutable, Ramda, Lodash | Elm *(stdlib)*          |
| React                    | html\*                  |
| ESLint                   | elm-format              |
| Mocha, Chai, et.al.      | elm-test                |

\* For rendering stateless components only


* * *


<img alt="Meme: The 2016 Front-End Leet Toolkit vs. Elm" src="images/elm-vs-front-end.png" style="height:80vh;border:0">


* * *


## <img alt="Babel" title="Babel" src="images/babel-logo.svg" style="height:16vh;vertical-align:middle;border:0;box-shadow:none">

`elm-make` compiles to ECMAScript 5 so it's compatible with all the things you care about.


* * *


## <img alt="Flow" title="Flow" src="images/flow-logo.png" style="height:17vh;vertical-align:middle;border:0;box-shadow:none">

Elm's a strong statically-typed language with type inference.


- - -


### This fails (so do other things)

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


## <img alt="Immutable" title="Immutable" src="images/immutable-logo.svg" style="height:1em;vertical-align:middle;border:0;box-shadow:none"> / <img alt="Ramda" title="Ramda" src="images/ramda-logo.svg" style="height:1.1em;vertical-align:middle;border:0;box-shadow:none"> / <img alt="Lodash" title="Lodash" src="images/lodash-logo.svg" style="height:1.1em;vertical-align:middle;border:0;box-shadow:none"> & Stateless Components

The core library has utility functions for Lists, Arrays, Sets, Dictionaries, Strings, Maybes...

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


## What if <img alt="Redux" title="Redux" src="images/redux-logo.svg" style="height:1.1em;vertical-align:middle;border:0;box-shadow:none"> was only a design pattern instead of a whole library?


- - -


## The (New) <img alt="Elm" title="Elm" src="images/elm-logo.svg" style="height:0.9em;vertical-align:middle;border:0;box-shadow:none"> Architecture

```elm
-- Model aka State
init : Model

-- View aka stateless component
-- Sends commands (dispatches actions)
view : Model -> Html Msg

-- Update aka Reducer
-- combines the message (action) and the current model to create
-- a new model for the state
-- Uses unions types and pattern matching
update : Msg -> Model -> Model
```


* * *


## Live <img alt="Elm" title="Elm" src="images/elm-logo.svg" style="height:0.9em;vertical-align:middle;border:0;box-shadow:none"> coding???

string reverser + string shouter

```elm
import Html exposing (Html, Attribute, div, input, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String


main =
  Html.beginnerProgram
    { model = init
    , update = update
    , view = view
    }
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


init : Model
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
    Reverse str ->
      { model | reverse = str }

    Shout str ->
      { model | shout = str }


view : Model -> Html Msg
view { reverse, shout } =
  div []
    [ input [ type' "text", placeholder "Reverse me", value reverse, onInput Reverse ] []
    , div [] [ text <| String.reverse reverse ]
    , input [ type' "text", placeholder "Shout me", value shout, onInput Shout ] []
    , div [] [ text <| String.toUpper shout ]
    ]


main =
  Html.beginnerProgram
    { model = init
    , update = update
    , view = view
    }
```


* * *


## But how easy is it to get <img alt="Elm" title="Elm" src="images/elm-logo.svg" style="height:0.9em;vertical-align:middle;border:0;box-shadow:none"> into an existing app?


- - -


### From the docs.

```bash
elm make src/MyThing.elm --output=my-thing.js
```

```js
var Elm = Elm || {};
Elm.MyThing = {
    fullscreen: function() { /* take over the <body> */ },
    embed: function(node) { /* take over the given node */ },
    worker: function() { /* run the program with no UI */ }
};
```


* * *


## Going deeper

- Effects: Commands, Subscriptions (Random # Gen., HTTP/REST, Time, Animation, Web Sockets)
- Nested Components
- Ports
- Results: Error Handling

[Read the guide](http://guide.elm-lang.org/)


* * *


## Thanks.

You can follow me on Twitter @toastal
