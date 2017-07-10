{smcl}
{* *! version 1.2.1  07mar2013}{...}
{vieweralsosee "reshape" "help reshape"}{...}
{viewerjumpto "Syntax" "sumup##syntax"}{...}
{viewerjumpto "Description" "sumup##description"}{...}
{viewerjumpto "Options" "sumup##options"}{...}

{title:Title}
{bf:gather} {hline 2} reshapes the dataset to a long form

{marker syntax}{...}
{title:Syntax}
{cmd:gather} {varlist} {cmd:, [}{opt variable(string)} {opt value(string)} {opt label(string)}{cmd:]}


{marker description}{...}
{title:Description}
{pstd}
{cmd:gather} gathers the variables in {it:varlist} and creates two variables, names variable and values. 

{marker options}{...}
{title:Options}
{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt variable(varname)}}  name of new variable corresponding to variable names; default is "variable" {p_end}
{synopt :{opt value(varname)}}  name of new variable corresponding to variable values; default is "values" {p_end}
{synopt :{opt label(varname)}}  creates a new variable storing the variable labels of {it:varlist}.{p_end}
