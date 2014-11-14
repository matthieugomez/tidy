stata-tidy
===========

An implementation of the [tidyr](https://github.com/hadley/tidyr) functions gather and spread in Stata



- gather transforms a wide dataset into a long dataset:
	```R
	#> id   a   b
	#> 0	1	3
	#> 1	6	2
	```
	```
	gather a b, variable("variable") value("value")
	```

	```R
	#> id variable value
	#> 0         a     1
	#> 0         b     3
	#> 1		 a     6
	#> 1         a     2
	```

- spread transforms a long dataset into a wide dataset:

	```R
	#> id variable value
	#> 0         a     1
	#> 0         b     3
	#> 1		 a     6
	#> 1         a     2
	```
	```
	spread variable value
	```
	```R
	#> id   a   b
	#> 0	1	3
	#> 1	6	2
	```

- Additionally, gather and spread handle variable labels


	```R
	#> id variable value
	#> 0         a     1
	#> 0         b     3
	#> 1		 a     6
	#> 1         a     2
	```
	```
	ds *, d
	```
	```R
	#> variable name  variable label
	#> id                          
	#> a                "units in $"          
	#> b                "units in %"
	```
	```
	gather a b, variable("variable") value("value") label("label")
	```
	```R
	#> id variable        label  value
	#> 0         a "units in $"      1
	#> 0         b "units in %"      3
	#> 1		 a "units in $"      6
	#> 1         a "units in %"      2
	```
	```
	spread variable value, label(label)
	```


