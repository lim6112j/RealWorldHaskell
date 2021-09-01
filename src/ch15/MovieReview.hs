-- |

module MovieReview where
import Control.Monad (liftM3)
data MovieReview = MovieReview {
        revTitle::String
        , revUser::String
        , revReview::String
        }
simpleReview :: [(String, Maybe String)] -> Maybe MovieReview
simpleReview alist =
  case lookup "title" alist of
    Just (Just title@(_:_)) ->
      case lookup "user" alist of
        Just (Just user@(_:_)) ->
          case lookup "review" alist of
            Just(Just review@(_:_)) ->
              Just(MovieReview title user review)
            _ -> Nothing -- no revew
        _ -> Nothing -- no user
    _ -> Nothing -- no title
maybeReview :: [(String, Maybe String)] -> Maybe MovieReview
maybeReview alist = do
  title <- lookup' "title" alist
  user <- lookup' "user" alist
  review <- lookup' "review" alist
  Just (MovieReview title user review)
lookup' key alist = case lookup key alist of
                      Just (Just s@(_:_)) -> Just s
                      _ -> Nothing
liftedReview alist =
  liftM3 MovieReview (lookup' "title" alist) (lookup' "user" alist) (lookup' "review" alist)
