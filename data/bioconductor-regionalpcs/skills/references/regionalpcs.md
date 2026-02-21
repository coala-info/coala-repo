# regionalpcs

Tiffany Eulalio

#### 15 January 2026

# Contents

* [1 regionalpcs](#regionalpcs)
* [2 Installation](#installation)
  + [2.0.1 Bioconductor Installation](#bioconductor-installation)
  + [2.0.2 Development Version Installation](#development-version-installation)
* [3 `regionalpcs` R Package Tutorial](#regionalpcs-r-package-tutorial)
  + [3.1 Loading Required Packages](#loading-required-packages)
  + [3.2 Load the Dataset](#load-the-dataset)
    - [3.2.1 Loading Minfi Sample Dataset](#loading-minfi-sample-dataset)
  + [3.3 Obtaining Methylation Array Probe Positions](#obtaining-methylation-array-probe-positions)
    - [3.3.1 Load Illumina 450k Array Probe Positions](#load-illumina-450k-array-probe-positions)
  + [3.4 Summarizing Gene Region Types](#summarizing-gene-region-types)
    - [3.4.1 Introduction](#introduction)
    - [3.4.2 Load Gene Region Annotations](#load-gene-region-annotations)
    - [3.4.3 Create a Region Map](#create-a-region-map)
    - [3.4.4 Summarizing Gene Regions with Regional Principal Components](#summarizing-gene-regions-with-regional-principal-components)
* [4 Session Information](#session-information)

# 1 regionalpcs

Navigating the complexity of DNA methylation data poses substantial challenges
due to its intricate biological patterns. The `regionalpcs` package is
conceived to address the substantial need for enhanced summarization and
interpretation at a regional level. Traditional methodologies, while
foundational, may not fully encapsulate the biological nuances of methylation
patterns, thereby potentially yielding interpretations that may be suboptimal
or veer towards inaccuracies. This package introduces and utilizes regional
principal components (rPCs), designed to adeptly capture biologically relevant
signals embedded within DNA methylation data. Through the implementation of
rPCs, researchers can gain new insights into complex interactions and
effects in methylation data that might otherwise be missed.

# 2 Installation

The `regionalpcs` package can be easily installed from Bioconductor, providing
you with the latest stable version suitable for general use. Alternatively,
for those interested in exploring or utilizing the latest features and
developments, the GitHub version can be installed directly.

### 2.0.1 Bioconductor Installation

Install `regionalpcs` from Bioconductor using the command below. Ensure
that your R version is compatible with the package version available on
Bioconductor for smooth installation and functionality.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")

BiocManager::install("regionalpcs")
```

### 2.0.2 Development Version Installation

To access the development version of `regionalpcs` directly from GitHub,
which might include new features or enhancements not yet available in the
Bioconductor version, use the following commands. Note that the development
version might be less stable than the officially released version.

```
# install devtools package if not already installed
if (!requireNamespace("devtools", quietly=TRUE))
    install.packages("devtools")

# download and install the regionalpcs package
devtools::install_github("tyeulalio/regionalpcs")
```

# 3 `regionalpcs` R Package Tutorial

## 3.1 Loading Required Packages

This tutorial depends on several Bioconductor packages. These packages should
be loaded at the beginning of the analysis.

```
library(regionalpcs)
library(GenomicRanges)
library(tidyr)
library(tibble)
library(dplyr)
library(minfiData)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
```

Let’s proceed to load the packages, briefly understanding their roles in
this tutorial.

* `regionalpcs`: Primary package for summarizing and interpreting DNA
  methylation data at a regional level.
* `GenomicRanges`: Facilitates representation and manipulation of genomic
  intervals and variables defined along a genome.
* `tidyr`, `tibble`, `dplyr`: Assist in data tidying, representation,
  and manipulation.
* `minfiData`: Provides example Illumina 450k data, aiding in the
  demonstration of `regionalpcs` functionalities.
* `TxDb.Hsapiens.UCSC.hg19.knownGene`: Accommodates transcriptome data,
  useful for annotating results.

Once the packages are loaded, we can start using the functions provided by each
package.

## 3.2 Load the Dataset

### 3.2.1 Loading Minfi Sample Dataset

In this tutorial, we’ll utilize a sample dataset, `MsetEx.sub`, which is a
subset derived from Illumina’s Human Methylation 450k dataset, specifically
preprocessed to contain 600 CpGs across 6 samples. The dataset is stored in a
`MethylSet` object, which is commonly used to represent methylation data.

The methylation beta values, denoting the proportion of methylated cytosines
at a particular CpG site, will be extracted from this dataset for our
subsequent analyses.

```
# Load the MethylSet data
data(MsetEx.sub)

# Display the first few rows of the dataset for a preliminary view
head(MsetEx.sub)
#> class: MethylSet
#> dim: 6 6
#> metadata(0):
#> assays(2): Meth Unmeth
#> rownames(6): cg00050873 cg00212031 ... cg00455876 cg01707559
#> rowData names(0):
#> colnames(6): 5723646052_R02C02 5723646052_R04C01 ... 5723646053_R05C02
#>   5723646053_R06C02
#> colData names(13): Sample_Name Sample_Well ... Basename filenames
#> Annotation
#>   array: IlluminaHumanMethylation450k
#>   annotation: ilmn12.hg19
#> Preprocessing
#>   Method: Raw (no normalization or bg correction)
#>   minfi version: 1.21.2
#>   Manifest version: 0.4.0

# Extract methylation M-values from the MethylSet
# M-values are logit-transformed beta-values and are often used in differential
# methylation analysis for improved statistical performance.
mvals <- getM(MsetEx.sub)

# Display the extracted methylation beta values
head(mvals)
#>            5723646052_R02C02 5723646052_R04C01 5723646052_R05C02
#> cg00050873          3.502348         0.4414491          4.340695
#> cg00212031         -3.273751         0.9234662         -2.614777
#> cg00213748          2.076816        -0.1309465          1.260995
#> cg00214611         -3.438838         1.7463950         -2.270551
#> cg00455876          1.839010        -0.9927320          1.619479
#> cg01707559         -3.303987        -0.6433201         -3.540887
#>            5723646053_R04C02 5723646053_R05C02 5723646053_R06C02
#> cg00050873        0.24458355        -0.3219281         0.2744392
#> cg00212031       -0.21052257        -0.6861413        -0.1397595
#> cg00213748       -1.10373279        -1.6616553        -0.1270869
#> cg00214611        0.29029649        -0.2103599        -0.6138630
#> cg00455876       -0.09504721        -0.2854655         0.6361273
#> cg01707559       -0.74835377        -0.4678048        -1.1345421
```

Note that `MsetEx.sub` provides a manageable slice of data that we can
utilize to illustrate the capabilities of `regionalpcs` without requiring
extensive computational resources.

Now that we have our dataset loaded and methylation values extracted,
let’s proceed with demonstrating the core functionalities of `regionalpcs`.

## 3.3 Obtaining Methylation Array Probe Positions

### 3.3.1 Load Illumina 450k Array Probe Positions

In this step, we’ll obtain the genomic coordinates of the CpG sites in our
methylation dataset using the 450k array probe annotations using the `minfi`
package.

```
# Map the methylation data to genomic coordinates using the mapToGenome
# function. This creates a GenomicMethylSet (gset) which includes genomic
# position information for each probe.
gset <- mapToGenome(MsetEx.sub)

# Display the GenomicMethylSet object to observe the structure and initial
# entries.
gset
#> class: GenomicMethylSet
#> dim: 600 6
#> metadata(0):
#> assays(2): Meth Unmeth
#> rownames(600): cg01003813 cg03723195 ... cg03930849 cg08265308
#> rowData names(0):
#> colnames(6): 5723646052_R02C02 5723646052_R04C01 ... 5723646053_R05C02
#>   5723646053_R06C02
#> colData names(13): Sample_Name Sample_Well ... Basename filenames
#> Annotation
#>   array: IlluminaHumanMethylation450k
#>   annotation: ilmn12.hg19
#> Preprocessing
#>   Method: Raw (no normalization or bg correction)
#>   minfi version: 1.21.2
#>   Manifest version: 0.4.0

# Convert the genomic position data into a GRanges object, enabling genomic
# range operations in subsequent analyses.
# The GRanges object (cpg_gr) provides a versatile structure for handling
# genomic coordinates in R/Bioconductor.
cpg_gr <- granges(gset)

# Display the GRanges object for a preliminary view of the genomic coordinates.
cpg_gr
#> GRanges object with 600 ranges and 0 metadata columns:
#>              seqnames    ranges strand
#>                 <Rle> <IRanges>  <Rle>
#>   cg01003813     chrX   2715058      *
#>   cg03723195     chrX   2847354      *
#>   cg00074638     chrX   2883307      *
#>   cg01728536     chrX   7070451      *
#>   cg01864404     chrX   8434367      *
#>          ...      ...       ...    ...
#>   cg26983430     chrY  24549675      *
#>   cg01757887     chrY  25114810      *
#>   cg00061679     chrY  25314171      *
#>   cg03930849     chrY  26716289      *
#>   cg08265308     chrY  28555550      *
#>   -------
#>   seqinfo: 2 sequences from hg19 genome; no seqlengths
```

## 3.4 Summarizing Gene Region Types

### 3.4.1 Introduction

Gene regions, which include functional segments such as promoters, gene bodies,
and intergenic regions, play pivotal roles in gene expression and regulation.
Summarizing methylation patterns across these regions can provide insights
into potential gene regulatory mechanisms and associations with phenotypes
or disease states. Herein, we will delve into how to succinctly summarize
methylation data at these crucial genomic segments using the `regionalpcs`
package.

### 3.4.2 Load Gene Region Annotations

First, let’s load the gene region annotations. Make sure to align the genomic
builds of your annotations and methylation data.

```
# Obtain promoter regions
# The TxDb object 'txdb' facilitates the retrieval of transcript-based
# genomic annotations.
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Extracting promoter regions with a defined upstream and downstream window.
# This GRanges object 'promoters_gr' will be utilized to map and summarize
# methylation data in promoter regions.
promoters_gr <- suppressMessages(promoters(genes(txdb),
                                    upstream=1000,
                                    downstream=0))

# Display the GRanges object containing the genomic coordinates of promoter
# regions.
promoters_gr
#> GRanges object with 28622 ranges and 1 metadata column:
#>         seqnames              ranges strand |     gene_id
#>            <Rle>           <IRanges>  <Rle> | <character>
#>       1    chr19   58874118-58875117      - |           1
#>      10     chr8   18247792-18248791      + |          10
#>     100    chr20   43280894-43281893      - |         100
#>    1000    chr18   25757911-25758910      - |        1000
#>   10000     chr1 244014382-244015381      - |       10000
#>     ...      ...                 ...    ... .         ...
#>    9991     chr9 115095934-115096933      - |        9991
#>    9992    chr21   35552030-35553029      + |        9992
#>    9993    chr22   19109968-19110967      - |        9993
#>    9994     chr6   90538613-90539612      + |        9994
#>    9997    chr22   50964891-50965890      - |        9997
#>   -------
#>   seqinfo: 298 sequences (2 circular) from hg19 genome
```

### 3.4.3 Create a Region Map

Creating a region map, which systematically assigns CpGs to specific gene
regions, stands as a crucial precursor to gene-region summarization using the
`regionalpcs` package. This mapping elucidates the physical positioning of
CpGs within particular gene regions, facilitating our upcoming endeavors to
comprehend how methylation varies across distinct genomic segments. We’ll use
the `create_region_map` function from the `regionalpcs` package. This function
takes two genomic ranges objects, `cpg_gr` contains CpG positions and `genes_gr`
contains gene region positions. Make sure both positions are aligned to the
same genome build (e.g. GrCH37, CrCH38).

```
# get the region map using the regionalpcs function
region_map <- regionalpcs::create_region_map(cpg_gr=cpg_gr,
                                                genes_gr=promoters_gr)

# Display the initial few rows of the region map.
head(region_map)
#>     gene_id     cpg_id
#> 1 100101121 cg05865243
#> 2 100101121 cg08242338
#> 3 100126270 cg03513471
#> 4 100131434 cg00466309
#> 5 100131755 cg03657257
#> 6 100132932 cg00243321
```

**Note:** The second column of `region_map` must contain values matching the
rownames of your methylation dataframe.

### 3.4.4 Summarizing Gene Regions with Regional Principal Components

In this final section, we’ll summarize gene regions using Principal
Components (PCs) to capture the maximum variation. We’ll utilize the
`compute_regional_pcs` function from the `regionalpcs` package for this.

#### 3.4.4.1 Compute Regional PCs

Let’s calculate the regional PCs using our gene regions for
demonstration purposes.

```
# Display head of region map
head(region_map)
#>     gene_id     cpg_id
#> 1 100101121 cg05865243
#> 2 100101121 cg08242338
#> 3 100126270 cg03513471
#> 4 100131434 cg00466309
#> 5 100131755 cg03657257
#> 6 100132932 cg00243321
dim(region_map)
#> [1] 224   2

# Compute regional PCs
res <- compute_regional_pcs(meth=mvals, region_map=region_map, pc_method="gd")
#> Using Gavish-Donoho method
```

#### 3.4.4.2 Inspecting the Output

The function returns a list containing multiple elements. Let’s first look at
what these elements are.

```
# Inspect the output list elements
names(res)
#> [1] "regional_pcs"     "percent_variance" "loadings"         "info"
```

#### 3.4.4.3 Extracting and Viewing Regional PCs

The first element (`res$regional_pcs`) is a data frame containing the
calculated regional PCs.

```
# Extract regional PCs
regional_pcs <- res$regional_pcs
head(regional_pcs)[1:4]
#>               5723646052_R02C02 5723646052_R04C01 5723646052_R05C02
#> 100101121-PC1        -6.1073435        3.72080283        -5.7450804
#> 100126270-PC1        -3.2940427        2.02802544        -3.7825506
#> 100131434-PC1        -3.8879495        1.82168108        -4.2354365
#> 100131755-PC1        -0.7592615        0.01247655        -0.7354440
#> 100132932-PC1        -0.7718594       -0.05416252        -1.3199530
#> 100133957-PC1        -2.0320262        0.19154436        -0.9193417
#>               5723646053_R04C02
#> 100101121-PC1          1.948004
#> 100126270-PC1          2.094130
#> 100131434-PC1          2.170768
#> 100131755-PC1          1.241555
#> 100132932-PC1         -1.475813
#> 100133957-PC1          1.190371
```

#### 3.4.4.4 Understanding the Results

The output is a data frame with regional PCs for each region as rows and our
samples as columns. This is our new representation of methylation values, now
on a gene regional PC scale. We can feed these into downstream analyses as is.

The number of regional PCs representing each gene region was determined by the
Gavish-Donoho method. This method allows us to identify PCs that capture actual
signal in our data and not the noise that is inherent in any dataset. To explore
alternative methods, we can change the `pc_method` parameter.

```
# Count the number of unique gene regions and PCs
regions <- data.frame(gene_pc = rownames(regional_pcs)) |>
    separate(gene_pc, into = c("gene", "pc"), sep = "-")
head(regions)
#>        gene  pc
#> 1 100101121 PC1
#> 2 100126270 PC1
#> 3 100131434 PC1
#> 4 100131755 PC1
#> 5 100132932 PC1
#> 6 100133957 PC1

# number of genes that have been summarized
length(unique(regions$gene))
#> [1] 143

# how many of each PC did we get
table(regions$pc)
#>
#> PC1
#> 143
```

We have summarized each of our genes using just one PC. The number of PCs
depends on three main factors: the number of samples, the number of CpGs in
the gene region, and the noise in the methylation data.

By default, the `compute_regional_pcs` function uses the Gavish-Donoho method.
However, we can also use the Marcenko-Pasteur method by setting the `pc_method`
parameter:

```
# Using Marcenko-Pasteur method
mp_res <- compute_regional_pcs(mvals, region_map, pc_method = "mp")
#> Using Marchenko-Pastur method

# select the regional pcs
mp_regional_pcs <- mp_res$regional_pcs

# separate the genes from the pc numbers
mp_regions <- data.frame(gene_pc = rownames(mp_regional_pcs)) |>
    separate(gene_pc, into = c("gene", "pc"), sep = "-")
head(mp_regions)
#>        gene  pc
#> 1 100101121 PC1
#> 2 100126270 PC1
#> 3 100131434 PC1
#> 4 100131755 PC1
#> 5 100132932 PC1
#> 6 100133957 PC1

# number of genes that have been summarized
length(unique(mp_regions$gene))
#> [1] 143

# how many of each PC did we get
table(mp_regions$pc)
#>
#> PC1
#> 143
```

The Marcenko-Pasteur and the Gavish-Donoho methods are both based on Random
Matrix Theory, and they aim to identify the number of significant PCs that
capture the true signal in the data and not just the noise. However, these
methods differ in how they select the number of significant PCs. The
Marcenko-Pasteur method typically selects more PCs to represent a gene region
compared to the Gavish-Donoho method. This may be due to the different ways in
which the two methods estimate the noise level in the data.

Ultimately, the choice between the two methods depends on the specific needs
and goals of the analysis. The Gavish-Donoho method tends to provide more
conservative results, while the Marcenko-Pasteur method may capture more of
the underlying signal in the data. Researchers should carefully consider
their objectives and the characteristics of their data when selecting a method.

# 4 Session Information

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#> [1] parallel  stats4    stats     graphics  grDevices utils     datasets
#> [8] methods   base
#>
#> other attached packages:
#>  [1] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
#>  [2] GenomicFeatures_1.62.0
#>  [3] AnnotationDbi_1.72.0
#>  [4] minfiData_0.56.0
#>  [5] IlluminaHumanMethylation450kanno.ilmn12.hg19_0.6.1
#>  [6] IlluminaHumanMethylation450kmanifest_0.4.0
#>  [7] minfi_1.56.0
#>  [8] bumphunter_1.52.0
#>  [9] locfit_1.5-9.12
#> [10] iterators_1.0.14
#> [11] foreach_1.5.2
#> [12] Biostrings_2.78.0
#> [13] XVector_0.50.0
#> [14] SummarizedExperiment_1.40.0
#> [15] Biobase_2.70.0
#> [16] MatrixGenerics_1.22.0
#> [17] matrixStats_1.5.0
#> [18] dplyr_1.1.4
#> [19] tibble_3.3.1
#> [20] tidyr_1.3.2
#> [21] GenomicRanges_1.62.1
#> [22] Seqinfo_1.0.0
#> [23] IRanges_2.44.0
#> [24] S4Vectors_0.48.0
#> [25] BiocGenerics_0.56.0
#> [26] generics_0.1.4
#> [27] regionalpcs_1.8.0
#> [28] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3        jsonlite_2.0.0
#>   [3] magrittr_2.0.4            farver_2.1.2
#>   [5] rmarkdown_2.30            BiocIO_1.20.0
#>   [7] vctrs_0.6.5               multtest_2.66.0
#>   [9] memoise_2.0.1             Rsamtools_2.26.0
#>  [11] DelayedMatrixStats_1.32.0 RCurl_1.98-1.17
#>  [13] askpass_1.2.1             htmltools_0.5.9
#>  [15] S4Arrays_1.10.1           curl_7.0.0
#>  [17] Rhdf5lib_1.32.0           SparseArray_1.10.8
#>  [19] rhdf5_2.54.1              sass_0.4.10
#>  [21] nor1mix_1.3-3             bslib_0.9.0
#>  [23] plyr_1.8.9                cachem_1.1.0
#>  [25] GenomicAlignments_1.46.0  lifecycle_1.0.5
#>  [27] pkgconfig_2.0.3           rsvd_1.0.5
#>  [29] Matrix_1.7-4              R6_2.6.1
#>  [31] fastmap_1.2.0             digest_0.6.39
#>  [33] siggenes_1.84.0           reshape_0.8.10
#>  [35] dqrng_0.4.1               irlba_2.3.5.1
#>  [37] RSQLite_2.4.5             beachmat_2.26.0
#>  [39] base64_2.0.2              PCAtools_2.22.1
#>  [41] RMTstat_0.3.1             httr_1.4.7
#>  [43] abind_1.4-8               compiler_4.5.2
#>  [45] beanplot_1.3.1            rngtools_1.5.2
#>  [47] withr_3.0.2               bit64_4.6.0-1
#>  [49] S7_0.2.1                  BiocParallel_1.44.0
#>  [51] DBI_1.2.3                 HDF5Array_1.38.0
#>  [53] MASS_7.3-65               openssl_2.3.4
#>  [55] DelayedArray_0.36.0       rjson_0.2.23
#>  [57] tools_4.5.2               otel_0.2.0
#>  [59] rentrez_1.2.4             glue_1.8.0
#>  [61] quadprog_1.5-8            h5mread_1.2.1
#>  [63] restfulr_0.0.16           nlme_3.1-168
#>  [65] rhdf5filters_1.22.0       grid_4.5.2
#>  [67] reshape2_1.4.5            gtable_0.3.6
#>  [69] tzdb_0.5.0                preprocessCore_1.72.0
#>  [71] data.table_1.18.0         hms_1.1.4
#>  [73] ScaledMatrix_1.18.0       BiocSingular_1.26.1
#>  [75] xml2_1.5.1                stringr_1.6.0
#>  [77] ggrepel_0.9.6             pillar_1.11.1
#>  [79] limma_3.66.0              genefilter_1.92.0
#>  [81] splines_4.5.2             lattice_0.22-7
#>  [83] survival_3.8-3            rtracklayer_1.70.1
#>  [85] bit_4.6.0                 GEOquery_2.78.0
#>  [87] annotate_1.88.0           tidyselect_1.2.1
#>  [89] knitr_1.51                bookdown_0.46
#>  [91] xfun_0.55                 scrime_1.3.5
#>  [93] statmod_1.5.1             stringi_1.8.7
#>  [95] yaml_2.3.12               evaluate_1.0.5
#>  [97] codetools_0.2-20          cigarillo_1.0.0
#>  [99] BiocManager_1.30.27       cli_3.6.5
#> [101] xtable_1.8-4              jquerylib_0.1.4
#> [103] dichromat_2.0-0.1         Rcpp_1.1.1
#> [105] png_0.1-8                 XML_3.99-0.20
#> [107] ggplot2_4.0.1             readr_2.1.6
#> [109] blob_1.3.0                mclust_6.1.2
#> [111] doRNG_1.8.6.2             sparseMatrixStats_1.22.0
#> [113] bitops_1.0-9              scales_1.4.0
#> [115] illuminaio_0.52.0         purrr_1.2.1
#> [117] crayon_1.5.3              rlang_1.1.7
#> [119] cowplot_1.2.0             KEGGREST_1.50.0
```