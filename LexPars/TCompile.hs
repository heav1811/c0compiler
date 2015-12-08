module TCompile where
import Grammar
import Tokens

type Code = (Op, Value, Value, Value)
data Op =  OpIf | OpAt | OpLb | OpLes | OpGrt | OpEq | OpAdd | OpMin | OpTim | OpJp | OpPrt | OpEn | OpEn2 | OpDe | OpDe2 | OpPrtLn | OpRd deriving(Show)
data Value = Const Int | UVar String | Label String | Null deriving(Show)

new_var :: Int -> String
new_var n = "t" ++ (show n)

compile :: Command -> [Code]
compile cmd = fst(compile_cmd 0 cmd)

compile_cmd :: Int -> Command -> ([Code], Int)
compile_cmd lbNum (Atrib (SVar var) exp) = (expCode ++ [(OpAt, UVar var, UVar expVar, Null)], lbNum)
  where (expVar, expCode, _) = compile_exp 0 exp
compile_cmd lbNum (DecE (TVar _ var) exp) = (expCode ++ [(OpAt, UVar var, UVar expVar, Null)], lbNum)
  where (expVar, expCode, _) = compile_exp 0 exp
compile_cmd lbNum (Dec (TVar _ var)) = (expCode ++ [(OpAt, UVar var, UVar expVar, Null)], lbNum)
  where (expVar, expCode, _) = compile_exp 0 (Num 0)
compile_cmd lbNum (Seq cmd1 cmd2) = (cod1 ++ cod2, lbNum2)
  where (cod1, lbNum1) = compile_cmd lbNum cmd1
        (cod2, lbNum2) = compile_cmd lbNum1 cmd2
compile_cmd lbNum (While exp cmd) = ([(OpLb, Label (show lbNum), Null, Null)]
                                     ++ [(OpEn, Null, Null, Null)]
                                     ++ expCode
                                     ++ [(OpEn2, Null, Null, Null)]
                                     ++ [(OpIf, UVar expVar, Label (show (lbNum + 1)), Null)]
                                     ++ cod
                                     ++ [(OpDe, Null, Null, Null)]
                                     ++ [(OpJp, Label (show lbNum), Null, Null)]
                                     ++ [(OpLb, Label (show (lbNum + 1)), Null, Null)]
                                     ++ [(OpDe2, Null, Null, Null)], lbNum1 + 1)
    where (expVar, expCode, _) = compile_exp 0 exp
          (cod, lbNum1) = compile_cmd (lbNum + 2) cmd
compile_cmd lbNum (IfElse exp cmd1 cmd2) = (expCode
                                          ++ [(OpIf, UVar expVar, Label (show lbNum), Null)]
                                          ++ [(OpEn, Null, Null, Null)]
                                          ++ cod1
                                          ++ [(OpDe, Null, Null, Null)]
                                          ++ [(OpJp, Label (show (lbNum + 1)), Null, Null)]
                                          ++ [(OpLb, Label (show lbNum), Null, Null)]
                                          ++ [(OpEn, Null, Null, Null)]
                                          ++ cod2
                                          ++ [(OpDe, Null, Null, Null)]
                                          ++ [(OpLb, Label (show (lbNum + 1)), Null, Null)], lbNum2)
    where (expVar, expCode, _) = compile_exp 0 exp
          (cod1, lbNum1) = compile_cmd (lbNum + 2) cmd1
          (cod2, lbNum2) = compile_cmd lbNum1 cmd2
compile_cmd lbNum (If exp cmd1) = (expCode
                                          ++ [(OpIf, UVar expVar, Label (show lbNum), Null)]
                                          ++ [(OpEn, Null, Null, Null)]
                                          ++ cod1
                                          ++ [(OpDe, Null, Null, Null)]
                                          ++ [(OpLb, Label (show lbNum), Null, Null)], lbNum1)
    where (expVar, expCode, _) = compile_exp 0 exp
          (cod1, lbNum1) = compile_cmd (lbNum + 1) cmd1          
compile_cmd lbNum (Print exp) = (expCode ++ [(OpPrt, UVar expVar, Null, Null)], lbNum)
  where (expVar, expCode, _) = compile_exp 0 exp
compile_cmd lbNum (PrintLn) = ([(OpPrtLn, Null, Null, Null)], lbNum)
compile_cmd lbNum (Main _ cmd) = compile_cmd lbNum cmd

compile_exp :: Int -> Exp -> (String, [Code], Int)
compile_exp nx (Read) = (var, [(OpRd, UVar var, Null, Null)], nx + 1)
  where var = new_var nx
compile_exp nx (Num x) = (var, [(OpAt, UVar var, Const x, Null)], nx + 1)
  where var = new_var nx        
compile_exp nx (Plus exp1 exp2) = (var, cod1 ++ cod2 ++ [(OpAdd, UVar var, UVar var1, UVar var2)], nx2)
  where var = new_var nx
        (var1, cod1, nx1) = compile_exp (nx + 1) exp1
        (var2, cod2, nx2) = compile_exp nx1 exp2
compile_exp nx (Minus exp1 exp2) = (var, cod1 ++ cod2 ++ [(OpMin, UVar var, UVar var1, UVar var2)], nx2)
  where var = new_var nx
        (var1, cod1, nx1) = compile_exp (nx + 1) exp1
        (var2, cod2, nx2) = compile_exp nx1 exp2
compile_exp nx (Times exp1 exp2) = (var, cod1 ++ cod2 ++ [(OpTim, UVar var, UVar var1, UVar var2)], nx2)
  where var = new_var nx
        (var1, cod1, nx1) = compile_exp (nx + 1) exp1
        (var2, cod2, nx2) = compile_exp nx1 exp2
compile_exp nx (Lesser exp1 exp2) = (var, cod1 ++ cod2 ++ [(OpLes, UVar var, UVar var1, UVar var2)], nx2)
  where var = new_var nx
        (var1, cod1, nx1) = compile_exp (nx + 1) exp1
        (var2, cod2, nx2) = compile_exp nx1 exp2
compile_exp nx (Greater exp1 exp2) = (var, cod1 ++ cod2 ++ [(OpGrt, UVar var, UVar var1, UVar var2)], nx2)
  where var = new_var nx
        (var1, cod1, nx1) = compile_exp (nx + 1) exp1
        (var2, cod2, nx2) = compile_exp nx1 exp2
compile_exp nx (TEquals exp1 exp2) = (var, cod1 ++ cod2 ++ [(OpEq, UVar var, UVar var1, UVar var2)], nx2)
  where var = new_var nx
        (var1, cod1, nx1) = compile_exp (nx + 1) exp1
        (var2, cod2, nx2) = compile_exp nx1 exp2
compile_exp nx (EVar (SVar x)) = (x, [], nx)
