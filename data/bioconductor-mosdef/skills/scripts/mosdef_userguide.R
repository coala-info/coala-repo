# Code example from 'mosdef_userguide' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.height = 6,
  fig.width = 8
)

## ----install, eval = FALSE----------------------------------------------------
# if (!require("BiocManager")) {
#   install.packages("BiocManager")
# }
# BiocManager::install("mosdef")

## ----installgh, eval = FALSE--------------------------------------------------
# BiocManager::install("imbeimainz/mosdef")

## ----loadlib, eval = TRUE, message=FALSE--------------------------------------
library("mosdef")

## ----loaddata, warning=FALSE--------------------------------------------------
suppressPackageStartupMessages({
  library("macrophage")
  library("DESeq2")
  library("org.Hs.eg.db")
})
data(gse, package = "macrophage")
dds_macrophage <- DESeqDataSet(gse, design = ~ line + condition)
rownames(dds_macrophage) <- substr(rownames(dds_macrophage), 1, 15)

## ----processdata--------------------------------------------------------------
keep <- rowSums(counts(dds_macrophage) >= 10) >= 6
dds_macrophage <- dds_macrophage[keep, ]

dds_macrophage <- DESeq(dds_macrophage)
res_macrophage_IFNg_vs_naive <- results(dds_macrophage,
                                        contrast = c("condition", "IFNg", "naive"),
                                        lfcThreshold = 1, 
                                        alpha = 0.05)

## ----orgdbs-------------------------------------------------------------------
library("AnnotationDbi")
library("org.Hs.eg.db")

## ----addsymbols---------------------------------------------------------------
res_macrophage_IFNg_vs_naive$symbol <- 
  AnnotationDbi::mapIds(org.Hs.eg.db,
                        keys = row.names(res_macrophage_IFNg_vs_naive),
                        column = "SYMBOL",
                        keytype = "ENSEMBL",
                        multiVals = "first"
)

## ----checkfunctions-----------------------------------------------------------
mosdef_de_container_check(dds_macrophage)
mosdef_res_check(res_macrophage_IFNg_vs_naive)

## ----runtopgo-----------------------------------------------------------------
library("topGO")
res_enrich_macrophage_topGO <- run_topGO(
  de_container = dds_macrophage,
  res_de = res_macrophage_IFNg_vs_naive,
  ontology = "BP",
  mapping = "org.Hs.eg.db",
  FDR_threshold = 0.05,
  gene_id = "symbol",
  de_type = "up_and_down",
  add_gene_to_terms = TRUE,
  topGO_method2 = "elim",
  min_counts = 20,
  top_de = 700,
  verbose = TRUE
)

## ----resultstopgo-------------------------------------------------------------
head(res_enrich_macrophage_topGO)

## ----rungoseq, eval = TRUE----------------------------------------------------
goseq_macrophage <- run_goseq(
  de_container = dds_macrophage,
  res_de = res_macrophage_IFNg_vs_naive,
  mapping = "org.Hs.eg.db",
  testCats = "GO:BP" # which categories to test of ("GO:BP, "GO:MF", "GO:CC")
)
head(goseq_macrophage)

## ----runclupro, eval = FALSE--------------------------------------------------
# clupro_macrophage <- run_cluPro(
#   de_container = dds_macrophage,
#   res_de = res_macrophage_IFNg_vs_naive,
#   mapping = "org.Hs.eg.db",
#   keyType = "SYMBOL",
#   ont = "BP"
# )
# head(clupro_macrophage)

## ----resultsclupro------------------------------------------------------------
data(res_enrich_macrophage_cluPro, package = "mosdef")

## ----cluproview---------------------------------------------------------------
head(res_enrich_macrophage_cluPro)

## ----topgoalt-----------------------------------------------------------------
res_subset <- deresult_to_df(res_macrophage_IFNg_vs_naive)[1:100, ] 
myde <- res_subset$id
myassayed <- rownames(res_macrophage_IFNg_vs_naive)
## Here keys are Ensembl not symbols
res_enrich_macrophage_topGO_vec <- run_topGO(
  de_genes = myde,
  bg_genes = myassayed,
  mapping = "org.Hs.eg.db",
  gene_id = "ensembl"
)
head(res_enrich_macrophage_topGO_vec)

## ----geneplot-----------------------------------------------------------------
gene_plot(
  de_container = dds_macrophage,
  gene = "ENSG00000125347",
  intgroup = "condition"
)

## ----volcanoplot--------------------------------------------------------------
volcPlot <- de_volcano(
  res_de = res_macrophage_IFNg_vs_naive,
  mapping = "org.Hs.eg.db",
  logfc_cutoff = 1,
  FDR = 0.05, 
  labeled_genes = 25
)
volcPlot

## ----volcanocustom------------------------------------------------------------
library("ggplot2")

volcPlot +
  ggtitle("macrophage Volcano") +
  ylab("-log10 PValue") +
  xlab("Log 2 FoldChange (Cutoff 1/-1)")

## ----volcanogo----------------------------------------------------------------
Volc_GO <- go_volcano(
  res_de = res_macrophage_IFNg_vs_naive,
  res_enrich = res_enrich_macrophage_topGO,
  term_index = 1,
  logfc_cutoff = 1,
  FDR = 0.05,
  mapping = "org.Hs.eg.db",
  n_overlaps = 50,
  col_to_use = "symbol",
  enrich_col = "genes",
  down_col = "black",
  up_col = "black",
  highlight_col = "tomato"
)

Volc_GO

## ----maplot-------------------------------------------------------------------
maplot <- plot_ma(
  res_de = res_macrophage_IFNg_vs_naive,
  FDR = 0.05,
  hlines = 1
)
# For further parameters please check the function documentation
maplot

## ----maplotannotated----------------------------------------------------------
maplot_genes <- plot_ma(
  res_de = res_macrophage_IFNg_vs_naive,
  FDR = 0.1,
  add_rug = FALSE,
  intgenes = c(
    "SLC7A2",
    "CFLAR",
    "PDK4",
    "IFNGR1"
  ), # suggested genes of interest
  hlines = 1,
  intgenes_color = "darkblue"
)
maplot_genes

## ----runbuttonifier-----------------------------------------------------------
# creating a smaller subset for visualization purposes and to keep the main res_de
res_subset <- deresult_to_df(res_macrophage_IFNg_vs_naive, FDR = 0.05)[1:100, ]

buttonifier(
  df = res_subset,
  col_to_use = "symbol",
  create_buttons_to = c("GC", "NCBI", "GTEX", "UNIPROT", "dbPTM", "HPA", "PUBMED"),
  ens_col = "id",
  ens_species = "Homo_sapiens"
)

## ----dtcustomized-------------------------------------------------------------
res_subset <- deresult_to_df(res_macrophage_IFNg_vs_naive, FDR = 0.05)[1:100, ]

res_subset <- buttonifier(res_subset,
  col_to_use = "symbol",
  create_buttons_to = c("GC", "NCBI", "HPA"),
  output_format = "DF"
)

DT::datatable(res_subset,
  escape = FALSE,
  rownames = FALSE,
  # other parameters specifically controlling the look of the DT...
  options = list(
    scrollX = TRUE
  )
)

## ----tablepainter-------------------------------------------------------------
de_table_painter(res_subset,
                 rounding_digits = 3,
                 signif_digits = 5)

## This also works directly on the DESeqResults objects:
de_table_painter(res_macrophage_IFNg_vs_naive[1:50, ],
                 rounding_digits = 3,
                 signif_digits = 5)



## ----createlinks--------------------------------------------------------------
res_subset <- deresult_to_df(res_macrophage_IFNg_vs_naive, FDR = 0.05)[1:100, ]

row.names(res_subset) <- create_link_ENSEMBL(row.names(res_subset), species = "Homo_sapiens")
res_subset$symbol_GC <-  create_link_GeneCards(res_subset$symbol)
res_subset$symbol_PubMed <- create_link_PubMed(res_subset$symbol)
res_subset$symbol_NCBI <- create_link_NCBI(res_subset$symbol)
res_subset$symbol_dbPTM <- create_link_dbPTM(res_subset$symbol)
res_subset$symbol_GTEX <- create_link_GTEX(res_subset$symbol)
res_subset$symbol_UniProt <- create_link_UniProt(res_subset$symbol)
res_subset$symbol_HPA <- create_link_HPA(res_subset$symbol)

DT::datatable(res_subset, escape = FALSE,
              options = list(
                scrollX = TRUE
              )
)

## ----geneinfo-----------------------------------------------------------------
geneinfo_to_html("IRF1",
  res_de = res_macrophage_IFNg_vs_naive,
  col_to_use = "symbol"
)

## ----geneinfocompact----------------------------------------------------------
geneinfo_to_html("ACTB")

## ----golink-------------------------------------------------------------------
res_enrich_macrophage_topGO$GO.ID <- create_link_GO(res_enrich_macrophage_topGO$GO.ID)

DT::datatable(res_enrich_macrophage_topGO[1:100, ], 
              escape = FALSE,
              options = list(
                scrollX = TRUE
              )
)

## ----goinfo-------------------------------------------------------------------
go_to_html("GO:0001525")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

