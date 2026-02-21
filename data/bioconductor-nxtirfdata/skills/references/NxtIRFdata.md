# NxtIRFdata: a data package for SpliceWiz

#### Alex Chit Hei Wong

#### 11/04/2025

Abstract

NxtIRFdata is a data package containing ready-made BED files of Mappability exclusion genomic regions. It also contains a fully-functioning example data set with a “mock” genome and genome annotation to demonstrate the functionalities of SpliceWiz, a powerful and interactive analysis and visualisation tool for alternative splicing.

# 0 Important announcement

NxtIRFcore’s full functionality (plus more) will be replaced by SpliceWiz in Bioconductor version 3.16 onwards!

# 1 Installation

To install this package, start R (version “4.2.1”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("NxtIRFdata")
```

Start using NxtIRFdata:

```
library(NxtIRFdata)
```

# 2 Obtaining the example NxtIRF genome and gene annotation files

Examples in SpliceWiz are demonstrated using an artificial genome and gene annotation. A synthetic reference, with genome sequence (FASTA) and gene annotation (GTF) files are provided, based on the genes SRSF1, SRSF2, SRSF3, TRA2A, TRA2B, TP53 and NSUN5. These genes, each with an additional 100 flanking nucleotides, were used to construct an artificial “chromosome Z” (chrZ). Gene annotations, based on release-94 of Ensembl GRCh38 (hg38), were modified with genome coordinates corresponding to this artificial chromosome.

These files can be accessed as follows:

```
example_fasta = chrZ_genome()
example_gtf = chrZ_gtf()
```

# 3 Obtaining the example BAM file dataset for SpliceWiz

The set of 6 BAM files used in the SpliceWiz vignette / example code can be downloaded to a path of the user’s choice using the following function:

```
bam_paths = example_bams(path = tempdir())
```

Note that this downloads BAM files and not their respective BAI (BAM file indices). This is because SpliceWiz reads BAM files natively and does not require RSamtools. BAI files are provided with BAM files in their respective ExperimentHub entries for users wishing to view these files using RSamtools.

# 4 Obtaining the Mappability Exclusion BED files

NxtIRFdata retrieves the relevant records from AnnotationHub and makes a local copy of the BED file. This BED file is used to produce Mappability Exclusion information to SpliceWiz.

Note that this function is intended to be called internally by SpliceWiz. Users interested in the format or nature of the Mappability BED file can call this function to examine the contents of the BED file

```
# To get the MappabilityExclusion for hg38 as a GRanges object
gr = get_mappability_exclusion(genome_type = "hg38", as_type = "GRanges")

# To get the MappabilityExclusion for hg38 as a locally-copied gzipped BED file
bed_path = get_mappability_exclusion(genome_type = "hg38", as_type = "bed.gz",
    path = tempdir())

# Other `genome_type` values include "hg19", "mm10", and "mm9"
```

# 5 Accessing NxtIRFdata via ExperimentHub

The data deposited in ExperimentHub can be accessed as follows:

```
library(ExperimentHub)
```

```
eh = ExperimentHub()
NxtIRF_hub = query(eh, "NxtIRF")

NxtIRF_hub

temp = eh[["EH6792"]]
temp

temp = eh[["EH6787"]]
temp
```

# 5 Information about the example BAM files

For more information about the example BAM files, refer to the NxtIRFdata package documentation:

```
?`NxtIRFdata-package`
```

# SessionInfo

```
sessionInfo()
```

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
## [1] ExperimentHub_3.0.0 AnnotationHub_4.0.0 BiocFileCache_3.0.0
## [4] dbplyr_2.5.1        BiocGenerics_0.56.0 generics_0.1.4
## [7] NxtIRFdata_1.16.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
##  [3] rjson_0.2.23                xfun_0.54
##  [5] bslib_0.9.0                 httr2_1.2.1
##  [7] lattice_0.22-7              Biobase_2.70.0
##  [9] vctrs_0.6.5                 tools_4.5.1
## [11] bitops_1.0-9                stats4_4.5.1
## [13] curl_7.0.0                  parallel_4.5.1
## [15] AnnotationDbi_1.72.0        tibble_3.3.0
## [17] RSQLite_2.4.3               blob_1.2.4
## [19] R.oo_1.27.1                 pkgconfig_2.0.3
## [21] Matrix_1.7-4                cigarillo_1.0.0
## [23] S4Vectors_0.48.0            lifecycle_1.0.4
## [25] compiler_4.5.1              Rsamtools_2.26.0
## [27] Biostrings_2.78.0           Seqinfo_1.0.0
## [29] codetools_0.2-20            htmltools_0.5.8.1
## [31] sass_0.4.10                 RCurl_1.98-1.17
## [33] yaml_2.3.10                 pillar_1.11.1
## [35] crayon_1.5.3                jquerylib_0.1.4
## [37] R.utils_2.13.0              BiocParallel_1.44.0
## [39] DelayedArray_0.36.0         cachem_1.1.0
## [41] abind_1.4-8                 tidyselect_1.2.1
## [43] digest_0.6.37               BiocVersion_3.22.0
## [45] dplyr_1.1.4                 purrr_1.1.0
## [47] restfulr_0.0.16             grid_4.5.1
## [49] fastmap_1.2.0               SparseArray_1.10.1
## [51] cli_3.6.5                   magrittr_2.0.4
## [53] S4Arrays_1.10.0             XML_3.99-0.19
## [55] withr_3.0.2                 filelock_1.0.3
## [57] rappdirs_0.3.3              bit64_4.6.0-1
## [59] rmarkdown_2.30              XVector_0.50.0
## [61] httr_1.4.7                  matrixStats_1.5.0
## [63] bit_4.6.0                   png_0.1-8
## [65] R.methodsS3_1.8.2           memoise_2.0.1
## [67] evaluate_1.0.5              knitr_1.50
## [69] GenomicRanges_1.62.0        IRanges_2.44.0
## [71] BiocIO_1.20.0               rtracklayer_1.70.0
## [73] rlang_1.1.6                 glue_1.8.0
## [75] DBI_1.2.3                   BiocManager_1.30.26
## [77] jsonlite_2.0.0              R6_2.6.1
## [79] MatrixGenerics_1.22.0       GenomicAlignments_1.46.0
```