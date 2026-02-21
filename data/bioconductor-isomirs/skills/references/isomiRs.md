# Characterization of miRNA and isomiR molecules

#### Lorena Pantano

#### 25 December 2025

Abstract

isomiRs package version: 1.38.1

* [Introduction](#introduction)
* [Citing isomiRs](#citing-isomirs)
* [Input format](#input-format)
* [IsomirDataSeq class](#isomirdataseq-class)
  + [Access data](#access-data)
  + [isomiRs annotation](#isomirs-annotation)
* [Reading input](#reading-input)
* [Manipulation](#manipulation)
  + [Descriptive analysis](#descriptive-analysis)
  + [Count data](#count-data)
  + [Annotation](#annotation)
* [Classification](#classification)
  + [Differential expression analysis](#differential-expression-analysis)
* [Session info](#session-info)
* [References](#references)

[Lorena Pantano](lorena.pantano%40gmail.com) - Harvard TH Chan School of Public Health, Boston, US

Georgia Escaramis - CIBERESP (CIBER Epidemiologia y Salud Publica)

## Introduction

miRNAs are small RNA fragments (18-23 nt long) that influence gene expression during development and cell stability. Morin et al (Morin et al. 2008), discovered isomiRs first time after sequencing human stem cells.

IsomiRs are miRNAs that vary slightly in sequence, which result from variations in the cleavage site during miRNA biogenesis (5’-trimming and 3’-trimming variants), nucleotide additions to the 3’-end of the mature miRNA (3’-addition variants) and nucleotide modifications (substitution variants)(Martı́ et al. 2010).

There are many tools designed for isomiR detection, however the majority are web application where user can not control the analysis. The two main command tools for isomiRs mapping are SeqBuster and sRNAbench (Guillermo et al. 2014). *[isomiRs](https://bioconductor.org/packages/3.22/isomiRs)*. package is designed to analyze the output of SeqBuster tool or any other tool after converting to the desire format.

## Citing isomiRs

If you use the package, please cite this paper (Pantano L 2010).

## Input format

The input should be the output of SeqBuster-miraligner tool (\*.mirna files). It is compatible with [mirTOP](http://github.com/mirtop/mirtop) tool as well, which parses BAM files with alignments against miRNA precursors.

For each sample the file should have the following format:

```
seq                     name           freq mir           start end  mism  add  t5  t3
TGTAAACATCCTACACTCAGCT  seq_100014_x23  23  hsa-miR-30b-5p  17  40   0       0  0   GT
TGTAAACATCCCTGACTGGAA   seq_100019_x4   4   hsa-miR-30d-5p  6   26   13TC    0  0   g
TGTAAACATCCCTGACTGGAA   seq_100019_x4   4   hsa-miR-30e-5p  17  37   12CT    0  0   g
CAAATTCGTATCTAGGGGATT   seq_100049_x1   1   hsa-miR-10a-3p  63  81   0       TT 0   ata
TGACCTAGGAATTGACAGCCAGT seq_100060_x1   1   hsa-miR-192-5p  25  47   8GT     0  c   agt
```

This is the standard output of SeqBuster-miraligner tool, but can be converted from any other tool having the mapping information on the precursors. Read more on [miraligner manual](http://seqcluster.readthedocs.org/mirna_annotation.html).

## IsomirDataSeq class

This object will store all raw data from the input files and some processed information used for visualization and statistical analysis. It is a subclass of `SummarizedExperiment` with `colData` and `counts` methods. Beside that, the object contains raw and normalized counts from miraligner allowing to update the summarization of miRNA expression.

### Access data

The user can access the normalized count matrix with `counts(object, norm=TRUE)`.

You can browse for the same miRNA or isomiRs in all samples with `isoSelect` method.

```
library(isomiRs)
data(mirData)
head(isoSelect(mirData, mirna="hsa-let-7a-5p", 1000))
```

```
## DataFrame with 6 rows and 14 columns
##                                 cc1       cc2       cc3       cc4       cc5
##                           <numeric> <numeric> <numeric> <numeric> <numeric>
## hsa-let-7a-5p                235825    171354    149541    180654    168884
## hsa-let-7a-5p;iso_3p:T         8806      5478      5427      6249      5538
## hsa-let-7a-5p;iso_3p:gtt       1173       884       751      1010       963
## hsa-let-7a-5p;iso_3p:t        50920     52403     35525     53213     51499
## hsa-let-7a-5p;iso_3p:tt        6041      5467      3817      7491      6394
## hsa-let-7a-5p;iso_add3p:A      9616      4742      5437      6714      5846
##                                 cc6       cc7       ct1       ct2       ct3
##                           <numeric> <numeric> <numeric> <numeric> <numeric>
## hsa-let-7a-5p                107430    153061    143030    163569    114028
## hsa-let-7a-5p;iso_3p:T         3734      5482      4825      6045      4626
## hsa-let-7a-5p;iso_3p:gtt        580       863       927       756       495
## hsa-let-7a-5p;iso_3p:t        30659     45492     42878     35795     24993
## hsa-let-7a-5p;iso_3p:tt        3984      5940      7107      4828      2858
## hsa-let-7a-5p;iso_add3p:A      3799      5532      5214      7326      4790
##                                 ct4       ct5       ct6       ct7
##                           <numeric> <numeric> <numeric> <numeric>
## hsa-let-7a-5p                123454    133092    158909    140272
## hsa-let-7a-5p;iso_3p:T         4181      4505      5134      4670
## hsa-let-7a-5p;iso_3p:gtt        719       682      1048       860
## hsa-let-7a-5p;iso_3p:t        34512     36973     47873     39585
## hsa-let-7a-5p;iso_3p:tt        5087      5652      6589      5447
## hsa-let-7a-5p;iso_add3p:A      4430      5010      6034      5081
```

`metadata(mirData)` contains two lists: `rawList` is a list with same length than number of samples and stores the input files for each sample; `isoList` is a list with same length than number of samples and stores information for each isomiR type summarizing the different changes for the different isomiRs (trimming at 3’, trimming a 5’, addition and substitution). For instance, you can get the data stored in `isoList` for sample 1 and 5’ changes with this code `metadata(ids)[["isoList"]][[1]]["t5sum"]`.

### isomiRs annotation

IsomiR names follows this structure:

* miRNA name
* type: ref if the sequence is the same as the miRNA reference. `iso` if the sequence has variations. *t5 tag: indicates variations at 5’ position. The naming contains two words: `direction - nucleotides`, where direction can be UPPER CASE NT (changes upstream of the 5’ reference position) or LOWER CASE NT (changes downstream of the 5’ reference position). `0` indicates no variation, meaning the 5’ position is the same as the reference. After `direction`, it follows the nucleotide/s that are added (for upstream changes) or deleted (for downstream changes).* t3 tag: indicates variations at 3’ position. The naming contains two words: `direction - nucleotides`, where direction can be LOWER CASE NT (upstream of the 3’ reference position) or UPPER CASE NT (downstream of the 3’ reference position). `0` indicates no variation, meaning the 3’ position is the same as the reference. After `direction`, it follows the nucleotide/s that are added (for downstream changes) or deleted (for upstream chanes). *ad tag: indicates nucleotides additions at 3’ position. The naming contains two words: `direction - nucleotides`, where direction is UPPER CASE NT (upstream of the 5’ reference position). `0` indicates no variation, meaning the 3’ position has no additions. After `direction`, it follows the nucleotide/s that are added.* mm tag: indicates nucleotides substitutions along the sequences. The naming contains three words: `position-nucleotideATsequence-nucleotideATreference`. \*seed tag: same as `mm` tag, but only if the change happens between nucleotide 2 and 8.

In general nucleotides in UPPER case mean insertions respect to the reference sequence, and nucleotides in LOWER case mean deletions respect to the reference sequence.

## Reading input

We are going to use a small RNAseq data from human brain samples (Pantano et al. 2015) to give some basic examples of isomiRs analyses.

In this data set we will find two groups:

*pc: 7 control individuals* pt: 7 patients with Parkinson’s Disease in early stage.

```
library(isomiRs)
data(mirData)
```

The function `IsomirDataSeqFromFiles` needs a vector with the paths for each file and a data frame with the design experiment similar to the one used for a mRNA differential expression analysis. Row names of the data frame should be the names for each sample in the same order than the list of files.

```
ids <- IsomirDataSeqFromFiles(fn_list, design=de)
```

## Manipulation

### Descriptive analysis

You can plot isomiRs expression with `isoPlot`. In this figure you will see how abundant is each type of isomiRs at different positions considering the total abundance and the total number of sequences. The `type` parameter controls what type of isomiRs to show. It can be trimming (iso5 and iso3), addition (add) or substitution (subs) changes.

```
ids <- isoCounts(mirData)
isoPlot(ids, type="all")
```

![](data:image/png;base64...)

### Count data

`isoCounts` gets the count matrix that can be used for many different downstream analyses changing the way isomiRs are collapsed. The following command will merge all isomiRs into one feature: the reference miRNA.

```
head(counts(ids))
```

```
##                    cc1    cc2    cc3    cc4    cc5    cc6    cc7    ct1    ct2
## hsa-let-7a-2-3p      5     13      4      9     11      6      7      0      4
## hsa-let-7a-3p      767    707    630    609    731    389    681    258    496
## hsa-let-7a-5p   317730 244832 203888 260931 244784 153049 220563 208511 222066
## hsa-let-7b-3p     1037   1949    679   1385   1884    697   1499    338    931
## hsa-let-7b-5p    69671  64702  42347  65322  60767  34975  56875  22215  45069
## hsa-let-7c-3p       36     16     25     40     26     23     35      3     30
##                    ct3    ct4    ct5    ct6    ct7
## hsa-let-7a-2-3p      2     12     12      8      3
## hsa-let-7a-3p      343    635    622    452    519
## hsa-let-7a-5p   154246 175523 189733 230690 199923
## hsa-let-7b-3p      494   1149   1194   1431    988
## hsa-let-7b-5p    28312  41214  43058  61258  46600
## hsa-let-7c-3p       28     26     24     22     17
```

The normalization uses `rlog` from *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* package and allows quick integration to another analyses like heatmap, clustering or PCA.

```
library(pheatmap)
ids = isoNorm(ids, formula = ~ condition)
pheatmap(counts(ids, norm=TRUE)[1:100,],
         annotation_col = data.frame(colData(ids)[,1,drop=FALSE]),
         show_rownames = FALSE, scale="row")
```

![](data:image/png;base64...)

### Annotation

To get a detail description for each isomiR, the function `isoAnnotate` can return the naming, sequence and importance value for each sample and isomiR. The importance is calculated by:

\[importance = \frac{isomiR\\_reads}{miRNA\\_reads}\]

The columns are:

* seq: sequence of the isomiR
* uid: isomiR name
* edit\_mature\_position: showing the position at the mature sequence where the nucleotide change happened: `position:nt_ref:nt_isomiR`.
* one column for each sample with the importance value

```
head(isoAnnotate(ids))
```

```
##                       seq
## 1 AAAAACCGTAGTTACTTTTGCAT
## 2    AAAAACTGAGACTACTTTTG
## 3   AAAAACTGAGACTACTTTTGC
## 4  AAAAACTGAGACTACTTTTGCA
## 5 AAAAACTGAGACTACTTTTGCAA
## 6   AAAAACTGCAGTTACTTTTGC
##                                                        uid    cc1      cc2
## 1 hsa-miR-548bb-3p;iso_snp:8GA;iso_add:T;iso_5p:c;iso_3p:A     NA       NA
## 2                                hsa-miR-548e-3p;iso_3p:ca  9.375 10.71429
## 3                                 hsa-miR-548e-3p;iso_3p:a 34.375 10.71429
## 4                                      hsa-miR-548e-3p;ref 21.875 64.28571
## 5                                hsa-miR-548e-3p;iso_add:A 34.375       NA
## 6                                hsa-miR-548ah-3p;iso_5p:c 15.000 11.76471
##        cc3        cc4 cc5      cc6 cc7      ct1      ct2       ct3 ct4
## 1       NA 100.000000  NA       NA  NA       NA       NA        NA  NA
## 2 15.15152   6.896552  NA       NA  NA 19.04762       NA  8.333333  20
## 3 30.30303  41.379310  28 66.66667  25 19.04762 47.61905 29.166667  20
## 4 27.27273  17.241379  44 33.33333  60 38.09524 23.80952 16.666667  30
## 5 21.21212  13.793103  12       NA  15 23.80952 19.04762 25.000000  30
## 6 23.07692         NA  NA       NA  NA       NA       NA        NA  NA
##         ct5      ct6      ct7 edit_mature_position
## 1        NA       NA       NA                 9:AG
## 2  8.695652       NA       NA                   NA
## 3 30.434783 13.04348 46.15385                   NA
## 4 30.434783 34.78261 30.76923                   NA
## 5 17.391304 43.47826 23.07692                   NA
## 6        NA       NA       NA                   NA
```

## Classification

### Differential expression analysis

The `isoDE` uses functions from *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* package. This function has parameters to create a matrix using only the reference miRNAs, all isomiRs, or some of them. This matrix and the design matrix are the inputs for DESeq2. The output will be a DESeqDataSet object, allowing to generate any plot or table explained in DESeq2 package vignette.

```
dds <- isoDE(ids, formula=~condition)
library(DESeq2)
plotMA(dds)
```

![](data:image/png;base64...)

```
head(results(dds, format="DataFrame"))
```

```
## log2 fold change (MLE): condition ct vs cc
## Wald test p-value: condition ct vs cc
## DataFrame with 6 rows and 6 columns
##                    baseMean log2FoldChange     lfcSE      stat    pvalue
##                   <numeric>      <numeric> <numeric> <numeric> <numeric>
## hsa-let-7a-2-3p 6.60005e+00      -0.391808  0.609493 -0.642843  0.520326
## hsa-let-7a-3p   5.46805e+02      -0.225686  0.224797 -1.003953  0.315401
## hsa-let-7a-5p   2.20626e+05       0.113470  0.270505  0.419475  0.674869
## hsa-let-7b-3p   1.09679e+03      -0.391275  0.329461 -1.187621  0.234983
## hsa-let-7b-5p   4.74160e+04      -0.235215  0.226065 -1.040476  0.298119
## hsa-let-7c-3p   2.31178e+01      -0.174438  0.302732 -0.576212  0.564472
##                      padj
##                 <numeric>
## hsa-let-7a-2-3p  0.989528
## hsa-let-7a-3p    0.989528
## hsa-let-7a-5p    0.989528
## hsa-let-7b-3p    0.989528
## hsa-let-7b-5p    0.989528
## hsa-let-7c-3p    0.989528
```

You can differentiate between reference sequences and isomiRs at 5’ end with this command:

```
dds = isoDE(ids, formula=~condition, ref=TRUE, iso5=TRUE)
head(results(dds, tidy=TRUE))
```

```
##                          row    baseMean log2FoldChange     lfcSE       stat
## 1            hsa-let-7a-2-3p   2.4059793     -0.8425278 1.0440442 -0.8069848
## 2 hsa-let-7a-2-3p;iso_5p:TAA   0.1285419      1.1051761 3.0845751  0.3582912
## 3        hsa-let-7a-2-3p;ref   4.0407844     -0.2219555 0.6581561 -0.3372384
## 4              hsa-let-7a-3p 376.7216287     -0.1663188 0.2027009 -0.8205135
## 5     hsa-let-7a-3p;iso_5p:A   0.6517381      1.0223121 1.7714731  0.5770972
## 6     hsa-let-7a-3p;iso_5p:c  84.6025648     -0.3165339 0.2538101 -1.2471289
##      pvalue      padj
## 1 0.4196753 0.9865695
## 2 0.7201254 0.9865695
## 3 0.7359372 0.9865695
## 4 0.4119234 0.9865695
## 5 0.5638738 0.9865695
## 6 0.2123502 0.9865695
```

Alternative, for more complicated cases or if you want to control more the differential expression analysis paramters you can use directly *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* package feeding it with the output of `counts(ids)` and `colData(ids)` like this:

```
dds = DESeqDataSetFromMatrix(counts(ids),
                             colData(ids), design = ~condition)
```

## Session info

Here is the output of `sessionInfo` on the system on which this document was compiled:

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] DESeq2_1.50.2               pheatmap_1.0.13
##  [3] isomiRs_1.38.1              SummarizedExperiment_1.40.0
##  [5] Biobase_2.70.0              GenomicRanges_1.62.1
##  [7] Seqinfo_1.0.0               IRanges_2.44.0
##  [9] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [11] generics_0.1.4              MatrixGenerics_1.22.0
## [13] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9                mnormt_2.1.1
##   [3] DBI_1.2.3                   gridExtra_2.3
##   [5] rlang_1.1.6                 magrittr_2.0.4
##   [7] clue_0.3-66                 GetoptLong_1.1.0
##   [9] otel_0.2.0                  compiler_4.5.2
##  [11] RSQLite_2.4.5               png_0.1-8
##  [13] vctrs_0.6.5                 stringr_1.6.0
##  [15] pkgconfig_2.0.3             shape_1.4.6.1
##  [17] crayon_1.5.3                fastmap_1.2.0
##  [19] backports_1.5.0             XVector_0.50.0
##  [21] labeling_0.4.3              caTools_1.18.3
##  [23] rmarkdown_2.30              tzdb_0.5.0
##  [25] purrr_1.2.0                 bit_4.6.0
##  [27] xfun_0.55                   cachem_1.1.0
##  [29] jsonlite_2.0.0              blob_1.2.4
##  [31] reshape_0.8.10              DelayedArray_0.36.0
##  [33] BiocParallel_1.44.0         psych_2.5.6
##  [35] broom_1.0.11                parallel_4.5.2
##  [37] cluster_2.1.8.1             DEGreport_1.46.0
##  [39] R6_2.6.1                    stringi_1.8.7
##  [41] bslib_0.9.0                 RColorBrewer_1.1-3
##  [43] limma_3.66.0                GGally_2.4.0
##  [45] jquerylib_0.1.4             Rcpp_1.1.0
##  [47] iterators_1.0.14            knitr_1.51
##  [49] readr_2.1.6                 Matrix_1.7-4
##  [51] tidyselect_1.2.1            dichromat_2.0-0.1
##  [53] abind_1.4-8                 yaml_2.3.12
##  [55] gplots_3.3.0                doParallel_1.0.17
##  [57] codetools_0.2-20            plyr_1.8.9
##  [59] lattice_0.22-7              tibble_3.3.0
##  [61] withr_3.0.2                 KEGGREST_1.50.0
##  [63] S7_0.2.1                    evaluate_1.0.5
##  [65] ggstats_0.12.0              ConsensusClusterPlus_1.74.0
##  [67] circlize_0.4.17             Biostrings_2.78.0
##  [69] pillar_1.11.1               BiocManager_1.30.27
##  [71] KernSmooth_2.23-26          foreach_1.5.2
##  [73] hms_1.1.4                   ggplot2_4.0.1
##  [75] scales_1.4.0                gtools_3.9.5
##  [77] glue_1.8.0                  tools_4.5.2
##  [79] locfit_1.5-9.12             cowplot_1.2.0
##  [81] grid_4.5.2                  tidyr_1.3.2
##  [83] AnnotationDbi_1.72.0        edgeR_4.8.2
##  [85] colorspace_2.1-2            nlme_3.1-168
##  [87] cli_3.6.5                   S4Arrays_1.10.1
##  [89] ComplexHeatmap_2.26.0       ggdendro_0.2.0
##  [91] dplyr_1.1.4                 gtable_0.3.6
##  [93] logging_0.10-108            sass_0.4.10
##  [95] digest_0.6.39               SparseArray_1.10.8
##  [97] ggrepel_0.9.6               rjson_0.2.23
##  [99] farver_2.1.2                memoise_2.0.1
## [101] htmltools_0.5.9             lifecycle_1.0.4
## [103] httr_1.4.7                  GlobalOptions_0.1.3
## [105] statmod_1.5.1               MASS_7.3-65
## [107] bit64_4.6.0-1
```

# References

Guillermo, Barturen, Rueda Antonio, Hamberg Maarten, Alganza Angel, Lebron Ricardo, Kotsyfakis Michalis, Shi BuJun, KoppersLalic Danijela, and Hackenberg Michael. 2014. “sRNAbench: profiling of small RNAs and its sequence variants in single or multi-species high-throughput experiments.” *Methods in Next Generation Sequencing* 1 (1): 2084–7173. <https://doi.org/10.2478/mngs-2014-0001>.

Martı́, Eulàlia, Lorena Pantano, Mónica Bañez-Coronel, Franc Llorens, Elena Miñones-Moyano, Sı́lvia Porta, Lauro Sumoy, Isidre Ferrer, and Xavier Estivill. 2010. “A myriad of miRNA variants in control and Huntington’s disease brain regions detected by massively parallel sequencing.” *Nucleic Acids Res.* 38: 7219–35. <https://doi.org/10.1093/nar/gkq575>.

Morin, R. D., M. D. O’Connor, M. Griffith, F. Kuchenbauer, A. Delaney, A.-L. Prabhu, Y. Zhao, et al. 2008. “Application of massively parallel sequencing to microRNA profiling and discovery in human embryonic stem cells.” *Genome Res.* 18: 610–21. <https://doi.org/10.1101/gr.7179508>.

Pantano, Lorena, Marc R Friedlander, Georgia Escaramis, Esther Lizano, Joan Pallares-Albanell, Isidre Ferrer, Xavier Estivill, and Eulalia Marti. 2015. “Specific small-RNA signatures in the amygdala at premotor and motor stages of Parkinson’s disease revealed by deep sequencing analysis.” *Bioinformatics (Oxford, England)*, November. <https://doi.org/10.1093/bioinformatics/btv632>.

Pantano L, Estivil X, Marti E. 2010. “SeqBuster.” *Nucleic Acids Res.* 38: e34. <https://doi.org/10.1093/nar/gkp1127>.