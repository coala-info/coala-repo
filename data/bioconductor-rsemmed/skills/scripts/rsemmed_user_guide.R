# Code example from 'rsemmed_user_guide' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("rsemmed")

## -----------------------------------------------------------------------------
library(rsemmed)

data(g_small)

## -----------------------------------------------------------------------------
nodes_sickle <- find_nodes(g_small, pattern = "sickle")
nodes_sickle

## -----------------------------------------------------------------------------
nodes_sickle <- nodes_sickle[c(1,3,5)]
nodes_sickle

## -----------------------------------------------------------------------------
nodes_malaria <- find_nodes(g_small, pattern = "malaria")
nodes_malaria

## -----------------------------------------------------------------------------
nodes_malaria$name

## -----------------------------------------------------------------------------
nodes_malaria <- nodes_malaria %>%
    find_nodes(pattern = "anti", match = FALSE) %>%
    find_nodes(pattern = "test", match = FALSE) %>%
    find_nodes(pattern = "screening", match = FALSE) %>%
    find_nodes(pattern = "pigment", match = FALSE) %>%
    find_nodes(pattern = "smear", match = FALSE) %>%
    find_nodes(pattern = "parasite", match = FALSE) %>%
    find_nodes(pattern = "serology", match = FALSE) %>%
    find_nodes(pattern = "vaccine", match = FALSE)
nodes_malaria

## -----------------------------------------------------------------------------
## malaria OR disease (dsyn)
find_nodes(g_small, pattern = "malaria", semtypes = "dsyn")

## malaria AND disease (dsyn)
find_nodes(g_small, pattern = "malaria") %>%
    find_nodes(semtypes = "dsyn")

## -----------------------------------------------------------------------------
find_nodes(g_small, names = "sickle trait")
find_nodes(g_small, names = "SICKLE trait")

## -----------------------------------------------------------------------------
paths <- find_paths(graph = g_small, from = nodes_sickle, to = nodes_malaria)

## -----------------------------------------------------------------------------
nodes_sickle

## -----------------------------------------------------------------------------
lengths(paths)

## ----fig.wide=TRUE------------------------------------------------------------
this_path <- paths[[1]][[100]]
tp <- text_path(g_small, this_path)
tp
plot_path(g_small, this_path)

## ----fig.wide=TRUE------------------------------------------------------------
this_path <- paths[[3]][[32]]
plot_path(g_small, this_path)

## ----fig.wide=TRUE------------------------------------------------------------
plot(density(degree(g_small), from = 0),
    xlab = "Degree", main = "Degree distribution")
## The second node in the path is "Infant" --> this_path[2]
abline(v = degree(g_small, v = this_path[2]), col = "red", lwd = 2)

## -----------------------------------------------------------------------------
e_feat <- get_edge_features(g_small)
head(e_feat)

## ----fig.wide=TRUE------------------------------------------------------------
paths_subset <- find_paths(
    graph = g_small,
    from = find_nodes(g_small, names = "sickle trait"),
    to = find_nodes(g_small, names = "Malaria, Cerebral")
)
paths_subset <- paths_subset[[1]]
par(mfrow = c(1,2), mar = c(3,0,1,0))
for (i in seq_along(paths_subset)) {
    cat("Path", i, ": ==============================================\n")
    text_path(g_small, paths_subset[[i]])
    cat("\n")
    plot_path(g_small, paths_subset[[i]])
}

## ----eval=FALSE---------------------------------------------------------------
# w <- make_edge_weights(g, e_feat,
#     node_names_out = c("Child", "Woman", "Infant")
# )

## -----------------------------------------------------------------------------
lapply(paths_subset, function(vs) {
    vs$semtype
})

## -----------------------------------------------------------------------------
w <- make_edge_weights(g_small, e_feat, node_semtypes_out = c("humn", "popg"))

paths_subset_reweight <- find_paths(
    graph = g_small,
    from = find_nodes(g_small, names = "sickle trait"),
    to = find_nodes(g_small, names = "Malaria, Cerebral"),
    weights = w
)
paths_subset_reweight

## -----------------------------------------------------------------------------
## Obtain the middle nodes (2nd node on the path)
out_names <- get_middle_nodes(g_small, paths_subset)

## Readjust weights
w <- make_edge_weights(g_small, e_feat,
    node_names_out = out_names, node_semtypes_out = c("humn", "popg")
)

## Find paths with new weights
paths_subset_reweight <- find_paths(
    graph = g_small,
    from = find_nodes(g_small, pattern = "sickle trait"),
    to = find_nodes(g_small, pattern = "Malaria, Cerebral"),
    weights = w
)
paths_subset_reweight <- paths_subset_reweight[[1]]

## How many paths?
length(paths_subset_reweight)

## ----fig.wide=TRUE------------------------------------------------------------
par(mfrow = c(1,2), mar = c(2,1.5,1,1.5))
plot_path(g_small, paths_subset_reweight[[1]])
plot_path(g_small, paths_subset_reweight[[2]])
plot_path(g_small, paths_subset_reweight[[1548]])
plot_path(g_small, paths_subset_reweight[[1549]])

## -----------------------------------------------------------------------------
get_middle_nodes(g_small, paths, collapse = FALSE)

## -----------------------------------------------------------------------------
w <- make_edge_weights(g_small, e_feat,
    node_semtypes_out = c("humn", "popg"),
    node_semtypes_in = c("gngm", "aapp")
)

paths_subset_reweight <- find_paths(
    graph = g_small,
    from = find_nodes(g_small, pattern = "sickle trait"),
    to = find_nodes(g_small, pattern = "Malaria, Cerebral"),
    weights = w
)
paths_subset_reweight <- paths_subset_reweight[[1]]
length(paths_subset_reweight)

## -----------------------------------------------------------------------------
## Reweighted paths from "sickle trait" to "Malaria, Cerebral"
semtype_summary <- summarize_semtypes(g_small, paths_subset_reweight)
semtype_summary
semtype_summary$semtypes[[1]]

## -----------------------------------------------------------------------------
## Original paths from "sickle" to "malaria"-related notes
summarize_semtypes(g_small, paths)

## -----------------------------------------------------------------------------
edge_summary <- summarize_predicates(g_small, paths)
edge_summary
edge_summary$predicates[[1]]

## -----------------------------------------------------------------------------
nodes_sickle_trait <- nodes_sickle[2:3]
nodes_sickle_trait

nbrs_sickle_trait <- grow_nodes(g_small, nodes_sickle_trait)
nbrs_sickle_trait

## -----------------------------------------------------------------------------
nbrs_sickle_trait_summ <- summarize_semtypes(g_small, nbrs_sickle_trait, is_path = FALSE)

## -----------------------------------------------------------------------------
length(nbrs_sickle_trait)
nbrs_sickle_trait2 <- nbrs_sickle_trait %>%
    find_nodes(
        pattern = "^Mice",
        semtypes = c("humn", "popg", "plnt", 
            "fish", "food", "edac", "dora", "aggp"),
        names = c("Polymerase Chain Reaction", "Mus"),
        match = FALSE
    )
length(nbrs_sickle_trait2)

## ----eval=FALSE---------------------------------------------------------------
# seed_nodes %>% grow_nodes() %>% find_nodes() %>% grow_nodes() %>% find_nodes()

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

