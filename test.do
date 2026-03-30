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

/* Test 3: unite */
clear all
set obs 10
gen var1 = "a"
gen var2 = "b"
unite var1 var2, gen(var3)
assert var3 == "a_b"

/* Test 4: unite with custom separator */
clear all
set obs 10
gen var1 = "x"
gen var2 = "y"
unite var1 var2, gen(var3) sep("-")
assert var3 == "x-y"

/* Test 5: unite with numeric variables */
clear all
set obs 10
gen var1 = 1
gen var2 = 2
unite var1 var2, gen(var3)
assert var3 == "1_2"

/* Test 6: gather with string variables */
clear all
set obs 10
gen id = _n
gen a = "hello"
gen b = "world"
gather a b
assert variable == "a" | variable == "b"

di as result "All tests passed."
