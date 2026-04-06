program define spread
	version 12.1
	syntax varlist(min=2 max=2), [label(varname) fast]


	if ("`fast'" == "") preserve

	tokenize `varlist'
	local variable `1'
	local value `2'
	qui{

		/* take care of label */
		if "`label'" == "" & "`:value label `variable''" ~= ""{
			tempvar label
			decode `variable', gen(`label')
		}
		else if "`label'" != ""{
			cap confirm string variable `label'
			if _rc{
				display as error "option label() requires a string variable"
				exit 4
			}
		}

		/* create variable`i' and label`i' */
		sort `variable'
		tempvar bylength
		bys `variable' : gen double `bylength' = _N 
		local start = 1
		local i = 0
		while `start' <= _N {
			local i = `i' + 1
			local end = `start' + `=`bylength'[`start']' - 1
			local variable_levels `"`variable_levels'  `"`=`variable'[`start']'"'"'
			if "`label'" ~= ""{
				local label_levels `"`label_levels'  `"`=`label'[`start']'"'"'
			}
			local start = `end' + 1
		}
		local n = `i'

		ds `variable' `value' `label' `bylength' , not
		local ivar `r(varlist)'
		if "`ivar'" == ""{
			tempvar newivar
			gen long `newivar' = _N
			local ivar `newivar'
		}
		



		cap confirm string variable `variable' 
		if _rc{
			local string ""
			local change "no"
		}
		else{
			local string string
			local change "yes"
			forval j = 1/`n'{
				local v : word `j' of `variable_levels'
				cap confirm name `v'
				if _rc{
					display as error `"The value `v' for the variable "`variable'" is not a valid Stata variable name"'
					exit 4
				}
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
		local ni `:word count `ivar''
		if `ni' > 10{
			tempvar id
			bys `ivar': gen `id' = 1
			qui replace `id' = sum(`id')
			local i `id'
		}
		else{
			local i `ivar'
		}

		/* reshape */
		tempvar jvalue value_stub
		if "`string'" != ""{
			gen long `jvalue' = .
			forval j = 1/`n'{
				local v : word `j' of `variable_levels'
				replace `jvalue' = `j' if `variable' == `"`v'"'
			}
			drop `bylength' `label'
			drop `variable'
			rename `value' `value_stub'
			qui reshape wide `value_stub', i(`i') j(`jvalue')
		}
		else{
			drop `bylength' `label'
			qui reshape wide `value', i(`i') j(`variable')
		}
		*cap which greshape
		*if _rc == 0{
		*	local reshape greshape
		*	local reshapefast `fast' compress
		*}
		*else{
			*local reshape reshape
			*local reshapefast
		*}
		* qui `reshape' wide `value', i(`i') j(`variable') `string' `reshapefast'


		/* check all new variable names are valid new variable name */
		forval i = 1/`n'{
			local v : word `i' of `variable_levels'
			if "`change'" != "no"{
				rename `value_stub'`i' `v'
				local names `names' `v'
				if "`label'" ~= ""{
					local l : word `i' of  `label_levels'
					label variable `v' `"`l'"'
				}
			}
			else{
				local names `names' `value'`v'
				if "`label'" ~= ""{
					local l : word `i' of  `label_levels'
					label variable `value'`v' `"`l'"'
				}
			}
		}
		di as result "new variables created: " as text "`=subinstr("`names'", " ", ", ", .)'"
	}

	if ("`fast'" == "") cap restore, not
end
