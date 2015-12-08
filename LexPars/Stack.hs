module Stack where

newtype Stack a = StackImpl [a]

is_empty :: Stack a -> Bool
is_empty (StackImpl s) = null s

empty :: Stack a
empty = StackImpl []

push :: a -> Stack a -> Stack a
push x (StackImpl s) = StackImpl (x:s)

top :: Stack a -> a
top (StackImpl s) = head s

pop :: Stack a -> Stack a
pop (StackImpl (s:ss)) = StackImpl ss

change_top :: a -> Stack a -> Stack a
change_top _ (StackImpl []) = StackImpl []
change_top vl (StackImpl (s:ss)) = StackImpl (vl:ss)
