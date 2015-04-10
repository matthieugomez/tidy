program define spread
	version 12.1
	syntax varlist, [variable(varname) value(varname) label(varname)]
	tokenize `varlist'
	local variable `1'
	local value `2'
	qui{
		ds `variable' `value', not
		local ivar `r(varlist)'
		cap	confirm string variable `variable' 
		if _rc{
			local string ""
		}
		else{
			local string string
			tempvar temp
			gen `temp' = !regexm(`variable',"^[a-zA-Z_]*[a-zA-Z\_0-9]*$")
			count if `temp' == 1
			if `r(N)' > 0 {
				levelsof `variable' if `temp' == 1
				display as error `"Some observations for `variable' don't have valid variable names: `=r(levels)'"'
				exit 4
			}
		}
		tempvar temp

		*/
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
		if "`label'"~=""{
			levelsof `label', local(label_levels)    
			drop `label'
		}
	}
	loca ni `:word count `ivar''
	if `ni' > 10{
		tempvar id
		bys `ivar': gen `id' = 1
		qui replace `id' = sum(`id')
		local i `id'
	}
	else{
		local i `ivar'
	}
	qui reshape wide `value', i(`i') j(`variable') `string'
	if "`string'" ~= ""{
		foreach v of varlist `value'*{
			local newname  `=subinstr("`v'", "`value'", "", 1)'
			rename `v' `newname'
			local names `names' `newname'
		}
	}
	else{
		foreach v of varlist `value'*{
			local names `names' `v'
		}
	}
	local names  `=subinstr("`names'", " ", ", ", .)'

	di as result "new variables created: " as text "`names'"

	if "`label'"~=""{
		tokenize `"`label_levels''"'
		local i = 0
		foreach v in `variable_levels'{
			local i = `i'+1
			label variable `v' "``i''"
		}
	}
end









