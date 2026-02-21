# Code example from 'wppi_workflow' vignette. See references/ for full tutorial.

## ----suppress-progressbars, echo=FALSE----------------------------------------
options(progress_enabled = FALSE, width = 80)

## ----workflow, results='hide'-------------------------------------------------
library(wppi)
# example gene set
genes_interest <- c(
    'ERCC8', 'AKT3', 'NOL3', 'TTK',
    'GFI1B', 'CDC25A', 'TPX2', 'SHE'
)
scores <- score_candidate_genes_from_PPI(genes_interest)
scores
# # A tibble: 295 x 3
#    score gene_symbol uniprot
#    <dbl> <chr>       <chr>
#  1 0.247 KNL1        Q8NG31
#  2 0.247 HTRA2       O43464
#  3 0.247 KAT6A       Q92794
#  4 0.247 BABAM1      Q9NWV8
#  5 0.247 SKI         P12755
#  6 0.247 FOXA2       Q9Y261
#  7 0.247 CLK2        P49760
#  8 0.247 HNRNPA1     P09651
#  9 0.247 HK1         P19367
# 10 0.180 SH3RF1      Q7Z6J0
# # . with 285 more rows

## ----database-knowledge-omnipath----------------------------------------------
omnipath_data <- wppi_omnipath_data(datasets = 'omnipath')

## ----database-knowledge, results='hide'---------------------------------------
db <- wppi_data(datasets = c('omnipath', 'kinaseextra'))
names(db)
# [1] "hpo"      "go"       "omnipath" "uniprot"

## ----database-knowledge-hpo---------------------------------------------------
# example HPO annotations set
HPO_data <- wppi_hpo_data()
HPO_interest <- unique(dplyr::filter(HPO_data, grepl('Diabetes', Name))$Name)

## ----omnipath-graph-----------------------------------------------------------
graph_op <- graph_from_op(db$omnipath)

## ----neighborhood-subnetwork, results='hide'----------------------------------
graph_op_1 <- subgraph_op(graph_op, genes_interest)
igraph::vcount(graph_op_1)
# [1] 256

## ----weighted-adjacency-matrix------------------------------------------------
w_adj <- weighted_adj(graph_op_1, db$go, db$hpo)

## ----random-walk--------------------------------------------------------------
w_rw <- random_walk(w_adj)

## ----scoring-proteins---------------------------------------------------------
scores <- prioritization_genes(graph_op_1, w_rw, genes_interest)
scores
# # A tibble: 249 x 3
#    score gene_symbol uniprot
#    <dbl> <chr>       <chr>
#  1 0.251 HTRA2       O43464 
#  2 0.251 KAT6A       Q92794 
#  3 0.251 BABAM1      Q9NWV8 
#  4 0.251 SKI         P12755 
#  5 0.251 CLK2        P49760 
#  6 0.248 TUBB        P07437 
#  7 0.248 KNL1        Q8NG31 
#  8 0.189 SH3RF1      Q7Z6J0 
#  9 0.189 SRPK2       P78362 
# 10 0.150 CSNK1D      P48730 
# # . with 239 more rows

## ----fig_knitr,echo=TRUE,eval = FALSE-----------------------------------------
# library(knitr)
# knitr::include_graphics("../figures/fig1.png")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

