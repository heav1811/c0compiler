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
'='     {TokenAtrib}
'+'	{TokenPlus}
'-'	{TokenMinus}
'*'	{TokenTimes}
'/'	{TokenDiv}
'%'	{TokenMod}
'||'    {TokenOr}
'&&'	{ TokenAnd}
'!'	{ TokenNeg}
'>='	{ TokenGI}
'<='	{ TokenLI}
'<'	{ TokenL}
'>'	{ TokenG}
var     { TokenVar $$}

%left '&&' '||'
%left '+' '-'
%left '*' '/' '%'
%left '<' '<=' '>=' '>'


%%

Exp	: Exp '+' Exp	{Plus $1 $3}
	| Exp '-' Exp	{Minus $1 $3}
	| Exp '*' Exp	{Times $1 $3}
	| Exp '/' Exp	{Div $1 $3}
        | Exp '%' Exp   {Mod $1 $3}
--binop
        | Exp '||' Exp  {Or $1 $3}
        | Exp '&&' Exp  {And $1 $3}
        | '!'int        {Negative $2}
        | Exp '>' Exp   {Greater $1 $3}
        | Exp '>=' Exp  {GreaterI $1 $3}
        | Exp '<' Exp   {Lesser $1 $3}
        | Exp '<=' Exp  {LesserI $1 $3}
--declare type?
        | int      	 {Num $1}
        | var            {Var $1}
        | var '=' int    {Atrib $1 $3}

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Exp = Num Int
	| Plus Exp Exp
	| Minus Exp Exp
	| Times Exp Exp
	| Div Exp Exp
        | Mod Exp Exp
        | Or Exp Exp
        | And Exp Exp
        | Greater Exp Exp
        | GreaterI Exp Exp
        | Lesser Exp Exp
        | LesserI Exp Exp
        | Negative Int
        | Var var
        | Atrib Var Int
	deriving (Show)





}
