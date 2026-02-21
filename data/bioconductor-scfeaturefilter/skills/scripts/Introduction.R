# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# ## try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scFeatureFilter")

## ----message=FALSE, warning=FALSE, collapse=TRUE------------------------------
library(scFeatureFilter)

library(ggplot2)
library(cowplot) # multipanel figures + nice theme

## ----collapse=TRUE------------------------------------------------------------
# example dataset included with the package:
scData_hESC

# filtering of the dataset with a single function call:
sc_feature_filter(scData_hESC)

## ----collapse=TRUE------------------------------------------------------------
scData_hESC

## ----collapse=TRUE------------------------------------------------------------
calculate_cvs(scData_hESC)

## ----collapse=TRUE------------------------------------------------------------
library(magrittr) # to use the pipe %>%

calculate_cvs(scData_hESC) %>%
    plot_mean_variance(colourByBin = FALSE)

## ----collapse=TRUE------------------------------------------------------------
scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000)

## ----collapse=TRUE------------------------------------------------------------
myPlot <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000) %>%
    plot_mean_variance(colourByBin = TRUE, density_color = "blue")

myPlot

## ----collapse=TRUE------------------------------------------------------------
myPlot + annotation_logticks(sides = "l")

## ----collapse=TRUE------------------------------------------------------------
corDistrib <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000) %>%
    correlate_windows(n_random = 3)

## ----collapse=TRUE------------------------------------------------------------
corDens <- correlations_to_densities(corDistrib, absolute_cc = TRUE)
plot_correlations_distributions(corDens, facet_ncol = 5) +
    scale_x_continuous(breaks = c(0, 0.5, 1), labels = c("0", "0.5", "1"))

## ----collapse=TRUE------------------------------------------------------------
metrics <- get_mean_median(corDistrib)
metrics
plot_correlations_distributions(corDens, metrics = metrics, facet_ncol = 5) +
    scale_x_continuous(breaks = c(0, 0.5, 1), labels = c("0", "0.5", "1"))

## ----collapse=TRUE------------------------------------------------------------
plot_metric(metrics, show_ctrl = FALSE, show_threshold = FALSE)

## ----collapse=TRUE------------------------------------------------------------
plot_metric(metrics, show_ctrl = TRUE, show_threshold = FALSE)

## ----collapse=TRUE------------------------------------------------------------
plot_metric(metrics, show_ctrl = TRUE, show_threshold = TRUE, threshold = 2)

## ----collapse=TRUE------------------------------------------------------------
determine_bin_cutoff(metrics, threshold = 2)

## ----collapse=TRUE------------------------------------------------------------
binned_data <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000)
metrics <- correlate_windows(binned_data, n_random = 3) %>%
    get_mean_median

filtered_data <- filter_expression_table(
    binned_data,
    bin_cutoff = determine_bin_cutoff(metrics)
)

dim(scData_hESC)
dim(filtered_data)
filtered_data

## ----message=FALSE, warning=FALSE, collapse=TRUE------------------------------
library(SingleCellExperiment)
library(scRNAseq) # example datasets

sce_allen <- ReprocessedAllenData()

# sce_allen is an SingleCellExperiment object
sce_allen

filtered_allen <- sc_feature_filter(sce_allen, sce_assay = "rsem_tpm")
is.matrix(filtered_allen) # filtered_allen is a tibble

sce_filtered_allen <- sce_allen[rownames(filtered_allen), ]
sce_filtered_allen

## ----collapse=TRUE------------------------------------------------------------
plot_top_window_autocor(calculate_cvs(scData_hESC))

## ----collapse=TRUE------------------------------------------------------------
metrics_bigBins <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 1000) %>%
    correlate_windows(n_random = 3) %>%
    get_mean_median

metrics_smallBins <- scData_hESC %>%
    calculate_cvs %>%
    define_top_genes(window_size = 100) %>%
    bin_scdata(window_size = 500) %>%
    correlate_windows(n_random = 3) %>%
    get_mean_median

plot_grid(
    plot_metric(metrics_bigBins) +
        labs(title = "1000 genes per bin"),
    plot_metric(metrics_smallBins) +
        labs(title = "500 genes per bin")
)

