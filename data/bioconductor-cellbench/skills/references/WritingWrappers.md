# Writing Wrappers

Shian Su

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Wrapper Guidelines](#wrapper-guidelines)
* [3 Practical Examples](#practical-examples)
  + [3.1 Simple Wrapper](#simple-wrapper)
* [4 Final remarks](#final-remarks)

# 1 Introduction

This vignette will introduce the reason for creating method wrappers and
conventions to follow. Method wrappers are a way to subtlely alter the behaviour
of functions from other libraries. CellBench requires that all methods within a
step accept the same type of input and produce the same type of output, this is
often not the case for functions of different libraries which perform the same
task, therefore it is necessary to write code that “wraps” these methods to
conform to our requirements.

Examples of wrappers can be found at the following Github repositories

* [NormCBM](https://github.com/Shians/NormCBM)
* [ImputeCBM](https://github.com/Shians/ImputeCBM)
* [ClusterCBM](https://github.com/Shians/ClusterCBM)

# 2 Wrapper Guidelines

There are some requirements for wrappers used in CellBench:

* All method wrappers must be able to run with a single argument. All other
  arguments need to be optional with sensible defaults.
* All methods of the same pipeline step must accept objects of the same type and
  produce objects of the same type. They should at the very least be the same
  `class()`, also be careful of methods that return raw counts compared to
  normalised counts.

To ensure flexibility and compatibility of wrappers, the following conventions are recommended:

* Wrappers take SingleCellExperiment objects.
* Wrappers should do the minimal amount of work possible. Ideally it does a little bit of data manipulation, runs a meaningful function and post-processes the results slightly. Wrappers should not perform multiple steps of a pipeline.

# 3 Practical Examples

## 3.1 Simple Wrapper

Wrappers should only require a single argument, additional arguments should be set to sensible defaults, if more arguments non-defaultable are absolutely necessary then wrappers should take a list as its first argument.

```
# generic skeleton for a wrapper
wrapper <- function(sce, ...) {
    stopifnot(is(sce, "SingleCellExperiment"))

    res <- method_function(sce, ...)

    return(res)
}
```

We can write a simple wrapper for `DrImpute()`:

```
# one possible wrapper implmentation
drimpute_wrapper <- function(sce, ...) {
    # wrapper only accepts SingleCellExperiment or matrix type objects
    stopifnot(is(sce, "SingleCellExperiment"))

    expr <- SingleCellExperiment::normcounts(sce)
    expr_processed <- DrImpute::preprocessSC(expr)
    logcounts(sce) <- DrImpute::DrImpute(expr_processed, ...)

    return(sce)
}
```

Any argument passed into `...` will be passed onto `DrImpute()`. Sometimes it helps to explicitly name the arguments we may want to change, or limit what we allow to be changed in order to guarantee better consistency.

```
# another possible implementation
# DrImpute's default ks is 10:15, we can use 5:15 for robustness
drimpute_wrapper <- function(sce, ks = 5:15, method = c("mean", "med")) {
    stopifnot(is(sce, "SingleCellExperiment"))

    expr <- SingleCellExperiment::normcounts(sce)

    expr_processed <- DrImpute::preprocessSC(expr)
    method <- match.arg(method)
    logcounts(sce) <- DrImpute::DrImpute(expr_processed, ks = ks, method = method)

    return(sce)
}
```

Then we can alter these wrappers on-the-fly using `purrr::partial()`

```
imputation_method <- fn_list(
    dr_impute_mean = purrr::partial(drimpute_wrapper, method = "mean"),
    dr_impute_median = purrr::partial(drimpute_wrapper, method = "med")
)
```

# 4 Final remarks

Wrappers for methods should take `SingleCellExperiment` and return `SingleCellExperiments` with results stored in the the appropriate slots of `assays`, `colData` or `rowData`. If the computational results don’t fit nicely into these slots the they should be placed in an appropriate property in `metadata`.