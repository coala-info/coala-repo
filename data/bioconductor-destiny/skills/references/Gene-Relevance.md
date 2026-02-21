# detecting relevant genes with destiny 3

# Single Cell RNA-Sequencing data and gene relevance

## Libraries

We need of course destiny, scran for preprocessing, and some tidyverse niceties.

```
library(conflicted)
library(destiny)
suppressPackageStartupMessages(library(scran))
library(purrr)
library(ggplot2)
library(SingleCellExperiment)
```

## Data

Let’s use data from the `scRNAseq`[1] package. If necessary, install it via `BiocManager::install('scRNAseq')`.

[1] Risso D, Cole M (2019). [scRNAseq: A Collection of Public Single-Cell RNA-Seq Datasets](https://bioconductor.org/packages/scRNAseq/).

```
# The parts of the help we’re interested in
help('scRNAseq-package', package = 'scRNAseq') %>%
    repr::repr_html() %>%
    stringr::str_extract_all(stringr::regex('<p>The dataset.*?</p>', dotall = TRUE)) %>%
    unlist() %>%
    paste(collapse = '') %>%
    knitr::raw_html()
```

The dataset `fluidigm` contains 65 cells from Pollen et al. (2014), each sequenced at high and low coverage.

The dataset `th2` contains 96 T helper cells from Mahata et al. (2014).

The dataset `allen` contains 379 cells from the mouse visual cortex. This is a subset of the data published in Tasic et al. (2016).

379 cells seems sufficient to see something!

```
allen <- scRNAseq::ReprocessedAllenData()
```

## Preprocessing

We’ll mostly stick to the [scran vignette](https://bioconductor.org/packages/devel/bioc/vignettes/scran/inst/doc/scran.html) here. Let’s add basic information to the data and choose what to work with.

As `scran` expects the raw counts in the `counts` assay, we rename the more accurate RSEM counts to `counts`. Our data has ERCC spike-ins in an `altExp` slot:

```
rowData(allen)$Symbol <- rownames(allen)
rowData(allen)$EntrezID <- AnnotationDbi::mapIds(org.Mm.eg.db::org.Mm.eg.db, rownames(allen), 'ENTREZID', 'ALIAS')
```

```
##
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
rowData(allen)$Uniprot <- AnnotationDbi::mapIds(org.Mm.eg.db::org.Mm.eg.db, rownames(allen), 'UNIPROT', 'ALIAS', multiVals = 'list')
```

```
## 'select()' returned 1:many mapping between keys and columns
```

```
assayNames(allen)[assayNames(allen) == 'rsem_counts'] <- 'counts'
assayNames(altExp(allen, 'ERCC'))[assayNames(altExp(allen, 'ERCC')) == 'rsem_counts'] <- 'counts'
allen
```

```
## class: SingleCellExperiment
## dim: 20816 379
## metadata(2): SuppInfo which_qc
## assays(4): tophat_counts cufflinks_fpkm counts rsem_tpm
## rownames(20816): 0610007P14Rik 0610009B22Rik ... Zzef1 Zzz3
## rowData names(3): Symbol EntrezID Uniprot
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(22): NREADS NALIGNED ... Animal.ID passes_qc_checks_s
## reducedDimNames(0):
## mainExpName: endogenous
## altExpNames(1): ERCC
```

Now we can use it to renormalize the data. We normalize the `counts` using the spike-in size factors and logarithmize them into `logcounts`.

```
allen <- computeSpikeFactors(allen, 'ERCC')
allen <- logNormCounts(allen)
allen
```

```
## class: SingleCellExperiment
## dim: 20816 379
## metadata(2): SuppInfo which_qc
## assays(5): tophat_counts cufflinks_fpkm counts rsem_tpm logcounts
## rownames(20816): 0610007P14Rik 0610009B22Rik ... Zzef1 Zzz3
## rowData names(3): Symbol EntrezID Uniprot
## colnames(379): SRR2140028 SRR2140022 ... SRR2139341 SRR2139336
## colData names(23): NREADS NALIGNED ... passes_qc_checks_s sizeFactor
## reducedDimNames(0):
## mainExpName: endogenous
## altExpNames(1): ERCC
```

We also use the spike-ins to detect highly variable genes more accurately:

```
decomp <- modelGeneVarWithSpikes(allen, 'ERCC')
rowData(allen)$hvg_order <- order(decomp$bio, decreasing = TRUE)
```

We create a subset of the data containing only rasonably highly variable genes:

```
allen_hvg <- subset(allen, hvg_order <= 5000L)
```

Let’s create a Diffusion map. For rapid results, people often create a PCA first, which can be stored in your `SingleCellExperiment` before creating the Diffusion map or simply created implicitly using `DiffusionMap(..., n_pcs = <number>)`.

However, even with many more principal components than necessary to get a nicely resolved Diffusion Map, the close spatial correspondence between diffusion components and genes are lost.

```
#To go from PCA: reducedDim(allen_hvg, 'pca') <- irlba::prcomp_irlba(t(assay(allen, 'logcounts')), 50)$x
```

The chosen distance metric has big implications on your results, you should try at least cosine and rankcor.

```
set.seed(1)
dms <- c('euclidean', 'cosine', 'rankcor') %>% #, 'l2'
    set_names() %>%
    map(~ DiffusionMap(allen_hvg, distance = ., knn_params = list(method = 'covertree')))
```

```
## Warning in DiffusionMap(allen_hvg, distance = ., knn_params = list(method =
## "covertree")): You have 5000 genes. Consider passing e.g. n_pcs = 50 to speed
## up computation.
## Warning in DiffusionMap(allen_hvg, distance = ., knn_params = list(method =
## "covertree")): You have 5000 genes. Consider passing e.g. n_pcs = 50 to speed
## up computation.
## Warning in DiffusionMap(allen_hvg, distance = ., knn_params = list(method =
## "covertree")): You have 5000 genes. Consider passing e.g. n_pcs = 50 to speed
## up computation.
```

```
dms %>%
    imap(function(dm, dist) plot(dm, 1:2, col_by = 'driver_1_s') + ggtitle(dist)) %>%
    cowplot::plot_grid(plotlist = ., nrow = 1)
```

![](data:image/png;base64...)

```
grs <- map(dms, gene_relevance)
```

```
gms <- imap(grs, function(gr, dist) plot(gr, iter_smooth = 0) + ggtitle(dist))
cowplot::plot_grid(plotlist = gms, nrow = 1)
```

![](data:image/png;base64...)

As you can see, despite the quite different embedding, the rankcor and Cosine diffusion Maps display a number of the same driving genes.

```
gms[-1] %>% map(~ .$ids[1:10]) %>% purrr::reduce(base::intersect) %>% cat(sep = ' ')
```

```
options(readr.show_col_types = FALSE)
tryCatch({
    httr::GET('https://rest.uniprot.org/uniprotkb/search', query = list(
        fields = 'accession,gene_names,cc_tissue_specificity',
        format = 'tsv',
        query = rowData(allen)$Uniprot[gms$cosine$ids[1:6]] %>% unlist() %>% paste(collapse = ' OR ')
    )) %>%
        httr::content(type = 'text/tab-separated-values', encoding = 'utf-8')
}, error = function(e) e)
```

```
## # A tibble: 25 × 3
##    Entry  `Gene Names`          `Tissue specificity`
##    <chr>  <chr>                 <chr>
##  1 Q8K2G4 Bbs7 Bbs2l1           <NA>
##  2 P58044 Idi1                  <NA>
##  3 Q922E6 Fastkd2               TISSUE SPECIFICITY: Ubiquitously expressed (Pub…
##  4 P63054 Pcp4 Pep19            <NA>
##  5 Q8VEH8 Erlec1                <NA>
##  6 G3XA48 Idi1                  <NA>
##  7 Q8QZR0 Tram1l1               <NA>
##  8 Q3V165 Bbs7                  <NA>
##  9 Q9CWA6 Erlec1                <NA>
## 10 B1ATV5 Bbs7 CT7-314H19.3-001 <NA>
## # ℹ 15 more rows
```