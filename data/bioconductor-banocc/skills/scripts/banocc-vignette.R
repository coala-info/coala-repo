# Code example from 'banocc-vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("BAnOCC")

## ----load, eval=TRUE----------------------------------------------------------
library(banocc)

## ----run-banocc-help, eval=FALSE----------------------------------------------
# ?run_banocc
# ?get_banocc_output

## ----rerun, cache=TRUE, echo=FALSE--------------------------------------------
rerun <- 0

## ----basic-run-banocc, eval=TRUE, cache=TRUE, dependson=c('rerun'), results="hide"----
data(compositions_null)
compiled_banocc_model <- rstan::stan_model(model_code = banocc::banocc_model) 
b_fit     <- banocc::run_banocc(C = compositions_null, compiled_banocc_model=compiled_banocc_model)
b_output <- banocc::get_banocc_output(banoccfit=b_fit)

## ----input-hyperparameters, eval=TRUE, cache=TRUE, dependson=c('rerun'), results="hide"----
p <- ncol(compositions_null)
b_fit_hp <- banocc::run_banocc(C = compositions_null, 
                               compiled_banocc_model = compiled_banocc_model,
                               n = rep(0, p),
                               L = 10 * diag(p), 
                               a = 0.5,
                               b = 0.01)

## ----sampling-sampling, eval=TRUE, cache=TRUE, dependson=c('rerun'), results="hide"----
b_fit_sampling <- banocc::run_banocc(C = compositions_null,
                                     compiled_banocc_model = compiled_banocc_model,
                                     chains = 2,
                                     iter = 11,
                                     warmup = 5,
                                     thin = 2)

## ----sampling-cores, eval=FALSE-----------------------------------------------
# # This code is not run
# b_fit_cores <- banocc::run_banocc(C = compositions_null,
#                                   compiled_banocc_model = compiled_banocc_model,
#                                   chains = 2,
#                                   cores = 2)

## ----sampling-init, eval=TRUE, cache=TRUE, dependson=c('rerun'), results="hide"----
init <- list(list(m = rep(0, p),
                  O = diag(p),
                  lambda = 0.02),
             list(m = runif(p),
                  O = 10 * diag(p),
                  lambda = runif(1, 0.1, 2)))
b_fit_init <- banocc::run_banocc(C = compositions_null,
                                 compiled_banocc_model = compiled_banocc_model,
                                 chains = 2,
                                 init = init)

## ----eval=FALSE---------------------------------------------------------------
# ?stan

## ----output-ci, eval=TRUE, cache=TRUE, dependson=c('rerun'), results="hide"----
# Get 90% credible intervals
b_out_90 <- banocc::get_banocc_output(banoccfit=b_fit,
                                      conf_alpha = 0.1)
# Get 99% credible intervals
b_out_99 <- banocc::get_banocc_output(banoccfit=b_fit,
                                      conf_alpha = 0.01)

## ----eval-convergence, eval=TRUE, cache=TRUE, dependson=c('rerun'), results="hide"----
# Default is to evaluate convergence
b_out_ec <- banocc::get_banocc_output(banoccfit=b_fit)

# This can be turned off using `eval_convergence`
b_out_nec <- banocc::get_banocc_output(banoccfit=b_fit,
                                       eval_convergence = FALSE)

## ----show-eval-convergence, eval=TRUE-----------------------------------------
# Iterations are too few, so estimates are missing
b_out_ec$Estimates.median

# Convergence was not evaluated, so estimates are not missing
b_out_nec$Estimates.median

## ----output-extra, eval=TRUE, cache=TRUE, dependson=c('rerun'), results="hide"----
# Get the smallest credible interval width that includes zero
b_out_min_width <- banocc::get_banocc_output(banoccfit=b_fit,
                                             get_min_width = TRUE)

# Get the scaled neighborhood criterion
b_out_snc <- banocc::get_banocc_output(banoccfit=b_fit,
                                       calc_snc = TRUE)

## ----traceplot, eval=TRUE, cache=TRUE-----------------------------------------
# The inverse covariances of feature 1 with all other features
rstan::traceplot(b_fit$Fit, pars=paste0("O[1,", 2:9, "]"))

## ----traceplot-warmup, eval=TRUE, cache=TRUE----------------------------------
# The inverse covariances of feature 1 with all other features, including warmup
rstan::traceplot(b_fit$Fit, pars=paste0("O[1,", 2:9, "]"),
                 inc_warmup=TRUE)

## ----Rhat, eval=TRUE, cache=TRUE----------------------------------------------
# This returns a named vector with the Rhat values for all parameters
rhat_all <- rstan::summary(b_fit$Fit)$summary[, "Rhat"]

# To see the Rhat values for the inverse covariances of feature 1
rhat_all[paste0("O[1,", 2:9, "]")]

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# # The above plot is from Dropbox/hutlab/Emma/paper1/writeup/figures/supplemental/lambbda_behavior.png

## ----model, eval=FALSE--------------------------------------------------------
# # This code is not run
# cat(banocc::banocc_model)

