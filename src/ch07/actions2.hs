-- |

module Actions2 where
str2messsage :: String -> String
str2messsage input = "Data: " ++ input

str2action :: String -> IO ()
str2action = putStrLn . str2messsage

numbers :: [Int]
numbers = [1..10]

-- runA :: IO ()
-- runA = do
--   str2action "Start of the program"
--   let strings = mapM (str2action . show ) numbers
--   strings
--   str2action "Done"
