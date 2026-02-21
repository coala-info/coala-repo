# Code example from 'omnipath_intro' vignette. See references/ for full tutorial.

## ----fig1, fig.cap="Overview of the resources featured in OmniPath. Causal resources (including activity-flow and enzyme-substrate resources) can provide direction (*) or sign and direction (+) of interactions.", echo=FALSE----
library(knitr)
knitr::include_graphics("man/figures/page1_1.png")

## ----installation, eval=FALSE-------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("OmnipathR")

## ----libraries, message=FALSE-------------------------------------------------------------------------------
library(OmnipathR)
library(igraph)
library(tidyr)
library(gprofiler2)

## ----interactions-------------------------------------------------------------------------------------------
## We check some of the different interaction databases
interaction_resources()

## The interactions are stored into a data frame.
pathways <- omnipath(resources = c("SignaLink3", "PhosphoSite", "SIGNOR"))

## We visualize the first interactions in the data frame.
print_interactions(head(pathways))

## ----sp, message=TRUE---------------------------------------------------------------------------------------
## We transform the interactions data frame into a graph
pathways_g <- interaction_graph(pathways)

## Find and print shortest paths on the directed network between proteins
## of interest:
print_path_es(
    igraph::shortest_paths(
        pathways_g,
        from = "TYRO3",
        to = "STAT3",
        output = "epath"
    )$epath[[1]],
    pathways_g
)

## Find and print all shortest paths between proteins of interest:
print_path_vs(
    igraph::all_shortest_paths(
        pathways_g,
        from = "DYRK2",
        to = "MAPKAPK2"
    )$res,
    pathways_g
)

## ----clustering, message=FALSE------------------------------------------------------------------------------
## We apply a clustering algorithm (Louvain) to group proteins in
## our network. We apply here Louvain which is fast but can only run
## on undirected graphs. Other clustering algorithms can deal with
## directed networks but with longer computational times,
## such as cluster_edge_betweenness. These cluster methods are directly
## available in the igraph package.
pathways_g_u <- igraph::as.undirected(pathways_g, mode = "mutual")
pathways_g_u <- igraph::simplify(pathways_g_u)
clusters <- igraph::cluster_fast_greedy(pathways_g_u)
## We extract the cluster where a protein of interest is contained
erbb2_cluster_id <- clusters$membership[which(clusters$names == "ERBB2")]
erbb2_cluster_g <- igraph::induced_subgraph(
    pathways_g_u,
    igraph::V(pathways_g)$name[which(clusters$membership == erbb2_cluster_id)]
)

## ----fig2, echo = FALSE, fig.cap="ERBB2 associated cluser. Subnetwork extracted from the interactions graph representing the cluster where we can find the gene *ERBB2* (yellow node)"----
## We print that cluster with its interactions.
par(mar = c(0.1, 0.1, 0.1, 0.1))
plot(
    erbb2_cluster_g,
    vertex.label.color = "black",
    vertex.frame.color = "#ffffff",
    vertex.size = 15,
    edge.curved = 0.2,
    vertex.color = ifelse(
        igraph::V(erbb2_cluster_g)$name == "ERBB2",
        "yellow",
        "#00CCFF"
    ),
    edge.color = "blue",
    edge.width = 0.8
)

## ----pathwayextra-------------------------------------------------------------------------------------------
## We query and store the interactions into a dataframe
iactions <-
    pathwayextra(
        resources = c("Wang", "Lit-BM-17"),
        organism = 10090  # mouse
    )

## We select all the interactions in which Amfr gene is involved
iactions_amfr <- dplyr::filter(
    iactions,
    source_genesymbol == "Amfr" |
    target_genesymbol == "Amfr"
)

## We print these interactions:
print_interactions(iactions_amfr)

## ----kinaseextra--------------------------------------------------------------------------------------------
## We query and store the interactions into a dataframe
phosphonetw <-
    kinaseextra(
        resources = c("PhosphoPoint", "PhosphoSite"),
        organism = 10116  # rat
    )

## We select the interactions in which Dpysl2 gene is a target
upstream_dpysl2 <- dplyr::filter(
    phosphonetw,
    target_genesymbol == "Dpysl2"
)

## We print these interactions:
print_interactions(upstream_dpysl2)

## ----ligrecextra--------------------------------------------------------------------------------------------
## We query and store the interactions into a dataframe
ligrec_netw <- ligrecextra(
    resources = c("iTALK", "Baccin2019"),
    organism = 9606  # human
)

## Receptors of the CDH1 ligand.
downstream_cdh1 <- dplyr::filter(
    ligrec_netw,
    source_genesymbol == "CDH1"
)

## We transform the interactions data frame into a graph
downstream_cdh1_g <- interaction_graph(downstream_cdh1)

## We induce a network with these genes
downstream_cdh1_g <- igraph::induced_subgraph(
    interaction_graph(omnipath()),
    igraph::V(downstream_cdh1_g)$name
)

## ----fig3, echo = FALSE, fig.cap="Ligand-receptor interactions for the ADM2 ligand."------------------------
## We print the induced network
par(mar = c(0.1, 0.1, 0.1, 0.1))
plot(
    downstream_cdh1_g,
    vertex.label.color = "black",
    vertex.frame.color = "#ffffff",
    vertex.size = 20,
    edge.curved = 0.2,
    vertex.color = ifelse(
        igraph::V(downstream_cdh1_g)$name == "CDH1",
        "yellow",
        "#00CCFF"
    ),
    edge.color = "blue",
    edge.width = 0.8
)

## ----dorothea-----------------------------------------------------------------------------------------------
## We query and store the interactions into a dataframe
dorothea_netw <- dorothea(
    dorothea_levels = "A",
    organism = 9606
)

## We select the most confident interactions for a given TF and we print
## the interactions to check the way it regulates its different targets
downstream_gli1  <- dplyr::filter(
    dorothea_netw,
    source_genesymbol == "GLI1"
)

print_interactions(downstream_gli1)

## ----mirnatarget--------------------------------------------------------------------------------------------
## We query and store the interactions into a dataframe
mirna_targets <- mirna_target(
    resources = c("miR2Disease", "miRDeathDB")
)

## We select the interactions where a miRNA is interacting with the TF
## used in the previous code chunk and we print these interactions.
upstream_gli1 <- dplyr::filter(
    mirna_targets,
    target_genesymbol == "GLI1"
)

print_interactions(upstream_gli1)

## We transform the previous selections to graphs (igraph objects)
downstream_gli1_g <- interaction_graph(downstream_gli1)
upstream_gli1_g <- interaction_graph(upstream_gli1)

## ----fig4, echo = FALSE, fig.cap="miRNA-TF-target network. Schematic network of the miRNA (red square nodes) targeting \textit{GLI1} (yellow node) and the genes regulated by this TF (blue round nodes)."----
## We print the union of both previous graphs
par(mar = c(0.1, 0.1, 0.1, 0.1))

gli1_g <- upstream_gli1_g %u% downstream_gli1_g

plot(
    gli1_g,
    vertex.label.color = "black",
    vertex.frame.color = "#ffffff",
    vertex.size = 20,
    edge.curved = 0.25,
    vertex.color = ifelse(
        grepl("miR", igraph::V(gli1_g)$name),
        "red",
        ifelse(
            igraph::V(gli1_g)$name == "GLI1",
            "yellow",
            "#00CCFF"
        )
    ),
    edge.color = "blue",
    vertex.shape = ifelse(
        grepl("miR",igraph::V(gli1_g)$name),
        "vrectangle",
        "circle"
    ),
    edge.width = 0.8
)

## ----small-molecules----------------------------------------------------------------------------------------
trametinib_targets <- small_molecule(sources = "TRAMETINIB")
print_interactions(trametinib_targets)

## ----PTMs---------------------------------------------------------------------------------------------------
## We check the different PTMs databases
enzsub_resources()

## We query and store the enzyme-PTM interactions into a dataframe.
## No filtering by databases in this case.
enzsub <- enzyme_substrate()

## We can select and print the reactions between a specific kinase and
## a specific substrate
print_interactions(dplyr::filter(
    enzsub,
    enzyme_genesymbol == "MAP2K1",
    substrate_genesymbol == "MAPK3"
))

## In the previous results, we can see that enzyme-PTM relationships do not
## contain sign (activation/inhibition). We can generate this information
## based on the protein-protein OmniPath interaction dataset.
interactions <- omnipath()
enzsub <- signed_ptms(enzsub, interactions)

## We select again the same kinase and substrate. Now we have information
## about inhibition or activation when we print the enzyme-PTM relationships
print_interactions(
    dplyr::filter(
        enzsub,
        enzyme_genesymbol=="MAP2K1",
        substrate_genesymbol=="MAPK3"
    )
)

## We can also transform the enzyme-PTM relationships into a graph.
enzsub_g <- enzsub_graph(enzsub = enzsub)

## We download PTMs for mouse
enzsub <- enzyme_substrate(
    resources = c("PhosphoSite", "SIGNOR"),
    organism = 10090
)

## ----complexes----------------------------------------------------------------------------------------------
## We check the different complexes databases
complex_resources()

## We query and store complexes from some sources into a dataframe.
the_complexes <- complexes(resources = c("CORUM", "hu.MAP"))

## We check all the molecular complexes where a set of genes participate
query_genes <- c("WRN", "PARP1")

## Complexes where any of the input genes participate
wrn_parp1_complexes <- unique(
    complex_genes(
        the_complexes,
        genes = query_genes,
        all_genes = FALSE
    )
)

## We print the components of the different selected components
head(wrn_parp1_complexes$components_genesymbols, 6)

## Complexes where all the input genes participate jointly
complexes_query_genes_join <- unique(
    complex_genes(
        the_complexes,
        genes = query_genes,
        all_genes = TRUE
    )
)

## We print the components of the different selected components
complexes_query_genes_join$components_genesymbols

## ----enrichment---------------------------------------------------------------------------------------------
wrn_parp1_cplx_genes <- unlist(
    strsplit(wrn_parp1_complexes$components_genesymbols, "_")
)

## We can perform an enrichment analyses with the genes in the complex
enrichment <- gprofiler2::gost(
    wrn_parp1_cplx_genes,
    significant = TRUE,
    user_threshold = 0.001,
    correction_method = "fdr",
    sources = c("GO:BP", "GO:CC", "GO:MF")
)

## We show the most significant results
enrichment$result %>%
    dplyr::select(term_id, source, term_name, p_value) %>%
    dplyr::top_n(5, -p_value)

## ----complex_annotations------------------------------------------------------------------------------------
## We check the different annotation databases
annotation_resources()

## We can further investigate the features of the complex selected
## in the previous section.

## We first get the annotations of the complex itself:
cplx_annot <- annotations(
    proteins = paste0("COMPLEX:", wrn_parp1_complexes$components_genesymbols)
)

head(dplyr::select(cplx_annot, source, label, value), 10)

## ----annotations_components---------------------------------------------------------------------------------
comp_annot <- annotations(
    proteins = wrn_parp1_cplx_genes,
    resources = "NetPath"
)

dplyr::select(comp_annot, genesymbol, value)

## ----subcell_loc--------------------------------------------------------------------------------------------
subcell_loc <- annotations(
    proteins = wrn_parp1_cplx_genes,
    resources = "ComPPI"
)

## ----annot_spread-------------------------------------------------------------------------------------------
tidyr::spread(subcell_loc, label, value) %>%
dplyr::arrange(desc(score)) %>%
dplyr::top_n(10, score)

## ----annot_wide---------------------------------------------------------------------------------------------
signalink_pathways <- annotations(
    resources = "SignaLink_pathway",
    wide = TRUE
)

## ----intercell----------------------------------------------------------------------------------------------
## We check some of the different intercell categories
intercell_generic_categories()

## We import the intercell data into a dataframe
intercell_loc <- intercell(
    scope = "generic",
    aspect = "locational"
)

## We check the intercell annotations for the individual components of
## our previous complex. We filter our data to print it in a good format
dplyr::filter(intercell_loc, genesymbol %in% wrn_parp1_cplx_genes) %>%
dplyr::distinct(genesymbol, parent, .keep_all = TRUE) %>%
dplyr::select(category, genesymbol, parent) %>%
dplyr::arrange(genesymbol)

## ----intercell_quality--------------------------------------------------------------------------------------
icn <- intercell_network(high_confidence = TRUE)

## ----intercell_filter---------------------------------------------------------------------------------------
icn <-
    intercell_network() %>%
    filter_intercell_network(
        min_curation_effort = 1,
        consensus_percentile = 33
    )

## ----close_dev----------------------------------------------------------------------------------------------
## We close graphical connections
while (!is.null(dev.list()))  dev.off()

## ----sessionInfo, echo=FALSE--------------------------------------------------------------------------------
sessionInfo()

