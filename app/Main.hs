module Main where

-- import Test.QuickCheck
-- import Lib
-- import PrettyJSON
-- import Prettify
-- import NaiveEq
-- import EqClasses
-- import JSONClass
-- import SimpleArrow
-- import Actions2
-- import BasicIO
-- import QCBasic
-- import Prelude hiding ((<>))
-- import PNM
-- import CountEntries
-- import LocalReader
-- import Control.Monad.Writer (WriterT, tell, execWriterT)
-- import Control.Monad.Reader
-- import UglyStack
-- import Return1
-- import Actions2
-- import Barcode
-- import TreeMap
-- import Parse
import MovieReview

--printMovie movieReview = case movieReview of
--Just a -> print a
--Nothing -> putStrLn ("no movie review")

printMovie movieReview = return movieReview >>= print

main :: IO ()
main = do
  printMovie $ apReview [("title", "move1"), ("user", "ben"), ("review", "5 star")]

-- a <- execWriterT $ countEntries "."
-- putStrLn $ show a
-- let (a, b, c) = runReader localExample "hello"
-- print (a, b, c)
-- (v, s) <- runMyApp (constrainedCount 0 ".") 3
-- mapM_ print v
