module LiveCode exposing (..)

import Html exposing (Html, Attribute, div, input, text)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String


main : Program Never
main =
    Html.beginnerProgram
        { model = init
        , update = update
        , view = view
        }
