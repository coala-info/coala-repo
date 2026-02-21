# Code example from 'omada-vignette' vignette. See references/ for full tutorial.

## ----setup, warning = FALSE, message = FALSE----------------------------------
library(omada)
sessionInfo()

## ----feasibility_analysis, warning = FALSE, message = FALSE-------------------
# Selecting dimensions and number of clusters
new.dataset.analysis <- feasibilityAnalysis(classes = 4, samples = 50, 
                                            features = 15)

# Basing the simulation on an existing dataset and selecting the number of clusters
existing.dataset.analysis <- feasibilityAnalysisDataBased(data = toy_genes, 
                                                          classes = 3)

# Extract results of either function
average.sts.k <- get_average_stabilities_per_k(new.dataset.analysis)
maximum.st <- get_max_stability(new.dataset.analysis)
average.st <- get_average_stability(new.dataset.analysis)
generated.ds <- get_generated_dataset(new.dataset.analysis)

## ----omada, warning = FALSE, message = FALSE, cache = TRUE, fig.width = 7, fig.asp = .42, fig.align='center'----
# Running the whole cascade of tools inputting an expression dataset 
# and the upper k (number of clusters) to be investigated
omada.analysis <- omada(toy_genes, method.upper.k = 6)

# Extract results
pa.scores <- get_partition_agreement_scores(omada.analysis)
fs.scores <- get_feature_selection_scores(omada.analysis)
fs.optimal.features <- 
  get_feature_selection_optimal_features(omada.analysis)
fs.optimal.number.of.features <- 
  get_feature_selection_optimal_number_of_features(omada.analysis)

cv.scores <- get_cluster_voting_scores(omada.analysis)
cv.memberships <- get_cluster_voting_memberships(omada.analysis)
cv.metrics.votes <- get_cluster_voting_metric_votes(omada.analysis)
cv.k.votes <- get_cluster_voting_k_votes(omada.analysis)
sample.memberships <- get_sample_memberships(omada.analysis)

# Plot results
plot_partition_agreement(omada.analysis)
plot_feature_selection(omada.analysis)
plot_cluster_voting(omada.analysis)

## ----method-selection, warning = FALSE, message = FALSE, cache = TRUE, fig.width = 7, fig.asp = .42, fig.align='center'----
# Selecting the upper k limit and number of comparisons
method.results <- clusteringMethodSelection(toy_genes, method.upper.k = 3, 
                                            number.of.comparisons = 2)

# Extract results
pa.scores <- get_partition_agreement_scores(method.results)

# Plot results
plot_partition_agreement(method.results)

## ----partition_agreement, warning = FALSE, message = FALSE--------------------
# Selecting algorithms, measures and number of clusters
agreement.results <- partitionAgreement(toy_genes, algorithm.1 = "spectral", 
                                        measure.1 = "rbfdot", 
                                        algorithm.2 = "kmeans",
                                        measure.2 = "Lloyd", 
                                        number.of.clusters = 3)

# Extract results
pa.scores <- get_agreement_scores(agreement.results)

## ----feature-selection, warning = FALSE, message = FALSE, cache = TRUE, fig.width = 7, fig.asp = .42, fig.align='center'----
# Selecting minimum and maximum number of clusters and feature step
feature.selection.results <-  featureSelection(toy_genes, min.k = 3, max.k = 6,
                                               step = 3)

# Extract results
feature.selection.scores <- get_average_feature_k_stabilities(feature.selection.results)
optimal.number.of.features <- get_optimal_number_of_features
optimal.features <- get_optimal_features(feature.selection.results)

# Plot results
plot_average_stabilities(feature.selection.results)

## ----cluster_voting, warning = FALSE, message = FALSE, cache = TRUE, fig.width = 7, fig.asp = .42, fig.align='center'----
# Selecting minimum and maximum number of clusters and algorithm to be used
cluster.voting.results <- clusterVoting(toy_genes, 4,8,"sc")

# Extract results
internal.metric.scores <- get_internal_metric_scores(cluster.voting.results)
cluster.memberships.k <- get_cluster_memberships_k(cluster.voting.results)
metric.votes.k <- get_metric_votes_k(cluster.voting.results)
vote.frequencies.k <- get_vote_frequencies_k(cluster.voting.results)

# Plot results
plot_vote_frequencies(cluster.voting.results)

## ----optimal_clustering, warning = FALSE, message = FALSE---------------------
# Running the clustering with specific number of clusters(k) and algorithm 
sample.memberships <- optimalClustering(toy_genes, 4, "spectral")

# Extract results
memberships <- get_optimal_memberships(sample.memberships)
optimal.stability <- get_optimal_stability_score(sample.memberships)
optimal.parameter <- get_optimal_parameter_used(sample.memberships)

