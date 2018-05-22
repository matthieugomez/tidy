discard
clear all
set obs 100
gen id = _n
gen ___1 = 3
gen ___2 = 4
label variable ___1 "price"
label variable ___2 "quantity"
fastreshape long ___, i(id) j(new)


gather a b
spread variable value



discard
clear all
set obs 100
gen id = _n
gen a = 3
gen b = 4
label variable a "price"
label variable b "quantity"
gather a b, label("label")
spread variable value, label(label)