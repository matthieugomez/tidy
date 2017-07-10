{smcl}
{* *! version 1.2.1  07mar2013}{...}
{viewerjumpto "Syntax" "sumup##syntax"}{...}
{viewerjumpto "Description" "sumup##description"}{...}
{viewerjumpto "Options" "sumup##options"}{...}

{title:Title}
{bf:unite} {hline 2} Paste together multiple variables into one

{marker syntax}{...}
{title:Syntax}
{cmd:unite} {varlist} {cmd:,}  {opt gen(newvar)} [{opt sep(string)}]


{marker description}{...}
{title:Description}
{pstd}
{cmd:unite} pastes together multiple variables into one

{marker options}{...}
{title:Options}
{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{synopt :{opt sep(newvar)}}  Name of the new variable {p_end}
{synopt :{opt sep(string)}}  Separator between variables. Default to _ {p_end}
