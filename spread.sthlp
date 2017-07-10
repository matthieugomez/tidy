{smcl}
{* *! version 1.2.1  07mar2013}{...}
{title:Title}
{bf:spread} {hline 2} reshapes the dataset to a wide form


{marker syntax}{...}
{title:Syntax}
{cmd:spread} {it:varname_variable} {it:varname_value} {cmd:, [} {opt label(varname_label)} {cmd:]}

{marker description}{...}
{title:Description}
{pstd}
{cmd:spread} spreads a key-value pair across multiple columns.


{marker options}{...}
{title:Options}
{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt label(varname_label)}} uses the string variable varname to construct variable labels for new variables
