{
module Lexer where
}

%wrapper "basic"

$digit = 0-9			-- digits
$alpha = [a-zA-Z]		-- alphabetic characters

tokens :-

  $white+				;
  "--".*				;
  $digit+				{ \p s -> TokenInt (read s) }
  [\=\+\-\*\/]+				{ \p s -> TokenOp s }
  \(                                    { \p s -> TokenOB }
  \)                                    { \p s -> TokenCB }

{
-- Each action has type :: String -> Token

-- The token type:
data Token =TokenInt Int
	|TokenOp String
	|TokenOB
	|TokenCB
	deriving (Eq,Show)
}
