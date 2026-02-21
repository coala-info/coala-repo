# Introduction

Diogo Veiga

#### 2025-10-30

#### Package

maser 1.28.0

# 1 Overview of maser

Alternative splicing occurs in most human genes and novel splice isoforms may be associated to disease or tissue specific functions. However, functional interpretation of splicing requires the integration of heterogeneous data sources such as transcriptomic and proteomic information.

We developed **maser** (**M**apping **A**lternative **S**plicing **E**vents to p**R**oteins) package to enable functional characterization of splicing in both transcriptomic and proteomic contexts. Overall, *maser* allows a detailed analysis of splicing events identified by [rMATS](http://rnaseq-mats.sourceforge.net/) by implementing the following functionalities:

* Filtering of [rMATS](http://rnaseq-mats.sourceforge.net/) splicing events based on RNA-seq coverage, p-values and differential percent spliced-in (PSI)
* Analysis of global splicing effects using boxplots, principal component analysis and volcano plots.
* Mapping of splicing events to [Ensembl](http://www.ensembl.org/) transcripts and [UniprotKB](http://www.uniprot.org/) proteins
* Integration with [UniprotKB](http://www.uniprot.org/) for batch annotation of protein features overlapping splicing events
* Visualization of transcripts and protein affected by splicing using custom *Gviz* plots.

A key feature of the package is mapping of splicing events to protein features such as topological domains, motifs and mutation sites provided by the [UniprotKB](http://www.uniprot.org/) database and visualized along side the genomic location of splicing.

In this manner, *maser* can quickly identify splicing affecting known protein domains, extracellular and transmembrane regions, as well as mutation sites in the protein.

In this vignette, we describe a basic *maser* workflow for analyzing alternative splicing, starting with importing splicing events, filtering events based on their coverage and differential expression, and analyzing global or specific spling events with several types of graphics.

The second vignette describes how to use *maser* for annotation and visualization of protein features affected by splicing.

Throughout the text we use the following abbreviations to describe different types of splicing events:

* SE, refers to exon skipping
* RI, intron retention
* MXE, mutually exclusive exons
* A3SS, alternative 3’ splice site
* A5SS, alternative 5’ splice site

# 2 Importing rMATS events

We demonstrate the package with data generated to investigate alternative splicing in colorectal cancer cells undergoing hypoxia
[publication](https://doi.org/10.1038/npjgenmed.2016.20). RNA-seq was collected at 0h and 24h after hypoxia in the HCT116 cell line. We applied [rMATS](http://rnaseq-mats.sourceforge.net/) to detect splicing events using the release 25 GTF (GRCh38 build) from the Gencode website. The example dataset was reduced because of size constraints.

To import splicing events, we use the constructor function `maser()` indicating the path containing rMATS files, and labels for conditions. The `maser()` constructor returns an object containing all events quantified by rMATS.

**Note**: The argument `ftype` indicates which rMATS output files to import. Newer rMATS versions (>4.0.1) use `JCEC` or `JC` nomenclature, while `ReadsOnTargetandJunction` or `JunctionCountOnly` are used in rMATS 3.2.5 or lower. See `?maser` for a description of parameters.

```
library(maser)
library(rtracklayer)

# path to Hypoxia data
path <- system.file("extdata", file.path("MATS_output"),
                    package = "maser")
hypoxia <- maser(path, c("Hypoxia 0h", "Hypoxia 24h"), ftype = "ReadsOnTargetAndJunctionCounts")
```

```
hypoxia
#> A Maser object with 6022 splicing events.
#>
#> Samples description:
#> Label=Hypoxia 0h     n=3 replicates
#> Label=Hypoxia 24h     n=3 replicates
#>
#> Splicing events:
#> A3SS.......... 459 events
#> A5SS.......... 567 events
#> SE.......... 4081 events
#> RI.......... 722 events
#> MXE.......... 193 events
```

Splicing events have genomic locations, raw counts, PSI levels and statistics (p-values) regarding their differential splicing between conditions. Access to different data types is done using `annotation()`, `counts()`, `PSI()`, and `summary()`, which takes as argument the `maser` object and event type.

```
head(summary(hypoxia, type = "SE")[, 1:8])
```

| ID | GeneID | geneSymbol | PValue | FDR | IncLevelDifference | PSI\_1 | PSI\_2 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 10022 | ENSG00000072682.18 | P4HA2 | 0 | 0 | -0.331 | 0.567,0.572,0.509 | 0.919,0.912,0.81 |
| 10161 | ENSG00000175592.8 | FOSL1 | 0 | 0 | -0.090 | 0.877,0.864,0.87 | 0.942,0.969,0.971 |
| 10162 | ENSG00000175592.8 | FOSL1 | 0 | 0 | -0.125 | 0.821,0.803,0.814 | 0.906,0.952,0.955 |
| 10344 | ENSG00000121931.15 | LRIF1 | 0 | 0 | 0.310 | 0.398,0.383,0.465 | 0.037,0.076,0.204 |
| 10730 | ENSG00000273559.4 | CWC25 | 0 | 0 | -0.335 | 0.075,0.105,0.071 | 0.394,0.424,0.439 |
| 11204 | ENSG00000103121.8 | CMC2 | 0 | 0 | 0.170 | 0.935,0.968,0.939 | 0.841,0.708,0.784 |

# 3 Filtering events

Low coverage splicing junctions are commonly found in RNA-seq data and lead to low confidence PSI levels. We can remove low coverage events using `filterByCoverage()`, which may signficantly reduced the number of splicing events.

```
hypoxia_filt <- filterByCoverage(hypoxia, avg_reads = 5)
```

The function `topEvents()` allows to select statistically significant events given a FDR cutoff and minimum PSI change. Default values are `fdr = 0.05` and `deltaPSI = 0.1` (ie. 10% minimum change).

```
hypoxia_top <- topEvents(hypoxia_filt, fdr = 0.05, deltaPSI = 0.1)
hypoxia_top
#> A Maser object with 2882 splicing events.
#>
#> Samples description:
#> Label=Hypoxia 0h     n=3 replicates
#> Label=Hypoxia 24h     n=3 replicates
#>
#> Splicing events:
#> A3SS.......... 224 events
#> A5SS.......... 285 events
#> SE.......... 1944 events
#> RI.......... 337 events
#> MXE.......... 92 events
```

Gene specific events can be selected using `geneEvents()`. For instance, there are 8 splicing changes affecting MIB2 as seen below.

```
hypoxia_mib2 <- geneEvents(hypoxia_filt, geneS = "MIB2", fdr = 0.05, deltaPSI = 0.1)
print(hypoxia_mib2)
#> A Maser object with 8 splicing events.
#>
#> Samples description:
#> Label=Hypoxia 0h     n=3 replicates
#> Label=Hypoxia 24h     n=3 replicates
#>
#> Splicing events:
#> A3SS.......... 0 events
#> A5SS.......... 3 events
#> SE.......... 3 events
#> RI.......... 2 events
#> MXE.......... 0 events
```

Events in a `maser` object can be queried using an interactive data table provided by `display()`. The table allows to look up event information such as gene names, identifiers and PSI levels.

```
maser::display(hypoxia_mib2, "SE")
```

PSI levels for gene events can be plotted using `plotGenePSI()`, indicating a valid splicing type.

```
plotGenePSI(hypoxia_mib2, type = "SE", show_replicates = TRUE)
```

![](data:image/png;base64...)

# 4 Global splicing plots

An overview of significant events can be obtained using either `dotplot()` or `volcano()` functions, specifying FDR levels, minimum change in PSI between conditions and splicing type.
Significant events in each condition will be highlighted.

```
volcano(hypoxia_filt, fdr = 0.05, deltaPSI = 0.1, type = "SE")
```

![](data:image/png;base64...)

If only significant events should be plotted, then use `topEvents()` combined with `volcano()` or `dotplot()` for visualization.

```
dotplot(hypoxia_top, type = "SE")
```

![](data:image/png;base64...)

Splicing patterns of individual replicates can also be inspected using principal component analysis (PCA) and plotted using `pca()`. Also, boxplots of PSI levels distributions for all events in the `maser` object can be visualized using `boxplot_PSI_levels()`. The breakdown of splicing types can be plotted using `splicingDistribution()` and desired significance thresholds. Please refer to help pages for examples on how to use these functions.

# 5 Genomic visualization of splicing events

Users can use *maser* to visualize Ensembl transcripts affected by splicing. The core function for transcripts visualization is `plotTranscripts()`. This is a wrapper function for performing both mapping of splicing events to the transcriptome, as well as visualization of transcripts that are compatible with the splice event. The function uses *[Gviz](https://bioconductor.org/packages/3.22/Gviz)* for visualization of the genomic locus of splicing event along with involved transcripts.

Internally, `plotTranscripts()` uses `mapTranscriptsToEvents()` to identify compatible transcripts by overlapping exons involved in splicing to the gene models provided in the Ensembl GTF. Each type of splice event requires a specific overlapping rule (described below) and a customized *[Gviz](https://bioconductor.org/packages/3.22/Gviz)* plot is created for each splicing type.

`plotTranscripts()` requires an Ensembl or Gencode GTF using the hg38 build of the human genome. Ensembl GTFs can be retrieved using *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* or imported using `import.gff()` from the *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* package. Several GTF releases are available, and *maser* is compatible with any version using the hg38 build.

We are going to use a reduced GTF extracted from Ensembl Release 85 for running examples.

```
## Ensembl GTF annotation
gtf_path <- system.file("extdata", file.path("GTF","Ensembl85_examples.gtf.gz"),
                        package = "maser")
ens_gtf <- rtracklayer::import.gff(gtf_path)
```

## 5.1 Exon skipping

The most common type of splicing event involves a cassette exon that is either expressed or skipped. For instance, the splicing factor SRSF6 undergoes splicing during hypoxia by expressing an alternative exon. `plotTranscripts` identify the switch from isoform *SRSF6-001* to the isoform *SRSF6-002* after 24hr hypoxia.

```
## Retrieve SRSF6 splicing events
srsf6_events <- geneEvents(hypoxia_filt, geneS = "SRSF6", fdr = 0.05,
                           deltaPSI = 0.1 )

## Dislay affected transcripts and PSI levels
plotTranscripts(srsf6_events, type = "SE", event_id = 33209,
                gtf = ens_gtf, zoom = FALSE, show_PSI = TRUE)
```

![](data:image/png;base64...)

In the *[Gviz](https://bioconductor.org/packages/3.22/Gviz)*, the *event* track depicts location of exons involved in skipping event. The *Inclusion* track shows transcripts overlapping the cassette exon as well as both flanking exons (i.e upstream and downstream exons). On the other hand, the *skipping* track displays transcripts overlapping both flanking exons but missing the cassette exon.

In the exon skipping event, the *PSI* track displays the inclusion level for the cassette exon (a.k.a. alternative exon). This *PSI* track is included by default and can be turned off with .

In the example above, there is a significant increase of the cassette exon inclusion after 24h hypoxia. This allows one to predict the direction of the isoform switch, i.e. from isoform *SRSF6-001* to the isoform *SRSF6-002* in hypoxic conditions.

## 5.2 Intron retention

Intron retention is a type of splice event that are usually associated to decreased protein translation. In this case, the *Retention* track shows transcripts with an exact overlap of the retained intron, and the *Non-retention* tracks will display transcripts in which the intron is spliced out and overlap flanking exons. Here the PSI track refers to the inclusion level of the retained intron. The example below shows the increase in retained intron affecting STAT2 in hypoxia.

```
stat2_events <- geneEvents(hypoxia_filt, geneS = "STAT2", fdr = 0.05, deltaPSI = 0.1 )
plotTranscripts(stat2_events, type = "RI", event_id = 3785,
                gtf = ens_gtf, zoom = FALSE)
```

![](data:image/png;base64...)

## 5.3 Mutually exclusive exons

This event refers to adjacent exons that are mutually exclusive, i.e. are not expressed together. There are 36 MXE events in the hypoxia dataset, including one affecting the *IL32* gene. Tracks will display transcripts harboring the first or second mutually exclusive exons, as well as both flanking exons.

The *PSI* track in the mutually exclusive exons event wil show two sets of boxplots. The first set refers to Exon 1 PSI levels while the second set refers to Exon 2 PSI levels in the two conditions. Therefore, the example below denotes increased Exon 2 PSI in hypoxia 24h.

```
il32_events <- geneEvents(hypoxia_filt, geneS = "IL32", fdr = 0.05, deltaPSI = 0.1 )
plotTranscripts(il32_events, type = "MXE", event_id = 1136,
                gtf = ens_gtf, zoom = FALSE)
```

![](data:image/png;base64...)

## 5.4 Alternative 5’ and 3’ exons

Alternative 5’ splicing occur due to alternative **donor** sites, while altenative 3’ is caused by change in the **acceptor** sites. Practically, these splicing events will lead to expression of longer or shorter exons.

The *short exon* track shows transcripts overlapping both short and flanking exons, while the *long exon* track shows transcripts overlapping both long and flanking exons.

In these type of events, the *PSI* track indicates inclusion levels for the longest exon. It might be useful for visualization to set `zoom = TRUE` when the alternative splicing generates exons of similar sizes.

In the example below, BCS1L contains an exon with alternative 5’ splice site, being that the longer exon has a signficantly higher PSI in normal condition (0h), while the shorter exon has higher PSI in hypoxia.

```
#A5SS event
bcs1l_gene <- geneEvents(hypoxia_filt, geneS = "BCS1L", fdr = 0.05, deltaPSI = 0.1 )
plotTranscripts(bcs1l_gene, type = "A5SS", event_id = 3988,
                gtf = ens_gtf, zoom = TRUE)
```

![](data:image/png;base64...)

# 6 Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled:

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
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] rtracklayer_1.70.0   maser_1.28.0         GenomicRanges_1.62.0
#>  [4] Seqinfo_1.0.0        IRanges_2.44.0       S4Vectors_0.48.0
#>  [7] BiocGenerics_0.56.0  generics_0.1.4       ggplot2_4.0.0
#> [10] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] DBI_1.2.3                   bitops_1.0-9
#>   [3] deldir_2.0-4                gridExtra_2.3
#>   [5] httr2_1.2.1                 biomaRt_2.66.0
#>   [7] rlang_1.1.6                 magrittr_2.0.4
#>   [9] biovizBase_1.58.0           matrixStats_1.5.0
#>  [11] compiler_4.5.1              RSQLite_2.4.3
#>  [13] GenomicFeatures_1.62.0      reshape2_1.4.4
#>  [15] png_0.1-8                   vctrs_0.6.5
#>  [17] ProtGenerics_1.42.0         stringr_1.5.2
#>  [19] pkgconfig_2.0.3             crayon_1.5.3
#>  [21] fastmap_1.2.0               magick_2.9.0
#>  [23] backports_1.5.0             dbplyr_2.5.1
#>  [25] XVector_0.50.0              labeling_0.4.3
#>  [27] Rsamtools_2.26.0            rmarkdown_2.30
#>  [29] UCSC.utils_1.6.0            tinytex_0.57
#>  [31] bit_4.6.0                   xfun_0.53
#>  [33] cachem_1.1.0                cigarillo_1.0.0
#>  [35] GenomeInfoDb_1.46.0         jsonlite_2.0.0
#>  [37] progress_1.2.3              blob_1.2.4
#>  [39] DelayedArray_0.36.0         BiocParallel_1.44.0
#>  [41] jpeg_0.1-11                 parallel_4.5.1
#>  [43] prettyunits_1.2.0           cluster_2.1.8.1
#>  [45] VariantAnnotation_1.56.0    R6_2.6.1
#>  [47] bslib_0.9.0                 stringi_1.8.7
#>  [49] RColorBrewer_1.1-3          rpart_4.1.24
#>  [51] Gviz_1.54.0                 jquerylib_0.1.4
#>  [53] Rcpp_1.1.0                  bookdown_0.45
#>  [55] SummarizedExperiment_1.40.0 knitr_1.50
#>  [57] base64enc_0.1-3             Matrix_1.7-4
#>  [59] nnet_7.3-20                 tidyselect_1.2.1
#>  [61] rstudioapi_0.17.1           dichromat_2.0-0.1
#>  [63] abind_1.4-8                 yaml_2.3.10
#>  [65] codetools_0.2-20            curl_7.0.0
#>  [67] plyr_1.8.9                  lattice_0.22-7
#>  [69] tibble_3.3.0                Biobase_2.70.0
#>  [71] withr_3.0.2                 KEGGREST_1.50.0
#>  [73] S7_0.2.0                    evaluate_1.0.5
#>  [75] foreign_0.8-90              BiocFileCache_3.0.0
#>  [77] Biostrings_2.78.0           pillar_1.11.1
#>  [79] BiocManager_1.30.26         filelock_1.0.3
#>  [81] MatrixGenerics_1.22.0       DT_0.34.0
#>  [83] checkmate_2.3.3             RCurl_1.98-1.17
#>  [85] ensembldb_2.34.0            hms_1.1.4
#>  [87] scales_1.4.0                glue_1.8.0
#>  [89] lazyeval_0.2.2              Hmisc_5.2-4
#>  [91] tools_4.5.1                 interp_1.1-6
#>  [93] BiocIO_1.20.0               data.table_1.17.8
#>  [95] BSgenome_1.78.0             GenomicAlignments_1.46.0
#>  [97] XML_3.99-0.19               grid_4.5.1
#>  [99] crosstalk_1.2.2             latticeExtra_0.6-31
#> [101] colorspace_2.1-2            AnnotationDbi_1.72.0
#> [103] htmlTable_2.4.3             restfulr_0.0.16
#> [105] Formula_1.2-5               cli_3.6.5
#> [107] rappdirs_0.3.3              S4Arrays_1.10.0
#> [109] dplyr_1.1.4                 AnnotationFilter_1.34.0
#> [111] gtable_0.3.6                sass_0.4.10
#> [113] digest_0.6.37               SparseArray_1.10.0
#> [115] rjson_0.2.23                htmlwidgets_1.6.4
#> [117] farver_2.1.2                memoise_2.0.1
#> [119] htmltools_0.5.8.1           lifecycle_1.0.4
#> [121] httr_1.4.7                  bit64_4.6.0-1
```