# metabinR

Anestis Gkanogiannis\*

\*anestis@gkanogiannis.com

#### 30 October 2025

#### Package

metabinR 1.12.0

# Contents

* [1 About metabinR](#about-metabinr)
* [2 Installation](#installation)
* [3 Preparation](#preparation)
  + [3.1 Allocate RAM and load required libraries](#allocate-ram-and-load-required-libraries)
* [4 Abundance based binning example](#abundance-based-binning-example)
* [5 Composition based binning example](#composition-based-binning-example)
* [6 Hierarchical (2step ABxCB) binning example](#hierarchical-2step-abxcb-binning-example)
* [7 Session Info](#session-info)

# 1 About metabinR

The goal of metabinR is to provide functions for performing abundance and
composition based binning on metagenomic samples, directly from FASTA or
FASTQ files.

Abundance based binning is performed by analyzing sequences with long kmers
(k>8), whereas composition based binning is performed by utilizing short kmers
(k<8).

# 2 Installation

To install `metabinR` package:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("metabinR")
```

# 3 Preparation

## 3.1 Allocate RAM and load required libraries

In order to allocate RAM, a special parameter needs to be passed while JVM
initializes. JVM parameters can be passed by setting `java.parameters` option.
The `-Xmx` parameter, followed (without space) by an integer value and a
letter, is used to tell JVM what is the maximum amount of heap RAM that it can
use. The letter in the parameter (uppercase or lowercase), indicates RAM units.
For example, parameters `-Xmx1024m` or `-Xmx1024M` or `-Xmx1g` or `-Xmx1G`, all
allocate 1 Gigabyte or 1024 Megabytes of maximum RAM for JVM.

```
options(java.parameters="-Xmx1500M")
unloadNamespace("metabinR")
library(metabinR)
library(data.table)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(cvms)
library(sabre)
```

# 4 Abundance based binning example

In this example we use the simulated metagenome sample (see sample data) to
perform abundance based binning.
The simulated metagenome contains 26664 Illumina reads (13332 pairs of 2x150bp)
that have been sampled from 10 bacterial genomes in such a way
(log-norm abundances) that each read is belongs to one of two abundance classes
(class 1 of high abundant taxa and class 2 of low abundant taxa).

We first get the abundance information for the simulated metagenome :

```
abundances <- read.table(
    system.file("extdata", "distribution_0.txt",package = "metabinR"),
    col.names = c("genome_id", "abundance" ,"AB_id"))
```

In `abundances` data.frame, column `genome_id` is the bacterial genome id,
column `abundance` is the abundance ratio
and column `AB_id` is the original abundance class (in this example 1 or 2).

Then we get the read mapping information (from which bacterial genome
each read is originating from and in which abundance class belongs) :

```
reads.mapping <- fread(system.file("extdata", "reads_mapping.tsv.gz",
                                   package = "metabinR")) %>%
    merge(abundances[, c("genome_id","AB_id")], by = "genome_id") %>%
    arrange(anonymous_read_id)
```

In `reads.mapping` data.frame, column `anonymous_read_id` is the read id,
column `genome_id` is the original bacterial genome id and
column `AB_id` is the original abundance class id.

We perform Abundance based Binning on the simulated reads,
for 2 abundance classes and analyzing data with 10-mers.
The call returns a dataframe of the assigned abundance cluster
and distances to all clusters for each read :

```
assignments.AB <- abundance_based_binning(
        system.file("extdata","reads.metagenome.fasta.gz", package="metabinR"),
        numOfClustersAB = 2,
        kMerSizeAB = 10,
        dryRun = FALSE,
        outputAB = "vignette") %>%
    arrange(read_id)
```

Note that read id of fasta header
matches `anonymous_read_id` of `reads.mapping`.

Call to will produce 2 fasta file,
one for each of the abundance classes, containing fasta reads assigned to each
class.
It will also produce a file containing histogram information of kmers counted.
We can plot this histogram as :

```
histogram.AB <- read.table("vignette__AB.histogram.tsv", header = TRUE)
ggplot(histogram.AB, aes(x=counts, y=frequency)) +
    geom_area() +
    labs(title = "kmer counts histogram") +
    theme_bw()
```

![](data:image/png;base64...)

We get the assigned abundance class for each read in `assignments.AB$AB`

Then we evaluate predicted abundance class and plot confusion matrix :

```
eval.AB.cvms <- cvms::evaluate(data = data.frame(
                                    prediction=as.character(assignments.AB$AB),
                                    target=as.character(reads.mapping$AB_id),
                                    stringsAsFactors = FALSE),
                                target_col = "target",
                                prediction_cols = "prediction",
                                type = "binomial"
)
eval.AB.sabre <- sabre::vmeasure(as.character(assignments.AB$AB),
                                as.character(reads.mapping$AB_id))

p <- cvms::plot_confusion_matrix(eval.AB.cvms) +
        labs(title = "Confusion Matrix",
                x = "Target Abundance Class",
                y = "Predicted Abundance Class")
tab <- as.data.frame(
    c(
        Accuracy =  round(eval.AB.cvms$Accuracy,4),
        Specificity =  round(eval.AB.cvms$Specificity,4),
        Sensitivity =  round(eval.AB.cvms$Sensitivity,4),
        Fscore =  round(eval.AB.cvms$F1,4),
        Kappa =  round(eval.AB.cvms$Kappa,4),
        Vmeasure = round(eval.AB.sabre$v_measure,4)
    )
)
grid.arrange(p, ncol = 1)
```

![](data:image/png;base64...)

```
knitr::kable(tab, caption = "AB binning evaluation", col.names = NULL)
```

Table 1: AB binning evaluation

|  |  |
| --- | --- |
| Accuracy | 0.8700 |
| Specificity | 0.9058 |
| Sensitivity | 0.7608 |
| Fscore | 0.7430 |
| Kappa | 0.6560 |
| Vmeasure | 0.3553 |

# 5 Composition based binning example

In a similar way, we analyze the simulated metagenome sample
with the Composition based Binning module.

The simulated metagenome contains 26664 Illumina reads (13332 pairs of 2x150bp)
that have been sampled from 10 bacterial genomes.
The originating bacteria genome is therefore the true class information of
each read in this example.

We first get the read mapping information (from which bacterial genome each
read is originating from) :

```
reads.mapping <- fread(
        system.file("extdata", "reads_mapping.tsv.gz",package = "metabinR")) %>%
    arrange(anonymous_read_id)
```

In `reads.mapping` data.frame, column `anonymous_read_id` is the read id and
column `genome_id` is the original bacterial genome id.

We perform Composition based Binning on the simulated reads,
for 10 composition classes (one for each bacterial genome) and analyzing data
with 6-mers.
The call returns a dataframe of the assigned composition cluster
and distances to all clusters for each read :

```
assignments.CB <- composition_based_binning(
        system.file("extdata","reads.metagenome.fasta.gz",package ="metabinR"),
        numOfClustersCB = 10,
        kMerSizeCB = 4,
        dryRun = TRUE,
        outputCB = "vignette") %>%
    arrange(read_id)
```

Note that read id of fasta header
matches `anonymous_read_id` of `reads.mapping`.

Since this is a clustering problem, it only makes sense to calculate `Vmeasure`
and other an extrinsic measures like `Homogeneity` and `completeness`.

```
eval.CB.sabre <- sabre::vmeasure(as.character(assignments.CB$CB),
                                as.character(reads.mapping$genome_id))
tab <- as.data.frame(
    c(
        Vmeasure = round(eval.AB.sabre$v_measure,4),
        Homogeneity = round(eval.AB.sabre$homogeneity,4),
        Completeness = round(eval.AB.sabre$completeness,4)
    )
)
knitr::kable(tab, caption = "CB binning evaluation", col.names = NULL)
```

Table 2: CB binning evaluation

|  |  |
| --- | --- |
| Vmeasure | 0.3553 |
| Homogeneity | 0.3514 |
| Completeness | 0.3594 |

# 6 Hierarchical (2step ABxCB) binning example

Finally, we analyze the simulated metagenome sample
with the Hierarchical Binning module.

The simulated metagenome contains 26664 Illumina reads (13332 pairs of 2x150bp)
that have been sampled from 10 bacterial genomes.
The originating bacteria genome is therefore the true class information of
each read in this example.

We first get the read mapping information (from which bacterial genome each
read is originating from) :

```
reads.mapping <- fread(
        system.file("extdata", "reads_mapping.tsv.gz",package = "metabinR")) %>%
    arrange(anonymous_read_id)
```

In `reads.mapping` data.frame, column `anonymous_read_id` is the read id and
column `genome_id` is the original bacterial genome id.

We perform Hierarchical Binning on the simulated reads,
for initially 2 abundance classes.
Data is analyzed with 10-mers for the AB part
and with 4-mers for the following CB part.
The call returns a dataframe of the assigned final hierarchical cluster (ABxCB)
and distances to all clusters for each read :

```
assignments.ABxCB <- hierarchical_binning(
        system.file("extdata","reads.metagenome.fasta.gz",package ="metabinR"),
        numOfClustersAB = 2,
        kMerSizeAB = 10,
        kMerSizeCB = 4,
        dryRun = TRUE,
        outputC = "vignette") %>%
    arrange(read_id)
```

Note that read id of fasta header
matches `anonymous_read_id` of `reads.mapping`.

Calculate `Vmeasure`
and other an extrinsic measures like `Homogeneity` and `completeness`.

```
eval.ABxCB.sabre <- sabre::vmeasure(as.character(assignments.ABxCB$ABxCB),
                                    as.character(reads.mapping$genome_id))
tab <- as.data.frame(
    c(
        Vmeasure = round(eval.ABxCB.sabre$v_measure,4),
        Homogeneity = round(eval.ABxCB.sabre$homogeneity,4),
        Completeness = round(eval.ABxCB.sabre$completeness,4)
    )
)
knitr::kable(tab, caption = "ABxCB binning evaluation", col.names = NULL)
```

Table 3: ABxCB binning evaluation

|  |  |
| --- | --- |
| Vmeasure | 0.2830 |
| Homogeneity | 0.4722 |
| Completeness | 0.2021 |

Clean files :

```
unlink("vignette__*")
```

# 7 Session Info

```
utils::sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
#>  [3] LC_TIME=en_GB                 LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
#>  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
#> [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] sabre_0.4.3       cvms_1.8.1        gridExtra_2.3     ggplot2_4.0.0
#> [5] dplyr_1.1.4       data.table_1.17.8 metabinR_1.12.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6            xfun_0.53               bslib_0.9.0
#>  [4] raster_3.6-32           htmlwidgets_1.6.4       rJava_1.0-11
#>  [7] lattice_0.22-7          yulab.utils_0.2.1       vctrs_0.6.5
#> [10] tools_4.5.1             generics_0.1.4          tibble_3.3.0
#> [13] proxy_0.4-27            pkgconfig_2.0.3         R.oo_1.27.1
#> [16] KernSmooth_2.23-26      ggnewscale_0.5.2        ggplotify_0.1.3
#> [19] checkmate_2.3.3         RColorBrewer_1.1-3      S7_0.2.0
#> [22] lifecycle_1.0.4         compiler_4.5.1          farver_2.1.2
#> [25] tinytex_0.57            terra_1.8-70            codetools_0.2-20
#> [28] ggimage_0.3.4           ggfun_0.2.0             fontLiberation_0.1.0
#> [31] fontquiver_0.2.1        htmltools_0.5.8.1       class_7.3-23
#> [34] sass_0.4.10             yaml_2.3.10             pillar_1.11.1
#> [37] jquerylib_0.1.4         tidyr_1.3.1             R.utils_2.13.0
#> [40] classInt_0.4-11         cachem_1.1.0            entropy_1.3.2
#> [43] magick_2.9.0            fontBitstreamVera_0.1.1 tidyselect_1.2.1
#> [46] digest_0.6.37           sf_1.0-21               purrr_1.1.0
#> [49] bookdown_0.45           labeling_0.4.3          rsvg_2.7.0
#> [52] fastmap_1.2.0           grid_4.5.1              cli_3.6.5
#> [55] magrittr_2.0.4          dichromat_2.0-0.1       e1071_1.7-16
#> [58] withr_3.0.2             rappdirs_0.3.3          gdtools_0.4.4
#> [61] scales_1.4.0            backports_1.5.0         sp_2.2-0
#> [64] rmarkdown_2.30          R.methodsS3_1.8.2       evaluate_1.0.5
#> [67] knitr_1.50              gridGraphics_0.5-1      rlang_1.1.6
#> [70] ggiraph_0.9.2           Rcpp_1.1.0              glue_1.8.0
#> [73] DBI_1.2.3               BiocManager_1.30.26     pROC_1.19.0.1
#> [76] jsonlite_2.0.0          R6_2.6.1                plyr_1.8.9
#> [79] fs_1.6.6                systemfonts_1.3.1       units_1.0-0
```