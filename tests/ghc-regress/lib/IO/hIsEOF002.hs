-- !!! test hIsEOF in various buffering situations

import IO
#if defined(__MINGW32__)
import PrelHandle(hSetBinaryMode)
#endif

main = do
  h <- openFile "hIsEOF002.hs" ReadMode
# if defined(__MINGW32__)
  hSetBinaryMode h True
# endif
  hSetBuffering h NoBuffering
  hSeek h SeekFromEnd 0
  hIsEOF h >>= print
  hSeek h SeekFromEnd (-1)
  hIsEOF h >>= print
  hGetChar h >>= print 

  hSetBuffering h LineBuffering
  hSeek h SeekFromEnd 0
  hIsEOF h >>= print
  hSeek h SeekFromEnd (-1)
  hIsEOF h >>= print
  hGetChar h >>= print  

  hSetBuffering h (BlockBuffering (Just 1))
  hSeek h SeekFromEnd 0
  hIsEOF h >>= print
  hSeek h SeekFromEnd (-1)
  hIsEOF h >>= print
  hGetChar h >>= print  

  hSetBuffering h (BlockBuffering Nothing)
  hSeek h SeekFromEnd 0
  hIsEOF h >>= print
  hSeek h SeekFromEnd (-1)
  hIsEOF h >>= print
  hGetChar h >>= print  
  hClose h

  h <- openFile "hIsEOF002.out" WriteMode
  hPutStrLn h "hello, world"
  hClose h

  h <- openFile "hIsEOF002.out" ReadWriteMode
# if defined(__MINGW32__)
  hSetBinaryMode h True
# endif
  hSetBuffering h NoBuffering
  hSeek h SeekFromEnd 0
  hIsEOF h >>= print
  hPutChar h 'x'
  hIsEOF h >>= print
  hSeek h SeekFromEnd (-1)
  hIsEOF h >>= print
  hGetChar h >>= print 
