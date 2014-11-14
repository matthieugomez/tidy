tidyr-stata
===========

An implementation of the tidyr functions gather and spread in Stata



Wide dataset
```R
#> id  a   b
#> 0	1	3
#> 1	6	2
```
From wide to long
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

From long to wide
```
spread variable value
```
```R
#> id  a   b
#> 0	1	3
#> 1	6	2
```




gather and spread can also alternate between a variable "label" and variable labels with the option `label`
