program define spread
syntax varlist, [variable(varname) value(varname) label(varname)]

tokenize `varlist'
local variable `1'
local value `2'




if "`label'"~=""{
	levelsof `variable', local(`variable'_levels)       
	levelsof `label', local(`label'_levels)    
	drop `label'
}

ds `variable' `value', not
local ivar `r(varlist)'


reshape wide `value', i(`ivar') j(`variable') string
foreach v of varlist `value'*{
	rename `v' `=subinstr("`v'", "`value'", "", 1)'
}

if "`label'"~=""{
	tokenize `"``label'_levels'"'
	local i = 0
	foreach v in ``variable'_levels'{
		local i = `i'+1
		label variable `v' "``i''"
	}
}
end


* discard
* clear all
* set obs 100
* gen id = _n
* gen a = 3
* gen b = 4
* label variable a "price"
* label variable b "quantity"
* gather a b
* spread variable value



* discard
* clear all
* set obs 100
* gen id = _n
* gen a = 3
* gen b = 4
* label variable a "price"
* label variable b "quantity"
* gather a b, label("label")
* spread variable value, label(label)






