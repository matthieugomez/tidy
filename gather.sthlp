{smcl}
{* *! version 1.2.1  07mar2013}{...}
{title:Title}
{bf:gather} {hline 2} transforms the dataset into a long form



{marker syntax}{...}
{title:Syntax}
{cmd:gather} {varlist} {cmd:, [}{opt variable(string)} {opt value(string)} {opt label(string)}{cmd:]}



{marker description}{...}
{title:Description}
{pstd}
{cmd:gather} gathers the variables in {it:varlist}. It shares its syntax and result with the {cmd:gather} functon in the R package {cmd:tidyr}. The option {opt label} creates a new variable to store labels in {it:varlist}.

