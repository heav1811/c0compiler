module SymbolTable where
import Stack as Stack
import qualified Data.Map as HashTable

type HashTable = HashTable.Map String Int
type SymbolTable = (Stack (HashTable, Int), Int, Stack Int)

empty :: SymbolTable
empty = (Stack.push (HashTable.empty, 0) Stack.empty, 0, Stack.empty)

enscope :: SymbolTable -> SymbolTable
enscope (st, i, p) = (Stack.push (HashTable.empty, 0) st, i, p)

descope :: SymbolTable -> SymbolTable
descope (st, i, p) = (Stack.pop st, i - (snd (Stack.top st)), p)

insert :: String -> SymbolTable -> SymbolTable
insert var (st, i, p) = (Stack.change_top ((HashTable.insert var i hs), hi + 1) st, i + 1, p)
  where (hs, hi) = Stack.top st

lookup :: String -> SymbolTable -> (Maybe Int)
lookup var (st, _, _)
  | Stack.is_empty st = Nothing
  | otherwise = let hs = fst (Stack.top st)
                in let ans = HashTable.lookup var hs
                   in if ans == Nothing then SymbolTable.lookup var (Stack.pop st, 0, Stack.empty)
                      else ans

size :: SymbolTable -> Int
size (_, vl, _) = vl

top_size :: SymbolTable -> Int
top_size (st, _, _) = snd (Stack.top st)

set_p :: Int -> SymbolTable -> SymbolTable
set_p np (st, vl, p) = (st, vl, Stack.push np p)

get_p :: SymbolTable -> (Int, SymbolTable)
get_p (st, vl, np) = (Stack.top np, (st, vl, Stack.pop np))


{-module SymbolTable where
import qualified Data.Map as HashTable

type HashTable = HashTable.Map String Int

type SymbolTable = (HashTable, Int)

empty :: SymbolTable
empty = (HashTable.empty, 0)

insert :: String -> SymbolTable -> SymbolTable
insert var (hs, vl) = (HashTable.insert var vl hs, 1 + vl)

lookup :: String -> SymbolTable -> Maybe Int
lookup var (hs, _) = HashTable.lookup var hs

size :: SymbolTable -> Int
size (_, vl) = vl
-}
