# Code example from 'motivation' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)
library(BiocStyle)

## -----------------------------------------------------------------------------
library(basilisk)
my_env <- BasiliskEnvironment(envname="my_env_name",
    pkgname="ClientPackage",
    packages=c("pandas==2.2.3", "scikit-learn==1.6.1")
)

second_env <- BasiliskEnvironment(envname="second_env_name",
    pkgname="ClientPackage",
    packages=c("scipy=1.15.1", "numpy==2.2.2") 
)

## ----eval=FALSE---------------------------------------------------------------
# parallel:::setDefaultClusterOptions(setup_strategy = "sequential")

## ----eval=(.Platform$OS.type != "windows")------------------------------------
tmp <- createLocalBasiliskEnv(
    "basilisk-vignette-test",
    packages=c("scikit-learn=1.6.1", "numpy=2.2.2")
)

## ----error=FALSE, message=FALSE, eval=(.Platform$OS.type != "windows")--------
x <- matrix(rnorm(1000), ncol=10)
basiliskRun(env=tmp, fun=function(mat) {
    module <- reticulate::import("sklearn.decomposition")
    runner <- module$TruncatedSVD()
    output <- runner$fit(mat) 
    output$singular_values_
}, mat = x, testload="scipy.optimize")

## ----error=FALSE, message=FALSE, eval=(.Platform$OS.type != "windows")--------
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

basiliskRun(env=tmp2, fun=function(mat) {
    module <- reticulate::import("scipy.stats")
    norm <- module$norm
    norm$cdf(c(-1, 0, 1))
}, mat = x, testload="scipy.optimize")

## -----------------------------------------------------------------------------
sessionInfo()

