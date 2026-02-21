Code

* Show All Code
* Hide All Code

# Introduction to txcutr

Mervin M Fansler1,2\*

1Tri-Institutional Training Program in Computational Biology and Medicine, Weill Cornell Graduate College, New York 10021, NY, USA
2Cancer Biology and Genetics Program, Memorial Sloan Kettering Cancer Center, New York, NY 10065, USA

\*mef3005@med.cornell.edu

#### 30 October 2025

#### Package

txcutr 1.16.0

# 1 Basics

## 1.1 Motivation

Some RNA-sequencing library preparations generate sequencing reads from specific locations in transcripts. For example, 3’-end tag methods, which include methods like Lexogen’s Quant-Seq or 10X’s Chromium Single Cell 3’, generate reads from the 3’ ends of transcripts. For applications interested in quantifying alternative cleavage site usage, using a truncated form of transcriptome annotation can help simplify downstream analysis and, in some pipelines, provide for more accurate estimates. This package implements methods to simplify the generation of such truncated annotations.

## 1.2 Install `txcutr`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[txcutr](https://bioconductor.org/packages/3.22/txcutr)* is a `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[txcutr](https://bioconductor.org/packages/3.22/txcutr)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("txcutr")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.3 Required Background

*[txcutr](https://bioconductor.org/packages/3.22/txcutr)* is based on many other packages and in particular on those that have implemented the infrastructure needed for dealing with transcriptome annotations. That is, packages like *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* and *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)*. While we anticipate most use cases for `txcutr` to not require manipulating `GRanges` or `TxDb` objects directly, it would be beneficial to be familiar with the vignettes provided in these packages.

## 1.4 Asking for Help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. We would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `txcutr` tag and check [any previous posts](https://support.bioconductor.org/t/txcutr/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.5 Citing `txcutr`

We hope that *[txcutr](https://bioconductor.org/packages/3.22/txcutr)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("txcutr")
#> To cite package 'txcutr' in publications use:
#>
#>   Fansler M (2025). _txcutr: Transcriptome CUTteR_.
#>   doi:10.18129/B9.bioc.txcutr
#>   <https://doi.org/10.18129/B9.bioc.txcutr>, R package version 1.16.0,
#>   <https://bioconductor.org/packages/txcutr>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {txcutr: Transcriptome CUTteR},
#>     author = {Mervin Fansler},
#>     year = {2025},
#>     note = {R package version 1.16.0},
#>     url = {https://bioconductor.org/packages/txcutr},
#>     doi = {10.18129/B9.bioc.txcutr},
#>   }
```

# 2 Quick Start to Using `txcutr`

## 2.1 Starting from TxDb Objects

Many transcriptome annotations, especially for model organisms, are already directly available as `TxDb` annotation packages. One can browse a list of available `TxDb` objects [on the Bioconductor website](https://bioconductor.org/packages/release/BiocViews.html#___TxDb).

### 2.1.1 Example TxDb

For demonstration purposes, we will work with the SGD genes for the yeast *Saccharomyces cerevisiae*, and restrict the processing to **chrI**.

```
library(GenomicFeatures)
library(TxDb.Scerevisiae.UCSC.sacCer3.sgdGene)
txdb <- TxDb.Scerevisiae.UCSC.sacCer3.sgdGene

## constrain to "chrI"
seqlevels(txdb) <- "chrI"

## view the lengths of first ten transcripts
transcriptLengths(txdb)[1:10,]
#>    tx_id   tx_name   gene_id nexon tx_len
#> 1      1   YAL069W   YAL069W     1    315
#> 2      2 YAL068W-A   YAL069W     1    255
#> 3      3 YAL067W-A YAL067W-A     1    228
#> 4      4   YAL066W   YAL066W     1    309
#> 5      5 YAL064W-B YAL064W-B     1    381
#> 6      6   YAL064W   YAL064W     1    285
#> 7      7   YAL062W   YAL062W     1   1374
#> 8      8   YAL061W   YAL061W     1   1254
#> 9      9   YAL060W   YAL060W     1   1149
#> 10    10   YAL059W   YAL059W     1    639
```

As seen from the above output, the transcript lengths are variable, but in a 3’-end tag-based RNA-sequencing library, we expect reads to only come from a narrow region at the 3’ end. We can use the methods in the *[txcutr](https://bioconductor.org/packages/3.22/txcutr)* package to restrict the annotation to that region for each transcript.

### 2.1.2 Transcriptome Truncation

Let’s use the `truncateTxome` method to restrict transcripts to their last 500 nucleotides (nts).

```
library(txcutr)

txdb_w500 <- truncateTxome(txdb, maxTxLength=500)
#> 'select()' returned 1:1 mapping between keys and columns
#> Truncating transcripts...
#> Done.
#> Checking for duplicate transcripts...
#> Removed 0 duplicates.
#> Creating exon ranges...
#> Done.
#> Creating tx ranges...
#> Done.
#> Creating gene ranges...
#> Done.
#> Warning in .makeTxDb_normarg_chrominfo(chrominfo): genome version information
#> is not available for this TxDb object

transcriptLengths(txdb_w500)[1:10,]
#>    tx_id   tx_name   gene_id nexon tx_len
#> 1      1   YAL069W   YAL069W     1    315
#> 2      2 YAL068W-A   YAL069W     1    255
#> 3      3 YAL067W-A YAL067W-A     1    228
#> 4      4   YAL066W   YAL066W     1    309
#> 5      5 YAL064W-B YAL064W-B     1    381
#> 6      6   YAL064W   YAL064W     1    285
#> 7      7   YAL062W   YAL062W     1    500
#> 8      8   YAL061W   YAL061W     1    500
#> 9      9   YAL060W   YAL060W     1    500
#> 10    10   YAL059W   YAL059W     1    500
```

Observe how the all transcripts that were previously longer than 500 nts are now exactly 500 nts. Also, any transcripts that were already short enough remain unchanged.

### 2.1.3 Exporting a New Annotation

We can now export this new transcriptome as a GTF file that could be used in an alignment pipeline or genome viewer. Note that ending the file name with **.gz** will automatically signal to that the file should be exported with **gzip** compression.

```
gtf_file <- tempfile("sacCer3_chrI.sgd.txcutr_w500", fileext=".gtf.gz")
exportGTF(txdb_w500, file=gtf_file)
```

### 2.1.4 Exporting Sequences

If we need to prepare an index for alignment or pseudo-alignment, this requires exporting the corresponding sequences of the truncated transcripts. To do this, will need to load a `BSgenome` object for *sacCer3*.

```
library(BSgenome.Scerevisiae.UCSC.sacCer3)
sacCer3 <- BSgenome.Scerevisiae.UCSC.sacCer3

fasta_file <- tempfile("sacCer3_chrI.sgd.txcutr_w500", fileext=".fa.gz")
exportFASTA(txdb_w500, genome=sacCer3, file=fasta_file)
```

### 2.1.5 Merge Table

Another file that might be needed by some quantification tools is a merge table. That is, a file that represents a map from the input transcripts to either output transcripts or genes. In some pipelines, one may wish to merge any transcripts that have any overlap. In others, there might be some minimum amount of distance between 3’ ends below which it may be uninteresting to discern between. For this, `txcutr` provides a `generateMergeTable` method, together with a `minDistance` argument.

To create a merge for any overlaps whatsoever, one would set the `minDistance` to be identical to the maximum transcript length.

```
df_merge <- generateMergeTable(txdb_w500, minDistance=500)

head(df_merge, 10)
#>      tx_in  tx_out gene_out
#> 1  YAL001C YAL001C  YAL001C
#> 2  YAL002W YAL002W  YAL002W
#> 3  YAL003W YAL003W  YAL003W
#> 4  YAL004W YAL004W  YAL004W
#> 5  YAL005C YAL005C  YAL005C
#> 6  YAL007C YAL007C  YAL007C
#> 7  YAL008W YAL008W  YAL008W
#> 8  YAL009W YAL009W  YAL009W
#> 9  YAL010C YAL010C  YAL010C
#> 10 YAL011W YAL011W  YAL011W
```

In this particular case, these first transcripts each map to themselves. This should not be a surprise, since very few genes in the input annotation had alternative transcripts. However, we can filter to highlight any transcripts that would get merged.

```
df_merge[df_merge$tx_in != df_merge$tx_out,]
#>       tx_in    tx_out gene_out
#> 28  YAL026C YAL026C-A  YAL026C
#> 84  YAL069W YAL068W-A  YAL069W
#> 118 YAR073W   YAR075W  YAR073W
```

Algorithmically, `txcutr` will give preference to more distal transcripts in the merge assignment. For example, looking at transcripts from gene **YAL026C**:

```
transcripts(txdb_w500, columns=c("tx_name", "gene_id"),
            filter=list(gene_id=c("YAL026C")))
#> GRanges object with 2 ranges and 2 metadata columns:
#>       seqnames      ranges strand |     tx_name         gene_id
#>          <Rle>   <IRanges>  <Rle> | <character> <CharacterList>
#>   [1]     chrI 95386-95823      - |   YAL026C-A         YAL026C
#>   [2]     chrI 95630-96129      - |     YAL026C         YAL026C
#>   -------
#>   seqinfo: 1 sequence from sacCer3 genome
```

we see that they are on the negative strand and **YAL026C-A** is more distal in this orientation. This is consistent with **YAL026C** being merged into **YAL026C-A** if we are merging all overlapping transcripts.

Note that one can also directly export the merge table using the `exportMergeTable` function.

## 2.2 Notes on Usage

### 2.2.1 Making TxDb Objects

The *[txdbmaker](https://bioconductor.org/packages/3.22/txdbmaker)* package provides a number of means to create custom `TxDb` objects that can then be used by `txcutr`. Alternative workflows might include starting from a GTF/GFF3 transcriptome annotation and using the `txdbmaker::makeTxDbFromGFF` method, or using the `txdbmaker::makeTxDbFromBiomart` method to create the object from Biomart resources.

### 2.2.2 BiocParallel

The truncation step can be computationally intensive, especially for species whose annotations include many alternative transcript isoforms, such as mouse or human. The `truncateTxome` method makes use of `BiocParallel::bplapply` when applicable, and will respect the `BiocParallel::register()` setting, unless an explicit `BPPARAM` argument is supplied.

We encourage use of a parallel parameter option, such as `MulticoreParam`, but it should be noted that with mammalian transcriptomes this results in a maximum RAM usage between 3-4GB per core. Please ensure adequate memory *per core* is available.

### 2.2.3 Alternative Cleavage and Polyadenylation

This tool developed out of a pipeline for quantifying 3’ UTR isoform expression from scRNA-seq. In such an application, it can be helpful to pre-filter transcripts that may be included in an annotation, but do not have validated 3’ ends. Of particular note are the GENCODE annotations: we recommend pre-filtering GENCODE GTF/GFF files to remove any entries with the tag **mRNA\_end\_NF**.

# 3 Reproducibility

The *[txcutr](https://bioconductor.org/packages/3.22/txcutr)* package (Fansler, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("intro.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("intro.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 03:04:15 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 35.499 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package                               * version   date (UTC) lib source
#>  abind                                   1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi                         * 1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  backports                               1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex                                  0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase                               * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache                           3.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics                          * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                                  1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager                             1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel                            1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle                             * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biomaRt                                 2.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings                              2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                                     4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                                   4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                                  1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                                    1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown                                0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                                   0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                                  1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cigarillo                               1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cli                                     3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools                               0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                                  1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                                    7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                                     1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr                                  2.5.1     2025-09-10 [2] CRAN (R 4.5.1)
#>  DelayedArray                            0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  digest                                  0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                                   1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate                                1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  fastmap                                 1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock                                1.0.3     2023-12-11 [2] CRAN (R 4.5.1)
#>  generics                              * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomeInfoDb                            1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomeInfoDbData                        1.2.15    2025-09-29 [2] Bioconductor
#>  GenomicAlignments                       1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicFeatures                       * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges                         * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  glue                                    1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  hms                                     1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
#>  htmltools                               0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                                    1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                                   1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges                               * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib                               0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite                                2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST                                1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                                   1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  lattice                                 0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle                               1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate                               1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr                                2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                                  1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics                          1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats                             1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                                 2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  pillar                                  1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig                               2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                                    1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                                     0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  prettyunits                             1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  progress                                1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  R6                                      2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs                                0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  Rcpp                                    1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                                   1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  RefManageR                            * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  restfulr                                0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rjson                                   0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                                   1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown                               2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  Rsamtools                               2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                                 2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rtracklayer                             1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays                                1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors                             * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sass                                    0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  Seqinfo                               * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo                           * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray                             1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                                 1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                                 1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment                    1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                                  3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect                              1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange                              0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  txcutr                                * 1.16.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  TxDb.Scerevisiae.UCSC.sacCer3.sgdGene * 3.2.2     2025-09-10 [2] Bioconductor
#>  txdbmaker                               1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  UCSC.utils                              1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  vctrs                                   0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  xfun                                    0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                                     3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  xml2                                    1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
#>  XVector                                 0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                                    2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpPttToK/Rinst3d0a23547b342f
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 4 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-fansler2025txcutr)
M. Fansler.
*txcutr: Transcriptome CUTteR*.
R package version 1.16.0.
2025.
DOI: [10.18129/B9.bioc.txcutr](https://doi.org/10.18129/B9.bioc.txcutr).
URL: <https://bioconductor.org/packages/txcutr>.

[[3]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[4]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[5]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[6]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[7]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[8]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.