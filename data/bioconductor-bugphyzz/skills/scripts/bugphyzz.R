# Code example from 'bugphyzz' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("bugphyzz")

## ----load package, message=FALSE----------------------------------------------
library(bugphyzz)
library(dplyr)
library(purrr)

## ----import data, message=FALSE-----------------------------------------------
bp <- importBugphyzz()
names(bp)

## ----a glimpse----------------------------------------------------------------
glimpse(bp$aerophilicity, width = 50)

## -----------------------------------------------------------------------------
aer_sigs_g <- makeSignatures(
    dat = bp[["aerophilicity"]], taxIdType = "Taxon_name", taxLevel = "genus"
)
map(aer_sigs_g, head)

## -----------------------------------------------------------------------------
gt_sigs_sp <- makeSignatures(
    dat = bp[["growth temperature"]], taxIdType = "Taxon_name",
    taxLevel = 'species'
)
map(gt_sigs_sp, head)

## -----------------------------------------------------------------------------
gt_sigs_mix <- makeSignatures(
    dat = bp[["growth temperature"]], taxIdType = "Taxon_name",
    taxLevel = "mixed", min = 0, max = 25
)
map(gt_sigs_mix, head)

## -----------------------------------------------------------------------------
ap_sigs_mix <- makeSignatures(
    dat = bp[["animal pathogen"]], taxIdType = "NCBI_ID",
    taxLevel = "mixed", evidence = c("exp", "igc", "nas", "tas")
)
map(ap_sigs_mix, head)

## -----------------------------------------------------------------------------
sigs <- map(bp, makeSignatures) |> 
    list_flatten(name_spec = "{inner}")
length(sigs)

## -----------------------------------------------------------------------------
head(map(sigs, head))

## ----message=FALSE------------------------------------------------------------
library(EnrichmentBrowser)
library(MicrobiomeBenchmarkData)
library(mia)

## ----warning=FALSE------------------------------------------------------------
dat_name <- 'HMP_2012_16S_gingival_V35'
tse <- MicrobiomeBenchmarkData::getBenchmarkData(dat_name, dryrun = FALSE)[[1]]
tse_genus <- mia::splitByRanks(tse)$genus
min_n_samples <- round(ncol(tse_genus) * 0.2)
tse_subset <- tse_genus[rowSums(assay(tse_genus) >= 1) >= min_n_samples,]
tse_subset

## -----------------------------------------------------------------------------
tse_subset$GROUP <- ifelse(
    tse_subset$body_subsite == 'subgingival_plaque', 0, 1
)
se <- EnrichmentBrowser::deAna(
    expr = tse_subset, de.method = 'edgeR', padj.method = 'fdr', 
    filter.by.expr = FALSE, 
)

## -----------------------------------------------------------------------------
assay(se)[1:5, 1:5] # counts

## -----------------------------------------------------------------------------
dat <- data.frame(colData(se))
design <- stats::model.matrix(~ GROUP, data = dat)
assay(se) <- limma::voom(
    counts = assay(se), design = design, plot = FALSE
)$E

## -----------------------------------------------------------------------------
assay(se)[1:5, 1:5] # normalized counts

## ----message=FALSE------------------------------------------------------------
gsea <- EnrichmentBrowser::sbea(
    method = 'gsea', se = se, gs = aer_sigs_g, perm = 1000,
    # Alpha is the FDR threshold (calculated above) to consider a feature as
    # significant.
    alpha = 0.1
)
gsea_tbl <- as.data.frame(gsea$res.tbl) |> 
    mutate(
        GENE.SET = ifelse(PVAL < 0.05, paste0(GENE.SET, ' *'), GENE.SET),
        PVAL = round(PVAL, 3),
    ) |> 
        dplyr::rename(BUG.SET = GENE.SET)
knitr::kable(gsea_tbl)

## ----message=FALSE------------------------------------------------------------
getTaxonSignatures(tax = "Escherichia coli", bp = bp)

## -----------------------------------------------------------------------------
getTaxonSignatures(tax = "562", bp = bp)

## -----------------------------------------------------------------------------
sessioninfo::session_info()

