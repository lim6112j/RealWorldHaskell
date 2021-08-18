-- |

module BasicIO where
run :: IO ()
-- run = do
  -- putStrLn "Greetings! What is your name"
  -- inpStr <- getLine
  -- putStrLn $ "Welcom to Haskell, " ++ inpStr ++ "!"
run = putStrLn "Greetings! What is your name?" >>
        getLine >>=
        (\inpStr -> putStrLn $ "Welcome to Haskell, " ++ inpStr ++ "!")
