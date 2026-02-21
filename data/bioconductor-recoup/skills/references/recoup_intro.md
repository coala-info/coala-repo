# Usage of the recoup package

Panagiotis Moulos

#### 30 October 2025

# 1 Genomic coverages remastered! The recoup package.

The explosion of the usage of Next Generation Sequencing techniques during the
past few years due to the seemingly endless portfolio of applications has
created the need for new NGS data analytics tools which are able to offer
comprehensive and at the same time flexible visualizations under several
experimental settings and factors. An established visualization tool in NGS
experiments is the visualization of the signal created by short reads after the
application of every NGS protocol. Genome Browsers (e.g. the UCSC Genome
Browser) serve very well this purpose considering single genomic areas. They are
very good when it comes to the visualization of the abundance of a single or a
few genes or the strength of a few protein-DNA interaction sites. However, when
it comes to the visualization of average signal profiles over multiple genomic
locations (gene regions or others like DNA methylation sites or transcription
factor binding sites), Genome Browsers fail to depict such information in a
comprehensive way. Furthermore, they cannot visualize average signal profiles of
factored data, for example a set of genes categorized in high, medium and low
expression or even by strand and they cannot visualize all signals of interest
mapped on all the genomic regions of interest in a compact way, something that
can be done using for example a heatmap.

In such cases, bioinformaticians use several toolkits like BEDTools and
facilities from R/Bioconductor to read/import short reads and overlap them with
genomic regions of interest, summarize them by binning/averaging overlaps to
control the resolution of final graphics etc. This procedure often requires the
usage of multiple tools and custom scripts with multiple steps. One of the most
comprehensive and easy-to-use tools up to date is
[ngs.plot](https://github.com/shenlab-sinai/ngsplot). It is sufficiently fast
for most applications and has a low memory footprint which allows users to run
it in low end machines too. It is command line based and users can run it by
using a simple configuration file most of the times, has a rich database of
genome annotation and genomic features and uses R/Bioconductor for underlying
calculations and plotting of profiles. However, ngs.plot is not up to date with
modern R graphics systems like `ggplot2` and `ComplexHeatmap`. As a result,
among others, it is impossible to create faceted genomic profiles using a
statistical design and in such cases, a lot of additional manual work and
computational time is required in order to reach the desired outcomes. The same
applies to heatmap profiles. Furthermore, the resolution of genomic profiles
(e.g. per base coverage or per bin of base-pairs coverage) cannot be controlled
and this can cause problems in cases where extreme levels of resolution (e.g.
DNAse-Seq experiments) is required to reach meaningful biological conclusions.
Last but not least, ngs.plot requires a not so straightforward setup in order
to run, does not run in a unified working environment (e.g. R environment with
its graphics displaying mechanisms) and in some cases produces oversized and
complex output.

The recoup package comes to fill such gaps by stepping on the shoulders of
giants. It uses the now standardized and stable Bioconductor facilities to read
and import short reads from BAM/BED files or processed genomic signals from
BIGWig files and also modern R graphics systems, namely
[ggplot2](http://ggplot2.org/) and
[ComplexHeatmap](https://github.com/jokergoo/ComplexHeatmap) in order to create
comprehensive averaged genomic profiles and genomic profile heatmaps. In
addition it offers a lot of (easy to use) customization options and automation
at various levels. Inexperienced users can gather their data in a simple text
file and just choose one of the supported organisms and recoup does the rest
for them. More experienced users can play with several options and provide more
flexible input so as to produce optimal results. This vignette, although it
covers basic usage of the package, it offers the basis for more sophisticated
usage. recoup is not as fast as ngs.plot but we are working on this! Also,
recoup is not here to replace other more mature packages. It is here to offer
more options to users that need more sophisticated genomic profile
visualizations. Finally, it offers a very flexible way to reuse genomic profiles
whose calculations may be computationally and time expensive by offering a smart
way to recognize which parameters have changed and acting based on these.

Specifically, recoup creates three types of plots:

1. Average short read coverage plots over specific reference genomic regions
   such as transcription start sites, gene bodies or completely custom regions
   provided in BED-like format.
2. Read coverage heatmaps where the profile of each single region is depicted
   (instead of averages) over specific reference genomic regions.
3. Average coverage plots showing abundance of the factor or RNA under
   investigation in specific regions (e.g. genes). This particular plot is very
   useful when one wants to examine whether for example all the expressed genes in
   two conditions correlate or whether the binding of a transcription factor
   correlates with RNA PolII activity in the promoter.

All plots can be faceted using a design file with the categories into which the
plots should be separated. All the above are illustrated in the examples in the
vignettes of this package.

## 1.1 Getting started

Detailed instructions on how to run the recoup genomic profile creation
pipeline can be found under the main documentation of the package:

```
library(recoup)
help(recoup)
```

Briefly, to run recoup you need:

* A set of BAM or BED files that contain the aligned short reads from a protein-
  DNA interaction experiment (ChIP-Seq from transcrption factors, DNA methylation
  signals, DNAse-Seq etc.) or gene expression experiments (RNA-Seq, spliced or
  unspliced). Theoretically, alignments from other protocols can be used (e.g. to
  measure the coverage of Exome-Seq).
* A set of reference genomic regions to calculate average profiles and heatmaps
  over. These can be provided as a BED-like text file with a header (see the data
  attached to the package, look at `recoup` man page). They can also be provided
  as an organism version keyword, e.g. `hg19` or `mm9` and the respective regions
  will be either retrieved from a local `recoup` annotation database setup, or
  downloaded on the fly (takes significantly more time as some extra operations
  are required).
* A design file in the case that you wish to categorize your profiles (e.g. a
  set of H3K27me1 or H4K20me1 profiles categorized by gene transcription or
  expression levels -high, medium, low, or different levels of binding strength
  of a transcription factor close to the TSS). The design file should have in the
  first column unique identifiers which should be the same, a subset or a superset
  of those in the reference genomic regions.

The package contains a small dataset which serves only for package building and
testing purposes as well as complying with Bioconductor guidelines. These data
are useful for the user to check how the input data to recoup should look like.
For a more complete test dataset (a small one) have a look and download from
[here](https://bit.ly/2KTRtwr)

The following commands should provide some information on the embedded test
data, which are subsets of the complete test data in the above link.

```
help(test.input)
help(test.genome)
help(test.design)
help(test.exons)
```

## 1.2 Getting some data

In order to run smoothly some usage examples and produce some realistic results,
you need to download a set of example BAM files, genomic regions and design
files from [here](https://bit.ly/2Wl3z7h).
Following, a description of each file in the archive (the tissue is always
liver):

* For the ChIP-Seq example
  + *WT\_H4K20me1.bam*: H4K20me1 signals from wild type adult mice, chromosome
    12 only
  + *WT\_H4K20me1.bam.bai*: The index of the above
  + *Set8KO\_H4K20me1.bam*: H4K20me1 signals from adult mice where the Set8
    (Pr-Set7) gene is knocked out, chromosome 12 only
  + *Set8KO\_H4K20me1.bam.bai*: The index of the above
  + *mm9\_custom\_chr12.txt*: Chromosome 12 mouse genes in a BED-like format
  + *design.txt*: A design file for profile plot faceting (or separation of
    heatmap profiles) with categorization of genes according to their expression
    (high, medium, low) and their direction of transcrpiption (strand).
* For the RNA-Seq example
  + *WT.bam*: Gene expression RNA signals from wild type adult mice,
    chromosome 12 only
  + *WT.bam.bai*: The index of the above
  + *Set8KO.bam*: Gene expression RNA signals from adult mice where the Set8
    (Pr-Set7) gene is knocked out, chromosome 12 only
  + *Set8KO.bam.bai*: The index of the above
  + *design\_mm9\_rna.txt*: A design file for profile plot faceting (or
    separation of heatmap profiles) with categorization of genes according to
    their Ensembl biotype and their direction of transcrpiption (strand). This
    type of categorization is also present in the fixed `recoup` annotation
    database

In order to run the vignette examples, you should download and extract the
archive to a path of your preference, e.g. `/home/me/recoup_tutorial`.

## 1.3 Building a local annotation database

Apart from a user specified file, the reference genomic regions used by recoup
to construct average profiles over, can be predefined gene set from a few common
organisms supported by recoup. See the `recoup` man page for a list of these
organisms. In order to use this “database” of predefined genomic areas, you
should run the function `buildAnnotationStore` with a list of organisms, a list
of annotation sources (Ensembl, RefSeq and UCSC supported) and a desired path to
store the annotations (defaults to `/home/me/.recoup`). For example:

```
buildAnnotationDatabase(c("hg19","mm9","rn4"),c("ensembl","refseq"))
```

See the man page of `buildAnnotationStore` for more details. This step is not
necessary for recoup to run as these annotations can be also downloaded on the
fly. However, if subsets of the supported organisms are to be used often, it is
much more preferrable to spend some time building the local store as it can save
a lot of running time later by investing some time in the beginning to build
this store.

## 1.4 Running recoup

The `recoup` function can be used to create coverage profiles from ChIP-Seq
like experiments (signals over continuous genomic regions) or from RNA-Seq
experiments (signals over non-continuous genomic regions). Due to restrictions
(logical ones) imposed by the Bioconductor development core team, the data that
are required for a realistic tutorial of the `recoup` package cannot be
included. Thus, this page along with the rest of the tutorial on how to create
genomic profiles from ChIP-Seq or RNA-Seq data can be found either
[here](http://epigenomics.fleming.gr/~panos/recoup_tutorial) or in the wiki
`recoup` pages in
[github](https://github.com/pmoulos/recoup/wiki/Introduction-to-recoup)

## 1.5 Important notes

1. When working with gene bodies, it happens very often that
   gene lengths are a little to a lot smaller than the number of bins into which
   they should be split and averaged in order to be able to create the average
   curve and heatmap profiles. While other packages line ngs.plot deal with this by
   always plotting in a pre-specifed axis system (e.g. 1-100 in the x-axis for
   ngs.plot) and using splines to sample coverages at equal spaces, recoup supports
   a more dynamic resolution by allowing the user to set the number of bins into
   which genomic areas will be binned or by allowing a per-base resolution where
   possible. Thus, when genes are smaller than the desired number of bins, there
   might be a problem. `recoup` deals with that in four possible ways:

   * An “automatic” way using a hybrid combination of the spline and
     neighborhood options below
   * Spline interpolation (R `spline` function with the default method)
   * Linear interpolation (R `approx` function with the default method)
   * A method based on averaging neighboring coverage points. In this case, a
     number of `NA` values are distributed randomly across the small area
     coverage vector (e.g. gene with length smaller than the desired number of
     bins), excluding the first and the last two positions, in order to reach
     the desired number of bins. Then, each `NA` position is filled with the
     mean value of the two values before and the two values after the `NA`
     position. This method should be avoided when >20% of the values of the
     extended vector are `NA`’s as it may cause a crash. However, it should be
     the most accurate one in the opposite case (few `NA`’s). See the
     `recoup` man page for further information.
2. In the two vignettes explaining the useage of the `recoup` package and its
   functions and in the examples, you will notice the direct use of `plot` function
   instead of direct plotting (`plotParams$plot=FALSE` instead of the default
   `TRUE`) or the `recoupPlot` function. This has been done on purpose as at this
   point, it is not straighforward how to tell the `knitr` vignette builder how to
   plot objects created within called functions.
3. Due to strict Bioconductor guidelines regarding package size, these vignettes
   can also be found in the github package
   [page](https://github.com/pmoulos/recoup) with a few more examples.

## 1.6 R session information

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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] recoup_1.38.0               ComplexHeatmap_2.26.0
##  [3] ggplot2_4.0.0               GenomicAlignments_1.46.0
##  [5] Rsamtools_2.26.0            Biostrings_2.78.0
##  [7] XVector_0.50.0              SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              MatrixGenerics_1.22.0
## [11] matrixStats_1.5.0           GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0               IRanges_2.44.0
## [15] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [17] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3              bitops_1.0-9           httr2_1.2.1
##  [4] biomaRt_2.66.0         rlang_1.1.6            magrittr_2.0.4
##  [7] clue_0.3-66            GetoptLong_1.0.5       compiler_4.5.1
## [10] RSQLite_2.4.3          GenomicFeatures_1.62.0 txdbmaker_1.6.0
## [13] png_0.1-8              vctrs_0.6.5            stringr_1.5.2
## [16] pkgconfig_2.0.3        shape_1.4.6.1          crayon_1.5.3
## [19] fastmap_1.2.0          dbplyr_2.5.1           rmarkdown_2.30
## [22] UCSC.utils_1.6.0       bit_4.6.0              xfun_0.53
## [25] cachem_1.1.0           cigarillo_1.0.0        GenomeInfoDb_1.46.0
## [28] jsonlite_2.0.0         progress_1.2.3         blob_1.2.4
## [31] DelayedArray_0.36.0    BiocParallel_1.44.0    parallel_4.5.1
## [34] prettyunits_1.2.0      cluster_2.1.8.1        R6_2.6.1
## [37] bslib_0.9.0            stringi_1.8.7          RColorBrewer_1.1-3
## [40] rtracklayer_1.70.0     jquerylib_0.1.4        bookdown_0.45
## [43] iterators_1.0.14       knitr_1.50             Matrix_1.7-4
## [46] tidyselect_1.2.1       dichromat_2.0-0.1      abind_1.4-8
## [49] yaml_2.3.10            doParallel_1.0.17      codetools_0.2-20
## [52] curl_7.0.0             lattice_0.22-7         tibble_3.3.0
## [55] withr_3.0.2            KEGGREST_1.50.0        S7_0.2.0
## [58] evaluate_1.0.5         BiocFileCache_3.0.0    circlize_0.4.16
## [61] pillar_1.11.1          BiocManager_1.30.26    filelock_1.0.3
## [64] foreach_1.5.2          RCurl_1.98-1.17        hms_1.1.4
## [67] scales_1.4.0           glue_1.8.0             tools_4.5.1
## [70] BiocIO_1.20.0          XML_3.99-0.19          AnnotationDbi_1.72.0
## [73] colorspace_2.1-2       restfulr_0.0.16        cli_3.6.5
## [76] rappdirs_0.3.3         S4Arrays_1.10.0        dplyr_1.1.4
## [79] gtable_0.3.6           sass_0.4.10            digest_0.6.37
## [82] SparseArray_1.10.0     rjson_0.2.23           farver_2.1.2
## [85] memoise_2.0.1          htmltools_0.5.8.1      lifecycle_1.0.4
## [88] httr_1.4.7             GlobalOptions_0.1.2    bit64_4.6.0-1
```