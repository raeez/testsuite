-- !!! Testing hGetPosn and hSetPosn
module Main(main) where

import IO
import IOExts

getPosnAndPrint h = do
  x <- hTell h
  v <- hGetChar h
  putStrLn ("At position: " ++ show x ++ ", found: " ++ show v)
  return x

recordDoAndRepos h a = do
  x <- getPosnAndPrint h
  a 
  hSeek h AbsoluteSeek x
  getPosnAndPrint h
  return ()

recordDoAndRepos2 h a = do
  x <- getPosnAndPrint h
  a 
  hSeek h AbsoluteSeek x
  getPosnAndPrint h
  return ()

recordDoAndRepos3 h a = do
  x <- getPosnAndPrint h
  a 
  hSeek h SeekFromEnd (negate (x + 1))
  getPosnAndPrint h
  return ()

file = "hTell001.hs"

main :: IO ()
main = do
  h  <- openFile file ReadMode
  recordDoAndRepos h $
   recordDoAndRepos h $
    recordDoAndRepos h $
     recordDoAndRepos h $
      recordDoAndRepos h $
       putStrLn ""
  hClose h
  putStrLn ""
  h  <- openFileEx file (BinaryMode ReadMode)
  recordDoAndRepos h $
   recordDoAndRepos h $
    recordDoAndRepos h $
     recordDoAndRepos h $
      recordDoAndRepos h $
       putStrLn ""
  hClose h
  putStrLn "\nUsing hSeek/AbsoluteSeek: "
  h  <- openFile file ReadMode
  recordDoAndRepos2 h $
   recordDoAndRepos2 h $
    recordDoAndRepos2 h $
     recordDoAndRepos2 h $
      recordDoAndRepos2 h $
       putStrLn ""

  hClose h
  putStrLn "\nUsing hSeek/SeekFromEnd: "
  putStrLn "(Don't worry if you're seeing differing numbers here, it might be down to '\\n' vs '\\r\\n')"
  h  <- openFile file ReadMode
  recordDoAndRepos3 h $
   recordDoAndRepos3 h $
    recordDoAndRepos3 h $
     recordDoAndRepos3 h $
      recordDoAndRepos3 h $
       putStrLn ""
