program define unite
	version 12.1
	syntax varlist, gen(string)  [sep(string)]
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
			local script `script' string(`v')
		}
		else{
			local script `script' `v'
		}
	}
	gen `gen' = `script'
end




