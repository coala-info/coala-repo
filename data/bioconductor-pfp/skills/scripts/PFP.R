# Code example from 'PFP' vignette. See references/ for full tutorial.

## ---- include=FALSE-----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center", 
  fig.show = "asis",
  eval = TRUE,
  tidy.opts = list(blank = FALSE, width.cutoff = 60),
  tidy = TRUE,
  message = FALSE,
  warning = FALSE
)

## ----install-pkg-bioconductor, eval=FALSE-------------------------------------
#  ## install PFP from github, require biocondutor dependencies package pre-installed
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#  BiocManager::install("PFP")

## ----install-pkg-github, eval=FALSE-------------------------------------------
#  ## install PFP from github, require biocondutor dependencies package pre-installed
#  if (!require(devtools))
#    install.packages("devtools")
#  devtools::install_github("aib-group/PFP")

## ----install-database-bioconductor, eval=FALSE--------------------------------
#  ## install PFP from github, require biocondutor dependencies package pre-installed
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#  BiocManager::install("org.Hs.eg.db")

## ----load-pkg,eval=TRUE, include=TRUE-----------------------------------------
library(PFP)

## ----a general-pipline,eval=TRUE, include=TRUE--------------------------------
#load the data -- gene list of human; the PFPRefnet object of human; the PFP 
#object to test; the list of different genes.
data("gene_list_hsa")
data("PFPRefnet_hsa")
data("PFP_test1")
data("data_std")
# Step1: calculate the similarity score of network.
PFP_test <- calc_PFP_score(genes = gene_list_hsa,PFPRefnet = PFPRefnet_hsa)
# Step2: rank the pathway by the PFP score.
rank1 <- rank_PFP(object = PFP_test,total_rank = TRUE,thresh_value=0.5)

## ----a the_target_gene,eval=TRUE, include=TRUE--------------------------------
# Step1: select the max score of pathway.
pathway_select <- refnet_info(rank1)[1,"id"]
gene_test <- pathways_score(rank1)$genes_score[[pathway_select]]$ENTREZID
# Step2: get the correlation coefficient score of the edge.
edges_coexp <- get_exp_cor_edges(gene_test,data_std)
# Step3: Find the difference genes that are of focus.
gene_list2 <- unique(c(edges_coexp$source,edges_coexp$target))
# Step4: Find the edge to focus on.
edges_kegg <- get_bg_related_kegg(gene_list2,PFPRefnet=PFPRefnet_hsa,
                                  rm_duplicated = TRUE)
# Step5: Find the associated network
require(org.Hs.eg.db)
net_test <- get_asso_net(edges_coexp = edges_coexp,
                         edges_kegg = edges_kegg,
                         if_symbol = TRUE,
                         gene_info_db = org.Hs.eg.db)

## ----a PFP example, fig.height=6, fig.width=7.2, warning=FALSE----------------
plot_PFP(PFP_test)

## ----a rank PFP, fig.height=6, fig.width=7.2, warning=FALSE-------------------
plot_PFP(rank1)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

