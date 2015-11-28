stata-tidy
===========


## gather
gather transforms a wide dataset into a long dataset. The command takes a varlist as an argument, composed of the list of variables to gather.

These variables are replaced by two new variables: the variable "variable" (containing the name of the former variables) and the variable "value" (containing their values). Use the option `variable` and `value` to change their default names.

Use the option  `label`  to store the labels of the former variables in a new variable


![](img/gather.jpg)


## spread
spread transforms a long dataset into a wide dataset. The command takes two variables as an argument. The first variable contains the names of the new variables, the second variable contains its corresponding values.

![](img/spread.jpg)

- If the first variable is a string, new variable names are constructed from its values.
- If the first variable is numeric, new variable names are constructed from its values prefixed by its name. Eventual value labels are transformed into variable labels.


## Installation
```
net install tidy, from(https://github.com/matthieugomez/stata-tidy/raw/master/)
```

If you have a version of Stata < 13, you need to install it manually:
1. Click the "Download ZIP" button in the right column to download a zipfile. Extract it into a folder (e.g. ~/SOMEFOLDER)
2. Run: (changing SOMEFOLDER with whatever you picked)
	```
	cap ado uninstall tidy
	net install tex, from("~/SOMEFOLDER")
	```

## References
This package is a basic implementation of the [tidyr package](https://github.com/hadley/tidyr) in R.