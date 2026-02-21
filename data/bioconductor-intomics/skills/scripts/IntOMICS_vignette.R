# Code example from 'IntOMICS_vignette' vignette. See references/ for full tutorial.

## ----include = TRUE, echo = TRUE, eval=FALSE----------------------------------
#  
#  # bioconductor install
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("IntOMICS")
#  
#  # install the newest (development) version from GitHub
#  # install.packages("remotes")
#  remotes::install_github("anna-pacinkova/IntOMICS")
#  

## ----include = TRUE, echo = TRUE----------------------------------------------

library(IntOMICS)

# load required libraries
suppressPackageStartupMessages({
library(curatedTCGAData)
library(TCGAutils)
library(bnlearn)
library(bnstruct)
library(matrixStats)
library(parallel)
library(RColorBrewer)
library(bestNormalize)
library(igraph)
library(gplots)
library(methods)
library(ggraph)
library(ggplot2)})


## ----echo=TRUE, include=TRUE, message = FALSE---------------------------------

coad_SE <- curatedTCGAData("COAD",
                           c("RNASeq2GeneNorm_illuminahiseq",
                             "Methylation_methyl450","GISTIC_AllByGene"), 
                           version = "2.0.1", dry.run = FALSE)
coad_SE <- TCGAprimaryTumors(coad_SE)
 
## keep NA for Methylation data
coad_ma <- subsetByColData(coad_SE, coad_SE$MSI_status == "MSI-H" | 
                             is.na(coad_SE$MSI_status))
# choose random 50 samples for illustration
random_samples <- sample(names(which(table(sampleMap(coad_ma)$primary)==3)),50)
coad_ma <- subsetByColData(coad_ma, random_samples)

rownames(coad_ma[["COAD_GISTIC_AllByGene-20160128"]]) <- rowData(coad_ma[["COAD_GISTIC_AllByGene-20160128"]])[["Gene.Symbol"]]
 
data(list=c("gene_annot","annot"))
rowselect <- list(gene_annot$gene_symbol, gene_annot$gene_symbol, 
                  unlist(annot))
names(rowselect) <- names(coad_ma)
omics <- coad_ma[rowselect, , ]
names(omics) <- c("cnv","ge","meth")


## ----echo=TRUE, include=TRUE--------------------------------------------------

t(assay(omics[["ge"]]))[1:5,1:5]


## ----echo=TRUE, include=TRUE--------------------------------------------------

t(assay(omics[["cnv"]]))[1:5,1:5]


## ----echo=TRUE, include=TRUE--------------------------------------------------

t(assay(omics[["meth"]]))[1:5,1:5]


## ----echo=TRUE, include=TRUE--------------------------------------------------

str(annot)


## ----echo=TRUE, include=TRUE--------------------------------------------------

gene_annot


## ----echo=TRUE, include=TRUE--------------------------------------------------

data("PK")
PK


## ----echo=TRUE, include=TRUE--------------------------------------------------

data("TFtarg_mat")
TFtarg_mat[1:5,1:5]


## ----echo=TRUE, include=TRUE--------------------------------------------------

data("layers_def")
layers_def


## ----echo=TRUE, include=TRUE--------------------------------------------------

OMICS_mod_res <- omics_module(omics = omics, 
                              PK = PK, 
                              layers_def = layers_def, 
                              TFtargs = TFtarg_mat,
                              annot = annot, 
                              gene_annot = gene_annot,
                              lm_METH = TRUE,
                              r_squared_thres = 0.3,
                              p_val_thres = 0.1)


## ----echo=TRUE, include=TRUE--------------------------------------------------

names(OMICS_mod_res)


## ----echo=TRUE, include=TRUE--------------------------------------------------

if(interactive())
{
  BN_mod_res_sparse <- bn_module(burn_in = 500, 
                               thin = 50, 
                               OMICS_mod_res = OMICS_mod_res,
                               minseglen = 5)
}


## ----echo=TRUE, include=TRUE--------------------------------------------------

data("BN_mod_res")
getSlots(class(BN_mod_res))


## ----echo=TRUE, include=TRUE--------------------------------------------------

trace_plots(mcmc_res = BN_mod_res,
            burn_in = 10000,
            thin = 500, 
            edge_freq_thres = 0.5)


## ----echo=TRUE, include=TRUE--------------------------------------------------

res_weighted <- edge_weights(mcmc_res = BN_mod_res, 
                            burn_in = 10000, 
                            thin = 500, 
                            edge_freq_thres = 0.5)

weighted_net_res <- weighted_net(cpdag_weights = res_weighted,
                                 gene_annot = gene_annot, 
                                 PK = PK, 
                                 OMICS_mod_res = OMICS_mod_res, 
                                 gene_ID = "gene_symbol", 
                                 TFtargs = TFtarg_mat, 
                                 B_prior_mat_weighted = B_prior_mat_weighted(BN_mod_res))


## ----fig_weights, fig.height = 7, fig.width = 7-------------------------------

ggraph_weighted_net(net = weighted_net_res, 
                    node_size = 10, 
                    node_label_size = 4, 
                    edge_label_size = 4)


## ----echo=TRUE, include=TRUE--------------------------------------------------

weighted_net_res <- weighted_net(cpdag_weights = res_weighted,
                                 gene_annot = gene_annot, 
                                 PK = PK, 
                                 OMICS_mod_res = OMICS_mod_res, 
                                 gene_ID = "gene_symbol", 
                                 edge_weights = "empB",
                                 TFtargs = TFtarg_mat, 
                                 B_prior_mat_weighted = B_prior_mat_weighted(BN_mod_res))


## ----fig_empB, fig.height = 7, fig.width = 7----------------------------------

ggraph_weighted_net(net = weighted_net_res)


## ----fig_heat, fig.height = 7, fig.width = 7----------------------------------

emp_b_heatmap(mcmc_res = BN_mod_res, 
             OMICS_mod_res = OMICS_mod_res, 
             gene_annot = gene_annot, 
             TFtargs = TFtarg_mat)


## ----fig_ew, fig.height = 4.5, fig.width = 5----------------------------------

res_weighted <- edge_weights(mcmc_res = BN_mod_res, 
                            burn_in = 10000, 
                            thin = 500,
                            edge_freq_thres = NULL)
                            
weighted_net_res <- weighted_net(cpdag_weights = res_weighted,
                                 gene_annot = gene_annot, 
                                 PK = PK, 
                                 OMICS_mod_res = OMICS_mod_res, 
                                 gene_ID = "gene_symbol", 
                                 TFtargs = TFtarg_mat, 
                                 B_prior_mat_weighted = B_prior_mat_weighted(BN_mod_res))

dens_edge_weights(weighted_net_res)


## ----echo=TRUE, include=TRUE--------------------------------------------------

sessionInfo()


