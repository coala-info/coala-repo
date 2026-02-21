# Freezing Python versions inside Bioconductor packages

Aaron Lun\*

\*infinite.monkeys.with.keyboards@gmail.com

#### Revised: March 16, 2025

#### Package

basilisk 1.22.0

# Contents

* [1 Overview](#overview)
* [2 For package developers](#for-package-developers)
  + [2.1 Overview](#overview-1)
  + [2.2 Setting up the package](#setting-up-the-package)
  + [2.3 Specifying Python environments](#specifying-python-environments)
    - [2.3.1 Defining `BasiliskEnvironment` objects](#defining-basiliskenvironment-objects)
    - [2.3.2 Populating environments on installation](#populating-environments-on-installation)
  + [2.4 Using the environments](#using-the-environments)
    - [2.4.1 Basics](#basics)
    - [2.4.2 Function constraints](#function-constraints)
    - [2.4.3 Persisting variables across calls](#persisting-variables-across-calls)
* [3 For end users](#for-end-users)
  + [3.1 Troubleshooting known issues](#troubleshooting-known-issues)
  + [3.2 Fine-tuning *basilisk*’s behavior](#fine-tuning-basilisks-behavior)
  + [3.3 Using *basilisk* directly for analyses](#using-basilisk-directly-for-analyses)
* [Session information](#session-information)

# 1 Overview

Packages like *[reticulate](https://CRAN.R-project.org/package%3Dreticulate)* facilitate the use of Python modules in our R-based data analyses, allowing us to leverage Python’s strengths in fields such as machine learning and image analysis.
However, it is notoriously difficult to ensure that a consistent version of Python is available with a consistently versioned set of modules, especially when the system installation of Python is used.
As a result, we cannot easily guarantee that some Python code executed via *[reticulate](https://CRAN.R-project.org/package%3Dreticulate)* on one computer will yield the same results as the same code run on another computer.
It is also possible that two R packages depend on incompatible versions of Python modules, such that it is impossible to use both packages at the same time.
These versioning issues represent a major obstacle to reliable execution of Python code across a variety of systems via R/Bioconductor packages.

*[basilisk](https://bioconductor.org/packages/3.22/basilisk)* provisions custom Python virtual environments that are managed by the Bioconductor installation machinery.
This provides developers of downstream Bioconductor packages (i.e., *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* “clients”) with more control over how their Python code is executed.
Additionally, *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* provides utilities to manage different Python environments within a single R session,
allowing multiple Bioconductor packages to use incompatible versions of Python packages in the course of a single analysis.
These features enable reproducible analysis, simplify debugging of code and improve interoperability between compliant packages.

# 2 For package developers

## 2.1 Overview

The *son.of.basilisk* package (provided in the `inst/example` directory of this package) is provided as an example of how one might write a client package that depends on *[basilisk](https://bioconductor.org/packages/3.22/basilisk)*.
This is a fully operational example package that can be installed and run, so prospective developers should use it as a template for their own packages.
We will assume that readers are familiar with general R package development practices and will limit our discussion to the *[basilisk](https://bioconductor.org/packages/3.22/basilisk)*-specific elements.

## 2.2 Setting up the package

`StagedInstall: no` should be set, to ensure that Python packages are installed with the correct hard-coded paths within the R package installation directory.

`Imports: basilisk` should be set along with appropriate directives in the `NAMESPACE` for all *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* functions that are used.

## 2.3 Specifying Python environments

### 2.3.1 Defining `BasiliskEnvironment` objects

A `basilisk.R` file should be present in the `R/` subdirectory containing commands to produce a `BasiliskEnvironment` object.
These objects define the Python virtual environments to be constructed by *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* on behalf of your client package.

```
library(basilisk)
my_env <- BasiliskEnvironment(envname="my_env_name",
    pkgname="ClientPackage",
    packages=c("pandas==2.2.3", "scikit-learn==1.6.1")
)

second_env <- BasiliskEnvironment(envname="second_env_name",
    pkgname="ClientPackage",
    packages=c("scipy=1.15.1", "numpy==2.2.2")
)
```

As shown above, all listed Python packages should have valid version numbers that can be obtained by `pip`.
It is strongly recommended to explicitly list the versions of any dependencies so as to future-proof the installation process.
If the package versions are not known, we suggest using `setBasiliskCheckVersions(FALSE)` and `listPackages()` to identify the appropriate versions.

If a different version of Python is required, it should be explicitly listed in the `packages=`, e.g., with `python=3.7`.
Otherwise, *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* will automatically use the default specified in `defaultPythonVersion` (currently 3.12.10).
It is a good idea to explicitly list a version of Python in `packages=`, even if it is already version-compatible with the default;
this ensures that Python environment creation is robust to future changes to the default.

### 2.3.2 Populating environments on installation

An executable `configure` file should be created in the top level of the client package, containing the command shown below.
This enables creation of Python environments during package installation if `BASILISK_USE_SYSTEM_DIR` is set.

```
#!/bin/sh

${R_HOME}/bin/Rscript -e "basilisk::configureBasiliskEnv()"
```

For completeness, `configure.win` should also be created:

```
#!/bin/sh

${R_HOME}/bin${R_ARCH_BIN}/Rscript.exe -e "basilisk::configureBasiliskEnv()"
```

Note that `basilisk.R` should be executable as a standalone file and create all `BasiliskEnvironment`s as named variables in the current R environment.
This is because the file will be directly `source`d by `configureBasiliskEnv()` for system installation of the Python environments (see `BASILISK_USE_SYSTEM_DIR` below).
As such, the file should not assume that the rest of the client package has been installed or that the client’s various dependencies have been loaded.

## 2.4 Using the environments

### 2.4.1 Basics

To use methods from the `my_env` environment that we previously defined, the functions in our hypothetical *ClientPackage* package should define functions like:

```
my_example_function <- function(ARG_VALUE_1, ARG_VALUE_2) {
    proc <- basiliskStart(my_env)
    on.exit(basiliskStop(proc))

    some_useful_thing <- basiliskRun(proc, fun=function(arg1, arg2) {
        mod <- reticulate::import("scikit-learn")
        output <- mod$some_calculation(arg1, arg2)

        # The return value MUST be a pure R object, i.e., no reticulate
        # Python objects, no pointers to shared memory.
        output
    }, arg1=ARG_VALUE_1, arg2=ARG_VALUE_2)

    some_useful_thing
}
```

In the above chunk, a developer-defined function `fun` is passed to `basiliskRun()` for execution inside the `proc` context where the specified Python environment is loaded.
Developers should not make any assumptions about the nature of `proc`, which is dependent on the state of the R session.
For example, *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* may choose to run `fun` in the current R session, or in another forked/socket process with the same R installation.
Any R functions that use Python code should do so via `basiliskRun()`, which ensures that different Bioconductor packages play nice when their dependencies clash.

`basiliskStart()` will lazily install the requested version of Python and packages in `my_env` if they are not already present.
This can result in some delays when `my_example_function()` is first called; afterwards, the cached environments will simply be re-used.
Check out the `use_python()` and `virtualenv_install()` functions from *[reticulate](https://CRAN.R-project.org/package%3Dreticulate)* for more details.

### 2.4.2 Function constraints

Developers should respect several constraints when defining a function for use in `basiliskRun()`:

* ⚠️ **The arguments to and return value of the function must be pure R objects.**
  Developers should NOT return *[reticulate](https://CRAN.R-project.org/package%3Dreticulate)* bindings to Python objects or any other pointers to external memory (e.g., file handles).
  This is because `basiliskRun()` may execute in a different process such that any pointers are no longer valid when they are transferred back to the parent process.
  Both the arguments to the function passed to `basiliskRun()` and its return value MUST be amenable to serialization.
* ⚠️ **Variables should be explicitly passed as arguments to the function.**
  Developers should not rely on closures capturing the R environment in which the function was defined.
  If the function is executed in a different process, any references to objects in its previous R environment will no longer be valid.
  Rather, the necessary objects should be explicitly passed as arguments to the function.
* ⚠️ **Non-base functions should be explicitly imported via their namespace.**
  When using functions (or variables) exported from non-base packages, they should be referenced using the `::` operator.
  This ensures that the relevant package will be loaded during function execution in a separate process.

More details on acceptable function definitions are provided in `?basiliskRun`.
Developers can check that their function behaves correctly in a different process
by setting `setBasiliskShared(FALSE)` and `setBasiliskFork(FALSE)` prior to running `basiliskRun()` in their unit tests.

### 2.4.3 Persisting variables across calls

Developers can persist variables across multiple calls to `basiliskRun()` by setting `persist=TRUE`.
This instructs `basiliskRun()` to pass along an R environment to `fun` as the `store=` argument,
which can be used inside `fun` to set or get variables if `basiliskRun()` is called with the same `proc`.
Stored variables are not subject to the restrictions on the arguments/return value of `fun`, but they are strictly internal to any instance of `proc`.

```
my_example_function <- function() {
    proc <- basiliskStart(my_env)
    on.exit(basiliskStop(proc))

    basiliskRun(proc, fun=function(store) {
        store$something <- rand(1)
        invisible(NULL)
    }, persist=TRUE)

    basiliskRun(proc, fun=function(store) {
        store$something
    }, persist=TRUE)
}
```

This capability allows developers to modularize complex Python workflows by splitting up steps across multiple calls to `basiliskRun()`.
However, it is probably unwise to re-use `proc` across user-visible functions, i.e., the end user should never have an opportunity to interact with `proc`.

# 3 For end users

## 3.1 Troubleshooting known issues

In most cases, end users should not have to read this document.
Properly configured *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* clients should handle all aspects of Python environment creation and loading without requiring user intervention.
That said, some system configurations are less cooperative than others:
this section contains a list of known issues and possible fixes.

Windows has a limit of 260 characters for its file paths.
This is occasionally exceeded due to deeply nested directories for some packages, causing installation to silently fail.
If this constraint is causing problems, it may be possible to circumvent them by setting `BASILISK_EXTERNAL_DIR` to a shorter path.

Builds for 32-bit Windows are not supported due to a lack of demand relative to the difficulty of setting it up.

Older versions of Rstudio on MacOSX have some difficulties with the generation of separate processes (see [here](https://github.com/rstudio/rstudio/issues/6692#issuecomment-619645114)).
As a workaround in such cases, users should set:

```
parallel:::setDefaultClusterOptions(setup_strategy = "sequential")
```

*[basilisk](https://bioconductor.org/packages/3.22/basilisk)* will automatically attempt to remove old Python environments for each client package.
However, this removal may not be fast enough on systems with low disk usage quotas, resulting in incomplete or failed installations.
In such cases, users can forcibly clear the external directory themselves to free up some space:

```
# Remove obsolete environments for specific package:
basilisk::clearExternalDir(package = "pkg_name", obsolete.only = TRUE)

# Remove all environments for a specific package:
basilisk::clearExternalDir(package = "pkg_name")

# Remove all basilisk-managed environments:
basilisk.utils::clearExternalDir()
```

## 3.2 Fine-tuning *basilisk*’s behavior

Administrators of an R installation can modify the behavior of *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* by setting a few environment variables.
All environment variables described here must be set at both installation time and run time to have any effect.
If any value is changed, it is generally safest to reinstall *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* and all of its clients.

Setting the `BASILISK_EXTERNAL_DIR` environment variable will change where the environments are created by [`basiliskStart()`](#basics) during lazy installation.
This is usually unnecessary unless the default path contains spaces or the combination of the default location and environment’s directory structure exceeds the file path length limit on Windows.

Setting `BASILISK_USE_SYSTEM_DIR` to `1` will instruct *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* to install a client package’s environments in the R system directory during R package installation.
This is useful for enterprise-level deployments as the environments are (i) not duplicated in each user’s home directory and (ii) always available to any user with access to the R installation.
However, it requires installation from source and thus is not set by default.

Setting the `BASILISK_CUSTOM_PYTHON_X_Y_Z` environment variable will cause all requests for Python version `X.Y.Z` to use the Python binary at the specified path.
This allows users to force *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* to use their own Python installation instead of installing one via *[reticulate](https://CRAN.R-project.org/package%3Dreticulate)*.
The same approach can be used with `BASILISK_CUSTOM_PYTHON_X_Y` and `BASILISK_CUSTOM_PYTHON_X` for Python versions `X.Y` or `X`.
Different client packages may need different Python versions so multiple environment variables may need to be set for different `X`/`Y`/`Z` combinations.

Setting the `BASILISK_NO_PYENV` environment variable will prevent *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* from installing any new Python instances via Pyenv.
If a requested Python version has no matching `BASILISK_CUSTOM_PYTHON_*` path, *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* will throw an error instead of attempting an installation.
This allows administrators to prevent unexpected installation of new Python instances,
e.g., when the requested version of Python is already available but the assotiated `BASILISK_CUSTOM_PYTHON_*` variable has not been set.

Setting `BASILISK_NO_DESTROY` to `1` will instruct *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* to *not* destroy previous environments upon installation of a new version of *[basilisk](https://bioconductor.org/packages/3.22/basilisk)*.
This destruction is done by default to avoid accumulating many large obsolete environments.
However, it is not desirable if there are multiple R instances running different versions of *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* from the same Bioconductor release, as installation by one R instance would delete the installed content for the other.
(Multiple R instances running different Bioconductor releases are not affected.)
This option has no effect if `BASILISK_USE_SYSTEM_DIR` is set.

## 3.3 Using *basilisk* directly for analyses

While *[basilisk](https://bioconductor.org/packages/3.22/basilisk)* is primarily intended for package developers, end users can also take advantage of its graceful handling of multiple Python environments in complex workflows.
For example, we can easily instantiate a Python environment in our working directory with `createLocalBasiliskEnv()`:

```
tmp <- createLocalBasiliskEnv(
    "basilisk-vignette-test",
    packages=c("scikit-learn=1.6.1", "numpy=2.2.2")
)
```

```
## Using Python: /home/biocbuild/.pyenv/versions/3.12.10/bin/python3.12
## Creating virtual environment '/tmp/RtmpeAQZIY/Rbuild3445a630a33e8b/basilisk/vignettes/basilisk-vignette-test/1.22.0' ...
```

```
## Done!
## Installing packages: pip, wheel, setuptools
```

```
## Installing packages: 'scikit-learn==1.6.1', 'numpy==2.2.2'
```

```
## Virtual environment '/tmp/RtmpeAQZIY/Rbuild3445a630a33e8b/basilisk/vignettes/basilisk-vignette-test/1.22.0' successfully created.
```

We can then supply this environment’s path to `basiliskRun()` to execute Python-based calculations.
To demonstrate, we’ll apply [scikit-learn](https://pypi.org/project/scikit-learn)’s truncated PCA on a random matrix.
Note that the restrictions mentioned [above](#function-constraints) for `fun` are still applicable here.

```
x <- matrix(rnorm(1000), ncol=10)
basiliskRun(env=tmp, fun=function(mat) {
    module <- reticulate::import("sklearn.decomposition")
    runner <- module$TruncatedSVD()
    output <- runner$fit(mat)
    output$singular_values_
}, mat = x, testload="scipy.optimize")
```

```
## [1] 11.93891 11.39027
```

`basiliskRun()` can also be used with Python environments constructed outside of *[basilisk](https://bioconductor.org/packages/3.22/basilisk)*.
Of course, in this case, it is the user’s responsibility to ensure that the environment is correctly provisioned.

```
library(reticulate)

tmp2 <- file.path(getwd(), "basilisk-vignette-test2")
if (!file.exists(tmp2)) {
    py.cmd <- suppressMessages(install_python(defaultPythonVersion))
    virtualenv_install(
        envname=tmp2,
        python_version=py.cmd,
        packages="scipy==1.15.1"
    )
}
```

```
## Using Python: /home/biocbuild/.pyenv/versions/3.12.10/bin/python3.12
## Creating virtual environment '/tmp/RtmpeAQZIY/Rbuild3445a630a33e8b/basilisk/vignettes/basilisk-vignette-test2' ...
```

```
## Done!
## Installing packages: pip, wheel, setuptools
```

```
## Virtual environment '/tmp/RtmpeAQZIY/Rbuild3445a630a33e8b/basilisk/vignettes/basilisk-vignette-test2' successfully created.
## Using virtual environment '/tmp/RtmpeAQZIY/Rbuild3445a630a33e8b/basilisk/vignettes/basilisk-vignette-test2' ...
```

```
basiliskRun(env=tmp2, fun=function(mat) {
    module <- reticulate::import("scipy.stats")
    norm <- module$norm
    norm$cdf(c(-1, 0, 1))
}, mat = x, testload="scipy.optimize")
```

```
## [1] 0.1586553 0.5000000 0.8413447
```

Notice how we were able to call `basiliskRun()` successfully on two different environments within the same R session.
This enables the construction of complex analysis workflows that span across R and multiple Python environments.

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
## [1] basilisk_1.22.0   reticulate_1.44.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           png_0.1-8           jsonlite_2.0.0
##  [7] dir.expiry_1.18.0   htmltools_0.5.8.1   sass_0.4.10
## [10] rappdirs_0.3.3      rmarkdown_2.30      grid_4.5.1
## [13] filelock_1.0.3      evaluate_1.0.5      jquerylib_0.1.4
## [16] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [19] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [22] Rcpp_1.1.0          lattice_0.22-7      digest_0.6.37
## [25] R6_2.6.1            parallel_4.5.1      bslib_0.9.0
## [28] Matrix_1.7-4        withr_3.0.2         tools_4.5.1
## [31] cachem_1.1.0
```