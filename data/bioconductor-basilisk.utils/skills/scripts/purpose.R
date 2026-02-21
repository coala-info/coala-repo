# Code example from 'purpose' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

library(BiocStyle)
self <- Biocpkg("basilisk.utils")

## -----------------------------------------------------------------------------
basilisk.utils::find()

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
my_custom_function <- function() {
    path <- do.call(basilisk.utils::createEnvironment, env1_args)
    file.path(path, "bin", "h5ls")
}

## -----------------------------------------------------------------------------
my_custom_function()

## -----------------------------------------------------------------------------
basilisk.utils::defaultCommand()
basilisk.utils::defaultMinimumVersion()
basilisk.utils::defaultDownloadVersion()
basilisk.utils::defaultCacheDirectory()

## -----------------------------------------------------------------------------
Sys.setenv(BIOCCONDA_CONDA_MINIMUM_VERSION="25.3.0")
basilisk.utils::defaultMinimumVersion()

## -----------------------------------------------------------------------------
sessionInfo()

