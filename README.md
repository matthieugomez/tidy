stata-tidy
===========

This is a basic implementation of the  [tidyr package](https://github.com/hadley/tidyr) from R.

## gather
`gather` transforms a wide dataset into a long dataset (i.e. `reshape long`). The command takes a list of variables as argument. This list corresponds to variables to gather. Use the option `label` to save the variable labels as a new variable.

```stata
sysuse educ99gdp.dta, clear
list in 1/5

     +------------------------------+
     |   country   public   private |
     |------------------------------|
  1. | Australia       .7        .7 |
  2. |   Britain       .7        .4 |
  3. |    Canada      1.5        .9 |
  4. |   Denmark      1.5        .1 |
  5. |    France       .9        .4 |
     +------------------------------+

gather public private
list in 1/10

     +------------------------------+
     |   country   variable   value |
     |------------------------------|
  1. | Australia     public      .7 |
  2. | Australia    private      .7 |
  3. |   Britain     public      .7 |
  4. |   Britain    private      .4 |
  5. |    Canada     public     1.5 |
     |------------------------------|
  6. |    Canada    private      .9 |
  7. |   Denmark     public     1.5 |
  8. |   Denmark    private      .1 |
  9. |    France     public      .9 |
 10. |    France    private      .4 |
     +------------------------------+
```

`gather public private` is equivalent to:
```stata
rename public _1
rename private _2
reshape long _, i(country) j(variable) string
rename _ value
```


## spread
`spread` transforms a long dataset into a wide dataset (i.e. `reshape wide`). The command takes two variable names as argument. The first variable contains the new variable names. The second variable contains the new variable values.

```stata
list in 1/5

     +------------------------------+
     |   country   variable   value |
     |------------------------------|
  1. | Australia     public      .7 |
  2. | Australia    private      .7 |
  3. |   Britain     public      .7 |
  4. |   Britain    private      .4 |
  5. |    Canada     public     1.5 |
     +------------------------------+

spread variable value
list in 1/5

     +------------------------------+
     |   country   private   public |
     |------------------------------|
  1. | Australia        .7       .7 |
  2. |   Britain        .4       .7 |
  3. |    Canada        .9      1.5 |
  4. |   Denmark        .1      1.5 |
  5. |    France        .4       .9 |
     +------------------------------+
```

`spread variable value` is equivalent to:
```stata
reshape wide value, i(country) j(variable) string
rename value* *
```

## unite
`unite` pastes together multiple variables into one.

```stata
gen var1 = "a"
gen var2 = "b"
unite var1 var2, gen(var3)
list in 1/3

     +--------------------+
     | var1   var2   var3 |
     |--------------------|
  1. |    a      b    a_b |
  2. |    a      b    a_b |
  3. |    a      b    a_b |
     +--------------------+
```

## Installation
`tidy` is available on SSC.
```stata
ssc install tidy
```

To install the latest version from Github:
```stata
net install tidy, from("https://raw.githubusercontent.com/matthieugomez/stata-tidy/main/")
```
