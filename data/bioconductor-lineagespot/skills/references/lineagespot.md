# lineagespot User Guide

Nikolaos Pechlivanis1\*, Maria Tsagiopoulou1, Maria Christina Maniou1, Anastasis Togkousidis1, Evangelia Mouchtaropoulou1, Taxiarchis Chassalevris2, Serafeim Chaintoutis2, Chrysostomos Dovas2, Maria Petala3, Margaritis Kostoglou4, Thodoris Karapantsios4, Stamatia Laidou1, Elisavet Vlachonikola1, Anastasia Chatzidimitriou1, Agis Papadopoulos5, Nikolaos Papaioannou2, Anagnostis Argiriou1 and Fotis E. Psomopoulos1

1Institute of Applied Biosciences, Centre for Research and Technology Hellas, Thessaloniki, GR
2School of Veterinary Medicine, Aristotle University of Thessaloniki, GR
3Dept. of Civil Engineering, Aristotle University of Thessaloniki, GR
4Dept. of Chemistry, Aristotle University of Thessaloniki, GR
5EYATH S.A., Thessaloniki Water Supply and Sewerage Company S.A., Thessaloniki, GR

\*nikosp41@certh.gr

#### 30 October 2025

#### Package

lineagespot 1.14.0

# 1 Introduction

`lineagespot` is a framework written in R, and aims to identify
SARS-CoV-2 related mutations based on a single (or a list) of variant(s)
file(s) (i.e., variant calling format). The method can facilitate the
detection of SARS-CoV-2 lineages in wastewater samples using next
generation sequencing, and attempts to infer the potential distribution
of the SARS-CoV-2 lineages.

# 2 Quick start

## 2.1 Installation

`lineagespot` is distributed as a [Bioconductor](https://www.bioconductor.org/)
package and requires `R` (version “4.1”), which can be installed on any
operating system from [CRAN](https://cran.r-project.org/), and
Bioconductor (version “3.14”).

To install `lineagespot` package enter the following commands in
your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("lineagespot")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 2.2 Raw data analysis

Example fastq files are provided through
[zenodo](https://zenodo.org/badge/DOI/10.5281/zenodo.4564182.svg).
For the pre processing steps of them, the bioinformatics analysis pipeline is
provided [here](../inst/scripts/raw-data-analysis.md).

## 2.3 Running lineagespot

Once `lineagespot` is successfully installed, it can be loaded as follow:

```
library(lineagespot)
```

`lineagespot` can be run by calling one function that implements the overall
pipeline:

```
results <- lineagespot(vcf_folder = system.file("extdata", "vcf-files",
                                                package = "lineagespot"),

                      gff3_path = system.file("extdata",
                                              "NC_045512.2_annot.gff3",
                                              package = "lineagespot"),

                      ref_folder = system.file("extdata", "ref",
                                               package = "lineagespot"))
```

## 2.4 Explore the results

The function returns three tables:

* An overall variant table containing all variants included in the input VCF
  files, along with the related information (gene, location etc.)

```
# overall table
head(results$variants.table)
#>          CHROM   POS                         ID    REF    ALT    DP AD_ref
#>         <char> <num>                     <char> <char> <char> <int>  <num>
#> 1: NC_045512.2   328   NC_045512.2;328;ACA;ACCA    ACA   ACCA    36     34
#> 2: NC_045512.2   355        NC_045512.2;355;C;T      C      T    42     41
#> 3: NC_045512.2   366        NC_045512.2;366;C;T      C      T    42     28
#> 4: NC_045512.2   401 NC_045512.2;401;CTTAA;CTAA  CTTAA   CTAA    37     35
#> 5: NC_045512.2   406     NC_045512.2;406;AGA;AA    AGA     AA    35     34
#> 6: NC_045512.2   421        NC_045512.2;421;C;A      C      A    35     34
#>    AD_alt Gene_Name  Nt_alt AA_alt         AF codon_num                sample
#>     <num>    <char>  <char> <char>      <num>     <num>                <char>
#> 1:      1     ORF1a  64dupC  Q22fs 0.02777778        21 SampleA_freebayes_ann
#> 2:      1     ORF1a   90C>T   G30G 0.02380952        30 SampleA_freebayes_ann
#> 3:     14     ORF1a  101C>T   S34F 0.33333333        34 SampleA_freebayes_ann
#> 4:      2     ORF1a 138delT  D48fs 0.05405405        46 SampleA_freebayes_ann
#> 5:      1     ORF1a 142delG  D48fs 0.02857143        47 SampleA_freebayes_ann
#> 6:      1     ORF1a  156C>A   G52G 0.02857143        52 SampleA_freebayes_ann
```

* A table with the identified overlaps/hits between the variant table and the
  given lineage reports.

```
# lineages' hits
head(results$lineage.hits)
#>    Gene_Name AA_alt                sample    DP AD_alt        AF lineage
#>       <char> <char>                <char> <num>  <num>     <num>  <char>
#> 1:         M   I82T SampleC_freebayes_ann  3984   2770 0.6952811    AY.1
#> 2:         N   D63G SampleC_freebayes_ann  2180    787 0.3610092    AY.1
#> 3:         N  R203M SampleC_freebayes_ann  4147   4125 0.9946950    AY.1
#> 4:         N  G215C SampleC_freebayes_ann  4477   2574 0.5749386    AY.1
#> 5:         N  D377Y SampleC_freebayes_ann  4271   1623 0.3800047    AY.1
#> 6:     ORF1a A1306S SampleC_freebayes_ann  2202   1267 0.5753860    AY.1
```

* A lineage report table where metrics for the abundance of each lineage are
  computed.
  To this end, the mean AF (allele frequence) of the variants per lineage,
  the mean AF of the unique variants per lineage and the non-zero min. AF of the
  lineage’s unique variants are computed.
  Moreover given a AF threshold the number of variants in each sample is
  computed along with the resulting proportion (Number of variants to the number
  of lineage rules).

```
# lineagespot report
head(results$lineage.report)
#>    lineage                sample     meanAF meanAF_uniq minAF_uniq_nonzero
#>     <char>                <char>      <num>       <num>              <num>
#> 1:    AY.1 SampleA_freebayes_ann 0.08333333   0.0000000                 NA
#> 2:    AY.1 SampleB_freebayes_ann 0.08333333   0.0000000                 NA
#> 3:    AY.1 SampleC_freebayes_ann 0.43162568   0.0000000                 NA
#> 4:    AY.2 SampleA_freebayes_ann 0.07692308   0.0000000                 NA
#> 5:    AY.2 SampleB_freebayes_ann 0.07692308   0.0000000                 NA
#> 6:    AY.2 SampleC_freebayes_ann 0.33117826   0.1198191          0.1594335
#>        N lineage N. rules lineage prop.
#>    <int>            <int>         <num>
#> 1:     1               31    0.03225806
#> 2:     1               31    0.03225806
#> 3:     6               31    0.19354839
#> 4:     1               29    0.03448276
#> 5:     1               29    0.03448276
#> 6:     4               29    0.13793103
```

# Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled running pandoc `2.7.3`:

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] lineagespot_1.14.0 RefManageR_1.4.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0             SummarizedExperiment_1.40.0
#>  [3] rjson_0.2.23                xfun_0.53
#>  [5] bslib_0.9.0                 Biobase_2.70.0
#>  [7] lattice_0.22-7              vctrs_0.6.5
#>  [9] tools_4.5.1                 bitops_1.0-9
#> [11] generics_0.1.4              curl_7.0.0
#> [13] stats4_4.5.1                parallel_4.5.1
#> [15] AnnotationDbi_1.72.0        RSQLite_2.4.3
#> [17] blob_1.2.4                  Matrix_1.7-4
#> [19] BSgenome_1.78.0             data.table_1.17.8
#> [21] cigarillo_1.0.0             S4Vectors_0.48.0
#> [23] lifecycle_1.0.4             compiler_4.5.1
#> [25] stringr_1.5.2               Rsamtools_2.26.0
#> [27] Biostrings_2.78.0           Seqinfo_1.0.0
#> [29] codetools_0.2-20            htmltools_0.5.8.1
#> [31] sass_0.4.10                 RCurl_1.98-1.17
#> [33] yaml_2.3.10                 crayon_1.5.3
#> [35] jquerylib_0.1.4             BiocParallel_1.44.0
#> [37] DelayedArray_0.36.0         cachem_1.1.0
#> [39] abind_1.4-8                 digest_0.6.37
#> [41] stringi_1.8.7               restfulr_0.0.16
#> [43] bookdown_0.45               VariantAnnotation_1.56.0
#> [45] bibtex_0.5.1                fastmap_1.2.0
#> [47] grid_4.5.1                  cli_3.6.5
#> [49] SparseArray_1.10.0          magrittr_2.0.4
#> [51] S4Arrays_1.10.0             GenomicFeatures_1.62.0
#> [53] XML_3.99-0.19               backports_1.5.0
#> [55] bit64_4.6.0-1               lubridate_1.9.4
#> [57] timechange_0.3.0            rmarkdown_2.30
#> [59] XVector_0.50.0              httr_1.4.7
#> [61] matrixStats_1.5.0           bit_4.6.0
#> [63] png_0.1-8                   memoise_2.0.1
#> [65] evaluate_1.0.5              knitr_1.50
#> [67] BiocIO_1.20.0               GenomicRanges_1.62.0
#> [69] IRanges_2.44.0              rtracklayer_1.70.0
#> [71] rlang_1.1.6                 Rcpp_1.1.0
#> [73] glue_1.8.0                  DBI_1.2.3
#> [75] BiocManager_1.30.26         xml2_1.4.1
#> [77] BiocGenerics_0.56.0         jsonlite_2.0.0
#> [79] R6_2.6.1                    plyr_1.8.9
#> [81] GenomicAlignments_1.46.0    MatrixGenerics_1.22.0
```