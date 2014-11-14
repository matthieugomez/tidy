tidyr-stata
===========

An implementation of the tidyr functions gather and spread in Stata



Wide dataset
```R
#> id  a   b
#> 0	1	3
#> 1	6	2

Long dataset
```R
#> id variable value
#> 0         a     1
#> 0         b     3
#> 1		 a     6
#> 1         a     2
```

From wide to long
```
gather a b
```
From long to wide
```R
spread variable value
```

gather and spread can also add variable label as a third variable, with the option `label`
