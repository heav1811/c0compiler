{
module Parser where
import Lexer
}

%name parse
%tokentype {Token}
%error {parseError}

%token
-- Arithmetic Expressions
  int                     { TokenInt $$ }
  '+'                     { TokenOp "+" }
  '-'                     { TokenOp "-" }
  '/'                     { TokenOp "/" }
  '*'                     { TokenOp "*" }
-- OpenBrackets
  '('                     { TokenOB }
-- CloseBrackets
  ')'                     { TokenCB }

%left '+' '-'
%left '*' '/'

%%
Exp:  Exp '+' Exp          { Plus $1 $3 }
    | Exp '-' Exp          { Minus $1  $3 }
    | Exp '*' Exp          { Times $1 $3 }
    | Exp '/' Exp          { Div $1 $3 }
    | '(' Exp ')'          { Brack $2 }
    | int                  { Num $1 }


{
  

data Expr = Num Int
   |Plus Expr Expr
   |Minus Expr Expr
   |Times Expr Expr
   |Div   Expr Expr
   |Brack Expr
   deriving Show

parseError :: [Token] -> a
parseError _ = error "Parse error"

}
