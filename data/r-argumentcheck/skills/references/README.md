[![Build Status](https://travis-ci.org/nutterb/ArgumentCheck.png?branch=devel-envi)](https://travis-ci.org/nutterb/ArgumentCheck)
![](http://cranlogs.r-pkg.org/badges/grand-total/ArgumentCheck)

ArgumentCheck
==============

## `ArgumentCheck` has been deprecated!!

If you've been using `ArgumentCheck`, I apologize, but I will no longer be maintaining
this package.  `checkmate` 1.6.3 (2016-10-23) introduced assert collections which allow
error messages to be collected and reported together.  This means that `checkmate` now 
provides the core feature of `ArgumentCheck` and does argument checking better.  It 
really is a much better package, and I encourage you to switch.

If you need assistance migrating from `ArgumentCheck` to `checkmate`, please file an 
issue and I will do my best to assist you.  My apologies for the inconvenience, but 
your code will be better for the change.

**Simple Tools for Facilitating Informative Parameter Checks in R Functions.**

The typical process of checking arguments in functions is
iterative.  In this process, an error may be returned and the user may fix
it only to receive another error on a different argument.  `ArgumentCheck`
facilitates a more helpful way to perform argument checks allowing the
programmer to run all of the checks and then return all of the errors and
warnings in a single message.

### Iterative Errors
Under the "Fail Early, Fail Often" philosophy, programmers are encouraged to terminate functions
with an error when they first encounter an error.  With Fail Early Fail Often, one might program
a function to calculate the volume of a cylinder as

```{r}
cylinder.volume <- function(height, radius)
{
  if (height < 0) stop("'height' must be >= 0")
  if (radius < 0) stop("'radius' must be >= 0")
  pi * radius^2 * height  
}
```

In this function, passing a negative value to either `height` or `radius` will cause an error.

```{r}
> cylinder.volume(-3, -3)

Error in cylinder.volume(-3, -3) : 'height' must be >= 0
```
As expected, the function failed when it noticed that `height` was a negative value, but it 
never noticed the lurking problem that `volume` was also negative.

A modified philosophy of "Fail Early, Fail Often, Fail All At Once" might inspire the 
following function.

```{r}
cylinder.volume_improved <- function(height, radius)
{
  #* Establish a new 'ArgCheck' object
  Check <- ArgumentCheck::newArgCheck()
  
  #* Add an error if height < 0
  if (height < 0) 
    ArgumentCheck::addError(
      msg = "'height' must be >= 0",
      argcheck = Check
    )
  
  #* Add an error if radius < 0
  if (radius < 0)
    ArgumentCheck::addError(
      msg = "'radius' must be >= 0",
      argcheck = Check
    )
  
  #* Return errors and warnings (if any)
  ArgumentCheck::finishArgCheck(Check)
  
  pi * radius^2 * height 
}

> cylinder.volume_improved(-3, -3)

Error: 
cylinder.volume_improved(-3, -3)
1: 'height' must be >= 0
2: 'radius' must be >= 0 
```

While the code is noticeably longer, it has the advantage of returning both errors together.  

`ArgumentCheck` uses an environment to store error and warning messages.  This environment is 
created within the function.  As an environment, carefully constructed nested functions can use 
a common environment to pass any number of warnings and errors to the user the first time 
`finishArgCheck` is encountered.

For the trivial example used here, the difference in performance is negligible.  Additional efforts
are underway to determine the performance cost of the additional code used when implementing 
`ArgumentCheck`.

```r
system.time(cylinder.volume(-3, -3))

system.time(cylinder.volume_improved(-3, -3))
```
