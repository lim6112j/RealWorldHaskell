{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Barcode where
import Data.Array (Array(..), (!), bounds, elems, indices, ixmap, listArray)
import Control.Applicative ((<$>))
import Control.Monad (forM_)
import Data.Char (digitToInt)
import Data.Ix (Ix(..))
import Data.List (foldl', group, sort, sortBy, tails)
import Data.Maybe (catMaybes, listToMaybe)
import Data.Ratio (Ratio)
import Data.Word (Word8)
import System.Environment (getArgs)
import qualified Data.ByteString.Lazy.Char8 as L 
import qualified Data.Map as M
import Parse
checkDigit :: (Integral a) => [a] -> a
checkDigit ds = 10 - (sum products `mod`  10)
  where products = mapEveryOther (*3) (reverse ds)
mapEveryOther :: (a -> a) -> [a] -> [a]
mapEveryOther f = zipWith ($) (cycle [f, id])
leftOddList = ["0001101", "0011001", "0010011", "0111101", "0100011",
               "0110001", "0101111", "0111011", "0110111", "0001011"]
rightList = map complement <$> leftOddList
  where complement '0' = '1' 
        complement '1' = '0'
leftEventList = map reverse rightList
parityList = ["111111", "110100", "110010", "110001", "101100",
              "100110", "100011", "101010", "101001", "100101"]
listToArray :: [a] -> Array Int a
listToArray xs = listArray  (0, l-1) xs
  where l = length xs
leftOddCodes, leftEvenCodes, rightCodes, parityCodes :: Array Int String
leftOddCodes = listToArray leftOddList
leftEvenCodes = listToArray leftEventList
rightCodes = listToArray rightList
parityCodes = listToArray parityList
foldA :: Ix k => (a -> b -> a) -> a -> Array k b -> a
foldA f s a = go s (indices a) 
  where go s (j:js) = let s' = f s (a ! j)
          in s' `seq` go s' js
        go s _ = s
foldAl :: Ix k => (a -> a -> a) -> Array k a -> a
foldAl f a = foldA f (a ! fst(bounds a)) a

encodeEAN13 :: String -> String
encodeEAN13 = concat . encodeDigits . map digitToInt
encodeDigits :: [Int] -> [String]
encodeDigits s@(first:rest) =
      outerGuard : lefties ++ centerGuard : righties  ++ [outerGuard]
  where (left, right) = splitAt 5 rest
        lefties = zipWith leftEncode (parityCodes !  first) left
        righties = map rightEncode (right ++ [checkDigit s])
leftEncode :: Char -> Int -> String
leftEncode '1' = (leftOddCodes !)
leftEncode '0' = (leftEvenCodes !)
rightEncode :: Int -> String
rightEncode = (rightCodes !)
outerGuard = "101"
centerGuard = "01010"
type Pixel = Word8
type RGB = (Pixel, Pixel, Pixel)
type Pixmap = Array (Int, Int) RGB

parseRawPPM :: Parse Pixmap
parseRawPPM =
  parseWhileWith w2c (/= '\n') ==> \header -> skipSpaces ==> k
  assert (header == "P6") "invalid raw header" ==>&
  parseNat ==> \width -> skipSpaces ==>&
  parseNat ==> \height -> skipSpaces ==>&
  parseNat ==> \maxValue ->
  assert (maxValue == 255) "max value out of spec" ==>&
  parseByte ==>&
  parseTimes (width * height) parseRGB ==> \pxs ->
  identity (listArray ((0, 0) , (width -1, height -1)) pxs)
 
