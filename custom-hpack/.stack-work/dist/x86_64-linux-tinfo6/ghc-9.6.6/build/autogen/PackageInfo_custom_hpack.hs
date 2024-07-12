{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_custom_hpack (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "custom_hpack"
version :: Version
version = Version [0,34,2] []

synopsis :: String
synopsis = "A modern format for Haskell packages"
copyright :: String
copyright = ""
homepage :: String
homepage = ""
