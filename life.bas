000 println "LIFE"
010 println "Press BKSP to exit"
011 cursor 1
012 wait 1000
013 clrscr
020 REM Initialize cursor location
021 let x = 0
022 let y = 0
023 setxy x, y
049 goto 100
050 REM Exit routine
051 clrscr
052 println "Bye!"
059 end
100 REM Main input loop
110 let i = kin 1
120 REM Exit case - end the program
121 if i = 8 then goto 50
130 REM Enter case - set the pixel under the cursor location
131 if i = 10 then gosub 500
140 REM Up arrow case
141 if i = 28 then gosub 600
150 REM Down arrow case
151 if i = 29 then gosub 700
160 REM Left arrow case
161 if i = 30 then gosub 900
170 REM Right arrow case
171 if i = 31 then gosub 800
180 REM Backspace - delete whatever's at the cursor location
181 if i = 127 then gosub 1000
400 REM Move the cursor
410 setxy x, y
420 goto 100
480 REM debug print stuff
481 println i
482 print x
483 print ", "
484 println y
489 return
500 REM Writes a * char into the current x and y location, then resets the cursor location
520 chr 42
530 x = x + 1
540 y = y + 1
550 setxy x,y
600 REM Move the cursor up
610 if y > 0 then y = y - 1
620 return
700 REM Move the cursor down
710 if y < 100 then y = y + 1
730 return
800 REM Move the cursor right
810 if x < 100 then x = x + 1
830 return
900 REM Move the cursor left
910 if x > 0 then x = x - 1
930 return
1000 REM Delete whatever is under the cursor
1010 chr 32
1020 return
