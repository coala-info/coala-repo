# Code example from 'LRcell-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install------------------------------------------------------------------
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager") ## this will install the BiocManager package
BiocManager::install("LRcell")

## ----setup--------------------------------------------------------------------
library(LRcell)

## -----------------------------------------------------------------------------
## for installing ExperimentHub
# BiocManager::install("ExperimentHub")

## query data
library(ExperimentHub)
eh <- ExperimentHub::ExperimentHub()
eh <- AnnotationHub::query(eh, "LRcellTypeMarkers")  ## query for LRcellTypeMarkers package
eh  ## this will list out EH number to access the calculated gene enrichment scores

## get mouse brain Frontal Cortex enriched genes
enriched.g <- eh[["EH4548"]]
marker.g <- get_markergenes(enriched.g, method="LR", topn=100)

## ----eval=FALSE---------------------------------------------------------------
# enriched.g <- LRcell_gene_enriched_scores(expr, annot, power=1, parallel=TRUE, n.cores=4)

## ----example------------------------------------------------------------------
# load example bulk data
data("example_gene_pvals")
head(example_gene_pvals, n=5)

## ----LRcell-------------------------------------------------------------------
res <- LRcell(gene.p = example_gene_pvals,
              marker.g = NULL,
              species = "mouse",
              region = "FC",
              method = "LiR")
FC_res <- res$FC
# exclude leading genes for a better view
sub_FC_res <- subset(FC_res, select=-lead_genes)
head(sub_FC_res)

## ----plot_LRcell, fig.width=8, fig.height=6, dpi=120--------------------------
plot_manhattan_enrich(FC_res, sig.cutoff = .05, label.topn = 5)

## ----download_marker----------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub::ExperimentHub()  ## use ExperimentHub to download data
eh <- query(eh, "LRcellTypeMarkers")
enriched_genes <- eh[["EH4548"]]  # use title ID which indicates FC region
# get marker genes for LRcell in logistic regression
FC_marker_genes <- get_markergenes(enriched_genes, method="LR", topn=100)

# to have a glance of the marker gene list
head(lapply(FC_marker_genes, head))

## ----LRcellCore---------------------------------------------------------------
res <- LRcellCore(gene.p = example_gene_pvals,
           marker.g = FC_marker_genes,
           method = "LR", min.size = 5, 
           sig.cutoff = 0.05)
## curate cell types
res$cell_type <- unlist(lapply(strsplit(res$ID, '\\.'), '[', 2))
head(subset(res, select=-lead_genes))

## ----plot_LRcellCore, fig.width=10, fig.height=6, dpi=120---------------------
plot_manhattan_enrich(res, sig.cutoff = .05, label.topn = 5)

## ----echo=FALSE---------------------------------------------------------------
# generate a simulated gene*cell read counts matrix
n.row <- 3; n.col <- 10
sim.expr <- matrix(0, nrow=n.row, ncol=n.col)
rownames(sim.expr) <- paste0("gene", 1:n.row)
colnames(sim.expr) <- paste0("cell", 1:n.col)

# generate a simulated annotation for cells
sim.annot <- c(rep("celltype1", 3), rep("celltype2", 3), rep("celltype3", 4))
names(sim.annot) <- colnames(sim.expr)

sim.expr['gene1', ] <- c(3, 0, 2, 8, 10, 6, 1, 0, 0, 2) # marker gene for celltype2
sim.expr['gene2', ] <- c(7, 5, 8, 1, 0, 5, 2, 3, 2, 1) # marker gene for celltype1
sim.expr['gene3', ] <- c(8, 10, 6, 7, 8, 9, 5, 8, 6, 8) # house keeping

## ----example_expr-------------------------------------------------------------
# print out the generated expression matrix
print(sim.expr)

# print out the cell-type annotation
print(sim.annot)

## ----marker_gene_selection----------------------------------------------------
# generating the enrichment score 
enriched_res <- LRcell_gene_enriched_scores(expr = sim.expr,
                            annot = sim.annot, parallel = FALSE)
enriched_res

## -----------------------------------------------------------------------------
marker_res <- get_markergenes(enriched.g = enriched_res,
                method = "LR", topn=1)
marker_res

## ----session_info-------------------------------------------------------------
sessionInfo()

