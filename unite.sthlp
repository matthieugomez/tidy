{smcl}
{* *! version 1.0  10jul2017}{...}
{viewerjumpto "Syntax" "unite##syntax"}{...}
{viewerjumpto "Description" "unite##description"}{...}
{viewerjumpto "Options" "unite##options"}{...}
{viewerjumpto "Examples" "unite##examples"}{...}

{title:Title}
{bf:unite} {hline 2} Paste together multiple variables into one

{marker syntax}{...}
{title:Syntax}
{cmd:unite} {varlist} {cmd:,}  {opt gen(newvar)} [{opt sep(string)}]

{marker description}{...}
{title:Description}
{cmd:unite} pastes together multiple variables into one. Its goal is similar to the identically titled function in the tidyr package.

{marker options}{...}
{title:Options}
{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt sep(newvar)}}  Name of the new variable
{synopt :{opt sep(string)}}  Separator between variables. Default to _

{marker examples}{...}
{title:Examples}
{phang2}{cmd:. set obs 100}{p_end}
{phang2}{cmd:. gen var1 = "a"}{p_end}
{phang2}{cmd:. gen var2 = "b"}{p_end}
{phang2}{cmd:. unite var1 var2, gen(var3)}{p_end}
