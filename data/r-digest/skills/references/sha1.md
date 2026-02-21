# Calculating SHA1 hashes with digest() and sha1()

Thierry Onkelinx and Dirk Eddelbuettel

Written Jan 2016, updated Jan 2018 and Oct 2020

NB: This vignette is (still) work-in-progress and not yet
complete.

## Short intro on hashes

TBD

## Difference between `digest()` and `sha1()`

R [FAQ
7.31](https://cran.r-project.org/doc/FAQ/R-FAQ.html#Why-doesn_0027t-R-think-these-numbers-are-equal_003f) illustrates potential problems with floating point arithmetic.
Mathematically the equality $x =
\sqrt{x}^2$ should hold. But the precision of floating points
numbers is finite. Hence some rounding is done, leading to numbers which
are no longer identical.

An illustration:

```
> # FAQ 7.31
> a0 <- 2
> b <- sqrt(a0)
> a1 <- b ^ 2
> identical(a0, a1)
[1] FALSE
> a0 - a1
[1] -4.440892e-16
> a <- c(a0, a1)
> # hexadecimal representation
> sprintf("%a", a)
[1] "0x1p+1"               "0x1.0000000000001p+1"
```

Although the difference is small, any difference will result in
different hash when using the `digest()` function. However,
the `sha1()` function tackles this problem by using the
hexadecimal representation of the numbers and truncates that
representation to a certain number of digits prior to calculating the
hash function.

```
> library(digest)
> # different hashes with digest
> sapply(a, digest, algo = "sha1")
[1] "315a5aa84aa6cfa4f3fb4b652a596770be0365e8"
[2] "5e3999bf79c230f7430e97d7f30070a7eff5ec92"
> # same hash with sha1 with default digits (14)
> sapply(a, sha1)
[1] "8a938d8f5fb9b8ccb6893aa1068babcc517f32d4"
[2] "8a938d8f5fb9b8ccb6893aa1068babcc517f32d4"
> # larger digits can lead to different hashes
> sapply(a, sha1, digits = 15)
[1] "98eb1dc9fada00b945d3ef01c77049ee5a4b7b9c"
[2] "5a173e2445df1134908037f69ac005fbd8afee74"
> # decreasing the number of digits gives a stronger truncation
> # the hash will change when then truncation gives a different result
> # case where truncating gives same hexadecimal value
> sapply(a, sha1, digits = 13)
[1] "43b3b465c975af322c85473190a9214b79b79bf6"
[2] "43b3b465c975af322c85473190a9214b79b79bf6"
> sapply(a, sha1, digits = 10)
[1] "6b537a9693c750ed535ca90527152f06e358aa3a"
[2] "6b537a9693c750ed535ca90527152f06e358aa3a"
> # case where truncating gives different hexadecimal value
> c(sha1(pi), sha1(pi, digits = 13), sha1(pi, digits = 10))
[1] "169388cf1ce60dc4e9904a22bc934c5db33d975b"
[2] "20dc38536b6689d5f2d053f30efb09c44af78378"
[3] "3a727417bd1807af2f0148cf3de69abff32c23ec"
```

The result of floating point arithmetic on 32-bit and 64-bit can be
slightly different. E.g. `print(pi ^ 11, 22)` returns
`294204.01797389047` on 32-bit and
`294204.01797389053` on 64-bit. Note that only the last 2
digits are different.

| command | 32-bit | 64-bit |
| --- | --- | --- |
| `print(pi ^ 11, 22)` | `294204.01797389047` | `294204.01797389053` |
| `sprintf("%a", pi ^ 11)` | `"0x1.1f4f01267bf5fp+18"` | `"0x1.1f4f01267bf6p+18"` |
| `digest(pi ^ 11, algo = "sha1")` | `"c5efc7f167df1bb402b27cf9b405d7cebfba339a"` | `"b61f6fea5e2a7952692cefe8bba86a00af3de713"` |
| `sha1(pi ^ 11, digits = 14)` | `"5c7740500b8f78ec2354ea6af58ea69634d9b7b1"` | `"4f3e296b9922a7ddece2183b1478d0685609a359"` |
| `sha1(pi ^ 11, digits = 13)` | `"372289f87396b0877ccb4790cf40bcb5e658cad7"` | `"372289f87396b0877ccb4790cf40bcb5e658cad7"` |
| `sha1(pi ^ 11, digits = 10)` | `"c05965af43f9566bfb5622f335817f674abfc9e4"` | `"c05965af43f9566bfb5622f335817f674abfc9e4"` |

## Choosing `digest()` or `sha1()`

TBD

## Creating a sha1 method for other classes

### How to

1. Identify the relevant components for the hash.
2. Determine the class of each relevant component and check if they are
   handled by `sha1()`.
   * Write a method for each component class not yet handled by
     `sha1`.
3. Extract the relevant components.
4. Combine the relevant components into a list. Not required in case of
   a single component.
5. Apply `sha1()` on the (list of) relevant
   component(s).
6. Turn this into a function with name sha1.\_classname\_.
7. sha1.\_classname\_ needs exactly the same arguments as
   `sha1()`
8. Choose sensible defaults for the arguments
   * `zapsmall = 7` is recommended.
   * `digits = 14` is recommended in case all numerics are
     data.
   * `digits = 4` is recommended in case some numerics stem
     from floating point arithmetic.

### summary.lm

Let’s illustrate this using the summary of a simple linear
regression. Suppose that we want a hash that takes into account the
coefficients, their standard error and sigma.

```
> # taken from the help file of lm.influence
> lm_SR <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = LifeCycleSavings)
> lm_sum <- summary(lm_SR)
> class(lm_sum)
[1] "summary.lm"
> # str() gives the structure of the lm object
> str(lm_sum)
List of 11
 $ call         : language lm(formula = sr ~ pop15 + pop75 + dpi + ddpi, data = LifeCycleSavings)
 $ terms        :Classes 'terms', 'formula'  language sr ~ pop15 + pop75 + dpi + ddpi
  .. ..- attr(*, "variables")= language list(sr, pop15, pop75, dpi, ddpi)
  .. ..- attr(*, "factors")= int [1:5, 1:4] 0 1 0 0 0 0 0 1 0 0 ...
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:5] "sr" "pop15" "pop75" "dpi" ...
  .. .. .. ..$ : chr [1:4] "pop15" "pop75" "dpi" "ddpi"
  .. ..- attr(*, "term.labels")= chr [1:4] "pop15" "pop75" "dpi" "ddpi"
  .. ..- attr(*, "order")= int [1:4] 1 1 1 1
  .. ..- attr(*, "intercept")= int 1
  .. ..- attr(*, "response")= int 1
  .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv>
  .. ..- attr(*, "predvars")= language list(sr, pop15, pop75, dpi, ddpi)
  .. ..- attr(*, "dataClasses")= Named chr [1:5] "numeric" "numeric" "numeric" "numeric" ...
  .. .. ..- attr(*, "names")= chr [1:5] "sr" "pop15" "pop75" "dpi" ...
 $ residuals    : Named num [1:50] 0.864 0.616 2.219 -0.698 3.553 ...
  ..- attr(*, "names")= chr [1:50] "Australia" "Austria" "Belgium" "Bolivia" ...
 $ coefficients : num [1:5, 1:4] 28.566087 -0.461193 -1.691498 -0.000337 0.409695 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:5] "(Intercept)" "pop15" "pop75" "dpi" ...
  .. ..$ : chr [1:4] "Estimate" "Std. Error" "t value" "Pr(>|t|)"
 $ aliased      : Named logi [1:5] FALSE FALSE FALSE FALSE FALSE
  ..- attr(*, "names")= chr [1:5] "(Intercept)" "pop15" "pop75" "dpi" ...
 $ sigma        : num 3.8
 $ df           : int [1:3] 5 45 5
 $ r.squared    : num 0.338
 $ adj.r.squared: num 0.28
 $ fstatistic   : Named num [1:3] 5.76 4 45
  ..- attr(*, "names")= chr [1:3] "value" "numdf" "dendf"
 $ cov.unscaled : num [1:5, 1:5] 3.74 -7.24e-02 -4.46e-01 -7.86e-05 -1.88e-02 ...
  ..- attr(*, "dimnames")=List of 2
  .. ..$ : chr [1:5] "(Intercept)" "pop15" "pop75" "dpi" ...
  .. ..$ : chr [1:5] "(Intercept)" "pop15" "pop75" "dpi" ...
 - attr(*, "class")= chr "summary.lm"
> # extract the coefficients and their standard error
> coef_sum <- coef(lm_sum)[, c("Estimate", "Std. Error")]
> # extract sigma
> sigma <- lm_sum$sigma
> # check the class of each component
> class(coef_sum)
[1] "matrix" "array"
> class(sigma)
[1] "numeric"
> # sha1() has methods for both matrix and numeric
> # because the values originate from floating point arithmetic it is better to use a low number of digits
> sha1(coef_sum, digits = 4)
[1] "3f0b0c552f94d753fcc8deb4d3e9fc11a83197af"
> sha1(sigma, digits = 4)
[1] "cbc83d1791ef1eeadd824ea9a038891b5889056b"
> # we want a single hash
> # combining the components in a list is a solution that works
> sha1(list(coef_sum, sigma), digits = 4)
[1] "476d27265365cd41662eedf059b335d38a221cc2"
> # now turn everything into an S3 method
> #   - a function with name "sha1.classname"
> #   - must have the same arguments as sha1()
> sha1.summary.lm <- function(x, digits = 4, zapsmall = 7){
+     coef_sum <- coef(x)[, c("Estimate", "Std. Error")]
+     sigma <- x$sigma
+     combined <- list(coef_sum, sigma)
+     sha1(combined, digits = digits, zapsmall = zapsmall)
+ }
> sha1(lm_sum)
[1] "476d27265365cd41662eedf059b335d38a221cc2"
> # try an altered dataset
> LCS2 <- LifeCycleSavings[rownames(LifeCycleSavings) != "Zambia", ]
> lm_SR2 <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = LCS2)
> sha1(summary(lm_SR2))
[1] "90beb028833bf0542997fde7c3f19e5b9fdfeef4"
```

### lm

Let’s illustrate this using the summary of a simple linear
regression. Suppose that we want a hash that takes into account the
coefficients, their standard error and sigma.

```
> class(lm_SR)
[1] "lm"
> # str() gives the structure of the lm object
> str(lm_SR)
List of 12
 $ coefficients : Named num [1:5] 28.566087 -0.461193 -1.691498 -0.000337 0.409695
  ..- attr(*, "names")= chr [1:5] "(Intercept)" "pop15" "pop75" "dpi" ...
 $ residuals    : Named num [1:50] 0.864 0.616 2.219 -0.698 3.553 ...
  ..- attr(*, "names")= chr [1:50] "Australia" "Austria" "Belgium" "Bolivia" ...
 $ effects      : Named num [1:50] -68.38 -14.29 7.3 -3.52 -7.94 ...
  ..- attr(*, "names")= chr [1:50] "(Intercept)" "pop15" "pop75" "dpi" ...
 $ rank         : int 5
 $ fitted.values: Named num [1:50] 10.57 11.45 10.95 6.45 9.33 ...
  ..- attr(*, "names")= chr [1:50] "Australia" "Austria" "Belgium" "Bolivia" ...
 $ assign       : int [1:5] 0 1 2 3 4
 $ qr           :List of 5
  ..$ qr   : num [1:50, 1:5] -7.071 0.141 0.141 0.141 0.141 ...
  .. ..- attr(*, "dimnames")=List of 2
  .. .. ..$ : chr [1:50] "Australia" "Austria" "Belgium" "Bolivia" ...
  .. .. ..$ : chr [1:5] "(Intercept)" "pop15" "pop75" "dpi" ...
  .. ..- attr(*, "assign")= int [1:5] 0 1 2 3 4
  ..$ qraux: num [1:5] 1.14 1.17 1.16 1.15 1.05
  ..$ pivot: int [1:5] 1 2 3 4 5
  ..$ tol  : num 1e-07
  ..$ rank : int 5
  ..- attr(*, "class")= chr "qr"
 $ df.residual  : int 45
 $ xlevels      : Named list()
 $ call         : language lm(formula = sr ~ pop15 + pop75 + dpi + ddpi, data = LifeCycleSavings)
 $ terms        :Classes 'terms', 'formula'  language sr ~ pop15 + pop75 + dpi + ddpi
  .. ..- attr(*, "variables")= language list(sr, pop15, pop75, dpi, ddpi)
  .. ..- attr(*, "factors")= int [1:5, 1:4] 0 1 0 0 0 0 0 1 0 0 ...
  .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. ..$ : chr [1:5] "sr" "pop15" "pop75" "dpi" ...
  .. .. .. ..$ : chr [1:4] "pop15" "pop75" "dpi" "ddpi"
  .. ..- attr(*, "term.labels")= chr [1:4] "pop15" "pop75" "dpi" "ddpi"
  .. ..- attr(*, "order")= int [1:4] 1 1 1 1
  .. ..- attr(*, "intercept")= int 1
  .. ..- attr(*, "response")= int 1
  .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv>
  .. ..- attr(*, "predvars")= language list(sr, pop15, pop75, dpi, ddpi)
  .. ..- attr(*, "dataClasses")= Named chr [1:5] "numeric" "numeric" "numeric" "numeric" ...
  .. .. ..- attr(*, "names")= chr [1:5] "sr" "pop15" "pop75" "dpi" ...
 $ model        :'data.frame':  50 obs. of  5 variables:
  ..$ sr   : num [1:50] 11.43 12.07 13.17 5.75 12.88 ...
  ..$ pop15: num [1:50] 29.4 23.3 23.8 41.9 42.2 ...
  ..$ pop75: num [1:50] 2.87 4.41 4.43 1.67 0.83 2.85 1.34 0.67 1.06 1.14 ...
  ..$ dpi  : num [1:50] 2330 1508 2108 189 728 ...
  ..$ ddpi : num [1:50] 2.87 3.93 3.82 0.22 4.56 2.43 2.67 6.51 3.08 2.8 ...
  ..- attr(*, "terms")=Classes 'terms', 'formula'  language sr ~ pop15 + pop75 + dpi + ddpi
  .. .. ..- attr(*, "variables")= language list(sr, pop15, pop75, dpi, ddpi)
  .. .. ..- attr(*, "factors")= int [1:5, 1:4] 0 1 0 0 0 0 0 1 0 0 ...
  .. .. .. ..- attr(*, "dimnames")=List of 2
  .. .. .. .. ..$ : chr [1:5] "sr" "pop15" "pop75" "dpi" ...
  .. .. .. .. ..$ : chr [1:4] "pop15" "pop75" "dpi" "ddpi"
  .. .. ..- attr(*, "term.labels")= chr [1:4] "pop15" "pop75" "dpi" "ddpi"
  .. .. ..- attr(*, "order")= int [1:4] 1 1 1 1
  .. .. ..- attr(*, "intercept")= int 1
  .. .. ..- attr(*, "response")= int 1
  .. .. ..- attr(*, ".Environment")=<environment: R_GlobalEnv>
  .. .. ..- attr(*, "predvars")= language list(sr, pop15, pop75, dpi, ddpi)
  .. .. ..- attr(*, "dataClasses")= Named chr [1:5] "numeric" "numeric" "numeric" "numeric" ...
  .. .. .. ..- attr(*, "names")= chr [1:5] "sr" "pop15" "pop75" "dpi" ...
 - attr(*, "class")= chr "lm"
> # extract the model and the terms
> lm_model <- lm_SR$model
> lm_terms <- lm_SR$terms
> # check their class
> class(lm_model) # handled by sha1()
[1] "data.frame"
> class(lm_terms) # not handled by sha1()
[1] "terms"   "formula"
> # define a method for formula
> sha1.formula <- function(x, digits = 14, zapsmall = 7, ..., algo = "sha1"){
+     sha1(as.character(x), digits = digits, zapsmall = zapsmall, algo = algo)
+ }
> sha1(lm_terms)
[1] "2737d209720aa7d1c0555050ad06ebe89f3850cd"
> sha1(lm_model)
[1] "27b7dd9e3e09b9577da6947b8473b63a1d0b6eb4"
> # define a method for lm
> sha1.lm <- function(x, digits = 14, zapsmall = 7, ..., algo = "sha1"){
+     lm_model <- x$model
+     lm_terms <- x$terms
+     combined <- list(lm_model, lm_terms)
+     sha1(combined, digits = digits, zapsmall = zapsmall, ..., algo = algo)
+ }
> sha1(lm_SR)
[1] "7eda2a9d58e458c8e782e40ce140d62b836b2a2f"
> sha1(lm_SR2)
[1] "4d3abdb1f17bd12fdf9d9b91a2ad04c07824fe4a"
```

## Using hashes to track changes in analysis

Use case

* automated analysis
* update frequency of the data might be lower than the frequency of
  automated analysis
* similar analyses on many datasets (e.g. many species in
  ecology)
* analyses that require a lot of computing time

  + not rerunning an analysis because nothing has changed saves enough
    resources to compensate the overhead of tracking changes
* Bundle all relevant information on an analysis in a class

  + data
  + method
  + formula
  + other metadata
  + resulting model
* calculate `sha1()`

  file fingerprint ~ `sha1()` on the stable parts

  status fingerprint ~ `sha1()` on the parts that result for
  the model

1. Prepare analysis objects
2. Store each analysis object in a rda file which uses the file
   fingerprint as filename
   * File will already exist when no change in analysis
   * Don’t overwrite existing files
3. Loop over all rda files
   * Do nothing if the analysis was run
   * Otherwise run the analysis and update the status and status
     fingerprint