# Using scifer to filter single-cell sorted B cell receptor (BCR) sanger sequences

Rodrigo Arcoverde Cerveira, Matthew James Hinchcliff1,2\*

1Division of Immunology & Allergy, Department of Medicine Solna, Karolinska Institutet and Karolinska University Hospital, Stockholm, Sweden
2Center for Molecular Medicine, Karolinska Institutet, Stockholm, Sweden

\*rodrigo.arcoverdi@gmail.com

#### 30 October 2025

#### Package

scifer 1.12.0

# Contents

* [0.1 Introduction](#introduction)
* [0.2 Dataset example and description](#dataset-example-and-description)
* [0.3 Folder organization](#folder-organization)
  + [0.3.1 Extra information](#extra-information)
* [0.4 Installation instructions](#installation-instructions)
* [0.5 Load required packages](#load-required-packages)
* [0.6 Checking flow cytometry data](#checking-flow-cytometry-data)
  + [0.6.1 Example 1](#example-1)
  + [0.6.2 Example 2](#example-2)
  + [0.6.3 Example 3](#example-3)
  + [0.6.4 Example 4](#example-4)
* [0.7 Sanger sequence dataset](#sanger-sequence-dataset)
  + [0.7.1 Processing a single B cell receptor sanger sequence](#processing-a-single-b-cell-receptor-sanger-sequence)
  + [0.7.2 Processing a group of B cell receptors sanger sequences](#processing-a-group-of-b-cell-receptors-sanger-sequences)
* [0.8 Joining flow cytometry and sanger sequencing datasets](#joining-flow-cytometry-and-sanger-sequencing-datasets)
* [0.9 IgBlast analysis for sequencing results](#igblast-analysis-for-sequencing-results)

## 0.1 Introduction

Have you ever index sorted cells in a 96 or 384-well plate and then sequenced using Sanger sequencing? If so, you probably had some struggles to either check the chromatogram of each cell sequenced manually or to identify which cell was sorted where after sequencing the plate. Scifer was developed to solve this issue by performing basic quality control of Sanger sequences and merging flow cytometry data from probed single-cell sorted B cells with sequencing data. Scifer can export summary tables, fasta files, chromatograms for visual inspection, and generate reports.

Single-cell sorting of probed B/T cells for Sanger sequencing of their receptors is widely used, either for identifying antigen-specific antibody sequences or studying antigen-specific B and T cell responses. For this reason, scifer R package was developed to facilitate the integration and QC of flow cytometry data and sanger sequencing.

## 0.2 Dataset example and description

This vignette aims to show one example of how to process your own samples based on a test dataset. This dataset contains raw flow cytometry index files (file extension: `.fcs`) and raw sanger sequences (file extension: `.ab1`). These samples are of antigen-specific B cells that were probed and single-cell sorted in a plate to have their B cell receptors (BCR) sequenced through sanger sequencing. This package can also be used for T cell receptors but you should have extra attention selecting the QC parameters according to your intended sequence. The sorted cells had their RNA reverse transcribed into cDNA and PCR amplified using a set of primer specific for rhesus macaques (sample origin), the resulting PCR products were sequenced using an IgG specific primer designed to capture the entire VDJ fragment of the BCRs.

## 0.3 Folder organization

Regardless of where is your data, you should have two folders, one for flow cytometry data and a second one for sanger sequences. The nomenclature of the `.fcs` files and the sanger sequence subfolders should be matching, this is fundamental for merging both datasets.

### 0.3.1 Extra information

If you want to have a more detailed explanation of installation steps and folder organization, check the README file in the [package github here.](https://github.com/rodrigarc/scifer)

## 0.4 Installation instructions

Get the latest stable `R` release from [CRAN](http://cran.r-project.org/). Then install `scifer` using from [Bioconductor](http://bioconductor.org/) the following code:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("scifer")
```

## 0.5 Load required packages

```
library(ggplot2)
library(scifer)
```

## 0.6 Checking flow cytometry data

It is important to check your flow data to check how is your data being processed, if it is already compensated, and if the cells were probed which thresholds you should use.

### 0.6.1 Example 1

Here is an example of a poor threshold using the forward and side scatter (cell size and granularity).

```
fcs_data <- fcs_processing(
    folder_path = system.file("/extdata/fcs_index_sorting", package = "scifer"),
    compensation = FALSE, plate_wells = 96,
    probe1 = "FSC.A", probe2 = "SSC.A",
    posvalue_probe1 = 600, posvalue_probe2 = 400
)

fcs_plot(fcs_data)
```

![](data:image/png;base64...)

You can play around with the threshold and the different channels available. You can check the name of each channel using this:

```
colnames(fcs_data)
#> NULL
```

You can see that the well position was already extracted from the file and a column named `specificity` was added. This specificity is named based on your selected channels and their thresholds.

### 0.6.2 Example 2

If you did not probe your cells for a specific antigen, you can just use the following and ignore the `specificity` column. This approach will add all of your cells, regardless of the detected fluorescence in a channel.

```
fcs_data <- fcs_processing(
    folder_path = system.file("/extdata/fcs_index_sorting", package = "scifer"),
    compensation = FALSE, plate_wells = 96,
    probe1 = "FSC.A", probe2 = "SSC.A",
    posvalue_probe1 = 0, posvalue_probe2 = 0
)

fcs_plot(fcs_data)
```

![](data:image/png;base64...)

### 0.6.3 Example 3

If you have probed your cells based on a specific marker, you can use the name of the channel or the custom name you have added during the sorting to that channel.

```
fcs_data <- fcs_processing(
    folder_path = system.file("/extdata/fcs_index_sorting", package = "scifer"),
    compensation = FALSE, plate_wells = 96,
    probe1 = "Pre.F", probe2 = "Post.F",
    posvalue_probe1 = 600, posvalue_probe2 = 400
)

fcs_plot(fcs_data)
```

![](data:image/png;base64...)

### 0.6.4 Example 4

Finally, the above data used compensation as set to `FALSE`, which is not usually the case since you probably have compensated your samples before sorting. You can set it to `TRUE` and the compensation matrix within the index files will be already automatically applied.

```
fcs_data <- fcs_processing(
    folder_path = system.file("/extdata/fcs_index_sorting", package = "scifer"),
    compensation = TRUE, plate_wells = 96,
    probe1 = "Pre.F", probe2 = "Post.F",
    posvalue_probe1 = 600, posvalue_probe2 = 400
)

fcs_plot(fcs_data)
```

![](data:image/png;base64...)

The `specificity` column uses these thresholds to name your sorted cells. In this example, you would have a `Pre.F` single-positive, `Post.F` single-positive, double-positive cells named as`DP`, and double-negative cells named as `DN`.

```
unique(fcs_data$specificity)
#> NULL
```

## 0.7 Sanger sequence dataset

### 0.7.1 Processing a single B cell receptor sanger sequence

Here is just an example of if you would like to process a single sanger sequence

```
## Read abif using sangerseqR package
abi_seq <- sangerseqR::read.abif(
    system.file("/extdata/sorted_sangerseq/E18_C1/A1_3_IgG_Inner.ab1",
        package = "scifer"
    )
)
## Summarise using summarise_abi_file()
summarised <- summarise_abi_file(abi_seq)
head(summarised[["summary"]])
#>              raw.length          trimmed.length              trim.start
#>                     465                       0                       0
#>             trim.finish     raw.secondary.peaks trimmed.secondary.peaks
#>                       0                     347                       0
head(summarised[["quality_score"]])
#>   score position
#> 1    25        1
#> 2     7        2
#> 3     6        3
#> 4     3        4
#> 5     2        5
#> 6     5        6
```

### 0.7.2 Processing a group of B cell receptors sanger sequences

Most of the time, if you have sequenced an entire plate, you want to automate this processing. Here you would process recursively all the `.ab1` files within the chosen folder.

\*Note: To speed up, you can increase the `processors` parameter depending on your local computer’s number of processors or set it to `NULL` which will try to detect the max number of cores.

```
sf <- summarise_quality(
    folder_sequences = system.file("extdata/sorted_sangerseq", package = "scifer"),
    secondary.peak.ratio = 0.33, trim.cutoff = 0.01, processor = 1
)
#> Looking for .ab1 files...
#> Found 5 .ab1 files...
#> Loading reads...
#> Calculating read summaries...
#> Cleaning up
```

Here are the columns from the summarised `data.frame`:

```
## Print names of all the variables
colnames(sf[["summaries"]])
#>  [1] "file.path"               "folder.name"
#>  [3] "file.name"               "raw.length"
#>  [5] "trimmed.length"          "trim.start"
#>  [7] "trim.finish"             "raw.secondary.peaks"
#>  [9] "trimmed.secondary.peaks" "raw.mean.quality"
#> [11] "trimmed.mean.quality"    "raw.min.quality"
#> [13] "trimmed.min.quality"
```

Here is the example `data.frame` with the summarised results of all the files within the selected path:

```
## Print table
head(sf[["summaries"]][4:10])
#>   raw.length trimmed.length trim.start trim.finish raw.secondary.peaks
#> 1        464            153         68         220                 342
#> 2        465            256          1         256                 347
#> 3        450            190         21         210                 300
#> 4        466            249         24         272                 141
#> 5        458            428         14         441                   7
#>   trimmed.secondary.peaks raw.mean.quality
#> 1                     114         12.34698
#> 2                     187         13.17345
#> 3                     116         14.56889
#> 4                      57         23.45299
#> 5                       1         52.35153
```

## 0.8 Joining flow cytometry and sanger sequencing datasets

Finally, the function you will use to integrate both datasets and export data from `scifer` is `quality_report()`. This function aims to basically merge the two datasets, assign sorting specificity based on the selected thresholds for each channel/probe and write different files.

This function generated the following files:

* general quality report (.html)
* individualized report per ID (.html)
* table containing the good quality sequences filtered in and their QC summary (.csv)
* fasta file containing all the sequences (.fasta)
* fasta files per ID (.fasta)
* Chromatogram of the approximate CDR3 region if secondary peaks are detected (.pdf)

```
quality_report(
    folder_sequences = system.file("extdata/sorted_sangerseq", package = "scifer"),
    outputfile = "QC_report.html", output_dir = "~/full/path/to/your/location",
    folder_path_fcs = system.file("extdata/fcs_index_sorting",
        package = "scifer"
    ),
    probe1 = "Pre.F", probe2 = "Post.F",
    posvalue_probe1 = 600, posvalue_probe2 = 400
)
```

## 0.9 IgBlast analysis for sequencing results

The `igblast()` function will generate a data frame with the IgBlast results for each sequence.

Before running IgBlast, select the database to be downloaded (e.g., [ORGDB](https://ogrdb.airr-community.org/), [IMGT](https://www.imgt.org/genedb/) , [KIMDB](http://kimdb.gkhlab.se/) and adjust it accordingly. As shown in the example below:

KIMDB\_rm/
├── V.fasta
├── D.fasta
├── J.fasta

The database argument is the path to the preferred database for species and receptor type. The database folder should contain separate `.fasta` files corresponding to the genes associated with each receptor type, e.g., `V`-, `D`-, and `J.fasta` files for BCR/TCR. The quality report creates a `sequences.fasta` file found in the `output_dir`. The path to this file should be used as the path input for the `fasta` argument in the `igblast()` function and the path to the database folder.

Scifer has included the KIMDB database for rhesus macaques, which is used for testing the functions.

As shown here:

```
ighv_res <- igblast(
        database = system.file("/extdata/test_fasta/KIMDB_rm", package = "scifer"),
        fasta = system.file("/extdata/test_fasta/test_igblast.txt", package = "scifer"),
        threads = 1 #For parallel processing. Default = 1
)
#> Running command: /home/biocbuild/.cache/R/biocconda/24.11.3-0/bin/conda run --prefix /home/biocbuild/.cache/R/scifer/igblast_wrap_basilisk/1.0.0 python /tmp/RtmpTxxL5o/Rinst2f32185c061590/scifer/script/igblastwrap.py --threads 1 --database /tmp/RtmpTxxL5o/Rinst2f32185c061590/scifer//extdata/test_fasta/KIMDB_rm --fasta /tmp/RtmpTxxL5o/Rinst2f32185c061590/scifer//extdata/test_fasta/test_igblast.txt

head(ighv_res, 2)
#>   sequence_id
#> 1       test1
#> 2       test2
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                             sequence
#> 1   ACCCGGGGGGCTGCAGACATAGGGAGGTGCTCTTGGGAGGGGGCCCCGGGGGGAAGCCAAAAGGGCCCTTTGGTGAAGGGGGGAAAAAAAGACCAGGACCCCCGGGGCCCAAGAAAAAAAGCGGACCTTCTGCCTCAACTTTTTCAAAATCTTTGCTGACGGGTGGCCTCTACTCAGGCCATGTGTTTGAGAAAGTCGAAGATGGTTTTTGTTTTCGGGGGGGAGACTGTAGCTGCGCAATTTCAAATCTGGACACAATGAGTTTTCCCACTAGGATTATACTTAAAACCCACCTATACCCCCTCCCCTGCAGCCTGTTGGACTACCTTTTAGTAAAAATTACTCAGGCTAAAACCGCAGATGCTAAGGAAAGGACTCACGAACACCCAGACTTTCGGACCCTGCCCCCCTAATACACCTCCTTCGGACCATAAAATTGAACACCTCTAAAGGGAAGCAGAAGA
#> 2 CCGAAGGGTTTTTTCCTAGTTGCATCAGCAGCATTTGTCCCCAGGAAGGGGAGGCTTTCAGCGACCCGTTGCGAAAATCTTTCGGTGTCAGGAGCCTCCATCAGCGGTGGTTAATATTTCCATGGATTCAGTCAGTTTCAAGGAAAATGCTCCAGCCCCCAGGGAGGTGTATGGTATTAATGTAGCATCTTTTACAGGAATGCAGCAAGAATCGAAAACCCGTTCTTAAAGATCATTCAACATGCACATCAACCAGTACCAAGACCGACTTTTCCAGGTGGACACGGCCGTCCAGTCCGATAACATACAAGTAGTCAGTGGTGTAAGAGGCTCACGGACGACGGATTCGATGGTGGGGCCAGGGGGTTCTGGTTACCGTTTCCTCCGCCCCCAACAAGGGTCCATCGGGCTTCCCCCCGGGGGTTGCCTCCCAGGGGAACTTCCATGCATCCCCACCTCTCCGTTT
#>                                                                                                                                             sequence_aa
#> 1                                                                    GGRL*LRNFKSGHNEFSH*DYT*NPPIPPPLQPVGLPFSKNYSG*NRRC*GKDSRTPRLSDPAPLIHLLRTIKLNTSKGKQK
#> 2 LHQQHLSPGRGGFQRPVAKIFRCQEPPSAVVNISMDSVSFKENAPAPREVYGINVASFTGMQQESKTRS*RSFNMHINQYQDRLFQVDTAVQSDNIQVVSGVRGSRTTDSMVGPGGSGYRFLRPQQGSIGLPPGGCLPGELPCIPTSPF
#>   locus stop_codon vj_in_frame v_frameshift productive rev_comp complete_vdj
#> 1   IGK       TRUE          NA           NA      FALSE    FALSE        FALSE
#> 2   IGH      FALSE          NA           NA         NA     TRUE        FALSE
#>   d_frame               v_call      d_call     j_call
#> 1      NA IGHV3-NL_12*02_S5864               IGHJ2*01
#> 2      NA IGHV4-NL_22*01_S5234 IGHD5-27*01 IGHJ4-3*01
#>                                                                                                                                       sequence_alignment
#> 1                                                                     GCTCTTGGGAGGGGGCCCCGGGGGGAAGCCAAAAGGGCCCTTTGGTGAAGGGGGGAAAAAAAGACCAGGACCCCCGGGGCCC
#> 2 AGTTGCATCAGCAGCATTTGTCCCCAGGAAGGG-GAGGCTTTCAGCGACCCGTTGCGAAAATCTTTCGGTGTCAGGAGCCTCCATCAGCGGTGGTTAATATTTCCATGGATTCAGTCAGTTTCAAGGAAAATGCTCCAGCCCCCAGGGAG
#>                                                                                                                                       germline_alignment
#> 1                                                                     GCTCCAGGGAGGGGGCCGGAGTGGGTAGNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNGGGGCCC
#> 2 AGGTGCAGCTGCAGGAGTCGGGCCCAGGACTGGTGAAGCCTTCAGAGACCCTGTCCCTCACCTGCGCTGTCTCTGGTGGCTCCATCAGCGGTGGTTANNNNNNNNNTGGATACAGTNNNNNNNNNNNNNNNNNNNNNNNNNNCCAGGGAG
#>                               sequence_alignment_aa
#> 1                       SWEGAPGGSQKGPLVKGGKKDQDPRGP
#> 2 LHQQHLSPGRGGFQRPVAKIFRCQEPPSAVVNISMDSVSFKENAPAPRE
#>                               germline_alignment_aa v_alignment_start
#> 1                       SREGAGVGXXXXXXXXXXXXXXXXXGP                 1
#> 2 VQLQESGPGLVKPSETLSLTCAVSGGSISGGXXXXGYSXXXXXXXXXQG                 1
#>   v_alignment_end d_alignment_start d_alignment_end j_alignment_start
#> 1              28                NA              NA                76
#> 2              97               107             116               143
#>   j_alignment_end
#> 1              82
#> 2             150
#>                                                                                v_sequence_alignment
#> 1                                                                      GCTCTTGGGAGGGGGCCCCGGGGGGAAG
#> 2 AGTTGCATCAGCAGCATTTGTCCCCAGGAAGGG-GAGGCTTTCAGCGACCCGTTGCGAAAATCTTTCGGTGTCAGGAGCCTCCATCAGCGGTGGTTA
#>           v_sequence_alignment_aa
#> 1                        SWEGAPGG
#> 2 LHQQHLSPGRGGFQRPVAKIFRCQEPPSAVV
#>                                                                                v_germline_alignment
#> 1                                                                      GCTCCAGGGAGGGGGCCGGAGTGGGTAG
#> 2 AGGTGCAGCTGCAGGAGTCGGGCCCAGGACTGGTGAAGCCTTCAGAGACCCTGTCCCTCACCTGCGCTGTCTCTGGTGGCTCCATCAGCGGTGGTTA
#>           v_germline_alignment_aa d_sequence_alignment d_sequence_alignment_aa
#> 1                        SREGAGVG
#> 2 VQLQESGPGLVKPSETLSLTCAVSGGSISGG           TGGATTCAGT                     DSV
#>   d_germline_alignment d_germline_alignment_aa j_sequence_alignment
#> 1                                                           GGGGCCC
#> 2           TGGATACAGT                     DTV             CCAGGGAG
#>   j_sequence_alignment_aa j_germline_alignment j_germline_alignment_aa
#> 1                      GP              GGGGCCC                      GP
#> 2                      RE             CCAGGGAG                      RE
#>                                                                        fwr1
#> 1
#> 2 AGTTGCATCAGCAGCATTTGTCCCCAGGAAGGGGAGGCTTTCAGCGACCCGTTGCGAAAATCTTTCGGTGTCA
#>                    fwr1_aa                    cdr1 cdr1_aa fwr2 fwr2_aa cdr2
#> 1                                                            NA      NA   NA
#> 2 LHQQHLSPGRGGFQRPVAKIFRCQ GGAGCCTCCATCAGCGGTGGTTA EPPSAVV   NA      NA   NA
#>   cdr2_aa fwr3 fwr3_aa fwr4 fwr4_aa cdr3 cdr3_aa junction junction_length
#> 1      NA   NA      NA   NA      NA   NA      NA       NA              NA
#> 2      NA   NA      NA   NA      NA   NA      NA       NA              NA
#>   junction_aa junction_aa_length v_score d_score j_score               v_cigar
#> 1          NA                 NA  23.650      NA  14.146    28S117N28M408S157N
#> 2          NA                 NA  50.138  14.146  16.069 17S1N33M1D63M353S201N
#>            d_cigar          j_cigar v_support d_support j_support v_identity
#> 1                  103S20N7M354S26N 6.874e+00        NA    14.470     75.000
#> 2 122S1N10M334S12N 158S19N8M300S21N 7.337e-08     19.89     3.834     68.041
#>   d_identity j_identity v_sequence_start v_sequence_end v_germline_start
#> 1         NA        100               29             56              118
#> 2         90        100               18            113                2
#>   v_germline_end d_sequence_start d_sequence_end d_germline_start
#> 1            145               NA             NA               NA
#> 2             98              123            132                2
#>   d_germline_end j_sequence_start j_sequence_end j_germline_start
#> 1             NA              104            110               21
#> 2             11              159            166               20
#>   j_germline_end fwr1_start fwr1_end cdr1_start cdr1_end fwr2_start fwr2_end
#> 1             27         NA       NA         NA       NA         NA       NA
#> 2             27         18       90         91      113         NA       NA
#>   cdr2_start cdr2_end fwr3_start fwr3_end fwr4_start fwr4_end cdr3_start
#> 1         NA       NA         NA       NA         NA       NA         NA
#> 2         NA       NA         NA       NA         NA       NA         NA
#>   cdr3_end                                             np1 np1_length
#> 1       NA CCAAAAGGGCCCTTTGGTGAAGGGGGGAAAAAAAGACCAGGACCCCC         47
#> 2       NA                                       ATATTTCCA          9
#>                          np2 np2_length
#> 1                                    NA
#> 2 CAGTTTCAAGGAAAATGCTCCAGCCC         26
```

```
sessionInfo()
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
#> [1] scifer_1.12.0    ggplot2_4.0.0    BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyselect_1.2.1      viridisLite_0.4.2     dplyr_1.1.4
#>  [4] farver_2.1.2          filelock_1.0.3        Biostrings_2.78.0
#>  [7] S7_0.2.0              fastmap_1.2.0         promises_1.4.0
#> [10] digest_0.6.37         mime_0.13             lifecycle_1.0.4
#> [13] pwalign_1.6.0         magrittr_2.0.4        compiler_4.5.1
#> [16] rlang_1.1.6           sass_0.4.10           tools_4.5.1
#> [19] yaml_2.3.10           data.table_1.17.8     knitr_1.50
#> [22] reticulate_1.44.0     here_1.0.2            plyr_1.8.9
#> [25] xml2_1.4.1            RColorBrewer_1.1-3    withr_3.0.2
#> [28] RProtoBufLib_2.22.0   BiocGenerics_0.56.0   grid_4.5.1
#> [31] stats4_4.5.1          xtable_1.8-4          MASS_7.3-65
#> [34] scales_1.4.0          isoband_0.2.7         dichromat_2.0-0.1
#> [37] cli_3.6.5             rmarkdown_2.30        crayon_1.5.3
#> [40] generics_0.1.4        otel_0.2.0            rstudioapi_0.17.1
#> [43] DBI_1.2.3             cachem_1.1.0          flowCore_2.22.0
#> [46] stringr_1.5.2         parallel_4.5.1        BiocManager_1.30.26
#> [49] XVector_0.50.0        matrixStats_1.5.0     basilisk_1.22.0
#> [52] vctrs_0.6.5           Matrix_1.7-4          jsonlite_2.0.0
#> [55] dir.expiry_1.18.0     cytolib_2.22.0        bookdown_0.45
#> [58] IRanges_2.44.0        S4Vectors_0.48.0      systemfonts_1.3.1
#> [61] jquerylib_0.1.4       glue_1.8.0            sangerseqR_1.46.0
#> [64] stringi_1.8.7         gtable_0.3.6          later_1.4.4
#> [67] tibble_3.3.0          pillar_1.11.1         basilisk.utils_1.22.0
#> [70] htmltools_0.5.8.1     Seqinfo_1.0.0         R6_2.6.1
#> [73] textshaping_1.0.4     rprojroot_2.1.1       evaluate_1.0.5
#> [76] kableExtra_1.4.0      shiny_1.11.1          lattice_0.22-7
#> [79] Biobase_2.70.0        png_0.1-8             DECIPHER_3.6.0
#> [82] httpuv_1.6.16         bslib_0.9.0           Rcpp_1.1.0
#> [85] svglite_2.2.2         gridExtra_2.3         xfun_0.53
#> [88] pkgconfig_2.0.3
```