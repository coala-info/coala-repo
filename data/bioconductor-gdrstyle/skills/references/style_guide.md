# gDR style guide

gDR team\*

\*gdr-support-d@gene.com

#### 30 October 2025

#### Package

gDRstyle 1.8.0

# 1 gDR style guide

A style guide for the gdrplatform organization.

## 1.1 General R code

1. Indentation

* 2 spaces for indentation

2. Use of spaces

* Always utilize `if (` over `if(`
* Always include spaces around logical comparison `1 == 1` over `1==1`
* Always include spaces around logical entity `if (1 == 1) {}` over `if (1=1){}`
* Always include spaces around “full” subsets `[ , subset]` over `[, subset]`

3. Naming conventions

* variables
  + Utilize lower\_snake\_case for variables
  + Assignment should use `<-` over `=`
  + variable name should reflect proper tense `validated_se <- validate_SE()` over `validate_se <- validate_SE()`
* function arguments
  + Utilize space between function arguments `function(a = "A")` over `function(a="A")`
  + Utilize lower\_snake\_case for function arguments `function(big_matrix)` over `function(bigMatrix)`
* function names
  + All action functions should start with verbs `compute_metrics_SE` over `metrics_SE`
  + All internal functions start with a `.`
  + Utilize lowerCamelCase for function names
  + Function names should be short and informative
  + Getters should start with `get*`, setters should start with `set*`, boolean checkers should start with `is*`

4. Functions, functions, functions

* Functions definition
  + Functions definition should start on the same line as function name
  + Every parameter should be in separate line
  + Prepare separate functions for complicated defaults (of function parameters)

```
 # Good
fun <- function(param1,
                param2,
                param_with_dir_for_st_important = get_st_important_dir()) {
  # Code is indented by two spaces.
  ...
}
 # Bad
fun <- function(param1, param2, param_with_dir_for_st_important = file.path(system.file(paste(param1, "SE", "rds", sep = "."), package = "important_package"))) {
  ...
}
```

* Function assignment
  + Always utilize `<-` over `=` to differentiate function arguments assignments from function assignments `myFunction <- function()` over `myFunction = function()`
* Function export
  + All internal functions are not exported
  + All exported functions have `assert` tests for their parameters
* `vapply` over `sapply` (or `lapply` + `unlist()` if predefining FUN.VALUE is difficult)
* Do not use `apply` on data.frame(s) (`mapply` is good for row-wise operations)
* Function returns
  + Use implicit returns over explicit

```
  # Good.
  foo <- function() {
    # Do stuff.
    x
  }
  # Bad.
  foo <- function() {
    # Do stuff.
    return(x)
  }
```

6. Use of curly braces

* `if` and `else` statements should be surrounded by curly braces on the same line

```
if (TRUE) {
  NULL
} else {
  NULL
}
```

```
## NULL
```

* Assign simple if-else statements to a variable.

```
what_is_going_on <- if (is_check()) {
  flog <- "it's getting hot..."
} else if (is_mate()) {
  flog <- "Oh noooo..."
} else {
  flog <- "there is a hope..."
}
```

8. Files

* Where possible, break code into smaller files
* Separate each function by 2 lines
* Tests should be named identically to the file in `R/` (`R/assays` => `tests/testthat/test-assays.R`)

9. Namespacing

* Only double colon namespace packages that are not imported in `package.R`
* Common packages should all be imported in `package.R`
  + this includes: `checkmate`, `SummarizedExperiment`, etc.

10. Tests

* `expect_equal(obs, exp)` over `expect_equal(exp, obs)`

11. Miscellaneous

* Exponentiation: always utilize `^` over `**` for exponentiation like `2 ^ 3` over `2**3`.
* Numerics: place `0`’s in front of decimals like `0.1` over `.1`
* Use named indexing over positional indexing `df[, "alias"] <- df[, "celllinename"]` over `df[, 1] <- df[, 2]`
* If anything is hardcoded (i.e. numbers or strings), consider refactoring by introducing additional function arguments or inserting logic over numbers.
  + `df[, fxn_that_returns_idx(x):length(x)] <- NA` over `df[, 2:length(x)] <- NA`
* Reassign repeated logic to a variable computed only once.

```
# Good.
idx <- foo()
if (length(idx) == 1) {
  f <- c(f[idx], f[-idx])
}
# Bad.
if (length(foo()) == 1) {
  f <- c(f[foo()], f[foo()])
}
```

## 1.2 General Shiny code

1. Do not use absolute IDs (non-namespaced IDs) inside modules. It breaks their modularity.
2. When adding an identifier to an element in order to style it with CSS, always prefer classes over IDs, as they work more naturally with modules and they can be reused.
3. Avoid inline CSS styles.
4. In CSS file, each rule should be on its own line.
5. Avoid using percentages for widths; instead, use bootstrap’s grid system by specifying columns.

## 1.3 General package code

1. Create file *{pkgname}-package.R* with `usethis::use_package_doc()`
2. Update *{pkgname}-package.R* - it should have such lines:

```
#' @note To learn more about functions start with `help(package = "{pkgname}")`
#' @keywords internal
#' @return package help page
"_PACKAGE"
```

```
## [1] "_PACKAGE"
```

3. Add in the DESCRIPTION `Roxygen: list(markdown = TRUE)`
4. All constants, imports and side-effects tools should be in file *package.R*. Do not use *zzz.R*

* if some functions/packages are often used within the package, add `@import` or `@importFrom` always in one place - file *package.R*
* if using function from another package, use `namespace::function_name`

5. Executes gDRstyle specific package checks with `gDRstyle::checkPackage()` (use `bioc_check = TRUE` to verify
   if the requirements for Bioconductor are also met)

## 1.4 Git best practices

1. Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

* Commit messages should look like `<type>: <description>` where `type` can be one of:
  + `fix`: for bugfixes;
  + `feat`: for new features;
  + `docs`: for documentation changes;
  + `style`: for formatting changes that do not affect the meaning of the code;
  + `test`: for adding missing tests or correcting existing tests;
  + `refactor`: for code changes that neither fixes a bug nor adds a feature
  + `ci`: for changes to CI configuration

2. Any change in code should be accompanied by a bumped version.

* new features - `PATCH` version;
* bugfixes and other changes - `MINOR` version.
  *Exceptions*: All public packages - as to-be-released on Bioconductor have version 0.99.x.
  Any changes in code should be accompanied by a bumped `MINOR` version regardless of the nature of the changes.

# SessionInfo

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] gDRstyle_1.8.0   BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           rex_1.2.1           jsonlite_2.0.0
##  [7] glue_1.8.0          backports_1.5.0     htmltools_0.5.8.1
## [10] sass_0.4.10         rmarkdown_2.30      evaluate_1.0.5
## [13] jquerylib_0.1.4     fastmap_1.2.0       yaml_2.3.10
## [16] lifecycle_1.0.4     bookdown_0.45       BiocManager_1.30.26
## [19] compiler_4.5.1      lintr_3.2.0         digest_0.6.37
## [22] R6_2.6.1            bslib_0.9.0         tools_4.5.1
## [25] lazyeval_0.2.2      xml2_1.4.1          cachem_1.1.0
## [28] desc_1.4.3
```