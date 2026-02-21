# Code example from 'WritingWrappers' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(CellBench)
library(purrr)

## -----------------------------------------------------------------------------
# generic skeleton for a wrapper
wrapper <- function(sce, ...) {
    stopifnot(is(sce, "SingleCellExperiment"))
    
    res <- method_function(sce, ...)
    
    return(res)
}

## -----------------------------------------------------------------------------
# one possible wrapper implmentation
drimpute_wrapper <- function(sce, ...) {
    # wrapper only accepts SingleCellExperiment or matrix type objects
    stopifnot(is(sce, "SingleCellExperiment"))

    expr <- SingleCellExperiment::normcounts(sce)
    expr_processed <- DrImpute::preprocessSC(expr)
    logcounts(sce) <- DrImpute::DrImpute(expr_processed, ...)

    return(sce)
}

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
imputation_method <- fn_list(
    dr_impute_mean = purrr::partial(drimpute_wrapper, method = "mean"),
    dr_impute_median = purrr::partial(drimpute_wrapper, method = "med")
)

