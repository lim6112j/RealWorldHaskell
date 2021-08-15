-- |

module SimpleArrow(SimpleFunc(..)) where
newtype SimpleFunc a b = SimpleFunc {
                        runF ::  a -> b
                        }
