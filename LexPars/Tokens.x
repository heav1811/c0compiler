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
	\%      {\s -> TokenMod}
--binop
	"||"    {\s -> TokenOr}
	"&&"	{\s -> TokenAnd}
	\!	{\s -> TokenNeg}
	">="  	{\s -> TokenGI}
	"<=" 	{\s -> TokenLI}
	\< 	{\s -> TokenL}
	\> 	{\s -> TokenG}
--Atrib
	\=     {\s -> TokenAtrib}
	$alpha [$alpha $digit \_ !]* {\s -> TokenVar (read s)}
 {
data Token
	= TokenInt Int
	| TokenPlus
	| TokenMinus
	| TokenTimes
	| TokenDiv
	| TokenMod
-- binop
	| TokenOr
	| TokenAnd
	| TokenNeg
	| TokenGI
	| TokenLI
	| TokenL
	| TokenG
--Atrib
	| TokenAtrib
        | TokenVar Var
	deriving (Show)

scanTokens = alexScanTokens
}
