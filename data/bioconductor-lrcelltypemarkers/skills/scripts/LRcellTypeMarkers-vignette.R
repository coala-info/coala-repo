# Code example from 'LRcellTypeMarkers-vignette' vignette. See references/ for full tutorial.

## ----intro--------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
eh <- query(eh, "LRcellTypeMarkers")
eh ## show entries of LRcellTypeMarkers package

## ----extract_data-------------------------------------------------------------
mouse_FC <- eh[['EH4548']]
mouse_FC[1:6, 1:6]  # show head of the data

## ----sort---------------------------------------------------------------------
library(LRcell)
FC_marker_genes <- get_markergenes(mouse_FC, method="LR", topn=100)
head(lapply(FC_marker_genes, head))  # glance at the marker genes

## ----load_example-------------------------------------------------------------
library(LRcell)
data("example_gene_pvals")
head(example_gene_pvals, n=5)

## ----run_LRcell---------------------------------------------------------------
res <- LRcellCore(gene.p = example_gene_pvals,
           marker.g = FC_marker_genes,
           method = "LR", min.size = 5, 
           sig.cutoff = 0.05)
## curate cell types
res$cell_type <- unlist(lapply(strsplit(res$ID, '\\.'), '[', 2))
head(subset(res, select=-lead_genes))

## ----plot_LRcellCore, fig.width=10, fig.height=6, dpi=120---------------------
plot_manhattan_enrich(res, sig.cutoff = .05, label.topn = 5)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

