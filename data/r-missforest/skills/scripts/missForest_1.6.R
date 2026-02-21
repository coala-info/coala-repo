# Code example from 'missForest_1.6' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE, message = FALSE, warning = FALSE,
  fig.width = 5.33, fig.height = 3, fig.align = "center"
)
options(width = 70, prompt = "> ", continue = "+ ")

## ----eval=FALSE-----------------------------------------------------
# install.packages("missForest", dependencies = TRUE)

## -------------------------------------------------------------------
library(missForest)

## -------------------------------------------------------------------
set.seed(81)
data(iris)
iris.mis <- prodNA(iris, noNA = 0.1)
summary(iris.mis)

## -------------------------------------------------------------------
set.seed(81)
iris.imp <- missForest(iris.mis)  # default backend = "ranger"

## -------------------------------------------------------------------
iris.imp$OOBerror

## -------------------------------------------------------------------
imp_var <- missForest(iris.mis, variablewise = TRUE)
imp_var$OOBerror

## -------------------------------------------------------------------
set.seed(81)
imp_verbose <- missForest(iris.mis, verbose = TRUE)
imp_verbose$OOBerror

## -------------------------------------------------------------------
set.seed(96)
data(esoph)
esoph.mis <- prodNA(esoph, noNA = 0.05)
esoph.imp <- missForest(esoph.mis, verbose = TRUE, maxiter = 6)
esoph.imp$OOBerror

## ----eval=FALSE-----------------------------------------------------
# # musk <- ...  # (not fetched during CRAN build)
# # musk.mis <- prodNA(musk, 0.05)
# # missForest(musk.mis, verbose = TRUE, maxiter = 3, ntree = 100)
# # missForest(musk.mis, verbose = TRUE, maxiter = 3, ntree = 20)

## -------------------------------------------------------------------
set.seed(81)
imp_sub <- missForest(iris.mis, replace = FALSE, verbose = TRUE)
imp_sub$OOBerror

## -------------------------------------------------------------------
# Per-variable samples: numeric use single integers; factors need a vector per class
iris.sampsize <- list(12, 12, 12, 12, c(10, 15, 10))
imp_ss <- missForest(iris.mis, sampsize = iris.sampsize)

# Per-class cutoffs (factor only). With ranger backend, cutoffs are emulated via probability forests.
iris.cutoff <- list(1, 1, 1, 1, c(0.3, 0.6, 0.1))
imp_co <- missForest(iris.mis, cutoff = iris.cutoff, backend = "randomForest")

# Class weights (factor only)
iris.classwt <- list(NULL, NULL, NULL, NULL, c(10, 30, 20))
imp_cw <- missForest(iris.mis, classwt = iris.classwt)

## -------------------------------------------------------------------
imp_nodes <- missForest(iris.mis, nodesize = c(5, 1))

## -------------------------------------------------------------------
set.seed(81)
imp_bench <- missForest(iris.mis, xtrue = iris, verbose = TRUE)
imp_bench$error

# Or compute it later:
err_manual <- mixError(imp_bench$ximp, iris.mis, iris)
err_manual

## ----eval=FALSE-----------------------------------------------------
# library(doParallel)
# registerDoParallel(2)
# # Variables mode
# imp_vars <- missForest(iris.mis, parallelize = "variables", verbose = TRUE)
# 
# # Forests mode (ranger threading)
# imp_fors <- missForest(iris.mis, parallelize = "forests", verbose = TRUE, num.threads = 2)

