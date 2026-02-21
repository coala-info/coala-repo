# Variant Calling

#### Benjamin Story

## Overview

In this vignette, we demonstrate the ability of mitoClone2 to identify mitochondrial variants from single-cell sequencing data of a single or multiple individuals without any *a priori* knowledge of pre-existing variants by capitalizing on either an extensive exclusionlist (that removes known/potential false-positive signals) OR information shared across multiple individuals. We note here that of these methods, the second, is the most powerful. The latter strategy relies on the assumption that biological noise (e.g. RNA editing) and technical noise (arising during either library preparation, RNA sequencing, read processing, or alignment steps of the experiment) should be consistent across samples from different individuals. On this end, each individual sample can then act as essentially a technical/pseudo-replicate for identification and elimination the mentioned artifacts. In situations where a single sample from one individual is analyzed, we fall back on our standard filtering method using pre-constructed exclusionlists including information related to homo-polymers, repeat regions, RNA editing sites, and known sequencing artifacts.

```
library(mitoClone2)
```

### Introduction

A major untapped resource in identifying clonal populations in single-cells can be found in the mitochondrial reads. Often discarded or used a marker for bad cells, the high mutation rate and coverage of the mitochondria makes it a prime piece of real estate for detecting genetic differences among cells. Another important note of biological importance is that in many cases multiple mitochondria exist within individual cells, each in turn containing multiple copies of the mitochondrial genome. Thus the heterogeneity of mitochondria does not follow the standard Mendelian bifurcation into homo/heterozygous mutations. The term used to describe this phenomenon is heteroplasmy - which is defined as the presence of more than one organellar genome within a single cell.

### Package goals

The primary goal of this package is to extract and analyze mitochondrial variants from single-cell RNA-seq data. The method should also work equally well with single-cell ATAC/DNA-seq data. Although the majority of functions provided by the package should work with BAM files from bulk sequencing experiments, a portion of the core functionality will be lost.

### Genome availability

There is built in compatibility with the hg38/hg19 human genomes and mm10 mouse genome. IMPORTANT: The mitochondrial genome sequence used in the UCSC hg19 reference is different than that used for NCBI’s GRCh37. GRCh37 uses the same reference as hg38/GRCh38 so make sure to check your relevant FASTA files to verify the expected length of your mitochondria. The lengths are as follows: UCSC hg38 (16569 bp), UCSC hg19 (16571 bp), and UCSC mm10 (16299 bp).

## Input data

Before we can begin addressing the different aspects of filtering and identifying bonafide variants, it is important to import your data in the appropriate format. In our case, we rely most heavily on the pre-existing structure defined by the `deepSNV::bam2R()` function which produces 22 columns matrix with a number of rows corresponding to ranges provided as input parameters. IMPORTANT: For the majority of this vignette, the assumption is that we are working with the entire mitochondrial genome of a given organism. You are free to input any position by mutation matrix to the filtering and clustering functions, but keep in mind certain parameters should be adjusted.

### Counting nucleotides from BAM files

To generate your count tables we have provided two functions to do so: Firstly, these tables can be created from a list of bam files using the function `baseCountsFromBamList` this function takes a list of bam files which can be created with `list.files()`. This function assumes that each individual single cell is represented by a single bam file. Alternatively, with our recent updates you can now pull variants directly from a 10x Genomics multiplexed BAM file using `bam2R_10x`. This relies on using the `CB` bam tag present within the BAM file to distinguish individual cells. Two helpful suggestions for this process are to initially subset BAM files for reads located on the mitochondrial chromosome and also to deduplicate reads if UMIs are present. You may also choose to count up the different nucleotides using a different method. In such cases, the only requirements for downstream mutation calling functions is that your `baseCounts` object be an R `list` that contains 5 to 8 columns where rows represent genomic positions and columns represent base calls (i.e. A,G,C,T,-,N,INS,DEL)

### Counting function examples and explanations

The **basic function** provided is `baseCountsFromBamList` which reads in BAM files from a list and has four parameters:

* `bamfiles` = This is simply a list of bamfiles for which you would like to count the number of nucleotides at each genomic position from the `sites` parameter.
* `sites` = These are the chromosome locations where you will count variants from. The default is the hg38 mitochondrial genome which starts at position 1 and has a length of 16569 bp.
* `ncores` = The number of threads used to count up reads from your bamfiles. If you have thousands of input BAM files and your system can handle it, reading in multiple BAM files at once will help speed things up. Default: 1.
* `ignore_nonstandard` = Ignores basecalls that are not an A, G, C, T, or N (unknown). A user can enable this if their reads tend to have a lot of spliced reads (which are likely erroneous) or insertions/deletions. Default: FALSE.

Note: Be aware that this function calls `deepSNV::bam2R()` with default parameters.

```
## example using function for a list of BAM files

baseCounts <- baseCountsFromBamList(bamfiles = list(system.file("extdata",
    "mm10_10x.bam", package = "mitoClone2")), sites = "chrM:1-15000", ncores = 1)
print(length(baseCounts))
```

```
## [1] 1
```

```
print(head(baseCounts[[1]][13267:13277, ]))
```

```
##        A   T   C G -  N INS DEL
## [1,]   4 395   0 0 0 14   0   0
## [2,] 398   0   0 0 0 22   0   0
## [3,] 383   0   0 0 0 36   0   0
## [4,] 381   1   0 1 0 36   0   0
## [5,] 402   0   0 0 0 23   0   0
## [6,]   0   0 406 0 0 15   0   0
```

The **next function** is for reading in a multiplexed BAM file `bam2R_10x` takes multiple parameters:

* `file` = This is a string containing the path for which you would like to count the number of nucleotide at each genomic position from the `sites` parameter for each cell barcode.
* `sites` = These are the chromosome locations where you will count variants from. The default is the hg38 mitochondrial genome which starts at position 1 and has a length of 16569 bp. Again, it is very important that you provide the appropriate chromosome names relative to your BAM file.
* `ncores` = The number of threads used to combine and summarize all the counts from your BAM file. In contrast to the previous function this parameter will not provide a dramatic speed boost. Default: 1.
* `ignore_nonstandard` = Ignores basecalls that are not an A, G, C, T, or N (unknown). A user can enable this if their reads tend to have a lot of spliced reads (which are likely erroneous) or insertions/deletions. Default: FALSE.

```
## example using function for a multiplexed BAM files cell barcodes
## found by extracting the 'CB' BAM tag
baseCounts <- bam2R_10x(file = system.file("extdata", "mm10_10x.bam", package = "mitoClone2"),
    sites = "chrM:1-15000", ncores = 1)
```

```
## FIRST PASSTotal reads processed: 5117
## Reads with barcodes: 5117 (100.00%)
## Unique barcodes found: 6
## Barcodes with >= 50 reads: 5
```

```
print(length(baseCounts))
```

```
## [1] 5
```

```
print(head(baseCounts[[1]][13267:13277, ]))
```

```
##       A  T  C G - N INS DEL
## [1,]  0 20  0 0 0 0   0   0
## [2,] 20  0  0 0 0 0   0   0
## [3,] 20  0  0 0 0 0   0   0
## [4,] 20  0  0 0 0 0   0   0
## [5,] 20  0  0 0 0 0   0   0
## [6,]  0  0 20 0 0 0   0   0
```

## Calling and filtering variants

The next step of the analysis is to take your counts of each nucleotide in each cell and identify variants that are present. A major barrier in this process is the inherent noise present in single cell datasets. Although we will only briefly discuss the important aspects of filtering this is by far the most crucial step of the analysis. The prevalence of mitochondrial variants is highly variable, in some cases more or less depending on the dataset. It is wise to adjust the parameters in order to tailor them to each particular dataset - one size fits all does not apply here. It is critical to choose optimal parameters for a dataset and experimentation is often necessary.

### Calling mutations based on an exclusionlist

The simplest way to identify variants, beyond simply enriching for those that are present in only a fraction of the population, is by removing detected variants that are likely to be caused by noise (as previously discussed). One conservative approach to accomplish this is to simply remove all variants that overlap with problematic sites. As a side note, this type of approach will decrease false positive hits but may incidentally increase false negative hits. This type of method is used when a you only have a single sample from one individual/timepoint.

The function `mutationCallsFromExclusionlist` performs filtering and then removes any variants on the exclusionlists. Parameters:

* `lim.cov` = The minimum number of reads overlapping a site in a given single cell for it to be considered covered. The default value is 20.
* `min.af` = The minimal allele frequency for a site to considered mutant in an single cell. Depending on the dataset this value may be higher or lower as illustrated in the examples at the end of vignette. The default value is 0.2.
* `universal.var.cells` = The number of cells which must be mutant for a given variant to filtered out. In this case mutations that are in the vast majority of cells, likely germline mutations, may be removed. The default setting for this is 95% of all cells. However, again this parameter should be adjusted based on the number and type of cells in a given analysis.
* `min.af.universal` = The parameter used in conjunction with the previous parameter which sets a threshold as to how high the allele frequency must be in a cell to qualify it as mutant. By default this parameter is identical to `min.af` but if needed it can be changed.
* `min.num.samples` = The number of cells that must be considered mutant for a given variant for that variant to be included. Again this value is highly dependent on the number and type of cells present in a given dataset. Default is set to 1% of cells.
* `exclusionlists` = The list of exclusionlists to use for filtering. The parameter should be a named list where each element in the list is a GRanges object. The GRanges object should contain the genomic coordinates of variants to be excluded from the analysis. By default, the exclusionlist is made up of: `three` which are elements within stretches of homopolymers on the mitochondrial chromosome of length 3 bp or greater, `masked` which are regions masked in the Refseq or UCSC genome releases (likely repetitive elements), `mutaseq` which are regions identified from a previous study (these can be excluded in most cases), and `rnaEDIT` which are RNA editing sites from the REDIportal. **In all cases, these are relative to the ‘hg38’ genome coordinates** and should not be used with other genomes without applying a liftOver step.

### Calling mutations based on variants shared within a cohort

The next way of filtering is a bit more intuitive. First of all, we make the following important assumption: **We are comparing similar sets of cells between patients/timepoints and the only differences between them are biological (thus all technical steps are identical).** Under this assumption, any technical noise as described previously ’(e.g. sequencing artifacts, alignment errors) and even low levels of biological noise (e.g. RNA-editing) should be mostly preserved between samples. Thus, by identifying all shared features (i.e. variants) between two samples being compared, we can exclude all this noise and identify true somatic variants. TL;DR: We ask the question - which variants are only present in a single individual and not in others?

The function `mutationCallsFromCohort` performs filtering based on mutations shared across experiments/samples and then retrieves variants that are uniquely enriched in single patients. Parameters:

* `MINREADS` = The minimum number of reads overlapping a site in a given single cell for it to be considered covered. The default value is 5.
* `MINCELL` = The minimum number of total cells across all datasets that must have **mutant** allele coverage over the target site. The default value is 20.
* `MINFRAC` = The minimal allele frequency for a site to considered mutant in an single The default value is 0.1.
* `MINCELLS.PATIENT` = The minimum number of cells within an individual patient that must have mutant coverage over the target site. The default value is 10.
* `MINRELATIVE.PATIENT` = The minimal allele frequency for a site to be considered mutant in a single cell within a single patient. The default value is 0.01.
* `MINRELATIVE.OTHER` = The minimal allele frequency for a site to be considered mutant in a single cell within other patient (in contrast to the previous parameter). If so, then the mutation is excluded as it is considered shared between two or more samples/patients. The default value is 0.1.
* `USE.REFERENCE` = The variant calls will be of the format REF>ALT where REF is decided based on the selected annotation below. Default is to have this set to TRUE. If set to FALSE the most abundant nucleotide across all cells at a given position will be considered reference. This may vary based on the samples provided to the function and thus may differ across runs if this is set to FALSE.
* `genome` = The mitochondrial genome reference used for the sample(s) being investigated. Please note that this is the UCSC standard chromosome sequence. It is VITAL to double check that the proper genome and sites options are provided that are congruent with the annotations of your bam file. Default: hg38.

To exemplify the use of these functions we are going to build a figure based on data from a previously published data set. In this case, one of the first papers to recognize the use of mitochondrial variants in single-cell sequencing. Ludwig et al., 2019 Lineage Tracing in Humans Enabled by Mitochondrial Mutations and Single-Cell Genomics. *Cell*. 2019 Mar 7;176(6):1325-1339.e22. doi: 10.1016/j.cell.2019.01.022 <https://pubmed.ncbi.nlm.nih.gov/30827679/>. The dataset has been shrunk substantially for this vignette and the names of the mitochondrial variants are randomized.

In this example, as a proof-of-concept, the experimenters used donor hematopoietic stem and progenitor cells (HSPCs) to derive cell colonies and then isolated cells from each for single-cell sequencing. As expected, the cells that were isolated from the same colony tended exhibit shared mitochondrial variants (i.e. they are indeed (sub)-clonal). The variant sites have been randomized and shrunk in order to save space.

## Example of **Exclusionlist filtering**

```
library(mitoClone2)
library(pheatmap)

## load our count data
load(system.file("extdata/example_counts.Rda", package = "mitoClone2"))

## investigate what our ideal baseCounts object looks like
print(head(example.counts[[1]]))
```

```
##         A  T  C     G    N
## [1,] 1358  0  2     1  386
## [2,] 1745  0  1     2  309
## [3,]  507  0  0     0   47
## [4,]    7  9  3 50627 6075
## [5,]    9 10  1 70151 5843
## [6,]   54 20 42 57073 5373
```

```
## calling mutations using our exclusionlist
Example <- mutationCallsFromExclusionlist(example.counts, min.af = 0.05,
    min.num.samples = 5, universal.var.cells = 0.5 * length(example.counts),
    binarize = 0.1)
```

```
## Subsetting for specific cells...
```

```
## setting up the meta data
Example.rawnames <- getAlleleCount(Example, "nonmutant")
```

```
## Extracting sum of all nonmutant alleles
```

```
Example.meta <- data.frame(row.names = rownames(Example.rawnames), Clone = gsub("_.*",
    "", gsub("Donor1_", "", rownames(Example.rawnames))))

## showing the clustering via heatmap (notice only 20 mutations were
## kept)
clustered <- quick_cluster(Example, binarize = TRUE, drop_empty = TRUE,
    clustering.method = "ward.D2", annotation_col = Example.meta, show_colnames = FALSE,
    fontsize_row = 7)
```

![](data:image/png;base64...)

## Example of **Cohort filtering**

Now (knowing the original parental colony from the publication) we apply **cohort filtering** to revealing similar results.

```
## Calling mutations using our known clonal information
Example <- mutationCallsFromCohort(example.counts, MINFRAC = 0.01, MINCELL = 8,
    MINCELLS.PATIENT = 5, patient = Example.meta$Clone, sites = "chrM:1-55")
```

```
## Making sure 'sites' parameter is set correctly...
```

```
## Looks good. Using the UCSC hg38 genome as a reference for variants. Be wary, only mitochondrial annotations are available!
```

```
## check the variants for a specific cluster
print(colnames(getAlleleCount(Example$C112, "mutant")))
```

```
## Extracting sum of all mutant alleles
```

```
## [1] "X19C.A" "X25A.G" "X50T.G" "X54G.A"
```

```
private.mutations <- unique(unlist(lapply(Example[grep("^C", names(Example))][unlist(lapply(Example[grep("^C",
    names(Example))], function(x) !is.null(x)))], function(y) names(getVarsCandidate(y)))))
private.mutations.df <- pullcountsVars(example.counts, gsub("X(\\d+)([AGCT])\\.([AGCT])",
    "\\1 \\2>\\3", private.mutations))
private.mutations.df <- mutationCallsFromMatrix(t(private.mutations.df$M),
    t(private.mutations.df$N), cluster = rep(TRUE, length(private.mutations)))

## Showing the clustering looks via heatmap
clustered <- quick_cluster(private.mutations.df, binarize = TRUE, drop_empty = TRUE,
    clustering.method = "ward.D2", annotation_col = Example.meta, show_colnames = FALSE,
    fontsize_row = 7)
```

![](data:image/png;base64...)

## Session information

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] pheatmap_1.0.13   mitoClone2_1.16.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            dplyr_1.1.4
##  [3] farver_2.1.2                blob_1.2.4
##  [5] Biostrings_2.78.0           S7_0.2.0
##  [7] bitops_1.0-9                fastmap_1.2.0
##  [9] RCurl_1.98-1.17             VariantAnnotation_1.56.0
## [11] GenomicAlignments_1.46.0    XML_3.99-0.19
## [13] digest_0.6.37               lifecycle_1.0.4
## [15] KEGGREST_1.50.0             RSQLite_2.4.3
## [17] magrittr_2.0.4              compiler_4.5.1
## [19] rlang_1.1.6                 sass_0.4.10
## [21] tools_4.5.1                 yaml_2.3.10
## [23] rtracklayer_1.70.0          Rhtslib_3.6.0
## [25] knitr_1.50                  S4Arrays_1.10.0
## [27] bit_4.6.0                   curl_7.0.0
## [29] DelayedArray_0.36.0         plyr_1.8.9
## [31] RColorBrewer_1.1-3          abind_1.4-8
## [33] BiocParallel_1.44.0         BiocGenerics_0.56.0
## [35] grid_4.5.1                  stats4_4.5.1
## [37] ggplot2_4.0.0               scales_1.4.0
## [39] dichromat_2.0-0.1           SummarizedExperiment_1.40.0
## [41] cli_3.6.5                   rmarkdown_2.30
## [43] crayon_1.5.3                generics_0.1.4
## [45] httr_1.4.7                  reshape2_1.4.4
## [47] rjson_0.2.23                DBI_1.2.3
## [49] cachem_1.1.0                stringr_1.5.2
## [51] splines_4.5.1               parallel_4.5.1
## [53] AnnotationDbi_1.72.0        formatR_1.14
## [55] XVector_0.50.0              restfulr_0.0.16
## [57] matrixStats_1.5.0           vctrs_0.6.5
## [59] Matrix_1.7-4                jsonlite_2.0.0
## [61] VGAM_1.1-13                 IRanges_2.44.0
## [63] S4Vectors_0.48.0            bit64_4.6.0-1
## [65] deepSNV_1.56.0              GenomicFeatures_1.62.0
## [67] jquerylib_0.1.4             glue_1.8.0
## [69] codetools_0.2-20            stringi_1.8.7
## [71] gtable_0.3.6                BiocIO_1.20.0
## [73] GenomicRanges_1.62.0        tibble_3.3.0
## [75] pillar_1.11.1               htmltools_0.5.8.1
## [77] Seqinfo_1.0.0               BSgenome_1.78.0
## [79] R6_2.6.1                    evaluate_1.0.5
## [81] lattice_0.22-7              Biobase_2.70.0
## [83] png_0.1-8                   Rsamtools_2.26.0
## [85] cigarillo_1.0.0             memoise_2.0.1
## [87] bslib_0.9.0                 Rcpp_1.1.0
## [89] SparseArray_1.10.0          xfun_0.53
## [91] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```