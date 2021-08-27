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
-- import CountEntries
-- import LocalReader
import Control.Monad.Writer (WriterT, tell, execWriterT)
import Control.Monad.Reader
import UglyStack

main :: IO ()
main = do
  -- a <- execWriterT $ countEntries "."
  -- putStrLn $ show a
  -- let (a, b, c) = runReader localExample "hello"
  -- print (a, b, c)
  (v, s) <- runApp (constrainedCount 0 ".") 3
  mapM_ print v
