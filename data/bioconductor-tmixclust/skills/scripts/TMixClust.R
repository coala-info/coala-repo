# Code example from 'TMixClust' vignette. See references/ for full tutorial.

## ----init, eval=TRUE, results='hide', echo=FALSE, cache=FALSE-----------------
knitr::opts_chunk$set(cache=FALSE, echo=FALSE, eval=TRUE)

## ----style-knitr, results="asis"-------------------------------------------
BiocStyle::latex()

## ----load-package-and-data, echo=TRUE, results='markup'--------------------
# load the package
library(TMixClust)

# load the simulated time series data set
data(toy_data_df)

# display the first rows of the data frame
print(head(toy_data_df))

# plot the time series of the data set
plot_time_series_df(toy_data_df)

## ----load-data-from-file, echo=TRUE, results='markup'----------------------
# retrieve the time series data frame from a text file
toy_data_file = system.file("extdata", "toy_time_series.txt",
                            package = "TMixClust")
toy_data = get_time_series_df(toy_data_file)

# display the first rows of the data frame
print(head(toy_data))

## ----load-data-from-biobase, echo=TRUE, results='hide'---------------------
# Load the SOS pathway data from Bioconductor package SPEM
library(SPEM)
data(sos)
sos_data = get_time_series_df_bio(sos)

# Print the first lines of the retrieved time series data frame
print(head(sos_data))

## ----cluster-toy-data, echo=TRUE, results='hide'---------------------------

# cluster the time series in 3 groups
cluster_obj = TMixClust(toy_data_df, nb_clusters = 3)

## ----analyse-stability, echo=TRUE, results='markup'------------------------
# command used for running clustering 10 times with K=3
# and obtaining the result stored in best_clust_toy_obj
# best_clust_toy_obj = analyse_stability(toy_data_df, nb_clusters = 3,
#                                    nb_clustering_runs = 10,
#                                    nb_cores = 3)

# load the optimal clustering result following stability analysis
data("best_clust_toy_obj")

# display the likelihood of the best clustering solution
print(paste("Likelihood of the best solution:",
            best_clust_toy_obj$em_ll[length(best_clust_toy_obj$em_ll)]))

# plot the time series in each cluster
for (i in 1:3) {
    # extract the time series in the current cluster and plot them
    c_df=toy_data_df[which(best_clust_toy_obj$em_cluster_assignment==i),]
    plot_time_series_df(c_df, plot_title = paste("cluster",i))
}

## ----generate-silhouette3, echo=TRUE, results='hide'-----------------------
# silhouette plot of the best clustering solution for K=3
plot_silhouette(best_clust_toy_obj)

## ----generate-silhouette2, echo=TRUE, results='hide'-----------------------
# cluster the data in 4 groups and generate a silhouette plot
cluster_obj_2 = TMixClust(toy_data_df, nb_clusters = 4)
plot_silhouette(cluster_obj_2)

## ----generate-report, echo=TRUE, results='hide'----------------------------
# generate a TMixClust report with detailed clustering results
# (not executed here)
# generate_TMixClust_report(cluster_obj)

## ----cluster-real-data, echo=TRUE, results='hide'--------------------------
# retrieve the yeast time series data frame from a text file
yeast_data_file = system.file("extdata", "yeast_time_series.txt",
                              package = "TMixClust")
yeast_data = get_time_series_df(yeast_data_file)

# plot the time series of the data set
plot_time_series_df(yeast_data)

# command used for running clustering 10 times with K=4
# and obtaining the result stored in best_clust_yeast_obj
# best_clust_yeast_obj = analyse_stability(yeast_data,
                                    # time_points = c(0,24,48,63,87),
                                    # nb_clusters = 4,
                                    # nb_clustering_runs = 10,
                                    # nb_cores = 3)

# load the optimal clustering object for the yeast dataset
data("best_clust_yeast_obj")

# plot the identified 4 time series clusters:
for (i in 1:4) {
    # extract the time series in the current cluster and plot them
    c_df=yeast_data[which(best_clust_yeast_obj$em_cluster_assignment==i),]
    plot_time_series_df(c_df, plot_title = paste("cluster",i))
}

## ----getting-help, echo=TRUE, results='hide'-------------------------------
?TMixClust
?generate_TMixClust_report
?get_time_series_df
?plot_time_series_df
?plot_silhouette
?analyse_stability

## ----session-info, results="asis"------------------------------------------
toLatex(sessionInfo())

## ----citation, echo=TRUE, results='hide'-----------------------------------
citation('TMixClust')

