module Csv where

import Text.ParserCombinators.Parsec

csvFile :: GenParser Char st [[String]]
csvFile = do
  result <- many line
  eof
  return result

line :: GenParser Char st [String]
line = do cells

cells :: GenParser Char st [String]
cells = do
  first <- cellContent
  next <- remainingCells
  return (first : next)

remainingCells :: GenParser Char st [String]
remainingCells = (char ',' >> cells) <|> return []

cellContent :: GenParser Char st String
cellContent = many (noneOf ",\n")