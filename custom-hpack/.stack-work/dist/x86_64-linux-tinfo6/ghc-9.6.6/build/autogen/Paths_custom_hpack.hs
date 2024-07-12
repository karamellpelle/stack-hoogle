{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_custom_hpack (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,34,2] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/karamellpelle/Source/stack-hoogle/.stack-work/install/x86_64-linux-tinfo6/af34bd7f761eb8997b7fe20bf1e7cdfe334c68bc8dfc172f186b8beacec299c2/9.6.6/bin"
libdir     = "/home/karamellpelle/Source/stack-hoogle/.stack-work/install/x86_64-linux-tinfo6/af34bd7f761eb8997b7fe20bf1e7cdfe334c68bc8dfc172f186b8beacec299c2/9.6.6/lib/x86_64-linux-ghc-9.6.6/custom-hpack-0.34.2-4qSkyTbj3Uw7pVOPTG9G7W"
dynlibdir  = "/home/karamellpelle/Source/stack-hoogle/.stack-work/install/x86_64-linux-tinfo6/af34bd7f761eb8997b7fe20bf1e7cdfe334c68bc8dfc172f186b8beacec299c2/9.6.6/lib/x86_64-linux-ghc-9.6.6"
datadir    = "/home/karamellpelle/Source/stack-hoogle/.stack-work/install/x86_64-linux-tinfo6/af34bd7f761eb8997b7fe20bf1e7cdfe334c68bc8dfc172f186b8beacec299c2/9.6.6/share/x86_64-linux-ghc-9.6.6/custom-hpack-0.34.2"
libexecdir = "/home/karamellpelle/Source/stack-hoogle/.stack-work/install/x86_64-linux-tinfo6/af34bd7f761eb8997b7fe20bf1e7cdfe334c68bc8dfc172f186b8beacec299c2/9.6.6/libexec/x86_64-linux-ghc-9.6.6/custom-hpack-0.34.2"
sysconfdir = "/home/karamellpelle/Source/stack-hoogle/.stack-work/install/x86_64-linux-tinfo6/af34bd7f761eb8997b7fe20bf1e7cdfe334c68bc8dfc172f186b8beacec299c2/9.6.6/etc"

getBinDir     = catchIO (getEnv "custom_hpack_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "custom_hpack_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "custom_hpack_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "custom_hpack_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "custom_hpack_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "custom_hpack_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
