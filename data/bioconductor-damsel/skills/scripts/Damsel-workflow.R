# Code example from 'Damsel-workflow' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.height = 7,
    fig.width = 12
)

## ----setup, include=FALSE-----------------------------------------------------
library(Damsel)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("Damsel")
# library(Damsel)

## -----------------------------------------------------------------------------
library(BSgenome.Dmelanogaster.UCSC.dm6)
regions_and_sites <- getGatcRegions(BSgenome.Dmelanogaster.UCSC.dm6)
regions <- regions_and_sites$regions
knitr::kable(head(regions))
knitr::kable(head(regions_and_sites$sites))

## ----eval=FALSE---------------------------------------------------------------
# path_to_bams <- system.file("extdata", package = "Damsel")
# counts.df <- countBamInGATC(path_to_bams,
#     regions = regions
# )

## ----include=FALSE------------------------------------------------------------
data_env <- new.env(parent = emptyenv())
data("dros_counts", envir = data_env, package = "Damsel")
counts.df <- data_env[["dros_counts"]]

## -----------------------------------------------------------------------------
knitr::kable(head(counts.df))

## ----eval=FALSE---------------------------------------------------------------
# data("dros_counts")

## ----heatmap------------------------------------------------------------------
plotCorrHeatmap(df = counts.df, method = "spearman")

## -----------------------------------------------------------------------------
plotCountsDistribution(counts.df, constant = 1)

## ----coverage3, fig.wide=TRUE-------------------------------------------------
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000,
    layout = "spread"
)

## -----------------------------------------------------------------------------
dge <- makeDGE(counts.df)
head(dge)

## ----mds, fig.height=6, fig.width=6-------------------------------------------
group <- dge$samples$group %>% as.character()
limma::plotMDS(dge, col = as.numeric(factor(group)))

## -----------------------------------------------------------------------------
dm_results <- testDmRegions(dge, p.value = 0.05, lfc = 1, regions = regions, plot = TRUE)
dm_results %>%
    dplyr::group_by(meth_status) %>%
    dplyr::summarise(n = dplyr::n())

knitr::kable(head(dm_results), digits = 32)

## ----fig.wide=TRUE------------------------------------------------------------
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000,
    log2_scale = FALSE
) +
    geom_dm(dm_results.df = dm_results)

## -----------------------------------------------------------------------------
gatc_sites <- regions_and_sites$sites

knitr::kable(head(gatc_sites))

## ----fig.wide=TRUE------------------------------------------------------------
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000,
    log2_scale = FALSE
) +
    geom_dm(dm_results) +
    geom_gatc(gatc_sites)

## -----------------------------------------------------------------------------
peaks <- identifyPeaks(dm_results)
nrow(peaks)

knitr::kable(head(peaks), digits = 32)

## ----fig.wide=TRUE------------------------------------------------------------
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000
) +
    geom_dm(dm_results) +
    geom_peak(peaks, peak.label = TRUE) +
    geom_gatc(gatc_sites)

## -----------------------------------------------------------------------------
plotCountsInPeaks(counts.df, dm_results, peaks, position = "stack")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("TxDb.Dmelanogaster.UCSC.dm6.ensGene")
# BiocManager::install("org.Dm.eg.db")

## -----------------------------------------------------------------------------
library("TxDb.Dmelanogaster.UCSC.dm6.ensGene")
txdb <- TxDb.Dmelanogaster.UCSC.dm6.ensGene::TxDb.Dmelanogaster.UCSC.dm6.ensGene
library("org.Dm.eg.db")
genes <- collateGenes(genes = txdb, regions = regions, org.Db = org.Dm.eg.db)
knitr::kable(head(genes))

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("biomaRt")

## -----------------------------------------------------------------------------
library(biomaRt)
collateGenes(genes = "dmelanogaster_gene_ensembl", regions = regions, version = 109)

## -----------------------------------------------------------------------------
annotation <- annotatePeaksGenes(peaks, genes, regions = regions, max_distance = 5000)

knitr::kable(head(annotation$closest), digits = 32)
knitr::kable(head(annotation$top_five), digits = 32)
knitr::kable(str(annotation$all), digits = 32)

## ----fig.wide=TRUE------------------------------------------------------------
plotCounts(counts.df,
    seqnames = "chr2L",
    start_region = 1,
    end_region = 40000
) +
    geom_dm(dm_results) +
    geom_peak(peaks) +
    geom_gatc(gatc_sites) +
    geom_genes_tx(genes, txdb)

## ----fig.wide=TRUE------------------------------------------------------------
plotWrap(
    id = peaks[1, ]$peak_id,
    counts.df = counts.df,
    dm_results.df = dm_results,
    peaks.df = peaks,
    gatc_sites.df = gatc_sites,
    genes.df = genes, txdb = txdb
)

## ----fig.wide=TRUE------------------------------------------------------------
plotWrap(
    id = genes[1, ]$ensembl_gene_id,
    counts.df = counts.df,
    dm_results.df = dm_results,
    peaks.df = peaks,
    gatc_sites.df = gatc_sites,
    genes.df = genes, txdb = txdb
)

## -----------------------------------------------------------------------------
ontology <- testGeneOntology(annotation$all, genes, regions = regions, extend_by = 2000)

## -----------------------------------------------------------------------------
knitr::kable(head(ontology$signif_results), digits = 32)
knitr::kable(head(ontology$prob_weights), digits = 32)

## ----fig.height=9, fig.width=10-----------------------------------------------
plotGeneOntology(ontology$signif_results)

## -----------------------------------------------------------------------------
sessionInfo()

