module Main where
import Grammar
import Tokens

main = do
	s <- getContents
	print $ parse $ scanTokens s