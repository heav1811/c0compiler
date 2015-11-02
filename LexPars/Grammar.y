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
'!='    {TokenDiv} 
'=='    {TokenEquals} 
'>='	{TokenGI}
'<='	{TokenLI}
'<'	{TokenL}
'>'	{TokenG}
var     {TokenVar $$}
';'     {TokenSep}
'('     {TokenLB}
')'     {TokenRB}
'{'     {TokenLP}
'}'     {TokenRP}
float   {TokenFloat $$}
bool    {TokenBool $$}
tint    {TokenTInt}
tfloat  {TokenTFloat}
tbool   {TokenTBool}
if      {TokenIf}
else    {TokenElse}
while   {TokenWhile}


%nonassoc '>' '<' '<=' '>=' '!' '!=' '=='
%left '&&' '||'
%left '+' '-'
%left '*' '/' '%'
%left ';'

%%

Cmd     : tint var '=' Exp    {DecE (TVar TInt $2) $4}
        | tbool var '=' Exp   {DecE (TVar TBool $2) $4}
        | tfloat var '=' Exp  {DecE (TVar TFloat $2) $4}
        | tint var            {Dec (TVar TInt $2)}
        | tbool var           {Dec (TVar TBool $2)}
        | tfloat var          {Dec (TVar TFloat $2)}
        | var '=' Exp         {Atrib (SVar $1) $3}
        | IFGrammar           {$1}
        | WhileGrammar        {$1}
        | Cmd ';' Cmd         {Seq $1 $3}
        | Cmd ';'             {$1}

IFGrammar : if '(' Exp ')' '{' Cmd '}'                   {If $3 $6}
          | if '(' Exp ')' ';'                           {IfNull $3} 
          | if '(' Exp ')' '{' Cmd '}' else '{' Cmd '}'  {IfElse $3 $6 $10}

WhileGrammar: while '(' Exp ')' '{' Cmd '}'              {While $3 $6}
            | while '(' Exp ')' ';'                      {WhileNull $3}
        

Exp	: Exp '+' Exp	{Plus $1 $3}
	| Exp '-' Exp	{Minus $1 $3}
	| Exp '*' Exp	{Times $1 $3}
	| Exp '/' Exp	{Div $1 $3}
        | Exp '%' Exp   {Mod $1 $3}
        | Exp '==' Exp  {TEquals $1 $3}
        | Exp '!=' Exp  {TDif $1 $3}
        | '!' Exp       {Negative $2}
--binop
        | Exp '||' Exp  {Or $1 $3}
        | Exp '&&' Exp  {And $1 $3}
        | Exp '>' Exp   {Greater $1 $3}
        | Exp '>=' Exp  {GreaterI $1 $3}
        | Exp '<' Exp   {Lesser $1 $3}
        | Exp '<=' Exp  {LesserI $1 $3}
        | int           {Num $1}
        | float         {NumFloat $1}
        | bool          {EBool $1}
        | var           {EVar (SVar $1)}

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Type = TInt
  | TBool
  | TFloat
  deriving (Show)

data Var = SVar String     -- Simple Var
  | TVar Type String       -- Typed var
  deriving (Show)

data Exp = Num Int 
  | NumFloat Float
  | EBool Bool
  | Plus Exp Exp
  | Minus Exp Exp
  | Times Exp Exp
  | Div Exp Exp
  | Mod Exp Exp
  | Or Exp Exp
  | TDif Exp Exp
  | TEquals Exp Exp
  | And Exp Exp
  | Greater Exp Exp
  | GreaterI Exp Exp
  | Lesser Exp Exp
  | LesserI Exp Exp
  | Negative Exp
  | EVar Var             --Expression Var
  deriving (Show)
   
data Command = Atrib Var Exp
  | DecE Var Exp         -- Declare type in expression
  | Dec Var              -- Declare var
  | Seq Command Command
  | If Exp Command
  | IfNull Exp
  | WhileNull Exp
  | IfElse Exp Command Command
  | While Exp Command 
  deriving (Show)

}
	  
