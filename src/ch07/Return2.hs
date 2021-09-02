-- |

module Return2 where
import Data.Char(toUpper)
isYes :: String -> Bool
isYes inpStr = (toUpper . head $ inpStr) == 'Y'
isGreen :: IO ()
isGreen = do
  one <- return 1
  let two = 2
  putStrLn $ show (one + two)
