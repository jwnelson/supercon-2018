000 println "LIFE"
010 println "Press BKSP to exit"
011 cursor 1
012 let d=0
013 REM Clear memory
014 gosub 060
015 clrscr
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
060 REM FUNCTION Clear memory
061 REM o: Address offset into the "g+1" next-generation frame buffer
061 let o = 1000
065 for c=0 to 721
066 if d=0 then goto 070
067 setxy 35,0
068 print "c "
069 print c
070 poke c,0
071 poke o+c,0
075 next c
079 return
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
570 poke m,1
580 if d=0 then goto 590
581 setxy 35,3
585 print "m "
586 print m
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
2003 REM o: offset for the base of the next frame's buffer
2005 let g = 0
2006 let o = 1000
2010 REM Start of main game loop
2012 cursor 1
2013 if d=0 then goto 2050
2014 setxy 35,0
2015 print "g "
2016 print g
2050 REM Run the main live/die function
2051 gosub 2100
2060 g = g + 1 
2070 goto 2010
2090 REM end of main game loop
2100 REM FUNCTION Iterate over the entire buffer and render the frame
2110 REM loop over rows
2111 for r=0 to 18
2112 if d=0 then goto 2120
2113 setxy 35,1
2114 print "r "
2115 print r
2120 REM loop over columns
2121 for s=0 to 38
2122 if d=0 then goto 2130
2122 setxy 35,2
2123 print "s "
2124 print s
2130 let m=0
2140 let n=0
2140 let v=0
2200 REM Check the cell's neighbors
2201 REM m: The current row's address offset into the frame buffer
2202 m = r*38
2210 REM Check the cell to the right 
2220 if s < 37 then n = n + peek r*38 + s+1
2230 REM Check the cell to the left
2240 if s > 0 then n = n + peek r*38 + s-1
2250 REM Check the cells above
2260 if r = 0  then goto 2300
2271 v = peek m + s-36
2272 n = n + v
2281 v = peek m + s-37
2282 n = n + v
2290 if s = 0 then goto 2300
2292 v = peek m + s-38
2300 REM Check the cells below
2310 if r = 37 then goto 2400
2321 v = peek m + s+36
2321 n = n + v
2321 v = peek m + s+38
2322 n = n + v
2330 if s = 37 then goto 2400
2350 v = peek m + s+38
2360 n = n + v
2370 if d=0 then goto 2400
2380 setxy 35,4
2390 print "n "
2395 print n
2396 setxy s,r
2400 REM Decide if the cell lives or dies...
2410 let v = peek m + s
2411 REM Check if the cell is already dead
2412 if v = 0 then goto 2510
2420 REM A living cell with fewer than 2 neighbors dies
2421 if n < 2 then poke o+m+s,0
2430 REM A living cell with more than 3 neighbors dies
2431 if n > 3 then poke o+m+s,0
2500 REM A dead cell is born from three neighbors
2510 if n = 3 then poke o+m+s,1
3150 REM Write the cells to screen
3155 setxy s,r
3160 REM Cell is alive - write a star
3161 if peek o+m+s = 1 then chr 42
3170 REM Cell is dead, backspace and kill it
3171 if peek o+m+s = 0 then chr 32
3180 next s
3185 next r
3200 REM Update the current frame buffer
3201 REM Copy the contents of the g+1 frame buffer at offset o into the current gen frame buffer
3210 for r=0 to 18
3220 for c=0 to 37
3230 m = o + r*38 + c
3240 v = peek m
3250 poke m,v
3260 next c
3270 next r
3190 return
