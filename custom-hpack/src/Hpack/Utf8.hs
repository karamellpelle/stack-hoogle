module Hpack.Utf8 (
  encodeUtf8
, readFile
, writeFile
, putStr
, hPutStr
, hPutStrLn
) where

import           Prelude hiding (readFile, writeFile, putStr)

import qualified Data.Text as T
import qualified Data.Text.Encoding as Encoding
import           Data.Text.Encoding.Error (lenientDecode)
import qualified Data.ByteString as B
import           System.IO (Handle, stdout, IOMode(..), withFile, Newline(..), nativeNewline)

encodeUtf8 :: String -> B.ByteString
encodeUtf8 = Encoding.encodeUtf8 . T.pack

decodeUtf8 :: B.ByteString -> String
decodeUtf8 = T.unpack . Encoding.decodeUtf8With lenientDecode

encodeText :: String -> B.ByteString
encodeText = encodeUtf8 . encodeNewlines

decodeText :: B.ByteString -> String
decodeText = decodeNewlines . decodeUtf8

encodeNewlines :: String -> String
encodeNewlines = case nativeNewline of
  LF -> id
  CRLF -> go
    where
      go xs = case xs of
        '\n' : ys -> '\r' : '\n' : ys
        y : ys -> y : go ys
        [] -> []

decodeNewlines :: String -> String
decodeNewlines = go
  where
    go xs = case xs of
      '\r' : '\n' : ys -> '\n' : go ys
      y : ys -> y : go ys
      [] -> []

readFile :: FilePath -> IO String
readFile = fmap decodeText . B.readFile

writeFile :: FilePath -> String -> IO ()
writeFile name xs = withFile name WriteMode (`hPutStr` xs)

putStr :: String -> IO ()
putStr = hPutStr stdout

hPutStrLn :: Handle -> String -> IO ()
hPutStrLn h xs = hPutStr h xs >> hPutStr h "\n"

hPutStr :: Handle -> String -> IO ()
hPutStr h = B.hPutStr h . encodeText
