# Code example from 'ADImpute_tutorial' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
is_check <- ("CheckExEnv" %in% search()) || any(c("_R_CHECK_TIMINGS_",
    "_R_CHECK_LICENSE_") %in% names(Sys.getenv()))
knitr::opts_chunk$set(eval = !is_check, collapse = TRUE, comment = "#>")
library(ADImpute)

## ----warning=FALSE, message=FALSE, eval=FALSE---------------------------------
# RPM <- NormalizeRPM(ADImpute::demo_data)
# imputed <- Impute(data = RPM, do = c("Network"), cores = 2,
#     net.coef = ADImpute::demo_net)

## ----warning=FALSE, message=FALSE, results=FALSE------------------------------
RPM <- NormalizeRPM(ADImpute::demo_data)
methods_pergene <- EvaluateMethods(data = RPM,
    do = c("Baseline", "DrImpute", "Network"),
    cores = 2, net.coef = ADImpute::demo_net)

## ----warning=FALSE------------------------------------------------------------
head(methods_pergene)

## ----warning=FALSE, message=FALSE, results=FALSE------------------------------
imputed <- Impute(do = "Ensemble", method.choice = methods_pergene,
    data = RPM, cores = 2, net.coef = ADImpute::demo_net)

## ----warning=FALSE------------------------------------------------------------
str(imputed)

## ----warning=FALSE, message=FALSE, results=FALSE------------------------------
imputed <- Impute(do = "Baseline",
    data = RPM,
    cores = 2,
    true.zero.thr = .3)

## ----warning=FALSE------------------------------------------------------------
str(imputed)

## ----warning=FALSE, message=FALSE, results=FALSE------------------------------
sce <- NormalizeRPM(sce = ADImpute::demo_sce)
sce <- EvaluateMethods(sce = sce)
sce <- Impute(sce = sce)

## ----warning=FALSE, eval=FALSE------------------------------------------------
# # # call to scImpute
# if('scimpute' %in% tolower(do)){
#     message('Make sure you have previously installed scImpute via GitHub.\n')
#     res <- tryCatch(ImputeScImpute(count_path, labeled = is.null(labels),
#             Kcluster = cell.clusters, labels = labels, drop_thre = drop_thre,
#             cores = cores, type = type, tr.length = tr.length),
#         error = function(e){ stop(paste('Error:', e$message,
#             '\nTry sourcing the Impute_extra.R file.'))})
#     imputed$scImpute <- log2( (res / scale) + pseudo.count)
# }
# 
# # call to SCRABBLE
# if('scrabble' %in% tolower(do)){
#     message('Make sure you have previously installed SCRABBLE via GitHub.\n')
#     res <- tryCatch(ImputeSCRABBLE(data, bulk),
#                     error = function(e) { stop(paste('Error:', e$message,
#                         '\nTry sourcing the Impute_extra.R file.'))})
#     imputed$SCRABBLE <- log2( (res / scale) + pseudo.count)
#     rm(res);gc()
# }

## -----------------------------------------------------------------------------
sessionInfo()

