program define spread
syntax varlist, [variable(varname) value(varname) label(varname)]

tokenize `varlist'
local variable `1'
local value `2'

qui{
	tempvar temp
	gen `temp' = !regexm(`1',"^[a-zA-Z_]*[a-zA-Z_0-9]*$")
	count if `temp' == 1
	if `r(N)' > 0 {
		display as error "Some observations for `1' don't have valid variable names" 
		exit 4
	}

	levelsof `variable', local(variable_levels)       
	local variable_levels : list clean variable_levels
	ds `varlist', not
	local vlist `r(varlist)'
	foreach v in `r(varlist)'{
		local i : list posof "`v'" in variable_levels
		if `i' ~= 0{
			display as error `"The value `v' for the variable "`1'" conflicts with existing variables"' 
			exit 4
		}
	}


	if "`label'"~=""{
		levelsof `label', local(label_levels)    
		drop `label'
	}


	ds `variable' `value', not
	local ivar `r(varlist)'
}
reshape wide `value', i(`ivar') j(`variable') string
foreach v of varlist `value'*{
	rename `v' `=subinstr("`v'", "`value'", "", 1)'
}

if "`label'"~=""{
	tokenize `"`label_levels''"'
	local i = 0
	foreach v in `variable_levels'{
		local i = `i'+1
		label variable `v' "``i''"
	}
}
end









