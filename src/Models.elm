module Models exposing (..)

import Page exposing (..)


type alias Alert =
  { kind : String
  , msg : String
  }

type alias User =
  { id : String
  , name : String
  , email : String
  , roles : List String
  , recieveEvaluationErrors : Bool
  }

type alias Jobset =
  { id : String
  , name : String
  , description : String
  , queued : Int
  , failed : Int
  , succeeded : Int
  , lastEvaluation : String
  , isShown : Bool
  }

type alias Project =
  { id : String
  , name : String
  , description : String
  , jobsets : List Jobset
  , isShown : Bool
  }

type alias HydraConfig =
  { logo : String
  , hydraVersion : String
  , nixVersion : String
  }

type alias QueueStats =
  { numBuilding : Int
  , numWaiting : Int
  , numMachines : Int
  }

type alias AppModel =
  { alert : Maybe Alert
  , hydraConfig : HydraConfig
  , projects : List Project
  , user : Maybe User
  , queueStats : QueueStats
  , searchString : String
  , currentPage : Page
  }


initialModel : AppModel
initialModel =
  { alert = Nothing
  , user = Nothing
  , currentPage = Page.Home
  , searchString = ""
  , hydraConfig =
    -- TODO: downsize logo, serve it with webpack
    { logo = "http://nixos.org/logo/nixos-logo-only-hires.png"
    , hydraVersion = "0.1.1234.abcdef"
    , nixVersion = "1.12pre1234_abcdef"
    }
  , queueStats = QueueStats 124 32345 19
  , projects =
    [ { id = "nixos"
      , name = "NixOS"
      , description = "the purely functional Linux distribution"
      , isShown = True
      , jobsets =
        [ { id = "release-16.03"
          , name = "release-16.03"
          , description = "NixOS 16.03 release branch"
          , queued = 5
          , failed = 275
          , succeeded = 24315
          , lastEvaluation = "2016-05-21 13:57:13"
          , isShown = True
          }
        , { id = "trunk-combined"
          , name = "trunk-combined"
          , description = "Combined NixOS/Nixpkgs unstable"
          , queued = 1
          , failed = 406
          , succeeded = 24243
          , lastEvaluation = "2016-05-21 13:57:03"
          , isShown = True
          }
        ]
      }
    , { id = "nix"
      , name = "Nix"
      , description = "the purely functional package manager"
      , isShown = True
      , jobsets =
        [ { id = "master"
          , name = "master"
          , description = "Master branch"
          , queued = 0
          , failed = 33
          , succeeded = 1
          , isShown = True
          , lastEvaluation = "2016-05-21 13:57:13"
          }
        ]
      }
    , { id = "nixpkgs"
      , name = "Nixpkgs"
      , description = "Nix Packages collection"
      , isShown = True
      , jobsets =
        [ { id = "trunk"
          , name = "trunk"
          , description = "Trunk"
          , isShown = True
          , queued = 0
          , failed = 7798
          , succeeded = 24006
          , lastEvaluation = "2016-05-21 13:57:13"
          }
        , { id = "staging"
          , name = "staging"
          , description = "Staging"
          , isShown = True
          , queued = 0
          , failed = 31604
          , succeeded = 63
          , lastEvaluation = "2016-05-21 13:57:03"
          }
        ]
      }
    , { id = "nixops"
      , name = "NixOps"
      , description = "Deploying NixOS machines"
      , isShown = True
      , jobsets = []
      }
    ]
  }
