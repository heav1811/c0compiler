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
	\>=  	{\s -> TokenGI}
	\<= 	{\s -> TokenLI}
	\< 	{\s -> TokenL}
	\> 	{\s -> TokenG}
	true	{\s -> TokenBool True}
	false 	{\s -> TokenBool False}
--Atrib
	\=      {\s -> TokenAtrib}
	\==     {\s -> TokenEquals}
--Types
	int	{\s -> TokenTInt}
	bool	{\s -> TokenTBool}
-- main
	main    {\s -> TokenMain}
        return  {\s -> TokenRet}
--Ifs
	if	{\s -> TokenIf}
	else	{\s -> TokenElse}
--Misc
	\;      {\s -> TokenSep}
	\!=     {\s -> TokenDif}  
--While
	while  {\s -> TokenWhile}
--Print
	printint  {\s -> TokenPrint}
	println   {\s -> TokenPrintLn}
	read      {\s -> TokenRead}
--types and var's
	@number	            {\s -> TokenInt (read s)} --1 digit or more consecutively
	@alph               {\s -> TokenVar s}	
	
	{
data Token
--Expressions
	= TokenInt Int
	| TokenBool Bool
	| TokenPlus
	| TokenMinus
	| TokenTimes
	| TokenDiv
	| TokenDif
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
	| TokenEquals	
--Atrib
	| TokenAtrib
        | TokenVar String
--Ifs
	|TokenIf
	|TokenElse
--while
	|TokenWhile
        |TokenSep
--print
        |TokenPrint
        |TokenPrintLn
        |TokenRead
--Types
	|TokenTInt
	|TokenTBool
	|TokenMain
        |TokenRet
	deriving (Show)



scanTokens = alexScanTokens
}
