module StandardLibrary exposing (..)

import Html exposing (Html, h2, text)
import String


exclaim : String -> String
exclaim string =
    string ++ "!"


view : List String -> Html
view =
    let
        heading string =
            h2 [] [ text string ]
    in
        heading << String.join " " << List.map exclaim


main : Html
main =
    view [ "Hello", "Darkness", "My", "Old", "Friend" ]
