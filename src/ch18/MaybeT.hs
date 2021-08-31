-- |

module MaybeT where
newtype MaybeT m a = MaybeT { runMaybeT :: m (Maybe a)}
bindMT :: (Monad m) => MaybeT m a -> (a -> MaybeT m b) -> MaybeT m b
x `bindMT` f = MaybeT $ do
                        unwrapped <- runMaybeT x
                        case unwrapped of
                          Nothing -> return Nothing
                          Just y -> runMaybeT (f y)
x `altBindMT` f = runMaybeT x >>= maybe (return Nothing) (runMaybeT . f)
