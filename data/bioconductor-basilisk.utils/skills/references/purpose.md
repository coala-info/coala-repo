# Bioconductor-managed conda installation

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: May 8, 2025

#### Package

basilisk.utils 1.22.0

# Contents

* [1 Overview](#overview)
* [2 For package developers](#for-package-developers)
* [3 Setting defaults](#setting-defaults)
* [Session information](#session-information)

# 1 Overview

*[basilisk.utils](https://bioconductor.org/packages/3.22/basilisk.utils)* provides consistent access to [conda](https://anaconda.org/anaconda/conda) via the [Miniforge](https://github.com/conda-forge/miniforge) project for use in other Bioconductor packages.
The idea is to check if an appropriate version of conda is already available on the host machine, and if not, download and install a local copy of conda managed by *[basilisk.utils](https://bioconductor.org/packages/3.22/basilisk.utils)*.
This avoids end-users having to manually install conda via `SystemRequirements: conda`.
To find the conda binary:

```
basilisk.utils::find()
```

```
## [1] "/home/biocbuild/.cache/R/biocconda/24.11.3-0/bin/conda"
```

This will return either a conda command on the `PATH` (if it is of a suitable version) or the cached path to a conda executable after downloading the binaries (otherwise).
Developers can use pass this to, e.g., *[reticulate](https://CRAN.R-project.org/package%3Dreticulate)*’s `conda_install()` function to create a package-specific conda environment.

# 2 For package developers

When writing a Bioconductor package that relies on a conda environment, we create a file that defines all of the environments that we need.
This is achieved by defining `*_args` variables, each of which is a list of arguments to pass to `createEnvironment()`.

```
# environments.R

env1_args <- list(
    pkg="my_package",
    name="env1",
    version="0.1.0", # doesn't have to be the same as the package version.
    packages="hdf5=1.14.6"
)

env2_args <- list(
    pkg="my_package",
    name="env2",
    version="0.2.0",
    packages="pandas" # version pinning is recommended, but not required.
)
```

We can now write our package functions that lazily create these environments on demand.

```
my_custom_function <- function() {
    path <- do.call(basilisk.utils::createEnvironment, env1_args)
    file.path(path, "bin", "h5ls")
}
```

Once the package is installed, the user’s first call to `my_custom_function()` will trigger the creation of the associated environment.

```
my_custom_function()
```

```
## [1] "/home/biocbuild/.cache/R/my_package/env1/0.1.0/bin/h5ls"
```

We also add a `configure` file to the root of the package directory.
This will create all environments during R package installation if the `BIOCCONDA_USE_SYSTEM_INSTALL` environment variable is set.
Administrators can subsequently bypass the lazy instantiation, e.g., for shared R installations on HPCs or within Docker images.

```
#!/bin/sh

${R_HOME}/bin/Rscript -e "basilisk.utils::configureEnvironments('R/environments.R')"
```

Also might as well do it for `configure.win`, so that it works on Windows as well:

```
#!/bin/sh

${R_HOME}/bin${R_ARCH_BIN}/Rscript.exe -e "basilisk.utils::configureEnvironments('R/environment.R')"
```

Package developers should also set `StagedInstall: no` to ensure that conda environments are created with the correct hard-coded paths within the R package installation directory.

# 3 Setting defaults

Most default behaviors of *[basilisk.utils](https://bioconductor.org/packages/3.22/basilisk.utils)* are captured in the following functions, which can in turn be controlled by environment variables.

```
basilisk.utils::defaultCommand()
```

```
## [1] "conda"
```

```
basilisk.utils::defaultMinimumVersion()
```

```
## [1] "24.11.3"
```

```
basilisk.utils::defaultDownloadVersion()
```

```
## [1] "24.11.3-0"
```

```
basilisk.utils::defaultCacheDirectory()
```

```
## [1] "/home/biocbuild/.cache/R/biocconda"
```

For example:

```
Sys.setenv(BIOCCONDA_CONDA_MINIMUM_VERSION="25.3.0")
basilisk.utils::defaultMinimumVersion()
```

```
## [1] "25.3.0"
```

And, as mentioned previously, the `BIOCCONDA_USE_SYSTEM_INSTALL` environment variable determines whether the environments are created during R package installation.

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
## [1] knitr_1.50       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37         R6_2.6.1              bookdown_0.45
##  [4] fastmap_1.2.0         xfun_0.53             dir.expiry_1.18.0
##  [7] cachem_1.1.0          filelock_1.0.3        htmltools_0.5.8.1
## [10] rmarkdown_2.30        lifecycle_1.0.4       cli_3.6.5
## [13] sass_0.4.10           jquerylib_0.1.4       compiler_4.5.1
## [16] tools_4.5.1           basilisk.utils_1.22.0 evaluate_1.0.5
## [19] bslib_0.9.0           yaml_2.3.10           BiocManager_1.30.26
## [22] jsonlite_2.0.0        rlang_1.1.6
```