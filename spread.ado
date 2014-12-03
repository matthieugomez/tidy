program define spread
syntax varlist, [variable(varname) value(varname) label(varname)]

tokenize `varlist'
local variable `variable'
local value `2'
qui{
	ds `variable' `value', not
	local ivar `r(varlist)'
	cap	confirm string variable `variable' 
	if _rc{
		display as error "Some observations for `variable' don't have valid variable names" 
		exit 4
	}
	gen `temp' = !regexm(`tempvariable',"^[a-zA-Z_]*[a-zA-Z_0-9]*$")
	count if `temp' == 1
	if `r(N)' > 0 {
		display as error "Some observations for `variable' don't have valid variable names" 
		exit 4
	}
	levelsof `variable', local(variable_levels)       
	local variable_levels : list clean variable_levels
	ds `varlist', not
	local vlist `r(varlist)'
	foreach v in `r(varlist)'{
		local i : list posof "`v'" in variable_levels
		if `i' ~= 0{
			display as error `"The value `v' for the variable "`variable'" conflicts with existing variables"' 
			exit 4
		}
	}
	}
	else

	if "`label'"~=""{
		levelsof `label', local(label_levels)    
		drop `label'
	}

}
drop `variable'
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









