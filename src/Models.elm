module Models exposing (..)


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
  }

type alias Project =
  { id : String
  , name : String
  , description : String
  , jobsets : List Jobset
  }

type alias HydraConfig =
  { logo : String
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
  }


initialModel : AppModel
initialModel =
  { alert = Nothing
  , user = Nothing
  , hydraConfig = HydraConfig "http://nixos.org/logo/nixos-logo-only-hires.png" -- TODO: downsize
  , queueStats = QueueStats 124 32345 19
  , projects =
    [ { id = "nixos"
      , name = "NixOS"
      , description = "the purely functional Linux distribution"
      , jobsets =
        [ { id = "release-16.03"
          , name = "release-16.03"
          , description = "NixOS 16.03 release branch"
          , queued = 5
          , failed = 275
          , succeeded = 24315
          , lastEvaluation = "2016-05-21 13:57:13"
          }
        , { id = "trunk-combined"
          , name = "trunk-combined"
          , description = "Combined NixOS/Nixpkgs unstable"
          , queued = 1
          , failed = 406
          , succeeded = 24243
          , lastEvaluation = "2016-05-21 13:57:03"
          }
        ]
      }
    , { id = "nix"
      , name = "Nix"
      , description = "the purely functional package manager"
      , jobsets =
        [ { id = "master"
          , name = "master"
          , description = "Master branch"
          , queued = 0
          , failed = 33
          , succeeded = 1
          , lastEvaluation = "2016-05-21 13:57:13"
          }
        ]
      }
    , { id = "nixpkgs"
      , name = "Nixpkgs"
      , description = "Nix Packages collection"
      , jobsets =
        [ { id = "trunk"
          , name = "trunk"
          , description = "Trunk"
          , queued = 0
          , failed = 7798
          , succeeded = 24006
          , lastEvaluation = "2016-05-21 13:57:13"
          }
        , { id = "staging"
          , name = "staging"
          , description = "Staging"
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
      , jobsets = []
      }
    ]
  }
