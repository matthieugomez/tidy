program define spread
	version 12.1
	syntax varlist, [variable(varname) value(varname)]
	tokenize `varlist'
	local variable `1'
	local value `2'
	qui{
		ds `variable' `value', not
		local ivar `r(varlist)'



		levelsof `variable', local(variable_levels)  clean
		if "`: value label `variable''" ~= ""{
			local labeldummy yes
			foreach v in `variable_levels'{
				local variable_label`v' `: label (`variable') `v''
			}
		}

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
			foreach v in `ivar'{
				local i : list posof "`v'" in variable_levels
				if `i' ~= 0{
					display as error `"The value `v' for the variable "`variable'" conflicts with existing variables"' 
					exit 4
				}
			}
		}
		/* manage when more than 10 id variables */
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


		local i = 0 
		foreach v in `variable_levels'{
			local i = `i'+1
			if "`string'" ~= ""{
				rename `value'`v' `v'
				local names `names' `v'

			}
			else{
				if "`labeldummy'" ~= ""{
					label variable `value'`v' ""
					noi di  "`variable_label`v''"
					label variable `value'`v' `variable_label`v''
				}
				local names `names' `value'`v'
			}
		}
		di as result "new variables created: " as text "`=subinstr("`names'", " ", ", ", .)'"
	}
end










