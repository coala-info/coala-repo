# Code example from 'Gene-Relevance' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(conflicted)
library(destiny)
suppressPackageStartupMessages(library(scran))
library(purrr)
library(ggplot2)
library(SingleCellExperiment)

## -----------------------------------------------------------------------------
# The parts of the help we’re interested in
help('scRNAseq-package', package = 'scRNAseq') %>%
    repr::repr_html() %>%
    stringr::str_extract_all(stringr::regex('<p>The dataset.*?</p>', dotall = TRUE)) %>%
    unlist() %>%
    paste(collapse = '') %>%
    knitr::raw_html()

## -----------------------------------------------------------------------------
allen <- scRNAseq::ReprocessedAllenData()

## -----------------------------------------------------------------------------
rowData(allen)$Symbol <- rownames(allen)
rowData(allen)$EntrezID <- AnnotationDbi::mapIds(org.Mm.eg.db::org.Mm.eg.db, rownames(allen), 'ENTREZID', 'ALIAS')
rowData(allen)$Uniprot <- AnnotationDbi::mapIds(org.Mm.eg.db::org.Mm.eg.db, rownames(allen), 'UNIPROT', 'ALIAS', multiVals = 'list')
assayNames(allen)[assayNames(allen) == 'rsem_counts'] <- 'counts'
assayNames(altExp(allen, 'ERCC'))[assayNames(altExp(allen, 'ERCC')) == 'rsem_counts'] <- 'counts'
allen

## -----------------------------------------------------------------------------
allen <- computeSpikeFactors(allen, 'ERCC')
allen <- logNormCounts(allen)
allen

## -----------------------------------------------------------------------------
decomp <- modelGeneVarWithSpikes(allen, 'ERCC')
rowData(allen)$hvg_order <- order(decomp$bio, decreasing = TRUE)

## -----------------------------------------------------------------------------
allen_hvg <- subset(allen, hvg_order <= 5000L)

## -----------------------------------------------------------------------------
#To go from PCA: reducedDim(allen_hvg, 'pca') <- irlba::prcomp_irlba(t(assay(allen, 'logcounts')), 50)$x

## -----------------------------------------------------------------------------
set.seed(1)
dms <- c('euclidean', 'cosine', 'rankcor') %>% #, 'l2'
    set_names() %>%
    map(~ DiffusionMap(allen_hvg, distance = ., knn_params = list(method = 'covertree')))

## ----fig.asp = 1/4, fig.width = 10--------------------------------------------
dms %>%
    imap(function(dm, dist) plot(dm, 1:2, col_by = 'driver_1_s') + ggtitle(dist)) %>%
    cowplot::plot_grid(plotlist = ., nrow = 1)

## -----------------------------------------------------------------------------
grs <- map(dms, gene_relevance)

## ----fig.asp = 1/4, fig.width = 10--------------------------------------------
gms <- imap(grs, function(gr, dist) plot(gr, iter_smooth = 0) + ggtitle(dist))
cowplot::plot_grid(plotlist = gms, nrow = 1)

## -----------------------------------------------------------------------------
gms[-1] %>% map(~ .$ids[1:10]) %>% purrr::reduce(base::intersect) %>% cat(sep = ' ')

## -----------------------------------------------------------------------------
options(readr.show_col_types = FALSE)
tryCatch({
    httr::GET('https://rest.uniprot.org/uniprotkb/search', query = list(
        fields = 'accession,gene_names,cc_tissue_specificity',
        format = 'tsv',
        query = rowData(allen)$Uniprot[gms$cosine$ids[1:6]] %>% unlist() %>% paste(collapse = ' OR ')
    )) %>%
        httr::content(type = 'text/tab-separated-values', encoding = 'utf-8')
}, error = function(e) e)

