stata-tidy
===========


## gather
gather transforms a wide dataset into a long dataset. The command takes a varlist as an argument, composed of the the list of variables to gather.
Two variables are created: the variable "variable" (containing the name of the former variables) and the variable "value" (containing their values). Use the option `variable` and `value` to specify different names. 
Use the option  `label` to create a new variable to store the labels of the former variables.


	![](img/gather.jpg)


## spread
spread transforms a long dataset into a wide dataset. The command takes two variables as an argument. The first variable contains the names of the new variables, the second variable contains its corresponding values


	![](img/spread.jpg)

	- If the first variable is a string, new variable names are constructed from the first variable values.
	- If the first variable is numeric, new variable names are constructed from the first variables name appended by its values. Eventual value labels are transformed into variable labels.


## Installation
```
net install tidy, from(https://github.com/matthieugomez/stata-tidy/raw/master/)
```

If you have a version of Stata < 13, you need to install it manually
Click the "Download ZIP" button in the right column to download a zipfile. Extract it into a folder (e.g. ~/SOMEFOLDER)
2. Run: (changing SOMEFOLDER with whatever you picked)
```
cap ado uninstall tidy
net install tex, from("~/SOMEFOLDER")


## References
[tidyr package](https://github.com/hadley/tidyr)