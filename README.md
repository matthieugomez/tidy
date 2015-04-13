stata-tidy
===========



- gather transforms a wide dataset into a long dataset. The only required argument is the list of variables to gather.
They are replaced by two new variables: the variable "variable" (containing the name of the former variables) and the variable "value" (containing their values).

	```
	sysuse educ99gdp.dta, clear
	gather public private
	```
	![](img/gather.jpg)


The option `variable` and `value` allow to specify different names for the new variables. The option `label` creates a new variable to store the labels of the former variables.
	
- spread transforms a long dataset into a wide dataset. The first variable must contains the names of the new variables. The second must contain the value of the new variable.

	```
	spread variable value
	```
	![](img/spread.jpg)

	- If the first variable is a string, the values become the names of the new variables
	- If the first variable is numeric, the new variables names are constructed as the name of the second variable followed by the numeric value. Value labels are transformed into variable labels.

	```
	sysuse educ99gdp.dta, clear
	gather public private
	egen g = group(variable), label
	drop variable
	spread g value
	```
