module Domain.LibraryBook exposing (..)

import Array exposing (Array)
import Json.Decode as Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Json.Encode as Encode
import OAuth
import RemoteData exposing (WebData)
import Http

import Domain.SearchBook exposing (..)
import Utils exposing (..)

type alias LibraryBook = 
    {
        id : Int
        , title : String
        , authors : String
        , description : String
        , publishedDate : String
        , language : String
        , smallThumbnail : String
        , thumbnail : String
        , owner : String
        , location : String
    }


searchbook2librarybook : SearchBook -> LibraryBook
searchbook2librarybook searchbook =
    {
        id = 0
        , title = searchbook.title
        , authors = searchbook.authors
        , description = searchbook.description
        , publishedDate = searchbook.publishedDate
        , language = searchbook.language
        , smallThumbnail = searchbook.smallThumbnail
        , thumbnail = searchbook.thumbnail
        , owner = ""
        , location = ""
    }


librarybook2String : LibraryBook -> String
librarybook2String libraryBook =
    " id =  " ++ String.fromInt libraryBook.id
    ++ ", title = " ++ libraryBook.title
    ++ ", authors = " ++ libraryBook.authors
    ++ ", description = " ++ libraryBook.description
    ++ ", publishedDate = " ++ libraryBook.publishedDate
    ++ ", language = " ++ libraryBook.language
    ++ ", smallThumbnail = " ++ libraryBook.smallThumbnail
    ++ ", thumbnail = " ++ libraryBook.thumbnail
    ++ ", owner = " ++ libraryBook.owner
    ++ ", location = " ++ libraryBook.location

-- Opaque
emptyLibrarybook : LibraryBook
emptyLibrarybook =
    {
        id = 0
        , title = ""
        , authors = ""
        , description = ""
        , publishedDate = ""
        , language = ""
        , smallThumbnail = ""
        , thumbnail = ""
        , owner = ""
        , location = ""
    }


libraryApiBooksUrl : String
libraryApiBooksUrl = libraryApiBaseUrl ++ "/books"


getBooks : { token : OAuth.Token, msg : (WebData (Array LibraryBook) -> msg), title : String, author : String, location : String, owner : String } -> Cmd msg
getBooks { token, msg, title, author, location, owner } =
    let
        puretoken = String.dropLeft 7 (OAuth.tokenToString token) -- cutoff /Bearer /
        requestUrl = Debug.log "requestUrl" libraryApiBooksUrl ++ "?access_token=" ++ puretoken
    in
        Http.get
            { url = requestUrl
            , expect = 
                libraryBooksDecoder
                |> Http.expectJson (RemoteData.fromResult >> msg)
            }


insertBook : (Result Http.Error LibraryBook -> msg ) -> OAuth.Token -> LibraryBook -> Cmd msg
insertBook msg token libraryBook =
    let
        -- librarybook1 = Debug.log "BookSelector.insertBook " libraryBook
        puretoken = String.dropLeft 7 (OAuth.tokenToString token) -- cutoff /Bearer /
        requestUrl = Debug.log "requestUrl" libraryApiBooksUrl ++ "?access_token=" ++ puretoken
        -- requestUrl = Debug.log "requestUrl" LibraryAppApi.libraryApiBooksUrl
        jsonBody = Debug.log "jsonBody" (newLibraryBookEncoder libraryBook)
        printheaders = Debug.log "token" (OAuth.tokenToString token)
        headers = OAuth.useToken token []
        -- headers1 = Http.header
    in
        Http.post
            { url = requestUrl
            , body = Http.jsonBody (newLibraryBookEncoder libraryBook)
            , expect = Http.expectJson msg libraryBookDecoder
            }


libraryBooksDecoder : Decoder (Array LibraryBook)
libraryBooksDecoder =
    Decode.array libraryBookDecoder


libraryBookDecoder : Decoder LibraryBook
libraryBookDecoder =
    Decode.succeed LibraryBook
        |> required "id" int
        |> required "title" string
        |> required "authors" string
        |> required "description" string
        |> optional "publishedDate" string ""
        |> optional "language" string ""
        |> optional "smallThumbnail" string ""
        |> optional "thumbnail" string ""
        |> optional "owner" string ""
        |> optional "location" string ""


setTitle : String -> LibraryBook -> LibraryBook
setTitle title libraryBook =
    { libraryBook | title = title }


setAuthors : String -> LibraryBook -> LibraryBook
setAuthors authors libraryBook =
    { libraryBook | authors = authors }


setDescription : String -> LibraryBook -> LibraryBook
setDescription description libraryBook =
    { libraryBook | description = description }


setPublishedDate : String -> LibraryBook -> LibraryBook
setPublishedDate publishedDate libraryBook =
    { libraryBook | publishedDate = publishedDate }


setLanguage : String -> LibraryBook -> LibraryBook
setLanguage language libraryBook =
    { libraryBook | language = language }


setOwner : String -> LibraryBook -> LibraryBook
setOwner owner libraryBook =
    { libraryBook | owner = owner }


    
setLocation : String -> LibraryBook -> LibraryBook
setLocation location libraryBook =
    { libraryBook | location = location }



libraryBookEncoder : LibraryBook -> Encode.Value
libraryBookEncoder libraryBook =
    Encode.object
        [ ( "id", Encode.int libraryBook.id )
        , ( "title", Encode.string libraryBook.title )
        , ( "authors", Encode.string libraryBook.authors )
        , ( "description", Encode.string libraryBook.description )
        , ( "publishedDate", Encode.string libraryBook.publishedDate )
        , ( "language", Encode.string libraryBook.language )
        , ( "smallThumbnail", Encode.string libraryBook.smallThumbnail )
        , ( "thumbnail", Encode.string libraryBook.thumbnail )
        , ( "owner", Encode.string libraryBook.owner )
        , ( "location", Encode.string libraryBook.location )
        ]


newLibraryBookEncoder : LibraryBook -> Encode.Value
newLibraryBookEncoder libraryBook =
    let a = Debug.log "libraryBookEncoder" libraryBook
    in
    Encode.object
        [ ( "title", Encode.string libraryBook.title )
        , ( "authors", Encode.string libraryBook.authors )
        , ( "description", Encode.string libraryBook.description )
        , ( "publishedDate", Encode.string libraryBook.publishedDate )
        , ( "language", Encode.string libraryBook.language )
        , ( "smallThumbnail", Encode.string libraryBook.smallThumbnail )
        , ( "thumbnail", Encode.string libraryBook.thumbnail )
        , ( "owner", Encode.string libraryBook.owner )
        , ( "location", Encode.string libraryBook.location )
        ]


