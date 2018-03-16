import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode



main =
  Html.program
    { init = init "dogs"
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { content : String }


init : String -> (Model, Cmd msg)
init topic =
  ( Model topic, Cmd.none )



-- UPDATE


type Msg
  = MorePlease
  | NewContent (Result Http.Error String)
  | TitlePlease
  | SetOne


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SetOne ->
      (Model "1", Cmd.none)

    MorePlease ->
      (model, getBody )

    TitlePlease ->
      (model, getTitle )

    NewContent (Ok newUrl) ->
      (Model newUrl, Cmd.none)

    NewContent (Err _) ->
      (Model "456", Cmd.none)



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.content]
    , button [ onClick MorePlease ] [ text "Get body" ]
    , button [ onClick TitlePlease ] [ text "Get title" ]
    , button [ onClick SetOne ] [ text "Set head to one" ]
    ]


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- HTTP


getBody : Cmd Msg
getBody =
  let
    url =
        "https://jsonplaceholder.typicode.com/posts/1"
  in
    Http.send NewContent (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
  Decode.at ["body"] Decode.string

getTitle : Cmd Msg
getTitle =
  let
    url =
        "https://jsonplaceholder.typicode.com/posts/1"
  in
    Http.send NewContent (Http.get url decodeGifUrl2)


decodeGifUrl2 : Decode.Decoder String
decodeGifUrl2 =
  Decode.at ["title"] Decode.string
