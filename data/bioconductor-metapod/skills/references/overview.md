# Meta-analyses on p-values of various differential tests

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: 1 November 2020

#### Package

metapod 1.18.0

# 1 Overview

The *[metapod](https://bioconductor.org/packages/3.22/metapod)* package provides utilities for meta-analyses on precomputed \(p\)-values, typicall generated from differential analyses of some sort.
This enables users to consolidate multiple related tests into a single metric for easier interpretation and prioritization of interesting events.
The functionality here was originally developed as part of the *[csaw](https://bioconductor.org/packages/3.22/csaw)* package, to combine inferences from adjacent windows inside a genomic region;
as well as from the *[scran](https://bioconductor.org/packages/3.22/scran)* package, to merge statistics from multiple batches or from multiple pairwise comparisons during marker gene detection.
Most functions in this package involve combining multiple (independent or not) \(p\)-values into a single combined \(p\)-value.
Additional functions are also provided to summarize the direction of any effect.

# 2 Meta-analyses on \(p\)-values

*[metapod](https://bioconductor.org/packages/3.22/metapod)* provides two families of functions to combine a group of \(p\)-values into a single statistic.
The first family considers parallel vectors of \(p\)-values where each group of \(p\)-values is defined from corresponding elements across vectors.
This is useful for combining different tests on the same set of features, e.g., DE analyses with the same gene annotation.
We illustrate this below by using Simes’ method to combine two parallel vectors:

```
library(metapod)
p1 <- rbeta(10000, 0.5, 1)
p2 <- rbeta(10000, 0.5, 1)
par.combined <- parallelSimes(list(p1, p2))
str(par.combined)
```

```
## List of 3
##  $ p.value       : num [1:10000] 0.0364 0.4541 0.458 0.1665 0.9207 ...
##  $ representative: int [1:10000] 1 2 2 2 1 2 2 1 2 2 ...
##  $ influential   :List of 2
##   ..$ : logi [1:10000] TRUE TRUE FALSE FALSE TRUE FALSE ...
##   ..$ : logi [1:10000] FALSE TRUE TRUE TRUE TRUE TRUE ...
```

The other approach is to consider groups of \(p\)-values within a single numeric vector.
This is useful when the \(p\)-values to be combined are generated as part of a single analysis.
The motivating example is that of adjacent windows in the same genomic region for ChIP-seq,
but one can also imagine the same situation for other features, e.g., exons in RNA-seq.
In this situation, we need a grouping factor to define the groups within our vector:

```
p <- rbeta(10000, 0.5, 1)
g <- sample(100, length(p), replace=TRUE)
gr.combined <- groupedSimes(p, g)
str(gr.combined)
```

```
## List of 3
##  $ p.value       : Named num [1:100] 0.033666 0.028223 0.004855 0.031088 0.000103 ...
##   ..- attr(*, "names")= chr [1:100] "1" "2" "3" "4" ...
##  $ representative: Named int [1:100] 3435 5795 8669 3261 4780 9164 7347 8092 9609 1930 ...
##   ..- attr(*, "names")= chr [1:100] "1" "2" "3" "4" ...
##  $ influential   : logi [1:10000] FALSE FALSE FALSE FALSE FALSE FALSE ...
```

Both families of functions return the combined \(p\)-value along with some other helpful statistics.
The `representative` vector specifies the index of the representative test for each group;
this is a test that is particularly important to the calculation of the combined \(p\)-value and can be used to, e.g., obtain a representative effect size.
Similarly, the `influential` vector indicates which of the individual tests in each group are “influential” in computing the combined \(p\)-value.
This is defined as the subset of tests that, if their \(p\)-values were set to unity, would alter the combined \(p\)-value.

# 3 \(p\)-value combining strategies

The following methods yield a significant result for groups where **any** of the individual tests are significant:

* Simes’ method (`parallelSimes()` and `groupedSimes()`) is robust to dependencies between tests and supports weighting of individual tests.
* Fisher’s method (`parallelFisher()` and `groupedFisher()`) assumes that tests are independent and does not support weighting.
* Pearson’s method (`parallelPearson()` and `groupedPearson()`) assumes that tests are independent and does not support weighting.
* Stouffer’s Z-score method (`parallelStouffer()` and `groupedStouffer()`) assumes that tests are independent and does support weighting.

Fisher’s method is most sensitive to the smallest \(p\)-value while Pearson’s method is most sensitive to the largest \(p\)-value.
Stouffer’s method serves as a compromise between these two extremes.
Simes’ method is more conservative than all three but is still functional in the presence of dependencies.

The following methods yield a significant result for groups where **some** of the individual tests are significant
(i.e., a minimum number or proportion of individual tests reject the null hypothesis):

* Wilkinson’s method (`parallelWilkinson()` and `groupedWilkinson()`) assumes that tests are independent and does not support weighting.
* The minimum Holm approach (`parallelHolmMin()` and `groupedHolmMin()`) does not require independence and supports weighting.

Technically, Wilkinson’s method can reject if any of the individual nulls are significant.
However, it has a dramatic increase in detection power when the specified minimum is attained, hence its inclusion in this category.

Finally, Berger’s intersection union test will yield a significant result for groups where **all** of the individual tests are significant.
This does not require independence but does not support weighting.

# 4 Summarizing the direction

The `summarizeParallelDirection()` and `summarizeGroupedDirection()` functions will summarize the direction of effect of all influential tests for each group.
For example, if all influential tests have positive log-fold changes, the group would be reported as having a direction of `"up"`.
Alternatively, if influential tests have both positive and negative log-fold changes, the reported direction would be `"mixed"`.
By only considering the influential tests, we avoid noise from “less significant” tests that do not contribute to the final \(p\)-value.

```
logfc1 <- rnorm(10000)
logfc2 <- rnorm(10000)

par.dir <- summarizeParallelDirection(list(logfc1, logfc2),
    influential = par.combined$influential)
table(par.dir)
```

```
## par.dir
##  down mixed    up
##  4290  1474  4236
```

`countParallelDirection()` and `countGroupedDirection` will just count the number of significant tests changing in each direction.
This is done after correcting for the number of tests in each group with the Benjamini-Hochberg or Holm methods.
These counts are somewhat simpler to interpret than the summarized direction but have their own caveats - see `?countParallelDirection` for details.

```
par.dir2 <- countParallelDirection(list(p1, p2), list(logfc1, logfc2))
str(par.dir2)
```

```
## List of 2
##  $ down: int [1:10000] 1 0 0 0 0 1 0 0 0 0 ...
##  $ up  : int [1:10000] 0 0 0 0 0 1 1 0 0 0 ...
```

Another approach is to just use the direction of effect of the representative test.
This is usually the best approach if a single direction and effect size is required, e.g., for visualization purposes.

# 5 Further comments

All functions support `log.p=TRUE` to accept log-transformed \(p\)-values as input and to return log-transformed output.
This is helpful in situations where underflow would cause generation of zero \(p\)-values.

Several functions support weighting of the individual tests within each group.
This is helpful if some of the tests are *a priori* known to be more important than others.

The `combineParallelPValues()` and `combineGroupedPValues()` wrapper functions will dispatch to the requested `method`,
making it easier to switch between methods inside other packages:

```
gr.combined2 <- combineGroupedPValues(p, g, method="holm-min")
str(gr.combined2)
```

```
## List of 3
##  $ p.value       : Named num [1:100] 1 1 1 1 1 1 1 1 1 1 ...
##   ..- attr(*, "names")= chr [1:100] "1" "2" "3" "4" ...
##  $ representative: Named int [1:100] 601 870 4153 3543 8504 8105 1345 7582 1177 5784 ...
##   ..- attr(*, "names")= chr [1:100] "1" "2" "3" "4" ...
##  $ influential   : logi [1:10000] FALSE FALSE TRUE FALSE TRUE TRUE ...
```

# Session information

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
## [1] metapod_1.18.0   knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] htmltools_0.5.8.1   rmarkdown_2.30      lifecycle_1.0.4
## [10] cli_3.6.5           sass_0.4.10         jquerylib_0.1.4
## [13] compiler_4.5.1      tools_4.5.1         evaluate_1.0.5
## [16] bslib_0.9.0         Rcpp_1.1.0          yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```