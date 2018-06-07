program define gather
	version 12.1
	syntax varlist[, variable(string) value(string) label(string) fast]

	if ("`fast'" == "") preserve

	if "`variable'"==""{
		local variable variable
	}
	if "`value'"==""{
		local value value
	}
	cap confirm new variable `variable'
	if _rc{
		di as error "variable `variable' already exists. Change default name of new variable with option variable()"
		exit
	}
	cap confirm new variable `value'
	if _rc{
		di as error "variable `value' already exists. Change default name of new variable with option value()"
		exit
	}

	qui ds `varlist'
	local varlist `r(varlist)'

	/* check same type */
	local type ""
	foreach v in `varlist'{
		cap confirm string var `v'
		if _rc == 0{
			if "`type'" == "numeric"{
				di as error "Variables to gather do not have the same type"
				exit 198
			}
			else{
				local type "string"
			}
		}
		else{
			if "`type'" == "string"{
				di as error "Variables to gather do not have the same type"
				exit 198
			}
			else{
				local type "numeric"
			}
		}
	}


	cap ds ____*
	if _rc == 0 {
		display as error "Please rename variables staring with ____ first" 
		exit 4
	}

	local i = 0
	qui ds `varlist', not
	local ivar `r(varlist)'
	if "`ivar'" ~= ""{
		cap bys `ivar':  assert _N == 1
		if _rc {
			display as error "key variables do not uniquely identify the observations" 
			exit 4
		}
	}
	else{
		tempvar ivar
		gen `ivar' = 1
	}
	tempname tempdup



	local names ""
	foreach v in `varlist'{
		local i = `i'+1
		local l`i' : variable label `v'
		rename `v' ____`i'
	}
	cap which fastreshape
	if _rc == 0{
		local reshape fastreshape
	}
	else{
		local reshape reshape
	}
	`reshape' long ____, i(`ivar') j(`variable') string `fast'
	if _rc{
		if _rc== 103{
			display as error "too many variables specified"
		}
		else{
			display as error "reshape terminated with error"
		}
		local i = 0
		foreach v in `varlist'{
			local i = `i'+1
			rename ____`i' `v'
		}
		display as error "reshape terminated with error"
		exit _rc
	}
	else{
		rename ____ `value'
		tokenize `varlist'
		local i = 0
		if "`label'"~=""{
			gen `label'=""
			order `ivar' `variable' `label' `value'
			local i = 0
			foreach name in `varlist'{
				local i = `i'+1
				qui replace `label' = "`l`i''" if `variable' == "`i'"
			}
		}
		local i =0
		foreach name in `varlist'{
			local i = `i'+1
			qui replace `variable' = "``i''" if `variable' == "`i'"
		}
	}

	if ("`fast'" == "") cap restore, not
end




