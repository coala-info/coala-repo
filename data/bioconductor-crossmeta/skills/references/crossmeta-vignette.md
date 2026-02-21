# Cross-Platform Meta Analysis

#### *Alex Pickering*

#### *2018-10-30*

`crossmeta` streamlines the cross-platform effect size and pathway meta-analysis of microarray data. For the analysis, you will need a list of Affymetrix, Illumina, and/or Agilent GSE numbers from [GEO](http://www.ncbi.nlm.nih.gov/geo/). All 21 species in the current [homologene](http://1.usa.gov/1TGoIy7) build are supported.

---

### Obtaining Raw Data

Search [GEO](http://www.ncbi.nlm.nih.gov/geo/) to find relevant microarray data for the meta-analysis. For this example, I searched for the PI3K inhibitor LY-294002. The search was filtered as follows:

* **Entry type**: Series
* **Organism**: Homo sapiens and Mus musculus
* **Study type**: Expression profiling by array

This search produced 35 hits from which five were chosen. In practice, it is best to select all GSEs matching the necessary criteria (supplementary raw data files available, multiple samples for each treatment, and from either Affymetrix, Illumina, or Agilent single channel arrays).

After identifying GSEs for the meta-analysis, download and decompress the raw data as follows. For raw Illumina data only, you may need to check that it has the correct format (and edit it if needed).

```
library(crossmeta)

# specify where data will be downloaded
data_dir <- file.path(getwd(), "data", "LY")

# gather all GSEs
gse_names  <- c("GSE9601", "GSE15069", "GSE50841", "GSE34817", "GSE29689")

# gather Illumina GSEs (see 'Checking Raw Illumina Data')
illum_names <- c("GSE50841", "GSE34817", "GSE29689")

# download raw data
# get_raw(gse_names, data_dir)
```

---

### Checking Raw Illumina Data

It is difficult to automate loading raw Illumina data files because they lack a standardized format. `crossmeta` will attempt to fix the headers of raw Illumina data files so that they can be loaded. If `crossmeta` fails, you will have to edit the headers of the raw Illumina data files yourself or omit the offending studies.

To edit raw Illumina data headers, I recommend that you download and set Sublime Text 2 as your default text editor. It has very nice regular expression capabilities. [Here](https://www.cheatography.com/davechild/cheat-sheets/regular-expressions/) is a good regular expression cheat-sheat.

Raw illumina files will be in `data_dir` in a seperate folder for each GSE. They are usually *.txt* files and include *non-normalized* in their name. Ensure the following:

* **Detection p-values**: present (usually every second column)
* **File format**: tab seperated *.txt* file
* **File name**: includes *non-normalized*

Also ensure that column names have the following format:

* **Probe ID**: *ID\_REF*
* **Expression values**: *AVG\_Signal-sample\_name*
* **Detection p-values**: *Detection-sample\_name*

To open these files one at a time with your default text editor:

```
# this is why we gathered Illumina GSEs
open_raw_illum(illum_names, data_dir)
```

To illustrate (`crossmeta` fixes these particular headers automatically):

For GSE50841:

* click *Find* then *Replace* (or *Ctrl + h*)
* *Find What*: *(SAMPLE \d+)\tDetection Pval*
* *Replace With*: *AVG\_Signal-\1\tDetection-\1*

For GSE34817:

* click *Find* then *Replace* (or *Ctrl + h*)
* *Find What*: *(MDA.+?)\tDetection Pval*
* *Replace With*: *AVG\_Signal-\1\tDetection-\1*

For GSE29689:

* change *PROBE\_ID* to *ID\_REF*.

A bioconductor data package (`lydata`) is available where all the above was performed. This data package will be used for subsequent demonstrations.

```
library(lydata)

# location of raw data
data_dir <- system.file("extdata", package = "lydata")
```

---

### Loading and Annotating Data

After downloading the raw data, it must be loaded and annotated. The necessary bioconductor annotation data packages will be downloaded as needed.

```
# reloads if previously called
esets <- load_raw(gse_names, data_dir)
```

If `crossmeta` does not know the bioconductor annotation data package for a given platform, entry will be requested. Use the given platform (GPL) to search online for the correct package name. For example, entry was requested for GSE29689 (platform GPL6883). A search for *GPL6883* on [GEO](http://www.ncbi.nlm.nih.gov/geo/) identified the title for this platform as *Illumina HumanRef-8 v3.0 expression beadchip*. A subsequent search on [Bioconductor](https://bioconductor.org/) for *illuminahuman* identified the appropriate package as *illuminaHumanv3*.

If you can’t find the bioconductor annotation data package (or none exists), type enter with a blank entry and `crossmeta` will attempt annotation using entrez gene ids in the feature data from the study in question. If entrez ids are absent, annotation will fail. To proceed, I reccommend that you add entrez ids and then use `crossmeta` to map these to hgnc symbols. As an example, if annotation had failed for GSE15069:

```
library(Biobase)
library(AnnotationDbi)

# check feature data to see what columns are available
head(fData(esets$GSE15069))

# if using RStudio
# View(fData(esets$GSE15069))

# annotation package for appropriate species
library(org.Mm.eg.db)

# map from accession number to entrez gene ids
acnums  <- as.character(fData(esets$GSE15069)$GB_ACC)
enids   <- mapIds(org.Mm.eg.db, acnums, "ENTREZID", "ACCNUM")

# add 'GENE_ID' column with entrez ids
fData(esets$GSE15069)$GENE_ID <- enids

# use crossmeta to map from entrez gene ids to homologous hgnc symbol
esets$GSE15069 <- symbol_annot(esets$GSE15069)

# to overwrite saved eset (to avoid repeating above)
saveRDS(esets$GSE15069, file.path(data_dir, "GSE15069", "GSE15069_eset.rds"))
```

---

### Differential Expression

After loading and annotating the data, you may proceed with differential expression analysis:

```
anals <- diff_expr(esets, data_dir)
```

You will be prompted to type group names and select samples for each control and test group that you wish to compare. Once done for a study, click `Done` and you will be prompted to do the same for the next study. You can re-select a previous control group by selecting the group name in the drop down box. You can also view and delete current contrasts in the `Contrasts` tab.

If you need to look up experimental details for the study (e.g. group membership) Click the `GEO` button in the top left corner.

**For Illumina samples**, If only titles are shown (no accessions), then samples from raw Illumina data could not be matched confidently to samples from the processed Illumina data. In this case, the sample titles are from the raw data and you may need to look in the individual sample records on GEO to identify which sample belongs to which group (not always possible).

If you need to re-run the above analysis, you can avoid having to reselect samples and rename groups:

```
# load auto-saved results of previous call to diff_expr
prev <- load_diff(gse_names, data_dir)

# supply prev to diff_expr
# anals <- diff_expr(esets, data_dir, prev_anals=prev)
```

Multi-dimensional scaling plots are generated for each GSE. These plots are generated from expression data with the effects of surrogate variables removed.

### Non-GUI Selection

Using the graphical user interface for sample selection can be error prone and time consuming for GSEs with a large number of samples. For these cases, you may prefer to specify group membership of samples using sample information from the study in question. As an example:

```
library(Biobase)

# load eset
gse_name  <- c("GSE34817")
eset <- load_raw(gse_name, data_dir)

# inspect pData of eset
# View(pData(eset$GSE34817))  # if using RStudio
head(pData(eset$GSE34817))    # otherwise

# get group info from pData (differs based on eset)
group <- pData(eset$GSE34817)$characteristics_ch1.1

# make group names concise and valid
group <- gsub("treatment: ", "", group)
group <- make.names(group)

# add group to eset pData
pData(eset$GSE34817)$group <- group

# setup selections
sel <- setup_prev(eset, contrasts = "LY-DMSO")

# run differential expression analysis
# anal <- diff_expr(eset, data_dir, prev_anal = sel)
```

---

### Tissue Sources

Pathway and effect-size meta-analyses can be performed for all studies and seperately for each tissue source. To do so, first add tissue sources and specify any sources that should be paired (treated as the same source for subsequent meta-analyses).

```
# run GUI to add tissue sources
# anals <- add_sources(prev, data_dir)

# for usage details
?add_sources
```

---

### Effect Size Meta-Analysis

After tissue sources have been specified for differential expression analyses, overall effect sizes can be determined through meta-analysis. The meta-analysis method determines an overall standardized effect size and false discovery rate for each gene that is present in a specified fraction of studies (30% by default).

```
# re-load previous analyses if need to
anals <- load_diff(gse_names, data_dir)

# perform meta analyses by tissue source
es_res <- es_meta(anals, by_source = TRUE)

# for explanation of values
?es_meta
```

The meta-analysis method was adapted from `GeneMeta`. Differences include the use of moderated unbiased effect sizes calculated by `metaMA`, the calculation of false discovery rates by `fdrtool`, and the allowance for genes measured in only a fraction of studies.

---

### Pathway Meta-Analysis

Sample groups and tissue sources specified for differential expression analyses are reused for pathway analyses. As such, `diff_expr` and `add_sources` must be used before pathway analysis for each contrast and subsequent meta-analysis.

```
# re-load previous differential expression analyses
anals <- load_diff(gse_names, data_dir)

# add tissue sources if haven't already
# anals <- add_sources(anals, data_dir)

# pathway analysis for each contrast
# path_anals <- diff_path(esets, anals, data_dir)

# reload previous pathway analyses
# path_anals <- load_path(gse_names, data_dir)

# pathway meta analysis by tissue source
# path_res <- path_meta(path_anals, ncores = 1, nperm = 5, by_source = TRUE)
```

Pathway analyses are performed using [PADOG](http://bioconductor.org/packages/release/bioc/html/PADOG.html), which outperforms other methods at prioritizing expected pathways ([ref1](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0079217#pone-0079217-g002), [ref2](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4707541/figure/f5/)). Pathway p-values from PADOG analyses are combined using Fisher’s method.

---

### Exploring Results and Finding Drug Candidates

One application of the signatures generated by meta-analysis is to search for a drug, or combination of drugs that is predicted to reverse or mimic your signature. These drugs might reverse diseases or mimic healthy lifestyles.

The function `explore_paths` interfaces with [ccmap](https://bioconductor.org/packages/release/bioc/html/ccmap.html) to find drug candidates and graphically explore the results of the pathway meta-analyses.

```
# explore_paths(es_res, path_res)

# for usage details
?explore_paths
```

If `crossmeta` is usefull to you, please contribute your signature! Your contribution will be used to build a public database of microarray meta-analyses. To contribute:

```
# subject is the focus of the meta-analysis (e.g. drug/disease name)
contribute(anals, subject = "LY294002")

# Thank you!
```

```
sessionInfo()
```

```
## R version 3.5.1 Patched (2018-07-12 r74967)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] parallel  stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
## [1] limma_3.38.0        Biobase_2.42.0      BiocGenerics_0.28.0
## [4] lydata_1.7.0        crossmeta_1.8.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_0.2.5  purrr_0.2.5       colorspace_1.3-2
##  [4] miniUI_0.1.1.1    htmltools_0.3.6   viridisLite_0.3.0
##  [7] yaml_2.2.0        plotly_4.8.0      rlang_0.3.0.1
## [10] later_0.7.5       pillar_1.3.0      withr_2.1.2
## [13] glue_1.3.0        rngtools_1.3.1    registry_0.5
## [16] SMVar_1.3.3       bindrcpp_0.2.2    doRNG_1.7.1
## [19] foreach_1.4.4     plyr_1.8.4        bindr_0.1.1
## [22] stringr_1.3.1     pkgmaker_0.27     munsell_0.5.0
## [25] gtable_0.2.0      htmlwidgets_1.3   codetools_0.2-15
## [28] evaluate_0.12     knitr_1.20        httpuv_1.4.5
## [31] fdrtool_1.2.15    Rcpp_0.12.19      xtable_1.8-3
## [34] promises_1.0.1    scales_1.0.0      backports_1.1.2
## [37] jsonlite_1.5      mime_0.6          ggplot2_3.1.0
## [40] digest_0.6.18     stringi_1.2.4     dplyr_0.7.7
## [43] shiny_1.1.0       bibtex_0.4.2      grid_3.5.1
## [46] rprojroot_1.3-2   tools_3.5.1       magrittr_1.5
## [49] lazyeval_0.2.1    tibble_1.4.2      crayon_1.3.4
## [52] tidyr_0.8.2       pkgconfig_2.0.2   data.table_1.11.8
## [55] assertthat_0.2.0  rmarkdown_1.10    httr_1.3.1
## [58] iterators_1.0.10  metaMA_3.1.2      R6_2.3.0
## [61] compiler_3.5.1
```