discard
clear all
set obs 100
gen id = _n
gen a = 3
gen b = 4
label variable a "price"
label variable b "quantity"
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