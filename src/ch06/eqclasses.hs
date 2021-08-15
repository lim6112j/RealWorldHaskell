-- |

module EqClasses where
import Prelude hiding ((==), (/=))
data Color = Red | Green | Blue

class BasicEq a where
 isEqual, isNotEqual :: a -> a -> Bool
 isEqual x y = not (isNotEqual x y)
 isNotEqual x y = not (isEqual x y)

instance BasicEq Color where
  isEqual Red Red = True
  isEqual Blue Blue = True
  isEqual Green Green = True
  isEqual _ _ = False
