{-# OPTIONS -fglasgow-exts #-}

-- This bogus program slipped past GHC 5.02!

data DS = forall a. C (a -> Int)

call (C f) arg = f arg
