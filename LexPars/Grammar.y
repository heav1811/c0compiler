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
'&&'	{TokenAnd}
'!'	{TokenNeg}
'>='	{TokenGI}
'<='	{TokenLI}
'<'	{TokenL}
'>'	{TokenG}
var     {TokenVar $$}
';'     {TokenSep}
'('     {TokenLB}
')'     {TokenRB}
'}'     {TokenLP}
'{'     {TokenRP}

%nonassoc '>' '<' '<=' '>=' '!'
%left '&&' '||'
%left '+' '-'
%left '*' '/' '%'
%left ';'


%%


Cmd     : var                 {Var $1}
        | Cmd ';' Cmd         {Seq $1 $3 }
        | var '=' int         {Atrib $1 $3}
        | Cmd ';'             {$1}
        | '{' Cmd ';' Cmd '}' {Seq $2 $4}
        | '{' Cmd ';' '}'     {$2}
        | int                 {Nume $1}
        | var '=' Exp         {Atri $1 $3 }



Exp	: Exp '+' Exp	{Plus $1 $3}
	| Exp '-' Exp	{Minus $1 $3}
	| Exp '*' Exp	{Times $1 $3}
	| Exp '/' Exp	{Div $1 $3}
        | Exp '%' Exp   {Mod $1 $3}
        | '!' Exp       {Negative $2}
        | '(' Exp ')'   { $2 }
--binop
        | Exp '||' Exp  {Or $1 $3}
        | Exp '&&' Exp  {And $1 $3}
        | Exp '>' Exp   {Greater $1 $3}
        | Exp '>=' Exp  {GreaterI $1 $3}
        | Exp '<' Exp   {Lesser $1 $3}
        | Exp '<=' Exp  {LesserI $1 $3}
        | int           {Num $1}
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
  | Negative Exp
  deriving (Show)
   
data Command = Var String
  | Nume Int
  | Atrib String Int
  | Atri String Exp
  | Seq Command Command
  deriving (Show)
 
}
	  
