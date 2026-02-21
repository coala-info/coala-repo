# Code example from 'censored_covariate' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----load packages------------------------------------------------------------
suppressPackageStartupMessages({
  library(censcyt)
  library(ggplot2)
  library(SummarizedExperiment)
  library(tidyr)
})

## ----data_simulation covariate------------------------------------------------
set.seed(1234)

nr_samples <- 50
nr_clusters <- 6
# the covariate is simulated from an exponential distribution:
X_true <- rexp(nr_samples)
# the censoring time is also sampled from an exponential distribution:
C <- rexp(nr_samples)
# the actual observed value is the minimum of the two:
X_obs <- pmin(X_true,C)
# additionally, we have the event indicator:
Event_ind <- ifelse(X_true>C,0,1)
# proportion censored:
(length(Event_ind)-sum(Event_ind))/length(Event_ind)

## ----data_simulation multicluster---------------------------------------------
# number of cells per sample
sizes <- round(runif(nr_samples,1e3,1e4))
# alpha parameters of the dirichlet-multinomial distribution. 
alphas <- runif(nr_clusters,1,10)
# main simulation function
simulation_output <- simulate_multicluster(alphas = alphas,
                                           sizes = sizes,
                                           covariate = X_obs,
                                           nr_diff = 2,
                                           return_summarized_experiment = TRUE,
                                           slope = list(0.9))
# counts as a SummarizedExperiment object
d_counts <- simulation_output$counts

## ----diffplot, fig.cap="Relative cell population abundance vs. survival time (X_obs). Event_ind indicates if X_obs is censored or observed.", fig.wide=TRUE----

# vector indicating if a cluster has a modeled association or not
is_diff_cluster <- ifelse(is.na(simulation_output$row_data$paired),FALSE,TRUE)
# first convert to proportions:
proportion <- as.data.frame(t(apply(assay(d_counts),2,function(x)x/sum(x))))
names(proportion) <- paste0("Nr: ",names(proportion), " - ", 
                            ifelse(is_diff_cluster,"DA","non DA"))
# then to long format for plotting
counts_long <-
  pivot_longer(proportion, 
               cols= seq_len(nr_clusters),
               names_to = "cluster_id",
               values_to = "proportion")
# add observed (partly censored) variable
counts_long$X_obs <- rep(X_obs,each=nr_clusters)
# add event indicator
counts_long$Event_ind <- factor(rep(Event_ind,each=nr_clusters),
                                levels = c(0,1),
                                labels=c("censored","observed"))

ggplot(counts_long) +
  geom_point(aes(x=X_obs,y=proportion,color=Event_ind)) +
  facet_wrap(~cluster_id)

## ----experiment_info----------------------------------------------------------
# all covariates and sample ids
experiment_info <- data.frame(sample_id = seq_len(nr_samples),
                              X_obs = X_obs, 
                              Event_ind = Event_ind)

## ----formula_contrast---------------------------------------------------------
da_formula <- createFormula(experiment_info = experiment_info,
                            cols_fixed = "X_obs",
                            cols_random = "sample_id",
                            event_indicator = "Event_ind")
# also create contrast matrix for testing
contrast <- matrix(c(0,1))

## ----differential_testing, message=TRUE---------------------------------------
# test with 50 repetitions with method risk set imputation (rs)
da_out <- testDA_censoredGLMM(d_counts = d_counts,
                              formula = da_formula,
                              contrast = contrast,
                              mi_reps = 30,
                              imputation_method = "km",
                              verbose = TRUE,
                              BPPARAM=BiocParallel::MulticoreParam(workers = 1))

## ----differential_testing evaluation, message=TRUE----------------------------
topTable(da_out)

# compare to actual differential clusters:
which(!is.na(simulation_output$row_data$paired))

## ----wrapper function create data---------------------------------------------
# Function to create expression data (one sample)
fcs_sim <- function(n = 2000, mean = 0, sd = 1, ncol = 10, cof = 5) {
  d <- matrix(sinh(rnorm(n*ncol, mean, sd)) * cof,ncol=ncol)
  # each marker is heavily expressed in one population, i.e. this should result 
  # in 'ncol' clusters
  for(i in seq_len(ncol)){
    d[seq(n/ncol*(i-1)+1,n/ncol*(i)),i] <- 
      sinh(rnorm(n/ncol, mean+2, sd)) * cof
  }
  colnames(d) <- paste0("marker", sprintf("%02d", 1:ncol))
  d
}

# create multiple expression data samples with DA signal
comb_sim <- function(X, nr_samples = 10, mean = 0, sd = 1, ncol = 10, cof = 5){
  # Create random data (without differential signal)
  d_input <- lapply(seq_len(nr_samples), 
                    function(i) fcs_sim(mean = mean, 
                                        sd = sd,
                                        ncol = ncol,
                                        cof = cof))
  # Add differential abundance (DA) signal
  for(i in seq_len(nr_samples)){
    # number of cells in cluster 1
    n_da <- round((plogis(X_true[i]))*300)
    # set to random expression
    d_input[[i]][seq_len(n_da), ] <- 
      matrix(sinh(rnorm(n_da*ncol, mean, sd)) * cof, ncol=ncol)
    # increase expression for cluster 1
    d_input[[i]][seq_len(n_da) ,1] <- 
      sinh(rnorm(n_da, mean + 2, sd)) * cof
  }
  d_input
}

# set parameter and simulat
d_input <- comb_sim(X_true, nr_samples = 50)


## ----wrapper function marker info---------------------------------------------
marker_info <- data.frame(
  channel_name = paste0("channel", sprintf("%03d", seq_len(10))),
  marker_name = paste0("marker", sprintf("%02d", seq_len(10))),
  marker_class = factor(c(rep("type", 10)),
                        levels = c("type", "state", "none")),
  stringsAsFactors = FALSE
)

## ----run wrapper function-----------------------------------------------------
# Run wrapper function
out_DA <- censcyt(d_input, 
                  experiment_info, 
                  marker_info,
                  formula = da_formula, 
                  contrast = contrast,
                  meta_clustering = TRUE, 
                  meta_k = 10,
                  seed_clustering = 123, 
                  verbose = FALSE, 
                  mi_reps = 10,
                  imputation_method = "km",
                  BPPARAM=BiocParallel::MulticoreParam(workers = 1))

## ----run wrapper result, fig.width=10-----------------------------------------

# Display results for top DA clusters
topTable(out_DA, format_vals = TRUE)

# Plot heatmap for DA tests
plotHeatmap(out_DA, 
            analysis_type = "DA", 
            sample_order = order(X_true))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

