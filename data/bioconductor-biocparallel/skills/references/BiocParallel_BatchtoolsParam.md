# Introduction to BatchtoolsParam

Nitesh Turaga and Martin Morgan

#### Edited: March 22, 2018; Compiled: October 29, 2025; Converted to Rmd: May 20, 2025

#### Package

BiocParallel 1.44.0

# Contents

* [1 Introduction](#introduction)
* [2 Quick start](#quick-start)
* [3 *BatchtoolsParam* interface](#batchtoolsparam-interface)
* [4 Defining templates](#defining-templates)
* [5 Use cases](#use-cases)
* [6 Session info](#session-info)

# 1 Introduction

The `BatchtoolsParam` class is an interface to the *[batchtools](https://CRAN.R-project.org/package%3Dbatchtools)*
package from within *[BiocParallel](https://bioconductor.org/packages/3.22/BiocParallel)*, for computing on a high
performance cluster such as SGE, TORQUE, LSF, SLURM, OpenLava.

# 2 Quick start

```
library(BiocParallel)
```

This example demonstrates the easiest way to launch a 100000 jobs using
batchtools. The first step involves creating a `BatchtoolsParam` class. You can
compute using ‘bplapply’ and then the result is stored.

```
## Pi approximation
piApprox <- function(n) {
    nums <- matrix(runif(2 * n), ncol = 2)
    d <- sqrt(nums[, 1]^2 + nums[, 2]^2)
    4 * mean(d <= 1)
}

piApprox(1000)
```

```
## [1] 3.208
```

```
## Apply piApprox over
param <- BatchtoolsParam()
result <- bplapply(rep(10e5, 10), piApprox, BPPARAM=param)
mean(unlist(result))
```

```
## [1] 3.142665
```

# 3 *BatchtoolsParam* interface

The `BatchtoolsParam` interface allows intuitive usage of your high performance
cluster with `BiocParallel`.

The `BatchtoolsParam` class allows the user to specify many arguments to
customize their jobs. Applicable to clusters with formal schedulers.

* **workers** - The number of workers used by the job.
* **cluster** - We currently support, SGE, SLURM, LSF, TORQUE and OpenLava. The
  ‘cluster’ argument is supported only if the R environment knows how to find the
  job scheduler. Each cluster type uses a template to pass the job to the
  scheduler. If the template is not given we use the default templates as given in
  the ‘batchtools’ package. The cluster can be accessed by ‘bpbackend(param)’.
* **registryargs** - The ‘registryargs’ argument takes a list of arguments to
  create a new job registry for you `BatchtoolsParam`. The job registry is a
  data.table which stores all the required information to process your jobs. The
  arguments we support for registryargs are:

  + **file.dir** - Path where all files of the registry are saved. Note that
    some templates do not handle relative paths well. If nothing is given, a
    temporary directory will be used in your current working directory.
  + **work.dir** - Working directory for R process for running jobs.
  + **packages** - Packages that will be loaded on each node.
  + **namespaces** - Namespaces that will be loaded on each node.
  + **source** - Files that are sourced before executing a job.
  + **load** - Files that are loaded before executing a job.

```
registryargs <- batchtoolsRegistryargs(
    file.dir = "mytempreg",
    work.dir = getwd(),
    packages = character(0L),
    namespaces = character(0L),
    source = character(0L),
    load = character(0L)
)
param <- BatchtoolsParam(registryargs = registryargs)
param
```

```
## class: BatchtoolsParam
##   bpisup: FALSE; bpnworkers: 4; bptasks: 0; bpjobname: BPJOB
##   bplog: FALSE; bpthreshold: INFO; bpstopOnError: TRUE
##   bpRNGseed: NA; bptimeout: NA; bpprogressbar: FALSE
##   bpexportglobals: TRUE; bpexportvariables: TRUE; bpforceGC: FALSE
##   bpfallback: TRUE
##   bplogdir: NA
##   bpresultdir: NA
##   cluster type: multicore
##   template: NA
##   registryargs:
##     file.dir: mytempreg
##     work.dir: /tmp/Rtmpv6Hcdg/Rbuild36c6d2546714b4/BiocParallel/vignettes
##     packages: character(0)
##     namespaces: character(0)
##     source: character(0)
##     load: character(0)
##     make.default: FALSE
##   saveregistry: FALSE
##   resources:
```

* **resources** - A named list of key-value pairs to be substituted into the
  template file; see `?batchtools::submitJobs`.
* **template** - The template argument is unique to the `BatchtoolsParam` class.
  It is required by the job scheduler. It defines how the jobs are submitted to
  the job scheduler. If the template is not given and the cluster is chosen, a
  default template is selected from the batchtools package.
* **log** - The log option is logical, TRUE/FALSE. If it is set to TRUE, then
  the logs which are in the registry are copied to directory given by the user
  using the `logdir` argument.
* **logdir** - Path to the logs. It is given only if `log=TRUE`.
* **resultdir** - Path to the directory is given when the job has files to be
  saved in a directory.

# 4 Defining templates

The job submission template controls how the job is processed by the job
scheduler on the cluster. Obviously, the format of the template will differ
depending on the type of job scheduler. Let’s look at the default SLURM template
as an example:

```
fname <- batchtoolsTemplate("slurm")
```

```
## using default 'slurm' template in batchtools.
```

```
cat(readLines(fname), sep="\n")
```

```
## #!/bin/bash
##
## ## Job Resource Interface Definition
## ##
## ## ntasks [integer(1)]:       Number of required tasks,
## ##                            Set larger than 1 if you want to further parallelize
## ##                            with MPI within your job.
## ## ncpus [integer(1)]:        Number of required cpus per task,
## ##                            Set larger than 1 if you want to further parallelize
## ##                            with multicore/parallel within each task.
## ## walltime [integer(1)]:     Walltime for this job, in seconds.
## ##                            Must be at least 60 seconds for Slurm to work properly.
## ## memory   [integer(1)]:     Memory in megabytes for each cpu.
## ##                            Must be at least 100 (when I tried lower values my
## ##                            jobs did not start at all).
## ##
## ## Default resources can be set in your .batchtools.conf.R by defining the variable
## ## 'default.resources' as a named list.
##
## <%
## # relative paths are not handled well by Slurm
## log.file = fs::path_expand(log.file)
## -%>
##
##
## #SBATCH --job-name=<%= job.name %>
## #SBATCH --output=<%= log.file %>
## #SBATCH --error=<%= log.file %>
## #SBATCH --time=<%= ceiling(resources$walltime / 60) %>
## #SBATCH --ntasks=1
## #SBATCH --cpus-per-task=<%= resources$ncpus %>
## #SBATCH --mem-per-cpu=<%= resources$memory %>
## <%= if (!is.null(resources$partition)) sprintf(paste0("#SBATCH --partition='", resources$partition, "'")) %>
## <%= if (array.jobs) sprintf("#SBATCH --array=1-%i", nrow(jobs)) else "" %>
##
## ## Initialize work environment like
## ## source /etc/profile
## ## module add ...
##
## ## Export value of DEBUGME environemnt var to slave
## export DEBUGME=<%= Sys.getenv("DEBUGME") %>
##
## <%= sprintf("export OMP_NUM_THREADS=%i", resources$omp.threads) -%>
## <%= sprintf("export OPENBLAS_NUM_THREADS=%i", resources$blas.threads) -%>
## <%= sprintf("export MKL_NUM_THREADS=%i", resources$blas.threads) -%>
##
## ## Run R:
## ## we merge R output with stdout from SLURM, which gets then logged via --output option
## Rscript -e 'batchtools::doJobCollection("<%= uri %>")'
```

The `<%= =>` blocks are automatically replaced by the values of the elements in
the `resources` argument in the `BatchtoolsParam` constructor. Failing to
specify critical parameters properly (e.g., wall time or memory limits too low)
will cause jobs to crash, usually rather cryptically. We suggest setting
parameters explicitly to provide robustness to changes to system defaults. Note
that the `<%= =>` blocks themselves do not usually need to be modified in the
template.

The part of the template that is most likely to require explicit customization
is the last line containing the call to `Rscript`. A more customized call may be
necessary if the R installation is not standard, e.g., if multiple versions of R
have been installed on a cluster. For example, one might use instead:

```
echo 'batchtools::doJobCollection("<%= uri %>")' |
    ArbitraryRcommand --no-save --no-echo
```

If such customization is necessary, we suggest making a local copy of the
template, modifying it as required, and then constructing a `BiocParallelParam`
object with the modified template using the `template` argument. However, we
find that the default templates accessible with `batchtoolsTemplate` are
satisfactory in most cases.

# 5 Use cases

As an example for a BatchtoolParam job being run on an SGE cluster, we use the
same `piApprox` function as defined earlier. The example runs the function on 5
workers and submits 100 jobs to the SGE cluster.

Example of SGE with minimal code:

```
library(BiocParallel)

## Pi approximation
piApprox <- function(n) {
    nums <- matrix(runif(2 * n), ncol = 2)
    d <- sqrt(nums[, 1]^2 + nums[, 2]^2)
    4 * mean(d <= 1)
}

template <- system.file(
    package = "BiocParallel",
    "unitTests", "test_script", "test-sge-template.tmpl"
)
param <- BatchtoolsParam(workers=5, cluster="sge", template=template)

## Run parallel job
result <- bplapply(rep(10e5, 100), piApprox, BPPARAM=param)
```

Example of SGE demonstrating some of `BatchtoolsParam` methods.

```
library(BiocParallel)

## Pi approximation
piApprox <- function(n) {
    nums <- matrix(runif(2 * n), ncol = 2)
    d <- sqrt(nums[, 1]^2 + nums[, 2]^2)
    4 * mean(d <= 1)
}

template <- system.file(
    package = "BiocParallel",
    "unitTests", "test_script", "test-sge-template.tmpl"
)
param <- BatchtoolsParam(workers=5, cluster="sge", template=template)

## start param
bpstart(param)

## Display param
param

## To show the registered backend
bpbackend(param)

## Register the param
register(param)

## Check the registered param
registered()

## Run parallel job
result <- bplapply(rep(10e5, 100), piApprox)

bpstop(param)
```

# 6 Session info

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
## [1] BiocParallel_1.44.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] base64url_1.4       jsonlite_2.0.0      compiler_4.5.1
##  [4] BiocManager_1.30.26 crayon_1.5.3        parallel_4.5.1
##  [7] jquerylib_0.1.4     progress_1.2.3      yaml_2.3.10
## [10] fastmap_1.2.0       R6_2.6.1            batchtools_0.9.18
## [13] knitr_1.50          backports_1.5.0     checkmate_2.3.3
## [16] tibble_3.3.0        bookdown_0.45       pillar_1.11.1
## [19] bslib_0.9.0         rlang_1.1.6         cachem_1.1.0
## [22] stringi_1.8.7       xfun_0.53           fs_1.6.6
## [25] sass_0.4.10         debugme_1.2.0       cli_3.6.5
## [28] magrittr_2.0.4      withr_3.0.2         digest_0.6.37
## [31] rappdirs_0.3.3      hms_1.1.4           lifecycle_1.0.4
## [34] prettyunits_1.2.0   vctrs_0.6.5         glue_1.8.0
## [37] evaluate_1.0.5      data.table_1.17.8   codetools_0.2-20
## [40] rmarkdown_2.30      tools_4.5.1         pkgconfig_2.0.3
## [43] htmltools_0.5.8.1   brew_1.0-10
```