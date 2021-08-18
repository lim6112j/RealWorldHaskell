{-# OPTIONS_GHC -Wno-deferred-type-errors #-}
-- |

module QC where
import Control.Monad
import Prettify
import Arbitrary
import Test.QuickCheck.Gen
instance Arbitrary Char where
  arbitrary = Arbitrary.elements (['A'..'Z'] ++ ['a'..'z'] ++ " ~!@#$%^&*()")
-- instance Arbitrary Doc where
--   arbitrary = do
--     n <- Arbitrary.choose (1, 6) :: Gen Int
--     case n of
--       1 -> return Empty
--       2 -> do Char <$> arbitrary
--       3 -> do Text <$> arbitrary
--       4 -> return Line
--       5 -> do x <- arbitrary
--               y <- arbitrary
--               return (Concat x y)
--       6 -> do x <- arbitrary
--               y <- arbitrary
--               return (Union x y)
  -- arbitrary =
  --   oneof [ return Empty
  --         , liftM Char arbitrary
  --         , liftM Text arbitrary
  --         , return Line
  --         , liftM2 Concat arbitrary arbitrary
  --         , liftM2 Union arbitrary arbitrary
  --         ]
