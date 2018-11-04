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
053 cursor 1
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
181 REM if i = 127 then gosub 1000
190 REM Start the game
191 if i = 103 then gosub 2000
400 REM Move the cursor
410 setxy x, y
420 goto 100
480 REM FUNCTION - debug print stuff
481 println i
482 print x
483 print ", "
484 println y
489 return
500 REM FUNCTION - Writes a * char into the current x and y location, then resets the cursor location
520 chr 42
550 setxy x,y
560 REM write the new cell to memory
560 let m = y*38 + x
570 poke m, 1
590 return
600 REM FUNCTION - Move the cursor up
610 if y > 0 then y = y - 1
620 return
700 REM FUNCTION - Move the cursor down
710 if y < 100 then y = y + 1
730 return
800 REM FUNCTION - Move the cursor right
810 if x < 100 then x = x + 1
830 return
900 REM FUNCTION - Move the cursor left
910 if x > 0 then x = x - 1
930 return
1000 REM FUNCTION - Delete whatever is under the cursor
1010 chr 32
1020 return
2000 REM Main Game Loop
2001 REM g: generation counter
2002 REM n: cell neighbor counter
2010 let g = 0
2011 let n = 0
2012 cursor 0
2013 setxy 37,0
2014 print g
2019 let c = 0 
2020 for c = 0 to 722
2021 setxy 37,1
2022 print c
2030 REM Determine if the cell lives or dies
2031 gosub 2200
2040 next c
2050 REM Render the frame
2051 gosub 3100
2060 g = g + 1 
2016 println g
2070 goto 2000
2071 REM End of the main game loop
2200 REM FUNCTION - Counts the neighbors surrounding the current cell "c"
2210 REM Check the cell to the right 
2220 if c < 722 then n = n + peek c+1
2230 REM Check the cell to the left
2240 if c > 0 then n = n + peek c-1
2250 REM Check the cells above
2260 if c < 38 then goto 2300
2270 let m = c-37
2271 let v = peek m
2272 n = n + v
2280 m = c-38
2281 v = peek m
2282 n = n + v
2290 if c < 38 then goto 2300
2291 m = c-39
2292 v = peek m
2300 REM Check the cells below
2310 if c > 684 then goto 2400
2320 m = c+37
2321 v = peek m
2321 n = n + v
2320 m = c+38
2321 v = peek m
2322 n = n + v
2330 if c > 684 then goto 2400
2340 m = c+39
2350 v = peek m
2360 n = n + v
2400 REM Decide if the cell lives or dies...
2411 let v = peek c
2410 REM Check if the cell is already dead
2412 if v = 0 then goto 2510
2420 REM A living cell with fewer than 2 neighbors dies
2421 if n < 2 then poke c,0
2430 REM A living cell with more than 3 neighbors dies
2431 if n > 3 then poke c,0
2490 return
2500 REM A dead cell is born from three neighbors
2510 if n = 3 then poke c,1
2520 return
3100 REM FUNCTION - Iterate over the entire buffer and render the frame
3104 clrscr
3110 REM loop over rows
3111 for r=0 to 100
3120 REM loop over columns
3121 for c=0 to 100
3130 x = c
3140 y = r
3150 setxy x,y
3160 REM Cell is alive - write a star
3161 let m = r*38
3162 m = m + c
3161 let v = peek m
3161 if v = 1 then chr 42
3170 REM Cell is dead, backspace and kill it
3171 if v = 0 then chr 127
3190 return
