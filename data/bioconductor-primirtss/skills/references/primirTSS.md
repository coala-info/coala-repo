# primirTSS

## 1 Introduction

Identifying human miRNA transcriptional start sites (TSSs) plays a significant role in understanding the transcriptional regulation of miRNA. However, due to the quick capping of pri-miRNA and many miRNA genes may lie in the introns or even exons of other genes, it is difficult to detect miRNA TSSs. miRNA TSSs are cell-specific. And miRNA TSSs are cell-specific, which implies the same miRNA in different cell-lines may start transcribing at different TSSs.

High throughput sequencing, like ChIP-seq, has gradually become an essential and versatile approach for us to identify and understand genomes and their transcriptional processes. By integrating H3k4me4 and Pol II data, parting of false positive counts after scoring can be filtered out. Besides, DNase I hypersensitive sites(DHS) also imply TSSs, where miRNAs will be accessible and functionally related to transcription activities. And additionally, the expression profile of miRNA and genes in certain cell-line will be considered as well to improve fidelity. By employing all these different kinds of data, here we have developed the primirTSS package to assist users to identify miRNA TSSs in human and to provide them with related information about where miRNA genes lie in the genome, with both command-line and graphical interfaces.

## 2 Find the best putative TSS

### Installation

#### 1 primirTSS

Install the latest release of R, then get `primirTSS` by starting R and entering the commands:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("primirTSS")
```

Or install the development version of the package using the same command, but with GitHub account name.

```
BiocManager::install("ipumin/primirTSS")
```

#### 2 Install Java SE Development Kit(JDK)

As Java development environment is indispensable for the primary function in our package, it is necessary for users to install [Java SE Development Kit 10](http://www.oracle.com/technetwork/java/javase/downloads/jdk10-downloads-4416644.html) before using `primirTSS`.

#### 3 Load the package into R session

```
library(primirTSS)
#> Warning: replacing previous import 'BiocGenerics::setequal' by
#> 'dplyr::setequal' when loading 'primirTSS'
#> Warning: replacing previous import 'utils::findMatches' by
#> 'S4Vectors::findMatches' when loading 'phastCons100way.UCSC.hg38'
```

## 3 Getting Started

### Step 1: Process of H3K4me3 and Pol II data

* `peak_merge()`: **Merge one kind of peaks** (H3K4me3 **or** Pol II)

**H3K4me3** and **Pol II** data are key points for accurate prediction with our method. If one of these two peak data is input, before executing the main function `find_TSS`, the function `peak_merge` should be used to merge adjacent peaks whose distance between each other is less than `n` base pairs and return the merged peaks as an output.

```
library(primirTSS)
peak_df <- data.frame(chrom = c("chr1", "chr2", "chr1"),
                       chromStart = c(450, 460, 680),
                       chromEnd = c(470, 480, 710),
                       stringsAsFactors = FALSE)
peak <-  as(peak_df, "GRanges")
peak_merge(peak, n =250)
#> GRanges object with 2 ranges and 0 metadata columns:
#>       seqnames    ranges strand
#>          <Rle> <IRanges>  <Rle>
#>   [1]     chr1   450-710      *
#>   [2]     chr2   460-480      *
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

* `peak_join()`: **Join two kinds of peaks** (H3K4me3 **and** Pol II)

If both of H3K4me3 and Pol II data, after separately merging these two kinds of evidence first, `peak_join` should be employed to integrate H3K4me3 and Pol II peaks and return the result as `bed_merged` parameter for the main function `find_tss`.

```
peak_df1 <- data.frame(chrom = c("chr1", "chr1", "chr1", "chr2"),
                       start = c(100, 460, 600, 70),
                       end = c(200, 500, 630, 100),
                       stringsAsFactors = FALSE)
peak1 <-  as(peak_df1, "GRanges")

peak_df2 <- data.frame(chrom = c("chr1", "chr1", "chr1", "chr2"),
                       start = c(160, 470, 640, 71),
                       end = c(210, 480, 700, 90),
                       stringsAsFactors = FALSE)
peak2 <-  as(peak_df2, "GRanges")

peak_join(peak1, peak2)
#> GRanges object with 3 ranges and 0 metadata columns:
#>       seqnames    ranges strand
#>          <Rle> <IRanges>  <Rle>
#>   [1]     chr1   160-200      *
#>   [2]     chr1   470-480      *
#>   [3]     chr2     71-90      *
#>   -------
#>   seqinfo: 2 sequences from an unspecified genome; no seqlengths
```

### Step 2: Predict most possible TSS for miRNA

* `find_tss` is the primary function in the package. The program will first score the candidate TSSs of miRNA and pick up the best candidate in the first step of prediction, (where users can set `flanking_num` and `threshold`).
* After the first step, H3K4me3 and Pol II data, miRNA expression profiles and DHS check, protein-coding genes expression profiles, if provided, will be integrated to decrease the rate of false positive.

There will be different circumstances where not all miRNA expression profiles, DHS data, protein-coding gene(‘gene’) expression profiles are available:

**Circumstance 1:** no miRNA expression data; then suggest DHS check and protein-coding gene check.

* `ignore_DHS_check`: If users do not have their own miRNA expression profile, the function will employ all the miRNAs already annotated in human, but we suggest using DHS data of the cell line from **ENCODE** to check whether this miRNA is expressed in the cell line or not as well as and all human gene expression profiles from **Ensemble** to check the relative position of TSSs and protein-coding genes to improve the accuracy of prediction.

```
peakfile <- system.file("testdata", "HMEC_h3.csv", package = "primirTSS")
DHSfile <- system.file("testdata", "HMEC_DHS.csv", package = "primirTSS")
peak_h3 <- read.csv(peakfile, stringsAsFactors = FALSE)
DHS <- read.csv(DHSfile, stringsAsFactors = FALSE)
DHS <- as(DHS, "GRanges")
peak_h3 <-  as(peak_h3, "GRanges")
peak <- peak_merge(peak_h3)
```

```
no_ownmiRNA <- find_tss(peak, ignore_DHS_check = FALSE,
                        DHS = DHS, allmirdhs_byforce = FALSE,
                        expressed_gene = "all",
                        allmirgene_byforce = FALSE,
                        seek_tf = FALSE)
```

**Circumstance 2**: miRNA expression data provided; then no need for DHS check but protein-coding gene check.

* `expressed_mir`: If users have their own miRNA expression profiles, we will use the expressed miRNAs and we suggest not using DHS data of the cell line or others to check the expression of miRNAs.But the protein-coding gene check to check the relative position of TSSs and protein-coding genes is necessary, which helps to verify the precision of prediction.

```
bed_merged <- data.frame(
                chrom = c("chr1", "chr1", "chr1", "chr1", "chr2"),
                start = c(9910686, 9942202, 9996940, 10032962, 9830615),
                end = c(9911113, 9944469, 9998065, 10035458, 9917994),
                stringsAsFactors = FALSE)
bed_merged <- as(bed_merged, "GRanges")

expressed_mir <- c("hsa-mir-5697")

ownmiRNA <- find_tss(bed_merged, expressed_mir = expressed_mir,
                     ignore_DHS_check = TRUE,
                     expressed_gene = "all",
                     allmirgene_byforce = TRUE,
                     seek_tf = FALSE)
```

* `expressed_gene`: Additionally, users can also specify certain genes expressed in the cell-line being analyzed:

### Step 3: Searching for TFs

* `seek_tf = TRUE`: If user want to predict transcriptional regulation relationship between TF and miRNA, like which TFs might regulate miRNA after get TSSs, they can change `seek_tf = FALSE` from `seek_tf = TRUE` directly in the comprehensive function `find_TSS()`.

### Step4: Analysis of results

Here is a demo of predicting TSS for hsa-mir-5697, ignore DHS check.

**PART1**, `$tss_df`:

```
ownmiRNA$tss_df
#> # A tibble: 1 × 10
#>   mir_name     chrom stem_loop_p1 stem_loop_p2 strand mir_context tss_type gene
#>   <chr>        <chr>        <dbl>        <dbl> <chr>  <chr>       <chr>    <chr>
#> 1 hsa-mir-5697 chr1       9967381      9967458 +      intra       host_TSS ENSG…
#> # ℹ 2 more variables: predicted_tss <dbl>, pri_tss_distance <dbl>
```

The first part of the result returns details of predicted TSSs, composed of seven columns: *mir\_name, chrom, stem\_loop\_p1, stem\_loop\_p2, strand mir\_context, tss\_type gene* and *predicted\_tss*:

| Entry | Implication |
| --- | --- |
| **mir\_name** | Name of miRNA. |
| **chrom** | Chromosome. |
| **stem\_loop\_p1** | The start site of a stem-loop. |
| **stem\_loop\_p2** | The end site of a stem-loop. |
| **strand** | Polynucleotide strands. (`+/-`) |
| **mir\_context** | 2 types of relative position relationship between stem-loop and protein-coding gene. (`intra/inter`) |
| **tss\_type** | 4 types of predicted TSSs. See the section below TSS types for details.(`host_TSS/intra_TSS/overlap_inter_TSS/inter_TSS`) |
| **gene** | Ensembl gene ID. |
| **predicted\_tss** | Predicted transcription start sites(TSSs). |
| **pri\_tss\_distance** | The distance between a predicted TSS and the start site of the stem-loop. |

TSSs are cataloged into 4 types as below:

* **host\_TSS**: The TSSs of miRNA that are close to the TSS of protein-coding gene implying they may share the same TSS, on the condition where `mir_context = intra`. (See above: `mir_context`)
* **intra\_TSS:** The TSSs of miRNA that are NOT close to the TSS of protein-coding gene, on the condition where `mir_context = intra`.
* **overlap\_inter\_TSS:** The TSSs of miRNA are cataloged as `overlap_inter_TSS` when the pri-miRNA gene overlaps with Ensembl gene, on the condition where “`mir_context = inter`”.
* **inter\_inter\_TSS:** The TSSs of miRNA are cataloged as `inter_inter_TSS` when the miRNA gene does NOT overlap with Ensembl gene, on the condition where “`mir_context = inter`”.

(See [Xu HUA et al](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btw171) 2016 for more details)

**PART2**, `$log`:

The second part of the result returns **4 logs** created during the process of prediction:

* **`find_nearest_peak_log`**: If no peaks locate in the upstream of a stem-loop to help determine putative TSSs of miRNA, we will fail to find the nearest peak, and this miRNA will be logged in `find_nearest_peak_log`.
* **`eponine_score_log`**: For a certain miRNA, if none of the candidate TSSs scored with Eponine method meet the threshold we set, we will fail to get an eponine score, and this miRNA will be logged in `eponine_score_log`.
* **`DHS_check_log`**: For a certain miRNA, if no DHS signals locate within 1 kb upstream of each putative TSSs, these putative TSSs will be filtered out, and this miRNA will be logged in `DHS_check_log`.
* **`gene_filter_log`**: For a certain miRNA, when integrating expressed\_gene data to improve prediction, if no putative TSSs are confirmed after considering the relative position relationship among TSSs, stem-loops and expressed genes, this miRNA will be filtered out and logged in `gene_filter_log`.

## 4 Plot the prediction of TSS for miRNA

* `plot_primiRNA()`: Apart from returning the putative TSS of each miRNA, the package `primirTSS` can also visualize the result and return an image composed of six tracks, (1)TSS, (2)genome, (3)pri-miRNA, (4)the closest gene, (5)eponine score and (6)conservation score. And the parameters in this function is almost the same as those in `find_tss()` except `expressed_mir` only represents one certain miRNA in `plot_primiRNA()`. **NOTICE** that this function is used for visualizing the TSS prediction of **only one** specific miRNA every single time.

```
plot_primiRNA(expressed_mir, bed_merged,
              flanking_num = 1000, threshold = 0.7,
              ignore_DHS_check = TRUE,
              DHS, allmirdhs_byforce = TRUE,
              expressed_gene = "all",
              allmirgene_byforce = TRUE)
```

![plot_tss](data:image/jpeg;base64...) 　 　Figure S1. ***Visualized result for miRNA TSSs by `Plot pri-miRNA TSS()`***

> As Figure S1 shows, the picture contains information of the pri-miRNA’s coordinate, the closest gene to the miRNA, the eponine score of the miRNA’s candidate TSS and the conservation score of the miRNA’s candidate TSS. There are six tracks plotted in return:
>
> | Entry | Implication |
> | --- | --- |
> | **Chromosome** | Position of miRNA on the chromosome. |
> | **hg19** | Reference genome coordinate in hg19. |
> | **pri-miRNA**: | Position of pri-miRNA. |
> | **Ensemble genes** | Position of related protein-coding gene. |
> | **Eponine score** | Score of best putative TSS by Eponine method. |
> | **Conservation score** | Conservation score of TSS. |

## 5 Graphical web interface for prediction

* `run_primirTSSapp()`: A graphical web interface is designed to achieve the functions of `find_tss` and `plot_primiRNA` to help users intuitively and conveniently predict putative TSSs of miRNA. Users can refer documents of the two functions, **Find the best putative TSS** and **Plot the prediction of TSSs for miRNA**, mentioned above for details.

### TAG1: Find the best putative TSS

![shiny_tss](data:image/jpeg;base64...) 　Figure S2. ***Graphical web interface of `Find pri-miRNA TSS()`***

> As Figure S2 shows, if we want to use the shiny app, we should select the appropriate options or upload the appropriate files. Histone peaks, Pol II peaks and DHS files are comma-separated values (CSV) files, whose first line is chrom,start,end. Every line of miRNA expression profiles has only one miRNA name which start with hsa-mir, such as hsa-mir-5697. Every line of gene expression profiles has only one gene name which derived from Ensembl, such as ENSG00000261657. All of miRNA expression profiles and gene expression profiles do not have column names. If we have prepared, we can push the Start the analysis button to start finding the TSSs. The process of analysis may need to take a few minutes, and a process bar will appear in right corner.
>
> As a result, we will view first six rows of the result. The first five columns are about  miRNA  information, next five columns are about  TSS  information. The column of gene denotes the gene whose TSS is closest to the miRNA TSS. The column of pri\_tss\_distance denotes the distance between miRNA TSS and stem-loop. If users choose to get TFs simultaneously, they will have an additional column, `tf`, which stores related TFs.

### TAG2: Plot pri-miRNA TSS

![shiny_plot](data:image/jpeg;base64...) 　Figure S3. ***Graphical web interface of `Plot pri-miRNA TSS()`***

> As Figure S4 shows, if we select the appropriate options and upload the appropriate files, we can have a picture of miRNA TSSs.

## Session info

Here is the output of sessionInfo() on the system on which this document was compiled:

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
#> [1] primirTSS_1.28.0
#>
#> loaded via a namespace (and not attached):
#>   [1] tidyselect_1.2.1                  dplyr_1.1.4
#>   [3] blob_1.2.4                        filelock_1.0.3
#>   [5] R.utils_2.13.0                    Biostrings_2.78.0
#>   [7] bitops_1.0-9                      fastmap_1.2.0
#>   [9] RCurl_1.98-1.17                   BiocFileCache_3.0.0
#>  [11] GenomicAlignments_1.46.0          XML_3.99-0.19
#>  [13] digest_0.6.37                     lifecycle_1.0.4
#>  [15] KEGGREST_1.50.0                   RSQLite_2.4.3
#>  [17] magrittr_2.0.4                    compiler_4.5.1
#>  [19] rlang_1.1.6                       sass_0.4.10
#>  [21] tools_4.5.1                       utf8_1.2.6
#>  [23] yaml_2.3.10                       BSgenome.Hsapiens.UCSC.hg38_1.4.5
#>  [25] rtracklayer_1.70.0                knitr_1.50
#>  [27] S4Arrays_1.10.0                   phastCons100way.UCSC.hg38_3.7.1
#>  [29] bit_4.6.0                         curl_7.0.0
#>  [31] DelayedArray_0.36.0               abind_1.4-8
#>  [33] BiocParallel_1.44.0               HDF5Array_1.38.0
#>  [35] withr_3.0.2                       purrr_1.1.0
#>  [37] BiocGenerics_0.56.0               R.oo_1.27.1
#>  [39] grid_4.5.1                        stats4_4.5.1
#>  [41] Rhdf5lib_1.32.0                   SummarizedExperiment_1.40.0
#>  [43] cli_3.6.5                         rmarkdown_2.30
#>  [45] crayon_1.5.3                      GenomicScores_2.22.0
#>  [47] generics_0.1.4                    httr_1.4.7
#>  [49] rjson_0.2.23                      DBI_1.2.3
#>  [51] cachem_1.1.0                      rhdf5_2.54.0
#>  [53] stringr_1.5.2                     parallel_4.5.1
#>  [55] AnnotationDbi_1.72.0              BiocManager_1.30.26
#>  [57] XVector_0.50.0                    restfulr_0.0.16
#>  [59] matrixStats_1.5.0                 vctrs_0.6.5
#>  [61] Matrix_1.7-4                      jsonlite_2.0.0
#>  [63] IRanges_2.44.0                    S4Vectors_0.48.0
#>  [65] bit64_4.6.0-1                     h5mread_1.2.0
#>  [67] tidyr_1.3.1                       jquerylib_0.1.4
#>  [69] glue_1.8.0                        codetools_0.2-20
#>  [71] JASPAR2018_1.1.1                  stringi_1.8.7
#>  [73] BiocVersion_3.22.0                GenomeInfoDb_1.46.0
#>  [75] BiocIO_1.20.0                     GenomicRanges_1.62.0
#>  [77] UCSC.utils_1.6.0                  tibble_3.3.0
#>  [79] pillar_1.11.1                     rappdirs_0.3.3
#>  [81] htmltools_0.5.8.1                 Seqinfo_1.0.0
#>  [83] rhdf5filters_1.22.0               BSgenome_1.78.0
#>  [85] R6_2.6.1                          dbplyr_2.5.1
#>  [87] httr2_1.2.1                       evaluate_1.0.5
#>  [89] lattice_0.22-7                    Biobase_2.70.0
#>  [91] AnnotationHub_4.0.0               png_0.1-8
#>  [93] R.methodsS3_1.8.2                 Rsamtools_2.26.0
#>  [95] cigarillo_1.0.0                   memoise_2.0.1
#>  [97] bslib_0.9.0                       SparseArray_1.10.0
#>  [99] xfun_0.53                         MatrixGenerics_1.22.0
#> [101] pkgconfig_2.0.3
```