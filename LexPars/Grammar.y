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
bool    {TokenBool $$}
tint    {TokenTInt}
tbool   {TokenTBool}
if      {TokenIf}
else    {TokenElse}
while   {TokenWhile}
main    {TokenMain}
return  {TokenRet}

%nonassoc '>' '<' '<=' '>=' '!' '!=' '=='
%left '&&' '||'
%left '+' '-'
%left '*' '/' '%'
%left ';'x

%%

MAIN:     typed                {$1}

typed   : tint main '('')''{' Cmd return int ';' '}'           {Main TInt $6}
        | tbool main '('')''{' Cmd return bool ';' '}'         {Main TBool $6}

Ucmd    : tint var '=' Exp    {DecE (TVar TInt $2) $4}
        | tbool var '=' Exp   {DecE (TVar TBool $2) $4}
        | tint var            {Dec (TVar TInt $2)}
        | tbool var           {Dec (TVar TBool $2)}
        | var '=' Exp         {Atrib (SVar $1) $3}

Cmd     : tint var '=' Exp    {DecE (TVar TInt $2) $4}
        | tint var            {Dec (TVar TInt $2)}
        | tbool var           {Dec (TVar TBool $2)}
        | var '=' Exp         {Atrib (SVar $1) $3}
        | CICLES              {$1}
        | Cmd ';' Cmd         {Seq $1 $3}
        | Cmd ';'             {$1}


CICLES  : IFGrammar           {$1}
        | WhileGrammar        {$1}


IFGrammar : if '(' Exp ')' '{' Cmd '}'                   {If $3 $6}
          | if '(' Exp ')' Ucmd                          {IfC $3 $5}
          | if '(' Exp ')' ';'                           {IfNull $3} 
          | if '(' Exp ')' '{' Cmd '}' else '{' Cmd '}'  {IfElse $3 $6 $10}
          | if '(' Exp ')' Ucmd else Ucmd                {IfElseC $3 $5 $7}

WhileGrammar: while '(' Exp ')' '{' Cmd '}'              {While $3 $6} 
            | while '(' Exp ')' Ucmd                     {WhileC $3 $5}
            | while '(' Exp ')' ';'                      {WhileNull $3}

Exp	: Exp '+' Exp	{Plus $1 $3}
	| Exp '-' Exp	{Minus $1 $3}
	| Exp '*' Exp	{Times $1 $3}
	| Exp '/' Exp	{Div $1 $3}
        | Exp '%' Exp   {Mod $1 $3}
        | Exp '==' Exp  {TEquals $1 $3}
        | Exp '!=' Exp  {TDif $1 $3}
        | '!' Exp       {Negative $2}
        | '(' Exp ')'   {$2}
--binop
        | Exp '||' Exp  {Or $1 $3}
        | Exp '&&' Exp  {And $1 $3}
        | Exp '>' Exp   {Greater $1 $3}
        | Exp '>=' Exp  {GreaterI $1 $3}
        | Exp '<' Exp   {Lesser $1 $3}
        | Exp '<=' Exp  {LesserI $1 $3}
        | int           {Num $1}
        | bool          {EBool $1}
        | var           {EVar (SVar $1)}

{

parseError :: [Token] -> a
parseError _ = error "Parse error"

data Type = TInt
  | TBool
  deriving (Show)

data Var = SVar String     -- Simple Var
  | TVar Type String       -- Typed var
  deriving (Show)

data Exp = Num Int 
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
  | IfC Exp Command
  | IfNull Exp
  | WhileNull Exp
  | IfElse Exp Command Command
  | IfElseC Exp Command Command
  | While Exp Command
  | WhileC Exp Command
  | Main Type Command
  deriving (Show)


}
	  
