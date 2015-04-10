stata-tidy
===========

An implementation of the [tidyr](https://github.com/hadley/tidyr) functions gather and spread in Stata



- gather transforms a wide dataset into a long dataset. Just specify the varlist that need to be gathered

	```
	sysuse educ99gdp.dta, clear
	list
	gather public private
	list
	```
	![](img/gather.jpg)


	
- spread transforms a long dataset into a wide dataset. The first variable must contains the name of the new variables. The second variable must contains the value of the new variable

	```
	spread public private
	list
	```
	![](img/spread.jpg)

