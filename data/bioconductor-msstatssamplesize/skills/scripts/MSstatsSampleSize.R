# Code example from 'MSstatsSampleSize' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(MSstatsSampleSize)

## -----------------------------------------------------------------------------
# # read in protein abundance sheet
# # The CSV sheet has 173 columns from control and cancer groups.
# # Each row is protein and each column (except the first column) is biological replicate.
# # The first column 'Protein' contains the protein names.

# OV_SRM_train <- read.csv(file = "OV_SRM_train.csv")
# # assign the column 'Protein' as row names
# rownames(OV_SRM_train) <- OV_SRM_train$Protein 
# # remove the column 'Protein
# OV_SRM_train <- OV_SRM_train[, colnames(OV_SRM_train)!="Protein"]
head(OV_SRM_train)

# Read in annotation including condition and biological replicates.
# Users should make this annotation file.
# OV_SRM_train_annotation <- read.csv(file="OV_SRM_train_annotation.csv", header=TRUE)
head(OV_SRM_train_annotation)

# estimate the mean protein abunadnce and variance in each condition
variance_estimation <- estimateVar(data = OV_SRM_train, 
                                   annotation = OV_SRM_train_annotation)

# the mean protein abundance in each condition
head(variance_estimation$mu)

# the standard deviation in each condition
head(variance_estimation$sigma)

# the mean protein abundance across all the conditions
head(variance_estimation$promean)

## ---- eval=FALSE--------------------------------------------------------------
#  #  output a pdf file with mean-SD plot
#  meanSDplot(variance_estimation)

## ----message = FALSE , warning = FALSE----------------------------------------
# expected_FC = "data": fold change estimated from OV_SRM_train
# select_simulated_proteins = "proportion": select the simulated proteins based on the proportion of total proteins
# simulate_valid = FALSE: use input OV_SRM_train as validation set
simulated_datasets <- simulateDataset(data = OV_SRM_train,
                                      annotation = OV_SRM_train_annotation,
                                      num_simulations = 10, # simulate 10 times
                                      expected_FC = "data", 
                                      list_diff_proteins =  NULL,
                                      select_simulated_proteins = "proportion",
                                      protein_proportion = 1.0,
                                      protein_number = 1000,
                                      samples_per_group = 50, # 50 samples per condition
                                      simulate_validation = FALSE, 
                                      valid_samples_per_group = 50)

## -----------------------------------------------------------------------------
# the number of simulated proteins
simulated_datasets$num_proteins

# a vector with the number of simulated samples in each condition
simulated_datasets$num_samples

# the list of simulated protein abundance matrices
# Each element of the list represents one simulation
head(simulated_datasets$simulation_train_Xs[[1]]) # first simulation

# the list of simulated condition vectors
# Each element of the list represents one simulation
head(simulated_datasets$simulation_train_Ys[[1]]) # first simulation

## ----message = FALSE , warning = FALSE----------------------------------------
# expected_FC = expected_FC: user defined fold change
unique(OV_SRM_train_annotation$Condition)
expected_FC <- c(1, 1.5)
names(expected_FC) <- c("control", "ovarian cancer")
set.seed(1212)
# Here I randomly select some proteins as differential to show how the function works
# The user should prepare this list of differential proteins by themselves
diff_proteins <- sample(rownames(OV_SRM_train), 20)
simualted_datasets_predefined_FC <- simulateDataset(data = OV_SRM_train,
                                      annotation = OV_SRM_train_annotation,
                                      num_simulations = 10, # simulate 10 times
                                      expected_FC = expected_FC,
                                      list_diff_proteins =  diff_proteins,
                                      select_simulated_proteins = "proportion",
                                      protein_proportion = 1.0,
                                      protein_number = 1000,
                                      samples_per_group = 50, # 50 samples per condition
                                      simulate_validation = FALSE,
                                      valid_samples_per_group = 50)


## ----message = FALSE, warning = FALSE-----------------------------------------
classification_results <- designSampleSizeClassification(
    simulations = simulated_datasets, 
    parallel = FALSE)


## ----message = FALSE, warning = FALSE-----------------------------------------
# the number of simulated proteins
classification_results$num_proteins
# a vector with the number of simulated samples in each condition
classification_results$num_samples
# the mean predictive accuracy over all the simulated datasets,
# which have same 'num_proteins' and 'num_samples'
classification_results$mean_predictive_accuracy
# the mean protein importance vector over all the simulated datasets,
# the length of which is 'num_proteins'.
head(classification_results$mean_feature_importance)

## ----message = FALSE, warning = FALSE-----------------------------------------
## try parallel computation to speed up
## The parallel computation may cause error while allocating the core resource
## Then the users can try the abova function without parallel computation
classification_results_parallel <- designSampleSizeClassification(
    simulations = simulated_datasets, 
    parallel = TRUE)

## ---- eval=FALSE--------------------------------------------------------------
#  #### sample size classification ####
#  # simulate different sample sizes
#  # 1) 10 biological replicats per group
#  # 1) 25 biological replicats per group
#  # 2) 50 biological replicats per group
#  # 3) 100 biological replicats per group
#  # 4) 200 biological replicats per group
#  list_samples_per_group <- c(10, 25, 50, 100, 200)
#  
#  # save the simulation results under each sample size
#  multiple_sample_sizes <- list()
#  
#  for(i in seq_along(list_samples_per_group)){
#      # run simulation for each sample size
#      simulated_datasets <- simulateDataset(data = OV_SRM_train,
#                                        annotation = OV_SRM_train_annotation,
#                                        num_simulations = 10, # simulate 10 times
#                                        expected_FC = "data",
#                                        list_diff_proteins =  NULL,
#                                        select_simulated_proteins = "proportion",
#                                        protein_proportion = 1.0,
#                                        protein_number = 1000,
#                                        samples_per_group = list_samples_per_group[i],
#                                        simulate_valid = FALSE,
#                                        valid_samples_per_group = 50)
#  
#      # run classification performance estimation for each sample size
#      res <- designSampleSizeClassification(simulations = simualted_datasets,
#                                            parallel = TRUE)
#  
#      # save results
#      multiple_sample_sizes[[i]] <- res
#  }
#  
#  ## make the plots
#  designSampleSizeClassificationPlots(multiple_sample_sizes,
#                                      list_samples_per_group,
#                                      ylimUp_predictive_accuracy = 0.8,
#                                      ylimDown_predictive_accuracy = 0.6)

## -----------------------------------------------------------------------------
#  output a pdf file with sample size calculation plot for hypothesis testing
#  also return a table which summaries the plot
HT_res <- designSampleSizeHypothesisTestingPlot(data = OV_SRM_train,
                                                annotation= OV_SRM_train_annotation,
                                                desired_FC = "data",
                                                select_testing_proteins = "proportion",
                                                protein_proportion = 1.0,
                                                protein_number = 1000,
                                                FDR=0.05,
                                                power=0.9)

# data frame with columns desiredFC, numSample, FDR, power and CV
head(HT_res)

## ---- eval=FALSE--------------------------------------------------------------
#  #  output a pdf file with 11 PCA plots
#  designSampleSizePCAplot(simulated_datasets)

