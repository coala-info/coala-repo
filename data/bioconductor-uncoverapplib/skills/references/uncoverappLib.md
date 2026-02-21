# *uncoverappLib*: a R shiny package containing unCOVERApp an interactive graphical application for clinical assessment of sequence coverage at the base-pair level

Emanuela Iovino , Tommaso Pippucci

#### 30 October 2025

#### Package

uncoverappLib 1.20.0

# Contents

* [1 Introduction](#introduction)
* [2 Installation and example](#installation-and-example)
* [3 Input file](#input-file)
* [4 Output](#output)
* [5 Session information](#session-information)

```
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
```

# 1 Introduction

This is a package containing unCOVERApp, a shiny graphical application for
clinical assessment of sequence coverage.
unCOVERApp allows:

* to display interactive plots showing sequence gene coverage down to base-pair
  resolution and functional/ clinical annotations of sequence
  positions within coverage gaps (`Coverage Analysis` page).
* to calculate the [maximum credible population allele frequency](http://cardiodb.org/allelefrequencyapp/) (AF) to be applied as AF
  filtering threshold tailored to the model of the disease-of-interest
  instead of a general AF cut-off (e.g. 1 % or 0.1 %)
  (`Calculate AF by allele frequency app` page).
* to calculate the 95 % probability of the binomial distribution to observe at
  least N variant-supporting reads (N is the number of successes) based on a
  user-defined allele fraction that is expected for the variant
  (which is the probability of success). Especially useful to obtain the
  range of variant-supporting reads that is most likely to occur at a given
  a depth of coverage (DoC)(which is the number of trials) for somatic variants with low allele fraction
  (`Binomial distribution`page).

# 2 Installation and example

Install the latest version of `uncoverappLib` using `BiocManager`.

`uncoverappLib` requires:

* R version >= 4.1.2
* java installed
* Annotation files for clinical assessment of low-coverage positions.

```
install.packages("BiocManager")
BiocManager::install("uncoverappLib")
library(uncoverappLib)
```

Alternatively, it can be installed from GitHub using:

```
#library(devtools)
#install_github("Manuelaio/uncoverappLib")
#library(uncoverappLib)
```

When users load `uncoverappLib` for the first time, the first thing to do is a
download of annotation files.
`getAnnotationFiles()` function allows to download the annotation files from [Zenodo](https://zenodo.org/record/3747448#.XpBmnVMzbOR) and parse it using
uncoverappLib package. The function does not return an R object but store the
annotation files in a cache (`sorted.bed.gz` and `sorted.bed.gz.tbi`) and show
the cache path.
The local cache is managed by the `BiocFileCache` **Bioconductor** package.
It is sufficient run the function `getAnnotationFiles(verbose= TRUE)` one time
after installing *uncoverappLib* package as shown below. The preprocessing time
can take few minutes, therefore during running vignette, users can provide `vignette= TRUE`
as a parameter to download an example annotation files, as below.

```
library(uncoverappLib)
#>
#>
#getAnnotationFiles(verbose= TRUE, vignette= TRUE)
```

The preprocessing time can take few minutes.

# 3 Input file

All unCOVERApp functionalities are based on the availability of a BED-style
formatted input file containing tab-separated specifications of genomic
coordinates (chromosome, start position, end position), the coverage value,
and the reference:alternate allele counts for each position. In the first
page **Preprocessing**, users can prepare the input file by specifying the genes
to be examined and the BAM file(s) to be inspected. Users should be able to
provide:

* a text file, with .txt extension, containing HGNC official gene name(s) one per
  row and to be uploaded to `Load input file` box. An example file is
  included in extdata of uncoverappLib packages

```
gene.list<- system.file("extdata", "mygene.txt", package = "uncoverappLib")
```

* a text file, with .list extension, containing absolute paths to BAM files
  (one per row) and to be uploaded to `Load bam file(s) list` box.

Type the following command to load our example:

```
bam_example <- system.file("extdata", "example_POLG.bam", package = "uncoverappLib")

print(bam_example)
#> [1] "/tmp/Rtmp4ootG1/Rinst3d3d8ed395d8a/uncoverappLib/extdata/example_POLG.bam"

write.table(bam_example, file= "./bam.list", quote= FALSE, row.names = FALSE,
            col.names = FALSE)
```

and launch `run.uncoverapp(where="browser")` command. After running `run.uncoverapp(where="browser")`
the shiny app appears in your deafult browser. RStudio user can define where
launching uncoverapp using `where` option:

* `browser` option will open `uncoverapp` in your default browser
* `viewer` option will open `uncoverapp` in RStudio viewer
* `window` option will open `uncoverapp` in RStudio RStudio

If option `where` is not defined uncoverapp will launch with default option of R.

In the first page **Preprocessing** users can load `mygene.txt` in
`Load input file` and `bam.list` in `Load bam file(s) list`.
In general, a target bed can also be used instead of genes name
selecting `Target Bed` option in `Choose the type of your input file`.
Users should also specify the reference genome in `Genome` box and the chromosome
notation of their BAM file(s) in `Chromosome Notation` box. In the BAM file,
the number option refers to 1, 2, …, X,.M chromosome notation, while the chr
option refers to chr1, chr2, … chrX, chrM chromosome notation.
Users can specify the `minimum mapping quality (MAPQ)` value in box and
`minimum base quality (QUAL)` value in box.
Default values for both mapping and
base qualities is 1. Users can download `Statistical_Summary` report
to obtain a coverage metrics per genes
(`List of genes name`) or per amplicons (`Target Bed`) according to uploaded input
file.
The report summarizes following information: mean, median,
number of positions under 20x and percentage of position above 20x.

To run the example, choose *chr* chromosome notation,
*hg19* genome reference and leave minimum mapping and base qualities to the
default settings, as shown in the following screenshot of the Preprocessing page:

![Screenshot of Preprocessing page.](data:image/png;base64...)

Figure 1: Screenshot of Preprocessing page

unCOVERApp input file generation fails if incorrect gene names are specified.
An unrecognized gene name(s) table is displayed if such a case occurs.
Below is a snippet of a the unCOVERApp input file generated as a result of
the **preprocessing** step performed for the example

```
chr15   89859516        89859516        68      A:68
chr15   89859517        89859517        70      T:70
chr15   89859518        89859518        73      A:2;G:71
chr15   89859519        89859519        73      A:73
chr15   89859520        89859520        74      C:74
chr15   89859521        89859521        75      C:1;T:74
```

The preprocessing time depends on the size of the BAM file(s) and on the number
of genes to investigate. In general, if many (e.g. > 50) genes are to be analyzed,
we would recommend to use `buildInput` function

Once pre-processing is done, users can move to the **Coverage Analysis** page
and push the `load prepared input file` button.

![Screenshot of Coverage Analysis page.](data:image/png;base64...)

Figure 2: Screenshot of Coverage Analysis page

To assess sequence coverage of the example, the following input parameters must
be specified in the sidebar of the **Coverage Analysis** section

* `Reference Genome` : reference genome (hg19 or hg38); choose hg19
* `Gene name` and push `Apply` button: write the HGNC official gene name *POLG*
* `Coverage threshold` : specify coverage threshold (e.g. 20x)
* `Sample` : sample name to be analyzed
* `Transcript number` : transcript number. Choose 1
* `exon number`: to zoom in a specific exon. Choose 10

Other input sections, as `Chromosome`, `Transcript ID`, `START genomic position`,
`END genomic position` and `Region coordinate`, are dynamically filled.

# 4 Output

unCOVERApp generates the following **outputs** :

* unfiltered BED file in `bed file` and the corresponding filtered dataset in
  `Low-coverage positions`
* information about POLG gene in `UCSC gene` table

![Screenshot of output of UCSC gene table.](data:image/png;base64...)

Figure 3: Screenshot of output of UCSC gene table

* information about POLG exons in
  `UCSC exons` table

![Screenshot of output of Exon genomic coordinate positions from UCSC table.](data:image/png;base64...)

Figure 4: Screenshot of output of Exon genomic coordinate positions from UCSC table

* sequence gene coverage plot in `Gene coverage` . The plot displays the
  chromosome ideogram, the genomic location and gene annotations from **Ensembl**
  and the transcript(s) annotation from UCSC. Processing time is few minutes. A
  related table shows the number of uncovered positions in each exon given a
  user-defined transcript number (here transcript number is 1), and the
  user-defined threshold coverage (here the coverage threshold is 20x).
  Table and plot both show the many genomic positions that display low-DoC profile
  in POLG.

![Screenshot of output of gene coverage.](data:image/png;base64...)

Figure 5: Screenshot of output of gene coverage

* plot of a specific exon, choose exon 10 in sidebar Exon number ,
  push `Make exon` and view the plot in `Exon coverage` .
  Processing time is few minutes.
  A related table shows the number of low-DoC positions in **ClinVar** which have
  a high impact annotation. For this output to be generated, **sorted.bed.gz**
  and **sorted.bed.gz.tbi** are required to be downloaded with
  `getAnnotationFiles()` function.
  Table and plot both show that 21 low-DoC genomic positions have ClinVar
  annotation, suggesting several clinically relevant positions that are not
  adequately represented in this experiment. It is possible zooming at base pair
  level choosing a few interval (20-30 bp) in `Region coordinates`
  and moving on `Zoom to sequence`.

![zoom of exon 10 ](data:image/png;base64...)

Figure 6: zoom of exon 10

* dbNSFP annotation of low coverage positions can be found in

![ Example of uncovered positions annotate with dbNSFP.](data:image/png;base64...)

Figure 7: Example of uncovered positions annotate with dbNSFP

By clicking on the `download` button, users can save the table as spreadsheet
format with certain cells colored according to pre-specified thresholds for AF,
CADD, MAP-CAP, SIFT, Polyphen2, ClinVar, OMIM ID, HGVSp and HGVSc, …).

In **Calculate maximum credible allele frequency** page, users can set
allele frequency cut-offs based on specific assumptions about the genetic
architecture of the disease. If not specified, variants with allele
frequency > 5 % will be instead filtered out. More details are available
[here](http://cardiodb.org/allelefrequencyapp/).
Moreover, users may click on the ”download” button and save the resulting
table as spreadsheet format.

The **Binomial distribution** page returns the 95 % binomial probability
distribution of the variant supporting reads on the input genomic position
(`Genomic position`).
Users should define the expected `allele fraction`
(the expected fraction of variant reads, probability of success)
and `Variant reads` (the minimum number of variant reads required by the user to
support variant calling, number of successes).
The comment color change according to binomial proportion intervals. If the
estimated intervals , with 95% confidence, is included or higher than user-defined
`Variant reads` the color of comment appears blue, otherwise if it is lower the
color appears red.

# 5 Session information

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
#> [1] uncoverappLib_1.20.0 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3
#>   [2] rstudioapi_0.17.1
#>   [3] jsonlite_2.0.0
#>   [4] magrittr_2.0.4
#>   [5] GenomicFeatures_1.62.0
#>   [6] farver_2.1.2
#>   [7] rmarkdown_2.30
#>   [8] BiocIO_1.20.0
#>   [9] vctrs_0.6.5
#>  [10] memoise_2.0.1
#>  [11] Rsamtools_2.26.0
#>  [12] RCurl_1.98-1.17
#>  [13] base64enc_0.1-3
#>  [14] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
#>  [15] htmltools_0.5.8.1
#>  [16] S4Arrays_1.10.0
#>  [17] Homo.sapiens_1.3.1
#>  [18] progress_1.2.3
#>  [19] curl_7.0.0
#>  [20] SparseArray_1.10.0
#>  [21] Formula_1.2-5
#>  [22] sass_0.4.10
#>  [23] bslib_0.9.0
#>  [24] htmlwidgets_1.6.4
#>  [25] Gviz_1.54.0
#>  [26] httr2_1.2.1
#>  [27] cachem_1.1.0
#>  [28] GenomicAlignments_1.46.0
#>  [29] mime_0.13
#>  [30] lifecycle_1.0.4
#>  [31] pkgconfig_2.0.3
#>  [32] Matrix_1.7-4
#>  [33] R6_2.6.1
#>  [34] fastmap_1.2.0
#>  [35] shiny_1.11.1
#>  [36] MatrixGenerics_1.22.0
#>  [37] digest_0.6.37
#>  [38] colorspace_2.1-2
#>  [39] shinycssloaders_1.1.0
#>  [40] ps_1.9.1
#>  [41] AnnotationDbi_1.72.0
#>  [42] S4Vectors_0.48.0
#>  [43] OrganismDbi_1.52.0
#>  [44] Hmisc_5.2-4
#>  [45] GenomicRanges_1.62.0
#>  [46] RSQLite_2.4.3
#>  [47] org.Hs.eg.db_3.22.0
#>  [48] filelock_1.0.3
#>  [49] condformat_0.10.1
#>  [50] httr_1.4.7
#>  [51] abind_1.4-8
#>  [52] compiler_4.5.1
#>  [53] bit64_4.6.0-1
#>  [54] htmlTable_2.4.3
#>  [55] S7_0.2.0
#>  [56] backports_1.5.0
#>  [57] BiocParallel_1.44.0
#>  [58] DBI_1.2.3
#>  [59] biomaRt_2.66.0
#>  [60] rappdirs_0.3.3
#>  [61] DelayedArray_0.36.0
#>  [62] rjson_0.2.23
#>  [63] tools_4.5.1
#>  [64] otel_0.2.0
#>  [65] foreign_0.8-90
#>  [66] httpuv_1.6.16
#>  [67] zip_2.3.3
#>  [68] nnet_7.3-20
#>  [69] glue_1.8.0
#>  [70] restfulr_0.0.16
#>  [71] promises_1.4.0
#>  [72] grid_4.5.1
#>  [73] checkmate_2.3.3
#>  [74] cluster_2.1.8.1
#>  [75] generics_0.1.4
#>  [76] gtable_0.3.6
#>  [77] BSgenome_1.78.0
#>  [78] shinyBS_0.61.1
#>  [79] ensembldb_2.34.0
#>  [80] data.table_1.17.8
#>  [81] hms_1.1.4
#>  [82] XVector_0.50.0
#>  [83] BiocGenerics_0.56.0
#>  [84] markdown_2.0
#>  [85] pillar_1.11.1
#>  [86] stringr_1.5.2
#>  [87] later_1.4.4
#>  [88] dplyr_1.1.4
#>  [89] BiocFileCache_3.0.0
#>  [90] lattice_0.22-7
#>  [91] rtracklayer_1.70.0
#>  [92] bit_4.6.0
#>  [93] deldir_2.0-4
#>  [94] EnsDb.Hsapiens.v75_2.99.0
#>  [95] biovizBase_1.58.0
#>  [96] tidyselect_1.2.1
#>  [97] RBGL_1.86.0
#>  [98] GO.db_3.22.0
#>  [99] Biostrings_2.78.0
#> [100] knitr_1.50
#> [101] gridExtra_2.3
#> [102] bookdown_0.45
#> [103] IRanges_2.44.0
#> [104] Seqinfo_1.0.0
#> [105] ProtGenerics_1.42.0
#> [106] SummarizedExperiment_1.40.0
#> [107] stats4_4.5.1
#> [108] xfun_0.53
#> [109] Biobase_2.70.0
#> [110] matrixStats_1.5.0
#> [111] DT_0.34.0
#> [112] stringi_1.8.7
#> [113] UCSC.utils_1.6.0
#> [114] EnsDb.Hsapiens.v86_2.99.0
#> [115] lazyeval_0.2.2
#> [116] yaml_2.3.10
#> [117] shinyWidgets_0.9.0
#> [118] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
#> [119] evaluate_1.0.5
#> [120] codetools_0.2-20
#> [121] cigarillo_1.0.0
#> [122] interp_1.1-6
#> [123] tibble_3.3.0
#> [124] BiocManager_1.30.26
#> [125] graph_1.88.0
#> [126] cli_3.6.5
#> [127] rpart_4.1.24
#> [128] xtable_1.8-4
#> [129] processx_3.8.6
#> [130] jquerylib_0.1.4
#> [131] dichromat_2.0-0.1
#> [132] Rcpp_1.1.0
#> [133] GenomeInfoDb_1.46.0
#> [134] dbplyr_2.5.1
#> [135] png_0.1-8
#> [136] XML_3.99-0.19
#> [137] parallel_4.5.1
#> [138] ggplot2_4.0.0
#> [139] blob_1.2.4
#> [140] prettyunits_1.2.0
#> [141] latticeExtra_0.6-31
#> [142] jpeg_0.1-11
#> [143] AnnotationFilter_1.34.0
#> [144] bitops_1.0-9
#> [145] rlist_0.4.6.2
#> [146] VariantAnnotation_1.56.0
#> [147] scales_1.4.0
#> [148] openxlsx_4.2.8
#> [149] crayon_1.5.3
#> [150] rlang_1.1.6
#> [151] KEGGREST_1.50.0
#> [152] shinyjs_2.1.0
```