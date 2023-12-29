module Evergreen.Migrate.V19 exposing (..)

{-| This migration file was automatically generated by the lamdera compiler.

It includes:

  - A migration for each of the 6 Lamdera core types that has changed
  - A function named `migrate_ModuleName_TypeName` for each changed/custom type

Expect to see:

  - `Unimplementеd` values as placeholders wherever I was unable to figure out a clear migration path for you
  - `@NOTICE` comments for things you should know about, i.e. new custom type constructors that won't get any
    value mappings from the old type by default

You can edit this file however you wish! It won't be generated again.

See <https://dashboard.lamdera.com/docs/evergreen> for more info.

-}

import Dict
import Evergreen.V16.Translation
import Evergreen.V16.Types
import Evergreen.V19.Translation
import Evergreen.V19.Types
import Lamdera.Migrations exposing (..)
import List
import Maybe


frontendModel : Evergreen.V16.Types.FrontendModel -> ModelMigration Evergreen.V19.Types.FrontendModel Evergreen.V19.Types.FrontendMsg
frontendModel old =
    ModelMigrated ( migrate_Types_FrontendModel old, Cmd.none )


backendModel : Evergreen.V16.Types.BackendModel -> ModelMigration Evergreen.V19.Types.BackendModel Evergreen.V19.Types.BackendMsg
backendModel old =
    ModelMigrated ( migrate_Types_BackendModel old, Cmd.none )


frontendMsg : Evergreen.V16.Types.FrontendMsg -> MsgMigration Evergreen.V19.Types.FrontendMsg Evergreen.V19.Types.FrontendMsg
frontendMsg old =
    MsgMigrated ( migrate_Types_FrontendMsg old, Cmd.none )


toBackend : Evergreen.V16.Types.ToBackend -> MsgMigration Evergreen.V19.Types.ToBackend Evergreen.V19.Types.BackendMsg
toBackend old =
    MsgUnchanged


backendMsg : Evergreen.V16.Types.BackendMsg -> MsgMigration Evergreen.V19.Types.BackendMsg Evergreen.V19.Types.BackendMsg
backendMsg old =
    MsgUnchanged


toFrontend : Evergreen.V16.Types.ToFrontend -> MsgMigration Evergreen.V19.Types.ToFrontend Evergreen.V19.Types.FrontendMsg
toFrontend old =
    MsgMigrated ( migrate_Types_ToFrontend old, Cmd.none )


migrate_Types_BackendModel : Evergreen.V16.Types.BackendModel -> Evergreen.V19.Types.BackendModel
migrate_Types_BackendModel old =
    { currentSaltIndex = old.currentSaltIndex
    , users =
        Dict.union old.passiveUsers
            (Dict.values old.activeSessions
                |> List.map (\v -> ( v.user.username, v.user ))
                |> Dict.fromList
            )
            |> Dict.toList
            |> List.map (\( k, v ) -> ( k, migrate_User v ))
            |> Dict.fromList
    , sessions =
        Dict.map
            (\_ v ->
                { created = v.created
                , username = v.user.username
                }
            )
            old.activeSessions
    , currentTime = old.currentTime
    }


migrate_User : Evergreen.V16.Types.User -> Evergreen.V19.Types.User
migrate_User user =
    { username = user.username
    , passwordHash = user.passwordHash
    , passwordSalt = user.passwordSalt
    , pastDictations = user.pastDictations |> List.map migrate_Types_PastDictation
    , settings = migrate_Types_Settings user.settings
    }


migrate_PastDictation : Evergreen.V16.Types.PastDictation -> Evergreen.V19.Types.PastDictation
migrate_PastDictation past =
    { errors = past.errors, lesson = migrate_Types_Lesson past.lesson, duration = past.duration, finished = past.finished }


migrate_Lesson : Evergreen.V16.Types.Lesson -> Evergreen.V19.Types.Lesson
migrate_Lesson lesson =
    { layout = Maybe.map migrate_Layout lesson.layout, title = lesson.title, content = lesson.content }


migrate_Layout : Evergreen.V16.Types.Layout -> Evergreen.V19.Types.Layout
migrate_Layout layout =
    case layout of
        Evergreen.V16.Types.Neo ->
            Evergreen.V19.Types.Neo

        Evergreen.V16.Types.NeoQwertz ->
            Evergreen.V19.Types.NeoQwertz

        Evergreen.V16.Types.Bone ->
            Evergreen.V19.Types.Bone

        Evergreen.V16.Types.AdNW ->
            Evergreen.V19.Types.AdNW

        Evergreen.V16.Types.KOY ->
            Evergreen.V19.Types.KOY

        Evergreen.V16.Types.NeoQwerty ->
            Evergreen.V19.Types.NeoQwerty

        Evergreen.V16.Types.Vou ->
            Evergreen.V19.Types.Vou

        Evergreen.V16.Types.Mine ->
            Evergreen.V19.Types.Mine


migrate_Types_FrontendModel : Evergreen.V16.Types.FrontendModel -> Evergreen.V19.Types.FrontendModel
migrate_Types_FrontendModel old =
    { key = old.key
    , page = old.page |> migrate_Types_Page
    , settings = old.settings |> migrate_Types_Settings
    , statistic = old.statistic |> List.map migrate_Types_PastDictation
    , authorised = old.authorised
    , appStatistic = { userCount = old.usersCount, pastDictationCount = 0 }
    }


migrate_Translation_Language : Evergreen.V16.Translation.Language -> Evergreen.V19.Translation.Language
migrate_Translation_Language old =
    case old of
        Evergreen.V16.Translation.German ->
            Evergreen.V19.Translation.German

        Evergreen.V16.Translation.English ->
            Evergreen.V19.Translation.English


migrate_Types_AuthModel : Evergreen.V16.Types.AuthModel -> Evergreen.V19.Types.AuthModel
migrate_Types_AuthModel old =
    { username = old.username
    , password = old.password
    , passwordVisibility = old.passwordVisibility
    , failed = old.failed |> migrate_Types_LoginFail
    }


migrate_Types_AuthMsg : Evergreen.V16.Types.AuthMsg -> Evergreen.V19.Types.AuthMsg
migrate_Types_AuthMsg old =
    case old of
        Evergreen.V16.Types.SetUsername p0 ->
            Evergreen.V19.Types.SetUsername p0

        Evergreen.V16.Types.SetPassword p0 ->
            Evergreen.V19.Types.SetPassword p0

        Evergreen.V16.Types.SetVisibility p0 ->
            Evergreen.V19.Types.SetVisibility p0

        Evergreen.V16.Types.TryLogin p0 p1 ->
            Evergreen.V19.Types.TryLogin p0 p1

        Evergreen.V16.Types.TryRegister p0 p1 ->
            Evergreen.V19.Types.TryRegister p0 p1

        Evergreen.V16.Types.ToInfo ->
            Evergreen.V19.Types.ToInfo

        Evergreen.V16.Types.WithoutLogin ->
            Evergreen.V19.Types.WithoutLogin

        Evergreen.V16.Types.ToggleTranslation ->
            Evergreen.V19.Types.ToggleTranslation


migrate_Types_Bucket : Evergreen.V16.Types.Bucket -> Evergreen.V19.Types.Bucket
migrate_Types_Bucket old =
    old |> List.map migrate_Types_PastDictation


migrate_Types_Dictation : Evergreen.V16.Types.Dictation -> Evergreen.V19.Types.Dictation
migrate_Types_Dictation old =
    old


migrate_Types_FrontendMsg : Evergreen.V16.Types.FrontendMsg -> Evergreen.V19.Types.FrontendMsg
migrate_Types_FrontendMsg old =
    case old of
        Evergreen.V16.Types.UrlClicked p0 ->
            Evergreen.V19.Types.UrlClicked p0

        Evergreen.V16.Types.UrlChanged p0 ->
            Evergreen.V19.Types.UrlChanged p0

        Evergreen.V16.Types.NoOpFrontendMsg ->
            Evergreen.V19.Types.NoOpFrontendMsg

        Evergreen.V16.Types.PageMsg p0 ->
            Evergreen.V19.Types.PageMsg (p0 |> migrate_Types_PageMsg)

        Evergreen.V16.Types.Back ->
            Evergreen.V19.Types.Back

        Evergreen.V16.Types.SetSettings p0 ->
            Evergreen.V19.Types.SetSettings (p0 |> migrate_Types_Settings)

        Evergreen.V16.Types.OnHover p0 ->
            Evergreen.V19.Types.OnHover (p0 |> migrate_Types_Hover)

        Evergreen.V16.Types.Logout ->
            Evergreen.V19.Types.Logout

        Evergreen.V16.Types.FinishedDictation p0 p1 p2 p3 ->
            Evergreen.V19.Types.FinishedDictation p0 (p1 |> migrate_Types_Lesson) p2 p3

        Evergreen.V16.Types.ChangePage p0 ->
            Evergreen.V19.Types.ChangePage (p0 |> migrate_Types_Page)


migrate_Types_Hover : Evergreen.V16.Types.Hover -> Evergreen.V19.Types.Hover
migrate_Types_Hover old =
    old |> migrate_Types_Bucket


migrate_Types_KeyboardKey : Evergreen.V16.Types.KeyboardKey -> Evergreen.V19.Types.KeyboardKey
migrate_Types_KeyboardKey old =
    case old of
        Evergreen.V16.Types.Character p0 ->
            Evergreen.V19.Types.Character p0

        Evergreen.V16.Types.Control p0 ->
            Evergreen.V19.Types.Control p0


migrate_Types_Layout : Evergreen.V16.Types.Layout -> Evergreen.V19.Types.Layout
migrate_Types_Layout old =
    case old of
        Evergreen.V16.Types.Neo ->
            Evergreen.V19.Types.Neo

        Evergreen.V16.Types.NeoQwertz ->
            Evergreen.V19.Types.NeoQwertz

        Evergreen.V16.Types.Bone ->
            Evergreen.V19.Types.Bone

        Evergreen.V16.Types.AdNW ->
            Evergreen.V19.Types.AdNW

        Evergreen.V16.Types.KOY ->
            Evergreen.V19.Types.KOY

        Evergreen.V16.Types.NeoQwerty ->
            Evergreen.V19.Types.NeoQwerty

        Evergreen.V16.Types.Vou ->
            Evergreen.V19.Types.Vou

        Evergreen.V16.Types.Mine ->
            Evergreen.V19.Types.Mine


migrate_Types_Lesson : Evergreen.V16.Types.Lesson -> Evergreen.V19.Types.Lesson
migrate_Types_Lesson old =
    { layout = old.layout |> Maybe.map migrate_Types_Layout
    , title = old.title
    , content = old.content
    }


migrate_Types_LoginFail : Evergreen.V16.Types.LoginFail -> Evergreen.V19.Types.LoginFail
migrate_Types_LoginFail old =
    case old of
        Evergreen.V16.Types.NotAsked ->
            Evergreen.V19.Types.NotAsked

        Evergreen.V16.Types.WrongUsernameOrPassword ->
            Evergreen.V19.Types.WrongUsernameOrPassword

        Evergreen.V16.Types.UsernameOrPasswordInvalid ->
            Evergreen.V19.Types.UsernameOrPasswordInvalid


migrate_Types_Menu : Evergreen.V16.Types.Menu -> Evergreen.V19.Types.Menu
migrate_Types_Menu old =
    { current = old.current |> Maybe.map migrate_Types_Lesson
    }


migrate_Types_Mods : Evergreen.V16.Types.Mods -> Evergreen.V19.Types.Mods
migrate_Types_Mods old =
    old


migrate_Types_Page : Evergreen.V16.Types.Page -> Evergreen.V19.Types.Page
migrate_Types_Page old =
    case old of
        Evergreen.V16.Types.MenuPage p0 ->
            Evergreen.V19.Types.MenuPage (p0 |> migrate_Types_Menu)

        Evergreen.V16.Types.TypingPage p0 ->
            Evergreen.V19.Types.TypingPage (p0 |> migrate_Types_TypingModel)

        Evergreen.V16.Types.TypingStatisticPage p0 ->
            Evergreen.V19.Types.TypingStatisticPage (p0 |> migrate_Types_TypingStatisticModel)

        Evergreen.V16.Types.SettingsPage p0 ->
            Evergreen.V19.Types.SettingsPage p0

        Evergreen.V16.Types.StatisticPage p0 ->
            Evergreen.V19.Types.StatisticPage (p0 |> migrate_Types_Hover)

        Evergreen.V16.Types.AuthPage p0 ->
            Evergreen.V19.Types.AuthPage (p0 |> migrate_Types_AuthModel)

        Evergreen.V16.Types.InfoPage ->
            Evergreen.V19.Types.InfoPage


migrate_Types_PageMsg : Evergreen.V16.Types.PageMsg -> Evergreen.V19.Types.PageMsg
migrate_Types_PageMsg old =
    case old of
        Evergreen.V16.Types.TypingMsg p0 ->
            Evergreen.V19.Types.TypingMsg (p0 |> migrate_Types_TypingMsg)

        Evergreen.V16.Types.AuthMsg p0 ->
            Evergreen.V19.Types.AuthMsg (p0 |> migrate_Types_AuthMsg)

        Evergreen.V16.Types.SettingsMsg p0 ->
            Evergreen.V19.Types.SettingsMsg (p0 |> migrate_Types_SettingsMsg)


migrate_Types_PastDictation : Evergreen.V16.Types.PastDictation -> Evergreen.V19.Types.PastDictation
migrate_Types_PastDictation old =
    { errors = old.errors
    , lesson = old.lesson |> migrate_Types_Lesson
    , duration = old.duration
    , finished = old.finished
    }


migrate_Types_Settings : Evergreen.V16.Types.Settings -> Evergreen.V19.Types.Settings
migrate_Types_Settings old =
    { blockOnError = old.blockOnError |> migrate_Types_WaitingFor
    , fontSize = old.fontSize
    , paddingLeft = old.paddingLeft
    , paddingRight = old.paddingRight
    , layout = old.layout |> migrate_Types_Layout
    , theme = old.theme |> migrate_Types_Theme
    , language = old.language |> migrate_Translation_Language
    }


migrate_Types_SettingsMsg : Evergreen.V16.Types.SettingsMsg -> Evergreen.V19.Types.SettingsMsg
migrate_Types_SettingsMsg old =
    case old of
        Evergreen.V16.Types.SetLayer p0 ->
            Evergreen.V19.Types.SetLayer p0


migrate_Types_Theme : Evergreen.V16.Types.Theme -> Evergreen.V19.Types.Theme
migrate_Types_Theme old =
    { name = old.name |> migrate_Types_ThemeName
    , dark = old.dark
    , rounding = old.rounding
    , borderWidth = old.borderWidth
    }


migrate_Types_ThemeName : Evergreen.V16.Types.ThemeName -> Evergreen.V19.Types.ThemeName
migrate_Types_ThemeName old =
    case old of
        Evergreen.V16.Types.WheatField ->
            Evergreen.V19.Types.WheatField

        Evergreen.V16.Types.ElectricFields ->
            Evergreen.V19.Types.ElectricFields

        Evergreen.V16.Types.CandyLand ->
            Evergreen.V19.Types.CandyLand

        Evergreen.V16.Types.NeoClassic ->
            Evergreen.V19.Types.NeoClassic

        Evergreen.V16.Types.Dracula ->
            Evergreen.V19.Types.Dracula


migrate_Types_ToFrontend : Evergreen.V16.Types.ToFrontend -> Evergreen.V19.Types.ToFrontend
migrate_Types_ToFrontend old =
    case old of
        Evergreen.V16.Types.GotSettings p0 ->
            Evergreen.V19.Types.GotSettings (p0 |> migrate_Types_Settings)

        Evergreen.V16.Types.KickOut ->
            Evergreen.V19.Types.KickOut

        Evergreen.V16.Types.RegisterFailed ->
            Evergreen.V19.Types.RegisterFailed

        Evergreen.V16.Types.LoginSuccessful ->
            Evergreen.V19.Types.LoginSuccessful

        Evergreen.V16.Types.LoginFailed ->
            Evergreen.V19.Types.LoginFailed

        Evergreen.V16.Types.UpdateStatistic p0 ->
            Evergreen.V19.Types.UpdateStatistic (p0 |> List.map migrate_Types_PastDictation)

        Evergreen.V16.Types.UpdateUserCount p0 ->
            Evergreen.V19.Types.UpdateAppStatistic { userCount = p0, pastDictationCount = 0 }

        Evergreen.V16.Types.UpdateAllPoints p0 ->
            Evergreen.V19.Types.UpdateAllPoints p0


migrate_Types_TypingModel : Evergreen.V16.Types.TypingModel -> Evergreen.V19.Types.TypingModel
migrate_Types_TypingModel old =
    { dictation = old.dictation |> migrate_Types_Dictation
    , madeError = old.madeError
    , errors = old.errors
    , mods = old.mods |> migrate_Types_Mods
    , lesson = old.lesson |> migrate_Types_Lesson
    , duration = old.duration
    , paused = old.paused
    , showKeyboard = old.showKeyboard
    , textOffset = old.textOffset
    , textSpeed = old.textSpeed
    }


migrate_Types_TypingMsg : Evergreen.V16.Types.TypingMsg -> Evergreen.V19.Types.TypingMsg
migrate_Types_TypingMsg old =
    case old of
        Evergreen.V16.Types.KeyDown p0 ->
            Evergreen.V19.Types.KeyDown (p0 |> migrate_Types_KeyboardKey)

        Evergreen.V16.Types.KeyUp p0 ->
            Evergreen.V19.Types.KeyUp (p0 |> migrate_Types_KeyboardKey)

        Evergreen.V16.Types.TickTypingTime ->
            Evergreen.V19.Types.TickTypingTime

        Evergreen.V16.Types.AnimationFrameDelta p0 ->
            Evergreen.V19.Types.AnimationFrameDelta p0

        Evergreen.V16.Types.Pause ->
            Evergreen.V19.Types.Pause

        Evergreen.V16.Types.Play ->
            Evergreen.V19.Types.Play

        Evergreen.V16.Types.ToggleKeyboard ->
            Evergreen.V19.Types.ToggleKeyboard

        Evergreen.V16.Types.Exit ->
            Evergreen.V19.Types.Exit


migrate_Types_TypingStatisticModel : Evergreen.V16.Types.TypingStatisticModel -> Evergreen.V19.Types.TypingStatisticModel
migrate_Types_TypingStatisticModel old =
    { past = old.past |> migrate_Types_PastDictation
    , allPoints = old.allPoints
    , fromLesson = False
    }


migrate_Types_WaitingFor : Evergreen.V16.Types.WaitingFor -> Evergreen.V19.Types.WaitingFor
migrate_Types_WaitingFor old =
    case old of
        Evergreen.V16.Types.OneBackspace ->
            Evergreen.V19.Types.OneBackspace

        Evergreen.V16.Types.CorrectLetter ->
            Evergreen.V19.Types.CorrectLetter
