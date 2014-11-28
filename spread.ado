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









