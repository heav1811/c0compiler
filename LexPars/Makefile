all: Calc

Tokens.hs: Tokens.x
	alex Tokens.x

Grammar.hs: Grammar.y
	happy Grammar.y

TCompile.o: TCompile.hs
	ghc --make TCompile

Stack.o: Stack.hs
	ghc --make Stack

SymbolTable.o: SymbolTable.hs
	ghc --make SymbolTable

Calc: Tokens.hs Grammar.hs Calc.hs TCompile.o Stack.o SymbolTable.o
	ghc --make Calc 

clean:
	rm -f Calc Grammar.hs Tokens.hs *.o *.hi
