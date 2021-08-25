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
import Prelude hiding ((<>))
-- import PNM
import CountEntries
import Control.Monad.Writer (WriterT, tell, execWriterT)

main :: IO ()
main = do
  a <- execWriterT $ countEntries "."
  putStrLn $ show a
