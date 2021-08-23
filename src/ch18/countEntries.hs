-- |

module CountEntries where
import System.Directory (doesDirectoryExist, getDirectoryContents)
import System.FilePath ((</>))
import Control.Monad (forM, liftM)
listDirectory :: FilePath -> IO [String]
listDirectory = fmap (filter notDots) . getDirectoryContents
  where notDots p = p /= "." && p /= ".."
countEtriesTrad :: FilePath -> IO [(FilePath, Int)]
countEtriesTrad path = do
  contents <- listDirectory path
  rest <- forM contents $ \name -> do
    let newName = path </> name
    isDir <- doesDirectoryExist newName
    if isDir
      then countEtriesTrad newName
      else return []
  return $ (path, length contents) : concat rest
