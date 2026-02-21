# Code example from 'intro-to-prince' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----warning=FALSE, message=FALSE---------------------------------------------
library(PrInCE)
data(scott)

## -----------------------------------------------------------------------------
dim(scott)

## -----------------------------------------------------------------------------
scott[1:10, 1:5]

## -----------------------------------------------------------------------------
data(gold_standard)
head(gold_standard)

## ----eval=FALSE---------------------------------------------------------------
# # set the seed to ensure reproducible output
# set.seed(0)
# ## not evaluated
# PrInCE(scott, gold_standard)

## ----eval=FALSE---------------------------------------------------------------
# # set the seed to ensure reproducible output
# set.seed(0)
# ## not evaluated
# build_gaussians(scott)

## -----------------------------------------------------------------------------
data(scott_gaussians)
str(scott_gaussians[[3]])

## -----------------------------------------------------------------------------
# set the seed to ensure reproducible output
set.seed(0)
# one-step analysis
interactions <- PrInCE(scott, gold_standard,
                       gaussians = scott_gaussians, 
                       cv_folds = 3,
                       verbose = TRUE)
head(interactions, 50)

## -----------------------------------------------------------------------------
precision <- interactions$precision[1:10000]
plot(precision)

## -----------------------------------------------------------------------------
network <- threshold_precision(interactions, threshold = 0.5)
nrow(network)

## -----------------------------------------------------------------------------
data(scott)
# set the seed to ensure reproducible output
set.seed(0)
# fit Gaussians
gauss <- build_gaussians(scott[seq_len(500), ], 
                         min_points = 10, min_consecutive = 5, 
                         max_gaussians = 3, min_R_squared = 0.75,
                         max_iterations = 10)
# filter profiles that were not fit
scott <- scott[names(gauss), ]

## -----------------------------------------------------------------------------
feat <- calculate_features(scott, gauss, euclidean_distance = FALSE)
head(feat)

## ----eval=FALSE---------------------------------------------------------------
# ## not run
# # concatenate features from three different `scott` replicates
# feat1 <- calculate_features(scott1, gauss1)
# feat2 <- calculate_features(scott2, gauss2)
# feat3 <- calculate_features(scott3, gauss3)
# feat <- concatenate_features(list(feat1, feat2, feat3))

## -----------------------------------------------------------------------------
data(gold_standard)
reference <- adjacency_matrix_from_list(gold_standard)
# set the seed to ensure reproducible output
set.seed(0)
# predict interactions
ppi <- predict_interactions(feat, reference, classifier = "SVM",
                            models = 1, cv_folds = 3)

## -----------------------------------------------------------------------------
precision <- ppi$precision[seq_len(2e4)]
plot(precision)

## -----------------------------------------------------------------------------
net <- threshold_precision(ppi, threshold = 0.7)
nrow(net)

## -----------------------------------------------------------------------------
# analyze cleaned profiles
data(scott)
filtered = filter_profiles(scott)
chromatograms = clean_profiles(filtered)

## -----------------------------------------------------------------------------
# detect significantly co-eluting complexes
set.seed(0)
z_scores = detect_complexes(chromatograms, gold_standard)

## -----------------------------------------------------------------------------
# remove complexes that could not be analyzed
z_scores = na.omit(z_scores)
# how many could be tested?
length(z_scores)
# how many were significant at uncorrected, two-tailed p < 0.05?
sum(z_scores > 1.96)
# print the top complexes
head(sort(z_scores, decreasing = TRUE))

## -----------------------------------------------------------------------------
data("kristensen")
data("kristensen_gaussians")
dim(kristensen)
length(kristensen_gaussians)

## -----------------------------------------------------------------------------
kristensen <- kristensen[names(kristensen_gaussians), ]
kristensen <- kristensen[seq_len(500), ]
kristensen_gaussians <- kristensen_gaussians[rownames(kristensen)]

## -----------------------------------------------------------------------------
data("gold_standard")
head(gold_standard, 5)

## -----------------------------------------------------------------------------
# set seed for reproducibility
set.seed(0)
# predict interactions
interactions <- PrInCE(profiles = kristensen, 
                       gold_standard = gold_standard,
                       gaussians = kristensen_gaussians,
                       models = 1,
                       cv_folds = 5)

## -----------------------------------------------------------------------------
network <- threshold_precision(interactions, 0.5)
nrow(network)

## -----------------------------------------------------------------------------
sessionInfo()

