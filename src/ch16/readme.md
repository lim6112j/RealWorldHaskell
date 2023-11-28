ghci> parseCSV "hi\n"
Right [["hi"]]
ghci> parseCSV "line1\nline2\nline3\n"
Right [["line1"],["line2"],["line3"]]
ghci> parseCSV "cell1,cell2,cell3\n"
Right [["cell1","cell2","cell3"]]
ghci> parseCSV "l1c1,l1c2\nl2c1,l2c2\n"
Right [["l1c1","l1c2"],["l2c1","l2c2"]]
ghci> parseCSV "Hi,\n\n,Hello\n"
Right [["Hi",""],[""],["","Hello"]]
