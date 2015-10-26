{
module Grammar where
import Tokens
import Data.Char
}

%name parse
%tokentype {Token}
%error {parseError}

%token

int	{TokenInt $$}
'+'	{TokenPlus}
'-'	{TokenMinus}
'*'	{TokenTimes}
'/'	{TokenDiv}

%left '+' '-'
%left '*' '/'

%%

Exp	: Exp '+' Exp	{Plus $1 $3}
	| Exp '-' Exp	{Minus $1 $3}
	| Exp '*' Exp	{Times $1 $3}
	| Exp '/' Exp	{Div $1 $3}
	| int 	{Num $1}

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Exp = Num Int
	| Plus Exp Exp
	| Minus Exp Exp
	| Times Exp Exp
	| Div Exp Exp
	deriving (Show)





}