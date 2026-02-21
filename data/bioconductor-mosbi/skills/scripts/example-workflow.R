# Code example from 'example-workflow' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup, message=FALSE-----------------------------------------------------
library(mosbi)

## -----------------------------------------------------------------------------
z_score <- function(x, margin = 2) {
    z_fun <- function(y) {
        (y - mean(y, na.rm = TRUE)) / sd(y, na.rm = TRUE)
    }

    if (margin == 2) {
        return(apply(x, margin, z_fun))
    } else if (margin == 1) {
        return(t(apply(x, margin, z_fun)))
    }
}

bicluster_histo <- function(biclusters) {
    cols <- mosbi::colhistogram(biclusters)
    rows <- mosbi::rowhistogram(biclusters)

    graphics::par(mfrow = c(1, 2))
    hist(cols, main = "Column size ditribution")
    hist(rows, main = "Row size ditribution")
}

## ----message=FALSE------------------------------------------------------------
# get data
data(mouse_data)

mouse_data <- mouse_data[c(
    grep(
        "metabolite_identification",
        colnames(mouse_data)
    ),
    grep("^X", colnames(mouse_data))
)]

# Make data matrix
data_matrix <- z_score(log2(as.matrix(mouse_data[2:ncol(mouse_data)])), 1)

rownames(data_matrix) <- mouse_data$metabolite_identification

stats::heatmap(data_matrix)

## ----message=FALSE------------------------------------------------------------
# Fabia
fb <- mosbi::run_fabia(data_matrix) # In case the algorithms throws an error,
# return an empty list

# isa2
BCisa <- mosbi::run_isa(data_matrix)

# Plaid
BCplaid <- mosbi::run_plaid(data_matrix)

# QUBIC
BCqubic <- mosbi::run_qubic(data_matrix)

# Merge results of all algorithms
all_bics <- c(fb, BCisa, BCplaid, BCqubic)

bicluster_histo(all_bics)

## -----------------------------------------------------------------------------
bic_net <- mosbi::bicluster_network(all_bics, # List of biclusters
    data_matrix, # Data matrix
    n_randomizations = 5,
    # Number of randomizations for the
    # error model
    MARGIN = "both",
    # Use datapoints for metric evaluation
    metric = 4, # Fowlkes–Mallows index
    # For information about the metrics,
    # visit the "Similarity metrics
    # evaluation" vignette
    n_steps = 1000,
    # At how many steps should
    # the cut-of is evaluated
    plot_edge_dist = TRUE
    # Plot the evaluation of cut-off estimation
)

## -----------------------------------------------------------------------------
stats::heatmap(get_adjacency(bic_net))

## -----------------------------------------------------------------------------
plot(bic_net)

## -----------------------------------------------------------------------------
mosbi::plot_algo_network(bic_net, all_bics, vertex.label = NA)

## -----------------------------------------------------------------------------
# Prepare groups for plotting
weeks <- vapply(
    strsplit(colnames(data_matrix), "\\."),
    function(x) {
        return(x[1])
    }, ""
)

names(weeks) <- colnames(data_matrix)

print(sort(unique(weeks))) # 5 colors required

week_cols <- c("yellow", "orange", "red", "green", "brown")

# Plot network colored by week
mosbi::plot_piechart_bicluster_network(bic_net, all_bics, weeks,
    week_cols,
    vertex.label = NA
)
graphics::legend("topright",
    legend = sort(unique(weeks)),
    fill = week_cols, title = "Week"
)

## -----------------------------------------------------------------------------
# Prepare groups for plotting
samples <- vapply(
    strsplit(colnames(data_matrix), "\\."),
    function(x) {
        return(x[2])
    }, ""
)

names(samples) <- colnames(data_matrix)

samples_cols <- RColorBrewer::brewer.pal(
    n = length(sort(unique(samples))),
    name = "Set3"
)


# Plot network colored by week
mosbi::plot_piechart_bicluster_network(bic_net, all_bics, samples,
    samples_cols,
    vertex.label = NA
)
graphics::legend("topright",
    legend = sort(unique(samples)),
    fill = samples_cols, title = "Sample"
)

## -----------------------------------------------------------------------------
coms <- mosbi::get_louvain_communities(bic_net,
    min_size = 3,
    bics = all_bics
)
# Only communities with a minimum size of 3 biclusters are saved.

## -----------------------------------------------------------------------------
# Plot all communities
for (i in seq(1, length(coms))) {
    tmp_bics <- mosbi::select_biclusters_from_bicluster_network(
        coms[[i]],
        all_bics
    )

    mosbi::plot_piechart_bicluster_network(coms[[i]], tmp_bics,
        weeks, week_cols,
        main = paste0("Community ", i)
    )
    graphics::legend("topright",
        legend = sort(unique(weeks)),
        fill = week_cols, title = "Week"
    )

    cat("\nCommunity ", i, " conists of results from the
             following algorithms:\n")
    cat(get_bic_net_algorithms(coms[[i]]))
    cat("\n")
}

## -----------------------------------------------------------------------------
ensemble_bicluster_list <- mosbi::ensemble_biclusters(coms, all_bics,
    data_matrix,
    row_threshold = .1,
    col_threshold = .1
)

## -----------------------------------------------------------------------------
sessionInfo()

