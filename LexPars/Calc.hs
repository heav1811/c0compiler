module Main where
import Grammar
import Tokens
import TCompile
import SymbolTable
import Data.Maybe

set_variable :: String -> String -> SymbolTable -> (String, SymbolTable)
set_variable var reg st
  | varV == Nothing = ("addi $sp, $sp, -4\n" ++ "la " ++ reg ++ ", ($sp)\n", SymbolTable.insert var st)
  | otherwise = let varN = 4 * (maxN - (fromJust varV) - 1)
                in ("la " ++ reg ++ ", " ++ (show varN) ++ "($sp)\n", st)
  where varV = SymbolTable.lookup var st
        maxN = SymbolTable.size st

get_variable :: SymbolTable -> String -> Int
get_variable st var = 4 * (maxN - fromJust(SymbolTable.lookup var st) - 1)
  where maxN = SymbolTable.size st

get_value :: SymbolTable -> String -> Value -> String
get_value _ reg (Const a) = "li " ++ reg ++ ", " ++ (show a) ++ "\n"
get_value st reg (UVar a) = "lw " ++ reg ++ ", " ++ (show var) ++ "($sp)\n"
  where var = get_variable st a

mipscode :: SymbolTable -> Code -> (String, SymbolTable)
mipscode st (OpAt, UVar var1, vl2, Null) = (cod2 ++ cod1 ++ "sw $t2, ($t1)\n", st1)
  where cod2 = get_value st "$t2" vl2
        (cod1, st1) = set_variable var1 "$t1" st
mipscode st (OpAdd, UVar var1, vl2, vl3) = (cod2 ++ cod3 ++ cod1 ++ "add $t0, $t2, $t3\nsw $t0, ($t1)\n", st1)
  where cod2 = get_value st "$t2" vl2
        cod3 = get_value st "$t3" vl3
        (cod1, st1) = set_variable var1 "$t1" st
mipscode st (OpMin, UVar var1, vl2, vl3) = (cod2 ++ cod3 ++ cod1 ++ "sub $t0, $t2, $t3\nsw $t0, ($t1)\n", st1)
  where cod2 = get_value st "$t2" vl2
        cod3 = get_value st "$t3" vl3
        (cod1, st1) = set_variable var1 "$t1" st
mipscode st (OpTim, UVar var1, vl2, vl3) = (cod2 ++ cod3 ++ cod1 ++ "mul $t0, $t2, $t3\nsw $t0, ($t1)\n", st1)
  where cod2 = get_value st "$t2" vl2
        cod3 = get_value st "$t3" vl3
        (cod1, st1) = set_variable var1 "$t1" st        
mipscode st (OpLes, UVar var1, vl2, vl3) = (cod2 ++ cod3 ++ cod1 ++ "slt $t0, $t2, $t3\nsw $t0, ($t1)\n", st1)
  where cod2 = get_value st "$t2" vl2
        cod3 = get_value st "$t3" vl3
        (cod1, st1) = set_variable var1 "$t1" st
mipscode st (OpGrt, UVar var1, vl2, vl3) = (cod2 ++ cod3 ++ cod1 ++ "sgt $t0, $t2, $t3\nsw $t0, ($t1)\n", st1)
  where cod2 = get_value st "$t2" vl2
        cod3 = get_value st "$t3" vl3
        (cod1, st1) = set_variable var1 "$t1" st
mipscode st (OpEq, UVar var1, vl2, vl3) = (cod2 ++ cod3 ++ cod1 ++ "seq $t0, $t2, $t3\nsw $t0, ($t1)\n", st1)
  where cod2 = get_value st "$t2" vl2
        cod3 = get_value st "$t3" vl3
        (cod1, st1) = set_variable var1 "$t1" st
mipscode st (OpLb, Label s, Null, Null) = ("L" ++ s ++ ":\n", st)
mipscode st (OpJp, Label s, Null, Null) = ("j L" ++ s ++ "\n", st)
mipscode st (OpIf, x, Label s, Null) = (cod ++ "beqz $t0, L" ++ s ++ "\n", st)
  where cod = get_value st "$t0" x
mipscode st (OpPrt, x, Null, Null) = (cod ++ "li $v0, 1\nmove $a0, $t0\nsyscall\n", st)
  where cod = get_value st "$t0" x
mipscode st (OpPrtLn, Null, Null, Null) = ("la $a0, lc\nli $v0, 4\nsyscall\n", st)
mipscode st (OpRd, UVar var, Null, Null) = ("li $v0, 5\nsyscall\n" ++ cod ++ "sw $v0, ($t0)\n", st1)
  where (cod, st1) = set_variable var "$t0" st
mipscode st (OpEn, _, _, _) = ("", SymbolTable.enscope st)
mipscode st (OpEn2, _, _, _) = ("", st1)
  where st1 = SymbolTable.set_p (SymbolTable.top_size st) st
mipscode st (OpDe, _, _, _) = ("addi $sp, $sp, " ++ (show (4 * curN)) ++ "\n", SymbolTable.descope st)
  where curN = SymbolTable.top_size st
mipscode st (OpDe2, _, _, _) = ("addi $sp, $sp, " ++ (show (4 * curN)) ++ "\n", st1)
  where (curN, st1) = SymbolTable.get_p st

callmips :: SymbolTable -> [Code] -> String
callmips _ [] = ".data\nlc:.asciiz \"\\n\"\n"
callmips st (x:xs) = cod ++ (callmips st1 xs)
  where (cod, st1) = mipscode st x

main = do
	s <- getContents
	let code = compile $ parse $ scanTokens s
        putStr $ callmips SymbolTable.empty code
