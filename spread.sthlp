{smcl}
{* *! version 1.0  10jul2017}{...}
{vieweralsosee "reshape" "help reshape"}{...}
{viewerjumpto "Syntax" "spread##syntax"}{...}
{viewerjumpto "Description" "spread##description"}{...}
{viewerjumpto "Options" "spread##options"}{...}
{viewerjumpto "Examples" "spread##examples"}{...}

{title:Title}
{bf:spread} {hline 2} An easier way to reshape long

{marker syntax}{...}
{title:Syntax}
{cmd:spread} {it:variable} {it:value} {cmd:, [} {opt label(varname)} {cmd:]}

{marker description}{...}
{title:Description}
{pstd}
{cmd:spread} spreads a variable-value pair across multiple columns. Its goal is similar to the identically titled function in the tidyr package.


{marker options}{...}
{title:Options}
{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt label(varname)}} uses the string variable varname to construct variable labels for new variables


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. sysuse educ99gdp.dta, clear}{p_end}
{phang2}{cmd:. gather public private}{p_end}
{phang2}{cmd:. spread variable value}{p_end}
