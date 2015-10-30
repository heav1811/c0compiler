{
module Tokens where
}

%wrapper "basic"

$digit = 0-9
$alpha = [a-zA-Z]
@number = $digit+
@whitespace = $white+
@alph = $alpha [$alpha $digit \_ !]*

tokens :-
	@whitespace	; --skip whitespaces
--Expressions
	\+	{\s -> TokenPlus}
	\-	{\s -> TokenMinus}
	\/	{\s -> TokenDiv}
	\*	{\s -> TokenTimes}
	\%      {\s -> TokenMod}
	\(      {\s -> TokenLB}
	\)	{\s -> TokenRB}
	\{	{\s -> TokenLP}
	\}	{\s -> TokenRP}
--binop
	\|\|    {\s -> TokenOr}
	&&	{\s -> TokenAnd}
	\!	{\s -> TokenNeg}
	\>\=  	{\s -> TokenGI}
	\<\= 	{\s -> TokenLI}
	\< 	{\s -> TokenL}
	\> 	{\s -> TokenG}
--Atrib
	\=      {\s -> TokenAtrib}
--Types
	int	{\s -> TokenTInt}
	float	{\s -> TokenTFloat}
	bool	{\s -> TokenTBool}
	
--Ifs
	if	{\s -> TokenIf}
	elseif  {\s -> TokenElseIf}
	else	{\s -> TokenElse}
--Misc
	\;     {\s -> TokenSep}
--While
	while  {\s -> TokenWhile}
--types and var's
	@number	{\s -> TokenInt (read s)} --1 digit or more consecutively
	@alph   {\s -> TokenVar s}
	
	
 {
data Token
--Expressions
	= TokenInt Int
	| TokenPlus
	| TokenMinus
	| TokenTimes
	| TokenDiv
	| TokenMod
--Brackets
	| TokenLB
	| TokenRB
	| TokenLP
	| TokenRP
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
        | TokenVar String
--Ifs
	|TokenIf
	|TokenElseIf
	|TokenElse
--while
	|TokenWhile
        |TokenSep
--Types
	|TokenTInt
	|TokenTFloat
	|TokenTBool
	deriving (Show)



scanTokens = alexScanTokens
}
