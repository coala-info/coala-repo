# Code example from 'Predicting-New-Scores' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----installation-github, eval = FALSE----------------------------------------
# # devel version
# 
# # install.packages("devtools")
# devtools::install_github("Muunraker/nipalsMCIA", ref = "devel",
#                          force = TRUE, build_vignettes = TRUE) # devel version

## ----installation-bioconductor, eval = FALSE----------------------------------
# # release version
# if (!require("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("nipalsMCIA")

## ----load-packages, message = FALSE-------------------------------------------
library(ggplot2)
library(MultiAssayExperiment)
library(nipalsMCIA)

## ----split-data---------------------------------------------------------------
data(NCI60)
set.seed(8)

num_samples <- dim(data_blocks[[1]])[1]
num_train <- round(num_samples * 0.7, 0)
train_samples <- sample.int(num_samples, num_train)

data_blocks_train <- data_blocks
data_blocks_test <- data_blocks

for (i in seq_along(data_blocks)) {
  data_blocks_train[[i]] <- data_blocks_train[[i]][train_samples, ]
  data_blocks_test[[i]] <- data_blocks_test[[i]][-train_samples, ]
}

# Split corresponding metadata
metadata_train <- data.frame(metadata_NCI60[train_samples, ],
                             row.names = rownames(data_blocks_train$mrna))
colnames(metadata_train) <- c("cancerType")

metadata_test <- data.frame(metadata_NCI60[-train_samples, ],
                            row.names = rownames(data_blocks_test$mrna))
colnames(metadata_test) <- c("cancerType")

# Create train and test mae objects
data_blocks_train_mae <- simple_mae(data_blocks_train, row_format = "sample",
                                    colData = metadata_train)
data_blocks_test_mae <- simple_mae(data_blocks_test, row_format = "sample",
                                   colData = metadata_test)

## ----computing-MCIA-on-training-data, message = FALSE, fig.show = "hide"------
MCIA_train <- nipals_multiblock(data_blocks = data_blocks_train_mae,
                                col_preproc_method = "colprofile", num_PCs = 10,
                                plots = "none", tol = 1e-9)

## ----visualize-training-model, fig.height = 2.5-------------------------------
meta_colors <- get_metadata_colors(mcia_results = MCIA_train, color_col = 1,
                                   color_pal_params = list(option = "E"))

global_scores <- nmb_get_gs(MCIA_train)
MCIA_out <- data.frame(global_scores[, 1:2])
MCIA_out$cancerType <- nmb_get_metadata(MCIA_train)$cancerType
colnames(MCIA_out) <- c("Factor.1", "Factor.2", "cancerType")

# plot the results
ggplot(data = MCIA_out, aes(x = Factor.1, y = Factor.2, color = cancerType)) +
  geom_point(size = 3) +
  labs(title = "MCIA for NCI60 training data") +
  scale_color_manual(values = meta_colors) +
  theme_bw()

## ----generate-new-scores, message = FALSE-------------------------------------
MCIA_test_scores <- predict_gs(mcia_results = MCIA_train,
                               test_data = data_blocks_test_mae)

## ----visualize-both-models, fig.height = 2.5----------------------------------
MCIA_out_test <- data.frame(MCIA_test_scores[, 1:2])
MCIA_out_test$cancerType <-
  MultiAssayExperiment::colData(data_blocks_test_mae)$cancerType

colnames(MCIA_out_test) <- c("Factor.1", "Factor.2", "cancerType")
MCIA_out_test$set <- "test"
MCIA_out$set <- "train"
MCIA_out_full <- rbind(MCIA_out, MCIA_out_test)
rownames(MCIA_out_full) <- NULL

# plot the results
ggplot(data = MCIA_out_full,
       aes(x = Factor.1, y = Factor.2, color = cancerType, shape = set)) +
  geom_point(size = 3) +
  labs(title = "MCIA for NCI60 training and test data") +
  scale_color_manual(values = meta_colors) +
  theme_bw()

## ----session-info-------------------------------------------------------------
sessionInfo()

