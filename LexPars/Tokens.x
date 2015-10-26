{
module Tokens where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
@number = $digit+
@whitespace = $white+

tokens :-
	@whitespace	; --skip whitespaces
	@number	{\s -> TokenInt (read s)} --1 digit or more consecutively
	\+	{\s -> TokenPlus}
	\-	{\s -> TokenMinus}
	\/	{\s -> TokenDiv}
	\*	{\s -> TokenTimes}
	
{
data Token
	= TokenInt Int
	| TokenPlus
	| TokenMinus
	| TokenTimes
	| TokenDiv
	deriving (Show)

scanTokens = alexScanTokens
}