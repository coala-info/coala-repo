# Code example from 'scMET_vignette' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='hide', message=FALSE-------------------------
library(BiocStyle)
library(knitr)
opts_chunk$set(error = FALSE, message = TRUE, warning = FALSE)
#opts_chunk$set(fig.asp = 1)

## ----scmet, fig.retina = NULL, fig.align='center', fig.wide = TRUE, fig.cap="`scMET` model overview.", echo=FALSE----
knitr::include_graphics("../inst/figures/scmet-motivation.png")

## ----installation, echo=TRUE, eval=FALSE--------------------------------------
# # Install stable version from Bioconductor
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("scMET")
# 
# ## Or development version from Github
# # install.packages("remotes")
# remotes::install_github("andreaskapou/scMET")

## ----load_package-------------------------------------------------------------
# Load package
suppressPackageStartupMessages(library(scMET))
suppressPackageStartupMessages(library(data.table))
set.seed(123)

## ----load_data----------------------------------------------------------------
# Synthetic data: list with following elements
names(scmet_dt)

## -----------------------------------------------------------------------------
head(scmet_dt$Y)

## -----------------------------------------------------------------------------
head(scmet_dt$X)

## -----------------------------------------------------------------------------
# Parameters \mu and \gamma
head(scmet_dt$theta_true)
# Hyper-paramter values
scmet_dt$theta_priors_true

## ----plot_synthetic, fig.wide = TRUE------------------------------------------
par(mfrow = c(1,2))
plot(scmet_dt$theta_true$mu, scmet_dt$theta_true$gamma, pch = 20,
     xlab = expression(paste("Mean methylation ",  mu)), 
     ylab = expression(paste("Overdsispersion ",  gamma)))
plot(scmet_dt$X[,2], scmet_dt$theta_true$mu, pch = 20,
     xlab = "X: CpG density", 
     ylab = expression(paste("Mean methylation ",  mu)))

## ----run_scmet_synthetic, warning=FALSE, message=FALSE------------------------
# Run with seed for reproducibility
fit_obj <- scmet(Y = scmet_dt$Y, X = scmet_dt$X, L = 4,
                 iter = 1000, seed = 12)

## -----------------------------------------------------------------------------
class(fit_obj)
names(fit_obj)

## -----------------------------------------------------------------------------
# Elements of the posterior list
names(fit_obj$posterior)
# Rows correspond to draws and columns to parameter dimensions
# here number of features.
dim(fit_obj$posterior$mu)
# First 5 draws across 3 features for \mu parameter
fit_obj$posterior$mu[1:5, 1:3]
# First 5 draws across 3 features for \gamma parameter
fit_obj$posterior$gamma[1:5, 1:3]
# First 5 draws for covariate coefficients
# number of columns equal to ncol(X) = 2
fit_obj$posterior$w_mu[1:5, ]

# First 5 draws for RBF coefficients
# number of columns equal to L = 4
fit_obj$posterior$w_gamma[1:5, ]

## ----mean_var_plot1, fig.wide = TRUE------------------------------------------
gg1 <- scmet_plot_mean_var(obj = fit_obj, y = "gamma", 
                           task = NULL, show_fit = TRUE)
gg2 <- scmet_plot_mean_var(obj = fit_obj, y = "epsilon", 
                           task = NULL, show_fit = TRUE)
cowplot::plot_grid(gg1, gg2, ncol = 2)

## ----fig.wide = TRUE, warning=FALSE, message=FALSE----------------------------
# Mean methylation estimates
gg1 <- scmet_plot_estimated_vs_true(obj = fit_obj, sim_dt = scmet_dt, 
                                    param = "mu")
# Overdispersion estimates
gg2 <- scmet_plot_estimated_vs_true(obj = fit_obj, sim_dt = scmet_dt, 
                                    param = "gamma")
cowplot::plot_grid(gg1, gg2, ncol = 2)

## ----warning=FALSE, message=FALSE---------------------------------------------
# Obtain MLE estimates by calling the bb_mle function
bbmle_fit <- scmet_dt$Y[, bb_mle(cbind(total_reads, met_reads)), 
                        by = c("Feature")]
bbmle_fit <- bbmle_fit[, c("Feature", "mu", "gamma")]
head(bbmle_fit)

## ----fig.width=6, fig.height=4, fig.wide = TRUE, warning=FALSE, message=FALSE----
# Overdispersion estimates MLE vs scMET
# subset of features to avoid over-plotting
scmet_plot_estimated_vs_true(obj = fit_obj, sim_dt = scmet_dt, 
                             param = "gamma", mle_fit = bbmle_fit)

## ----warning=FALSE------------------------------------------------------------
# Run HVF analysis
fit_obj <- scmet_hvf(scmet_obj = fit_obj, delta_e = 0.75, 
                     evidence_thresh = 0.8, efdr = 0.1)

# Summary of HVF analysis
head(fit_obj$hvf$summary)

## ----fig.width=6, fig.height=3, fig.wide = TRUE-------------------------------
scmet_plot_efdr_efnr_grid(obj = fit_obj, task = "hvf")

## ----fig.height=4, fig.width=9, fig.wide = TRUE-------------------------------
gg1 <- scmet_plot_vf_tail_prob(obj = fit_obj, x = "mu", task = "hvf")
gg2 <- scmet_plot_mean_var(obj = fit_obj, y = "gamma", task = "hvf")
cowplot::plot_grid(gg1, gg2, ncol = 2)

## ----load_diff_data-----------------------------------------------------------
# Structure of simulated data from two populations
names(scmet_diff_dt)

## ----fig.wide = TRUE----------------------------------------------------------
# Extract DV features
dv <- scmet_diff_dt$diff_var_features$feature_idx
# Parameters for each group
theta_A <- scmet_diff_dt$scmet_dt_A$theta_true
theta_B <- scmet_diff_dt$scmet_dt_B$theta_true

par(mfrow = c(1,2))
# Group A mean - overdispersion relationship
plot(theta_A$mu, theta_A$gamma, pch = 20, main = "Group A",
     xlab = expression(paste("Mean methylation ",  mu)), 
     ylab = expression(paste("Overdsispersion ",  gamma)))
points(theta_A$mu[dv], theta_A$gamma[dv], col = "red", pch = 20)

# Group B mean - overdispersion relationship
plot(theta_B$mu, theta_B$gamma, pch = 20, main = "Group B",
     xlab = expression(paste("Mean methylation ",  mu)), 
     ylab = expression(paste("Overdsispersion ",  gamma)))
points(theta_B$mu[dv], theta_B$gamma[dv], col = "red", pch = 20)

## ----warning = FALSE, message = FALSE-----------------------------------------
# Run scMET for group A
fit_A <- scmet(Y = scmet_diff_dt$scmet_dt_A$Y,
               X = scmet_diff_dt$scmet_dt_A$X, L = 4, 
               iter = 300, seed = 12)
# Run scMET for group B
fit_B <- scmet(Y = scmet_diff_dt$scmet_dt_B$Y,
               X = scmet_diff_dt$scmet_dt_B$X, L = 4, 
               iter = 300, seed = 12)

## ----fig.wide = TRUE----------------------------------------------------------
gg1 <- scmet_plot_mean_var(obj = fit_A, y = "gamma", task = NULL, 
                           title = "Group A")
gg2 <- scmet_plot_mean_var(obj = fit_B, y = "gamma", task = NULL, 
                           title = "Group B")
cowplot::plot_grid(gg1, gg2, ncol = 2)

## -----------------------------------------------------------------------------
# Run differential analysis with small evidence_thresh
# tp obtain more hits.
diff_obj <- scmet_differential(obj_A = fit_A, obj_B = fit_B,
                               evidence_thresh_m = 0.65,
                               evidence_thresh_e = 0.65,
                               group_label_A = "A",
                               group_label_B = "B")

## -----------------------------------------------------------------------------
# Structure of diff_obj
class(diff_obj)
names(diff_obj)

## -----------------------------------------------------------------------------
# DM results
head(diff_obj$diff_mu_summary)
# Summary of DMs
diff_obj$diff_mu_summary |> 
        dplyr::count(mu_diff_test)
# DV (based on epsilon) results
head(diff_obj$diff_epsilon_summary)
# Summary of DVs
diff_obj$diff_epsilon_summary |> 
  dplyr::count(epsilon_diff_test)

## ----fig.width=10, fig.height=3.5, fig.wide = TRUE----------------------------
gg1 <- scmet_plot_efdr_efnr_grid(obj = diff_obj, task = "diff_mu")
gg2 <- scmet_plot_efdr_efnr_grid(obj = diff_obj, task = "diff_epsilon")
cowplot::plot_grid(gg1, gg2, ncol = 2)

## ----fig.width=6, fig.height=4, fig.wide = TRUE-------------------------------
# DM volcano plot
scmet_plot_volcano(diff_obj, task = "diff_mu")
# DV based on epsilon volcano plot
scmet_plot_volcano(diff_obj, task = "diff_epsilon")

## ----fig.width=10, fig.height=4, fig.wide = TRUE------------------------------
# MA plot for DM analysis and x axis overall mean methylation
gg1 <- scmet_plot_ma(diff_obj, task = "diff_mu", x = "mu")
# MA plot for DV analysis and x axis overall mean methylation
gg2 <- scmet_plot_ma(diff_obj, task = "diff_epsilon", x = "mu")
cowplot::plot_grid(gg1, gg2, ncol = 2)

## -----------------------------------------------------------------------------
Y_scmet <- scmet_dt$Y # Methylation data
X <- scmet_dt$X # Covariates
head(Y_scmet)

## -----------------------------------------------------------------------------
# We could set X = NULL if we do not have covariates
Y_sce <- scmet_to_sce(Y = Y_scmet, X = X)
Y_sce

## -----------------------------------------------------------------------------
scmet_obj <- sce_to_scmet(sce = Y_sce)
head(scmet_obj$Y)

## -----------------------------------------------------------------------------
all(Y_scmet == scmet_obj$Y)

## ----session_info, echo=TRUE, message=FALSE-----------------------------------
sessionInfo()

