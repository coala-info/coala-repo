# Code example from 'GeneTonic_manual' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-----------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment  = "#>",
  error    = FALSE,
  warning  = FALSE,
  eval     = TRUE,
  message  = FALSE,
  fig.width = 10
)
options(width = 100)
stopifnot(requireNamespace("htmltools"))
htmltools::tagList(rmarkdown::html_dependency_font_awesome())

## ----install, eval=FALSE--------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("GeneTonic")

## ----loadlib, eval = TRUE-------------------------------------------------------------------------
library("GeneTonic")

## ----launchapp, eval=FALSE------------------------------------------------------------------------
# GeneTonic(dds = dds_object,
#           res_de = res_de_object,
#           res_enrich = res_enrich_object,
#           annotation_obj = annotation_object,
#           project_id = "myFirstGeneTonic")

## ----examplerun, eval=FALSE-----------------------------------------------------------------------
# example("GeneTonic", ask = FALSE)

## ----create_dds, eval=TRUE------------------------------------------------------------------------
library("macrophage")
library("DESeq2")

data("gse", package = "macrophage")

dds_macrophage <- DESeqDataSet(gse, design = ~line + condition)
# changing the ids to Ensembl instead of the Gencode used in the object
rownames(dds_macrophage) <- substr(rownames(dds_macrophage), 1, 15)
dds_macrophage

## ----create_resde1, eval = TRUE-------------------------------------------------------------------
keep <- rowSums(counts(dds_macrophage) >= 10) >= 6
dds_macrophage <- dds_macrophage[keep, ]
dds_macrophage

## ----create_resde2, eval = FALSE------------------------------------------------------------------
# dds_macrophage <- DESeq(dds_macrophage)
# # vst_macrophage <- vst(dds_macrophage)
# res_macrophage_IFNg_vs_naive <- results(dds_macrophage,
#                                         contrast = c("condition", "IFNg", "naive"),
#                                         lfcThreshold = 1, alpha = 0.05)
# res_macrophage_IFNg_vs_naive$SYMBOL <- rowData(dds_macrophage)$SYMBOL

## ----load_resde, eval=TRUE------------------------------------------------------------------------
## To speed up the operations in the vignette, we can also load this object directly
data("res_de_macrophage")
head(res_macrophage_IFNg_vs_naive)

## ----create_resenrich1, eval=TRUE-----------------------------------------------------------------
library("AnnotationDbi")
de_symbols_IFNg_vs_naive <- mosdef::deresult_to_df(res_macrophage_IFNg_vs_naive, FDR = 0.05)$SYMBOL
bg_ids <- rowData(dds_macrophage)$SYMBOL[rowSums(counts(dds_macrophage)) > 0]

## ----create_resenrich2, eval=FALSE----------------------------------------------------------------
# library("topGO")
# topgoDE_macrophage_IFNg_vs_naive <-
#   mosdef::run_topGO(de_genes = de_symbols_IFNg_vs_naive,
#                     bg_genes = bg_ids,
#                     ontology = "BP",
#                     mapping = "org.Hs.eg.db",
#                     geneID = "symbol")

## ----load_resenrich, eval=TRUE--------------------------------------------------------------------
## To speed up the operations in the vignette, we also load this object directly
data("res_enrich_macrophage")
head(topgoDE_macrophage_IFNg_vs_naive, 2)

## ----convert_resenrich, eval=TRUE-----------------------------------------------------------------
res_enrich_macrophage <- shake_topGOtableResult(topgoDE_macrophage_IFNg_vs_naive)
colnames(res_enrich_macrophage)

## ----create_anno, eval=TRUE-----------------------------------------------------------------------
library("org.Hs.eg.db")
anno_df <- data.frame(
  gene_id = rownames(dds_macrophage),
  gene_name = mapIds(org.Hs.eg.db, keys = rownames(dds_macrophage), column = "SYMBOL", keytype = "ENSEMBL"),
  stringsAsFactors = FALSE,
  row.names = rownames(dds_macrophage)
)
## alternatively:
# anno_df <- mosdef::get_annotation_orgdb(dds_macrophage, "org.Hs.eg.db", "ENSEMBL")

## ----aggr_enrich, eval=TRUE-----------------------------------------------------------------------
res_enrich_macrophage <- get_aggrscores(res_enrich = res_enrich_macrophage,
                                        res_de = res_macrophage_IFNg_vs_naive,
                                        annotation_obj = anno_df,
                                        aggrfun = mean)

## ----dryrun, eval=FALSE---------------------------------------------------------------------------
# GeneTonic(dds = dds_macrophage,
#           res_de = res_macrophage_IFNg_vs_naive,
#           res_enrich = res_enrich_macrophage,
#           annotation_obj = anno_df,
#           project_id = "GT1")

## -------------------------------------------------------------------------------------------------
gtl <- GeneTonicList(
  dds = DESeq2::estimateSizeFactors(dds_macrophage),
  res_de = res_macrophage_IFNg_vs_naive,
  res_enrich = res_enrich_macrophage,
  annotation_obj = anno_df
)

# if nothing is returned, the object is ready to be provided to GeneTonic
checkup_gtl(gtl)

if (interactive()) {
  GeneTonic(gtl = gtl)
}

## ----fig.cap="Screenshot of the `GeneTonic` application, when launched as a server where users can directly upload `GeneTonicList` objects. Information on the format and content for this object type are provided in the collapsible element on the right side of the dashboard body.", echo=FALSE----
knitr::include_graphics("upload_gtl.png")

## ----starthappyhour, eval = FALSE-----------------------------------------------------------------
# happy_hour(dds = dds_macrophage,
#            res_de = res_de,
#            res_enrich = res_enrich,
#            annotation_obj = anno_df,
#            project_id = "examplerun",
#            mygenesets = res_enrich$gs_id[c(1:5,11,31)],
#            mygenes = c("ENSG00000125347",
#                        "ENSG00000172399",
#                        "ENSG00000137496")
# )

## ----enhancetable---------------------------------------------------------------------------------
p <- enhance_table(res_enrich_macrophage,
                   res_macrophage_IFNg_vs_naive,
                   n_gs = 30,
                   annotation_obj = anno_df,
                   chars_limit = 60)
p
library("plotly")
ggplotly(p)

## ----alluvial-------------------------------------------------------------------------------------
gs_alluvial(res_enrich = res_enrich_macrophage,
            res_de = res_macrophage_IFNg_vs_naive,
            annotation_obj = anno_df,
            n_gs = 4)

## ----ggs------------------------------------------------------------------------------------------
ggs <- ggs_graph(res_enrich_macrophage,
                 res_de = res_macrophage_IFNg_vs_naive,
                 anno_df,
                 n_gs = 20)
ggs

# could be viewed interactively with
library(visNetwork)
library(magrittr)
ggs %>%
  visIgraph() %>%
  visOptions(highlightNearest = list(enabled = TRUE,
                                     degree = 1,
                                     hover = TRUE),
             nodesIdSelection = TRUE)

## ----summaryrep-----------------------------------------------------------------------------------
em <- enrichment_map(res_enrich_macrophage,
                     res_macrophage_IFNg_vs_naive,
                     n_gs = 30,
                     color_by = "z_score",
                     anno_df)
library("igraph")
library("visNetwork")
library("magrittr")

em %>% 
  visIgraph() %>% 
  visOptions(highlightNearest = list(enabled = TRUE,
                                     degree = 1,
                                     hover = TRUE),
             nodesIdSelection = TRUE)


## -------------------------------------------------------------------------------------------------
distilled <- distill_enrichment(res_enrich_macrophage,
                                res_macrophage_IFNg_vs_naive,
                                anno_df,
                                n_gs = 60,
                                cluster_fun = "cluster_markov")
DT::datatable(distilled$distilled_table[,1:4])
dim(distilled$distilled_table)
DT::datatable(distilled$res_enrich[,])

dg <- distilled$distilled_em 

library("igraph")
library("visNetwork")
library("magrittr")

# defining a color palette for nicer display
colpal <- colorspace::rainbow_hcl(length(unique(V(dg)$color)))[V(dg)$color]
V(dg)$color.background <- scales::alpha(colpal, alpha = 0.8)
V(dg)$color.highlight <- scales::alpha(colpal, alpha = 1)
V(dg)$color.hover <- scales::alpha(colpal, alpha = 0.5)

V(dg)$color.border <- "black"

visNetwork::visIgraph(dg) %>%
  visOptions(highlightNearest = list(enabled = TRUE,
                                     degree = 1,
                                     hover = TRUE),
             nodesIdSelection = TRUE, 
             selectedBy = "membership")

## -------------------------------------------------------------------------------------------------
res_enrich_subset <- res_enrich_macrophage[1:100, ]

fuzzy_subset <- gs_fuzzyclustering(
  res_enrich = res_enrich_subset,
  n_gs = nrow(res_enrich_subset),
  gs_ids = NULL,
  similarity_matrix = NULL,
  similarity_threshold = 0.35,
  fuzzy_seeding_initial_neighbors = 3,
  fuzzy_multilinkage_rule = 0.5)

# show all genesets members of the first cluster
fuzzy_subset[fuzzy_subset$gs_fuzzycluster == "1", ]

# list only the representative clusters
DT::datatable(
  fuzzy_subset[fuzzy_subset$gs_cluster_status == "Representative", ]
)

## ----volcano--------------------------------------------------------------------------------------
gs_volcano(res_enrich_macrophage,
           p_threshold = 0.05,
           color_by = "aggr_score",
           volcano_labels = 10,
           gs_ids = NULL,
           plot_title = "my volcano")
res_enrich_simplified <- gs_simplify(res_enrich_macrophage,
                                     gs_overlap = 0.7)
dim(res_enrich_macrophage)
dim(res_enrich_simplified)
gs_volcano(res_enrich_simplified,
           color_by = "aggr_score")

## ----dendro---------------------------------------------------------------------------------------
gs_dendro(res_enrich_macrophage,
          n_gs = 50,
          gs_dist_type = "kappa", 
          clust_method = "ward.D2",
          color_leaves_by = "z_score",
          size_leaves_by = "gs_pvalue",
          color_branches_by = "clusters",
          create_plot = TRUE)

## ----mds------------------------------------------------------------------------------------------
gs_mds(res_enrich_macrophage,
       res_macrophage_IFNg_vs_naive,
       anno_df,
       n_gs = 200,
       gs_ids = NULL,
       similarity_measure = "kappa_matrix",
       mds_k = 2,
       mds_labels = 5,
       mds_colorby = "z_score",
       gs_labels = NULL,
       plot_title = NULL) 

## ----overview-------------------------------------------------------------------------------------
gs_summary_overview(res_enrich_macrophage,
                    n_gs = 30,
                    p_value_column = "gs_pvalue",
                    color_by = "z_score")

## ----sumheat--------------------------------------------------------------------------------------
gs_summary_heat(res_enrich_macrophage,
                res_macrophage_IFNg_vs_naive,
                anno_df,
                n_gs = 15)

## -------------------------------------------------------------------------------------------------
gs_summary_heat(gtl = gtl,
                n_gs = 10)

## ----scoresheat-----------------------------------------------------------------------------------
vst_macrophage <- vst(dds_macrophage)
scores_mat <- gs_scores(
  se = vst_macrophage,
  res_de = res_macrophage_IFNg_vs_naive,
  res_enrich = res_enrich_macrophage,
  annotation_obj = anno_df
)
gs_scoresheat(scores_mat,
              n_gs = 30)

## ----happyhour, eval=FALSE------------------------------------------------------------------------
# happy_hour(dds = dds_macrophage,
#            res_de = res_de,
#            res_enrich = res_enrich,
#            annotation_obj = anno_df,
#            project_id = "examplerun",
#            mygenesets = res_enrich$gs_id[c(1:5,11,31)],
#            mygenes = c("ENSG00000125347",
#                        "ENSG00000172399",
#                        "ENSG00000137496")
# )

## ----happyhour2, eval=FALSE-----------------------------------------------------------------------
# happy_hour(gtl = gtl,
#            project_id = "examplerun",
#            mygenesets = gtl$res_enrich$gs_id[c(1:5,11,31)],
#            mygenes = c("ENSG00000125347",
#                        "ENSG00000172399",
#                        "ENSG00000137496"),
#            open_after_creating = TRUE
# )

## ----template-------------------------------------------------------------------------------------
template_rmd <- system.file("extdata",
                            "cocktail_recipe.Rmd",
                            package = "GeneTonic")
template_rmd

## ----comparepair----------------------------------------------------------------------------------
# generating some shuffled gene sets
res_enrich2 <- res_enrich_macrophage[1:50, ]
set.seed(42)
shuffled_ones <- sample(seq_len(50)) # to generate permuted p-values
res_enrich2$gs_pvalue <- res_enrich2$gs_pvalue[shuffled_ones]
res_enrich2$z_score <- res_enrich2$z_score[shuffled_ones]
res_enrich2$aggr_score <- res_enrich2$aggr_score[shuffled_ones]

gs_summary_overview_pair(res_enrich = res_enrich_macrophage,
                         res_enrich2 = res_enrich2,
                         n_gs = 25)

## ----compare4-------------------------------------------------------------------------------------
res_enrich2 <- res_enrich_macrophage[1:42, ]
res_enrich3 <- res_enrich_macrophage[1:42, ]
res_enrich4 <- res_enrich_macrophage[1:42, ]

set.seed(2*42)
shuffled_ones_2 <- sample(seq_len(42)) # to generate permuted p-values
res_enrich2$gs_pvalue <- res_enrich2$gs_pvalue[shuffled_ones_2]
res_enrich2$z_score <- res_enrich2$z_score[shuffled_ones_2]
res_enrich2$aggr_score <- res_enrich2$aggr_score[shuffled_ones_2]

set.seed(3*42)
shuffled_ones_3 <- sample(seq_len(42)) # to generate permuted p-values
res_enrich3$gs_pvalue <- res_enrich3$gs_pvalue[shuffled_ones_3]
res_enrich3$z_score <- res_enrich3$z_score[shuffled_ones_3]
res_enrich3$aggr_score <- res_enrich3$aggr_score[shuffled_ones_3]

set.seed(4*42)
shuffled_ones_4 <- sample(seq_len(42)) # to generate permuted p-values
res_enrich4$gs_pvalue <- res_enrich4$gs_pvalue[shuffled_ones_4]
res_enrich4$z_score <- res_enrich4$z_score[shuffled_ones_4]
res_enrich4$aggr_score <- res_enrich4$aggr_score[shuffled_ones_4]

compa_list <- list(
  scenario2 = res_enrich2,
  scenario3 = res_enrich3,
  scenario4 = res_enrich4
)

gs_horizon(res_enrich_macrophage,
           compared_res_enrich_list = compa_list,
           n_gs = 20,
           sort_by = "clustered")

## ----compareradar---------------------------------------------------------------------------------
# with only one set
gs_radar(res_enrich = res_enrich_macrophage)
# with a dataset to compare against
gs_radar(res_enrich = res_enrich_macrophage,
         res_enrich2 = res_enrich2)

## ----misc-----------------------------------------------------------------------------------------
head(mosdef::deresult_to_df(res_macrophage_IFNg_vs_naive))
# to make sure normalized values are available...
dds_macrophage <- estimateSizeFactors(dds_macrophage)   
mosdef::gene_plot(dds_macrophage,
          gene = "ENSG00000125347",
          intgroup = "condition",
          annotation_obj = anno_df,
          plot_type = "auto")
mosdef::gene_plot(dds_macrophage,
          gene = "ENSG00000174944",
          intgroup = "condition",
          assay = "abundance",
          annotation_obj = anno_df,
          plot_type = "auto")

mosdef::geneinfo_to_html("IRF1")

## ----gsheatmap------------------------------------------------------------------------------------
gs_heatmap(se = vst_macrophage,
           res_de = res_macrophage_IFNg_vs_naive,
           res_enrich = res_enrich_macrophage,
           annotation_obj = anno_df,
           geneset_id = "GO:0060337"  ,
           cluster_columns = TRUE,
           anno_col_info = "condition"
)

mosdef::go_to_html("GO:0060337",
                   res_enrich = res_enrich_macrophage)

## ----signaturevolcano-----------------------------------------------------------------------------
signature_volcano(res_de = res_macrophage_IFNg_vs_naive,
                  res_enrich = res_enrich_macrophage,
                  annotation_obj = anno_df,
                  geneset_id = "GO:0060337",
                  FDR = 0.05,
                  color = "#1a81c2"
)

## ----shakers, eval=FALSE--------------------------------------------------------------------------
# res_enrich <- shake_enrichResult(enrichment_results_from_clusterProfiler)
# res_enrich <- shake_topGOtableResult(enrichment_results_from_topGOtable)

## ----checkup--------------------------------------------------------------------------------------
checkup_GeneTonic(dds = dds_macrophage,
                  res_de = res_macrophage_IFNg_vs_naive,
                  res_enrich = res_enrich_macrophage,
                  annotation_obj = anno_df)
# if all is fine, it should return an invisible NULL and a simple message

## ----cite-----------------------------------------------------------------------------------------
citation("GeneTonic")

## ----sessioninfo----------------------------------------------------------------------------------
sessionInfo()

