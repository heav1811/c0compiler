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
'!='    {TokenDiv} --
'=='    {TokenEquals} --
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
float   {TokenFloat $$}
bool    {TokenBool $$}--
tint    {TokenTInt}
tfloat  {TokenTFloat}--
tbool   {TokenTBool}--
if      {TokenIf}
else    {TokenElse}
while   {TokenWhile}--


%nonassoc '>' '<' '<=' '>=' '!'
%left '&&' '||'
%left '+' '-'
%left '*' '/' '%'
%left ';'


%%

Prog        : SeqStatement    {$1}

SeqStatement: SeqStatement Cmd  {Seq $1 $2}
            | Cmd               {$1}
           

Cmd     : Cmd ';' Cmd         {Seq $1 $3 }
        | Cmd ';'             {$1}
        | '{' Cmd ';' Cmd '}' {Seq $2 $4}
        | '{' Cmd ';' '}'     {$2}
        |  var '=' Exp ';'    {Atrib $1 $3}
        | IFGrammar      {$1}
        | WhileGrammar   {$1}

IFGrammar : if Exp Cmd                           { If $2 $3}
          | if Exp Cmd else Cmd                  { IfElse $2 $3 $5}

WhileGrammar: while Exp Cmd      {While $2 $3}
        

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
        | float         {NumFloat $1}

-- Type    : tint                                     {TInt}
--         | tfloat                                   {TFloat}
--         | tbool                                    {TBool}
{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Exp = Num Int 
  | NumFloat Float
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
 | Atrib String Exp
 | Seq Command Command
 | If Exp Command
 | IfElse Exp Command Command
 | While Exp Command 
  deriving (Show)

}
	  
