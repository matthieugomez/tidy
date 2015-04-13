{smcl}
{* *! version 1.2.1  07mar2013}{...}
{title:Title}
{bf:spread} {hline 2} transforms the dataset into a wide form



{marker syntax}{...}
{title:Syntax}
{cmd:spread} {it:varname_variable} {it:varname_value} {cmd:,}[{opt label(legendvar)}]



{marker description}{...}
{title:Description}
{pstd}
{cmd:spread} spreads the two variables {it:varname_variable} and {it:varname_value}. It shares its syntax and result with the {cmd:spread} function in the R package {cmd:tidyr}. The option {opt label} adds variable labels as specified in {it:varname_label}.
