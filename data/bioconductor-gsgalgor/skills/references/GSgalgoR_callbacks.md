# GSgalgoR Callbacks Mechanism

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Example 1: A simple custom callback function definition](#example-1-a-simple-custom-callback-function-definition)
* [3 Example 2: Saving partial population pool using custom callback function](#example-2-saving-partial-population-pool-using-custom-callback-function)
* [4 Callbacks implemented in GSgalgoR](#callbacks-implemented-in-gsgalgor)
* [5 Session info](#session-info)

# 1 Introduction

The GSgalgoR package provides a practical but straightforward callback mechanism
for adapting different `galgo()` execution sections to final user needs. The
GSgalgoR callbacks mechanism enables adding custom functions to change the
`galgo()` function behavior by including minor modification to galgo’s workflow.
A common application of the callback mechanism is to implement personalized
reports, saving partial information during the evolution process or compute the
execution time.

There are five possible points where the user can hook its own code inside
`galgo()` execution process.

* At the beginning of the `galgo()` execution process. (i.e. when `galgo()`
  is about to start.)
* At the end of the `galgo()` execution process. (i.e. when `galgo()` is about
  to finish. )
* At the beginning of the evolution process. (i.e. at the beginning of each
  generation/iteration. )
* At the end of the evolution process.
  (i.e. at the end of each generation/iteration.)
* In the middle of the evolution process. (i.e. in the middle of the
  generation, right after the new mating pool have been created.)

Each one of the five possible hooks can be accessed through parameters
with the \*\_callback\* suffix in the `galgo()` function.

```
galgo(...,
    start_galgo_callback = callback_default,# `galgo()` is about to start.
    end_galgo_callback = callback_default,  # `galgo()` is about to finish.
    start_gen_callback = callback_default, # At the beginning of each generation
    end_gen_callback = callback_default,    # At the end of each generation
    report_callback = callback_default,     # In the middle of the generation,
                                            #  right after the new mating pool
                                            #  have been created.
    ...)
```

# 2 Example 1: A simple custom callback function definition

A callback function definition can be any R function accepting six parameters.

-`userdir`: the directory (“character”) where the user can save information
into local filesystem.
-`generation`: the number (“integer”) of the current generation/iteration.
-`pop_pool`: the data.frame containing the resulting solutions for current
iteration.
-`pareto`: the solutions found by `galgo()` accross all generations in the
solution space
-`prob_matrix`: the expression set (“matrix) where features are rows and
samples distributed in columns.
-`current_time`: The current time (an object of class”POSIXct").

The following callback function example prints the generation number and
current time every two iterations

```
library(GSgalgoR)
```

```
my_callback <-
    function(userdir = "",
        generation,
            pop_pool,
            pareto,
            prob_matrix,
            current_time) {
    # code starts  here
    if (generation%%2 == 0)
        message(paste0("generation: ",generation,
                    " current_time: ",current_time))
    }
```

then, the `my_callback()` function needs to be assigned to some of the
available hooks provided by the `galgo()`. An example of such assignment and
the resulting output is provided in the two snippets below.

A reduced version of the
[TRANSBIG](bioconductor.org/packages/release/data/experiment/html/breastCancerTRANSBIG.html)
dataset is used to setup the expression and clinical information
required for the `galgo()` function.

```
library(breastCancerTRANSBIG)
```

```
data(transbig)
train <- transbig
rm(transbig)
expression <- Biobase::exprs(train)
clinical <- Biobase::pData(train)
OS <- survival::Surv(time = clinical$t.rfs, event = clinical$e.rfs)
# use a reduced dataset for the example
expression <- expression[sample(1:nrow(expression), 100), ]
# scale the expression matrix
expression <- t(scale(t(expression)))
```

Then, the `galgo()` function is invoked and the recently defined function
`my_callback()` is assigned to the `report_callback` hook-point.

```
library(GSgalgoR)
```

```
# Running galgo
GSgalgoR::galgo(generations = 6,
            population = 15,
            prob_matrix = expression,
            OS = OS,
    start_galgo_callback = GSgalgoR::callback_default,
    end_galgo_callback = GSgalgoR::callback_default,
    report_callback = my_callback,      # call `my_callback()` in the mile
                                        # of each generation/iteration.
    start_gen_callback = GSgalgoR::callback_default,
    end_gen_callback = GSgalgoR::callback_default)
#> Using CPU for computing pearson distance
#> generation: 2 current_time: 2025-10-30 00:22:05.336846
#> generation: 4 current_time: 2025-10-30 00:22:06.930151
#> generation: 6 current_time: 2025-10-30 00:22:08.810658
#> NULL
```

# 3 Example 2: Saving partial population pool using custom callback function

The following callback function save in a temporary directory the solutions
obtained every five generation/iteration. A file the number of the generation
and with a `rda.` extension will be left in a directory defined
by the `tempdir()` function.

```
my_save_pop_callback <-
    function(userdir = "",
            generation,
            pop_pool,
            pareto,
            prob_matrix,
            current_time) {
        directory <- paste0(tempdir(), "/")
        if (!dir.exists(directory)) {
            dir.create(directory, recursive = TRUE)
        }
        filename <- paste0(directory, generation, ".rda")
        if (generation%%2 == 0){
            save(file = filename, pop_pool)
        }
        message(paste("solution file saved in",filename))
    }
```

As usual, the `galgo()` function is invoked and the recently defined
function `my_save_pop_callback()` is assigned to the `end_gen_callback`
hook-point. As a result, every five generation/iteration the complete
solution obtained by galgo will be saved in a file.

```
# Running galgo
GSgalgoR::galgo(
    generations = 6,
    population = 15,
    prob_matrix = expression,
    OS = OS,
    start_galgo_callback = GSgalgoR::callback_default,
    end_galgo_callback = GSgalgoR::callback_default,
    report_callback = my_callback,# call `my_callback()`
                                #  in the middle of each generation/iteration.
    start_gen_callback = GSgalgoR::callback_default,
    end_gen_callback = my_save_pop_callback # call `my_save_pop_callback()`
                                            # at the end of each
                                            #   generation/iteration
    )
#> Using CPU for computing pearson distance
#> solution file saved in /tmp/RtmpUidRl5/1.rda
#> generation: 2 current_time: 2025-10-30 00:22:17.867554
#> solution file saved in /tmp/RtmpUidRl5/2.rda
#> solution file saved in /tmp/RtmpUidRl5/3.rda
#> generation: 4 current_time: 2025-10-30 00:22:19.840363
#> solution file saved in /tmp/RtmpUidRl5/4.rda
#> solution file saved in /tmp/RtmpUidRl5/5.rda
#> generation: 6 current_time: 2025-10-30 00:22:21.773084
#> solution file saved in /tmp/RtmpUidRl5/6.rda
#> NULL
```

# 4 Callbacks implemented in GSgalgoR

By default, GSfalgoR implements four callback functions

`callback_default()` a simple callback that does nothing at all. It is just
used for setting the default behavior of some of the hook-points
inside `galgo()`
`callback_base_report()` a report callback for printing basic information
about the solution provided by `galgo()` such as fitness and crowding distance.
`callback_no_report()` a report callback for informing the user galgo is
running. Not valuable information is shown.
`callback_base_return_pop()` a callback function for building and returning t
he `galgo.Obj` object.

In the the default definition of the `galgo()` function the hook-points are
defined as follow:

-`start_galgo_callback = callback_default`

-`end_galgo_callback = callback_base_return_pop`

-`report_callback = callback_base_report`

-`start_gen_callback = callback_default`

-`end_gen_callback = callback_default`

Notice by using the callback mechanism it is possible to modify even the
returning value of the `galgo()` function. The default
`callback_base_return_pop()` returns a `galgo.Obj` object, however it would
simple to change that behavior for something like the `my_save_pop_callback()`
and the function will not returning any value.

```
# Running galgo
GSgalgoR::galgo(
    generations = 6,
    population = 15,
    prob_matrix = expression,
    OS = OS,
    start_galgo_callback = GSgalgoR::callback_default,
    end_galgo_callback = my_save_pop_callback,
    report_callback = my_callback,  # call `my_callback()`
                                    # in the middle of each generation/iteration
    start_gen_callback = GSgalgoR::callback_default,
    end_gen_callback = GSgalgoR::callback_default
    )
#> Using CPU for computing pearson distance
#> generation: 2 current_time: 2025-10-30 00:22:30.219861
#> generation: 4 current_time: 2025-10-30 00:22:31.894365
#> generation: 6 current_time: 2025-10-30 00:22:33.741871
#> solution file saved in /tmp/RtmpUidRl5/6.rda
```

For preserving the return behavior of the `galgo()` function,
`callback_base_return_pop()` should be called inside a custom callback.
An example of such situation is shown below:

```
another_callback <-
    function(userdir = "",
            generation,
            pop_pool,
            pareto,
            prob_matrix,
            current_time) {
    # code starts  here

    # code ends here
    callback_base_return_pop(userdir,
                            generation,
                            pop_pool,
                            prob_matrix,
                            current_time)
    }
```

# 5 Session info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#>  [1] survminer_0.5.1             ggpubr_0.6.2
#>  [3] ggplot2_4.0.0               genefu_2.42.0
#>  [5] AIMS_1.42.0                 e1071_1.7-16
#>  [7] iC10_2.0.2                  biomaRt_2.66.0
#>  [9] survcomp_1.60.0             prodlim_2025.04.28
#> [11] survival_3.8-3              Biobase_2.70.0
#> [13] BiocGenerics_0.56.0         generics_0.1.4
#> [15] GSgalgoR_1.20.0             breastCancerUPP_1.47.0
#> [17] breastCancerTRANSBIG_1.47.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3     jsonlite_2.0.0         magrittr_2.0.4
#>   [4] magick_2.9.0           SuppDists_1.1-9.9      farver_2.1.2
#>   [7] rmarkdown_2.30         vctrs_0.6.5            memoise_2.0.1
#>  [10] tinytex_0.57           rstatix_0.7.3          htmltools_0.5.8.1
#>  [13] progress_1.2.3         curl_7.0.0             broom_1.0.10
#>  [16] Formula_1.2-5          sass_0.4.10            parallelly_1.45.1
#>  [19] KernSmooth_2.23-26     bslib_0.9.0            httr2_1.2.1
#>  [22] impute_1.84.0          zoo_1.8-14             cachem_1.1.0
#>  [25] lifecycle_1.0.4        iterators_1.0.14       pkgconfig_2.0.3
#>  [28] Matrix_1.7-4           R6_2.6.1               fastmap_1.2.0
#>  [31] future_1.67.0          digest_0.6.37          AnnotationDbi_1.72.0
#>  [34] S4Vectors_0.48.0       nsga2R_1.1             RSQLite_2.4.3
#>  [37] filelock_1.0.3         labeling_0.4.3         km.ci_0.5-6
#>  [40] httr_1.4.7             abind_1.4-8            compiler_4.5.1
#>  [43] proxy_0.4-27           bit64_4.6.0-1          withr_3.0.2
#>  [46] doParallel_1.0.17      S7_0.2.0               backports_1.5.0
#>  [49] carData_3.0-5          DBI_1.2.3              ggsignif_0.6.4
#>  [52] lava_1.8.1             rappdirs_0.3.3         tools_4.5.1
#>  [55] iC10TrainingData_2.0.1 future.apply_1.20.0    bootstrap_2019.6
#>  [58] glue_1.8.0             gridtext_0.1.5         grid_4.5.1
#>  [61] cluster_2.1.8.1        gtable_0.3.6           KMsurv_0.1-6
#>  [64] class_7.3-23           tidyr_1.3.1            data.table_1.17.8
#>  [67] hms_1.1.4              xml2_1.4.1             car_3.1-3
#>  [70] XVector_0.50.0         foreach_1.5.2          pillar_1.11.1
#>  [73] stringr_1.5.2          limma_3.66.0           splines_4.5.1
#>  [76] ggtext_0.1.2           dplyr_1.1.4            BiocFileCache_3.0.0
#>  [79] lattice_0.22-7         bit_4.6.0              tidyselect_1.2.1
#>  [82] Biostrings_2.78.0      knitr_1.50             gridExtra_2.3
#>  [85] bookdown_0.45          IRanges_2.44.0         Seqinfo_1.0.0
#>  [88] pamr_1.57              stats4_4.5.1           xfun_0.53
#>  [91] statmod_1.5.1          stringi_1.8.7          yaml_2.3.10
#>  [94] evaluate_1.0.5         codetools_0.2-20       tibble_3.3.0
#>  [97] BiocManager_1.30.26    cli_3.6.5              survivalROC_1.0.3.1
#> [100] xtable_1.8-4           jquerylib_0.1.4        survMisc_0.5.6
#> [103] dichromat_2.0-0.1      Rcpp_1.1.0             rmeta_3.0
#> [106] globals_0.18.0         dbplyr_2.5.1           png_0.1-8
#> [109] parallel_4.5.1         mco_1.17               blob_1.2.4
#> [112] prettyunits_1.2.0      mclust_6.1.1           listenv_0.9.1
#> [115] scales_1.4.0           purrr_1.1.0            crayon_1.5.3
#> [118] rlang_1.1.6            KEGGREST_1.50.0
```