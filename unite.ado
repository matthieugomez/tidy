program define unite
	version 12.1
	syntax varlist(min=1), gen(name) [sep(string)]
	confirm new variable `gen'


	if "`sep'" == ""{
		local sep "_"
	}
	local i = 0
	foreach v in `varlist'{
		local i = `i' + 1
		if `i' > 1 {
			local script "`script' + "`sep'" +"
		}
		cap confirm string variable `v'
		if _rc{
			local format : format `v'
			if regexm("`format'", "^%t") {
				local script `script' trim(string(`v', "`format'"))
			}
			else if regexm("`format'", "g$") {
				local script `script' cond(missing(`v'), trim(string(`v')), cond(floor(`v') == `v', trim(string(`v', "%36.0f")), cond(abs(`v') >= 1e-4 & abs(`v') < 1e15, regexr(regexr(trim(string(`v', "%36.15f")), "0+$", ""), "\.$", ""), trim(string(`v', "%36.15g")))))
			}
			else{
				local script `script' trim(string(`v', "`format'"))
			}
		}
		else{
			local script `script' `v'
		}
	}
	gen `gen' = `script'
end




