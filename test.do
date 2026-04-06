discard

/* Test 1: basic gather/spread roundtrip */
clear all
set obs 100
gen id = _n
gen a = runiform()
gen b = runiform()
gather a b
assert variable == "a" | variable == "b"
spread variable value
assert _N == 100

/* Test 2: gather/spread with labels */
clear all
set obs 100
gen id = _n
gen a = 3
gen b = 4
label variable a "price"
label variable b "quantity"
gather a b, label("label")
assert label == "price" | label == "quantity"
spread variable value, label(label)
assert "`:variable label a'" == "price"
assert "`:variable label b'" == "quantity"

/* Test 3: gather without id variables */
clear all
input str1 a str1 b
"x" "y"
"m" "n"
end
gather a b
assert _N == 4
assert value == "x" | value == "y" | value == "m" | value == "n"

/* Test 4: gather rejects label() collisions */
clear all
input id x y lbl
1 10 20 99
2 30 40 88
end
capture noisily gather x y, label(lbl)
local rc = _rc
assert `rc' == 110

/* Test 5: spread rejects extra positional arguments */
clear all
input id str1 variable value extra
1 "a" 10 99
1 "b" 20 99
end
capture noisily spread variable value extra
local rc = _rc
assert `rc' == 103

/* Test 6: spread handles long but valid string names */
clear all
input id str30 variable value
1 "abcdefghijklmnopqrstuvwxyz1234" 10
1 "short" 20
end
spread variable value
confirm variable abcdefghijklmnopqrstuvwxyz1234
assert abcdefghijklmnopqrstuvwxyz1234 == 10
assert short == 20

/* Test 7: unite */
clear all
set obs 10
gen var1 = "a"
gen var2 = "b"
unite var1 var2, gen(var3)
assert var3 == "a_b"

/* Test 8: unite with custom separator */
clear all
set obs 10
gen var1 = "x"
gen var2 = "y"
unite var1 var2, gen(var3) sep("-")
assert var3 == "x-y"

/* Test 9: unite with numeric variables */
clear all
set obs 10
gen var1 = 1
gen var2 = 2
unite var1 var2, gen(var3)
assert var3 == "1_2"

/* Test 10: unite preserves large integers and date formats */
clear all
set obs 1
gen long id1 = 123456789
gen double id2 = 1234567890123
gen double d = td(05apr2026)
format d %td
unite id1 id2 d, gen(key)
assert key == "123456789_1234567890123_05apr2026"

/* Test 11: gather with string variables */
clear all
set obs 10
gen id = _n
gen a = "hello"
gen b = "world"
gather a b
assert variable == "a" | variable == "b"

di as result "All tests passed."
