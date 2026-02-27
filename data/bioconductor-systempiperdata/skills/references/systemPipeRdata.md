Code

* Show All Code
* Hide All Code

# *systemPipeRdata*: Workflow templates and sample data

Author: Le Zhang, Daniela Cassol, and Thomas Girke

#### Last update: 24 February, 2026

#### Package

systemPipeRdata 2.14.5

# 1 Introduction

[`systemPipeRdata`](https://www.bioconductor.org/packages/release/data/experiment/html/systemPipeRdata.html)
provides data analysis workflow templates compatible with the
[`systemPipeR`](https://www.bioconductor.org/packages/release/bioc/html/systemPipeR.html)
software package (H Backman and Girke [2016](#ref-H_Backman2016-bt)). The latter is a Workflow Management
System (WMS) for designing and running end-to-end analysis workflows with
automated report generation for a wide range of data analysis applications.
Support for running external software is provided by a command-line interface
(CLI) that adopts the Common Workflow Language (CWL). How to use `systemPipeR`
is explained in its main vignette
[here](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html).
The workflow templates provided by `systemPipeRdata` come equipped with sample
data and the necessary parameter files required to run a selected workflow.
This setup simplifies the learning process of using `systemPipeR`, facilitates
testing of workflows, and serves as a foundation for designing new workflows.
The standardized directory structure (Figure 1) utilized by the workflow
templates and their sample data is outlined in the [Directory
Structure](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#3_Directory_structure)
section of `systemPipeR's` main vignette.

![](data:image/png;base64...)

**Figure 1:** Directory structure of`systemPipeR's` workflows. For details, see [here](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#3_Directory_structure).

# 2 Getting started

## 2.1 Installation

The `systemPipeRdata` package is available at [Bioconductor](http://www.bioconductor.org/packages/release/data/experiment/html/systemPipeRdata.html) and can be installed from within R as follows.

```
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("systemPipeRdata")
```

## 2.2 Loading package and documentation

```
library("systemPipeRdata")  # Loads the package
```

```
library(help = "systemPipeRdata")  # Lists package info
vignette("systemPipeRdata")  # Opens vignette
```

# 3 Overview of workflow templates

An overview table of workflow templates, included in `systemPipeRdata`, can be
returned as shown below. By clicking the URLs in the last column of the below
workflow list, users can view the `Rmd` source file of a workflow, as well as
the final `HTML` report generated after running a workflow on the provided test
data. A list of the default data analysis steps included in each workflow is
given [here](#wf-template-steps). Additional workflow templates are available
on this project’s GitHub organization (for details, see
[below](#wf-github-collection)). To create an empty workflow template without
any test data included, users want to choose the `new` template, which includes
only the required directory structure and parameter files.

```
availableWF()
```

| Name | Description | URL |
| --- | --- | --- |
| new | Generic Workflow Template | [Rmd](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/new.Rmd), [HTML](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/new.html) |
| rnaseq | RNA-Seq Workflow Template | [Rmd](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRNAseq.Rmd), [HTML](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRNAseq.html) |
| riboseq | RIBO-Seq Workflow Template | [Rmd](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRIBOseq.Rmd), [HTML](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRIBOseq.html) |
| chipseq | ChIP-Seq Workflow Template | [Rmd](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeChIPseq.Rmd), [HTML](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeChIPseq.html) |
| varseq | VAR-Seq Workflow Template | [Rmd](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeVARseq.Rmd), [HTML](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeVARseq.html) |
| SPblast | BLAST Workflow Template | [Rmd](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPblast.Rmd), [HTML](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPblast.html) |
| SPcheminfo | Cheminformatics Drug Similarity Template | [Rmd](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPcheminfo.Rmd), [HTML](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPcheminfo.html) |
| SPscrna | Basic Single-Cell Workflow Template | [Rmd](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPscrna.Rmd), [HTML](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPscrna.html) |

**Table 1:** Workflow templates

# 4 Use workflow templates

## 4.1 Load a workflow

The chosen example below uses the `genWorkenvir` function from the
`systemPipeRdata` package to create an RNA-Seq workflow environment (selected
under `workflow="rnaseq"`) that is fully populated with a small test data set,
including FASTQ files, reference genome and annotation data. The name of the
resulting workflow directory can be specified under the `mydirname` argument.
The default `NULL` uses the name of the chosen workflow. An error is issued if
a directory of the same name and path exists already. After this, the user’s R
session needs to be directed into the resulting `rnaseq` directory (here with
`setwd`). The other workflow templates from the [above](#wf-bioc-collection)
table can be loaded the same way.

```
library(systemPipeRdata)
genWorkenvir(workflow = "rnaseq")
setwd("rnaseq")
```

On Linux and OS X systems the same can be achieved from the command-line of a
terminal with the following commands.

```
$ Rscript -e "systemPipeRdata::genWorkenvir(workflow='rnaseq', mydirname='rnaseq')"
$ cd rnaseq
```

## 4.2 Run and visualize workflow

For running and working with `systemPipeR` workflows, users want to visit
[systemPipeR’s main
vignette](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html).
The following gives only a very brief preview on how to run workflows, and create scientific
and technical reports.

After a workflow environment (directory) has been created and the corresponding
R session directed into the resulting directory (here `rnaseq`), the workflow
can be loaded from the included R Markdown file (`Rmd`, here `systemPipeRNAseq.Rmd`).
This template provides common data analysis steps that are typical for RNA-Seq
workflows. Users have the options to add, remove, modify workflow steps by
applying these changes to the `sal` workflow management container directly, or
updating the `Rmd` file first and then updating `sal` accordingly.

```
library(systemPipeR)
sal <- SPRproject()
sal <- importWF(sal, file_path = "systemPipeRNAseq.Rmd", verbose = FALSE)
```

The default analysis steps of the imported RNA-Seq workflow are listed below. Users
can modify the existing steps, add new ones or remove steps as needed.

**Default analysis steps in RNA-Seq Workflow**

1. Read preprocessing
   * Quality filtering (trimming)
   * FASTQ quality report
2. Alignments: *`HISAT2`* (or any other RNA-Seq aligner)
3. Alignment stats
4. Read counting
5. Sample-wise correlation analysis
6. Analysis of differentially expressed genes (DEGs)
7. GO term enrichment analysis
8. Gene-wise clustering

Once the workflow has been loaded into `sal`, it can be executed from start to
finish (or partially) with the `runWF` command. However, running the workflow
will only be possible if all dependent CL software is installed on a user’s
system. Their names and availability on a system can be listed with
`listCmdTools(sal, check_path=TRUE)`.

```
sal <- runWF(sal)
```

Workflows can be visualized as topology graphs using the `plotWF` function.

```
plotWF(sal)
```

![Toplogy graph of RNA-Seq workflow.](data:image/png;base64...)

Scientific and technical reports can be generated with the `renderReport` and
`renderLogs` functions, respectively. Scientific reports can also be generated
with the `render` function of the `rmarkdown` package. The technical reports are
based on log information that `systemPipeR` collects during workflow runs.

```
# Scietific report
sal <- renderReport(sal)
rmarkdown::render("systemPipeRNAseq.Rmd", clean = TRUE, output_format = "BiocStyle::html_document")

# Technical (log) report
sal <- renderLogs(sal)
```

# 5 Additional workflow templates

The project’s [GitHub Organization](https://github.com/systemPipeR) hosts a repository of workflow templates,
containing both well-established and experimental workflows. Within the R
environment, the same `availableWF` function mentioned [earlier](#load-wf) can be utilized to
retrieve a list of the workflows in this collection.

```
availableWF(github = TRUE)
```

```
Additional Workflow Templates in systemPipeR GitHub Organization:
       Workflow                                     Download URL
1     SPatacseq    https://github.com/systemPipeR/SPatacseq.git
2     SPclipseq    https://github.com/systemPipeR/SPclipseq.git
3      SPdenovo    https://github.com/systemPipeR/SPdenovo.git
4         SPhic    https://github.com/systemPipeR/SPhic.git
5   SPmetatrans    https://github.com/systemPipeR/SPmetatrans.git
6   SPmethylseq    https://github.com/systemPipeR/SPmethylseq.git
7    SPmirnaseq    https://github.com/systemPipeR/SPmirnaseq.git
8 SPpolyriboseq    https://github.com/systemPipeR/SPpolyriboseq.git
9    SPscrnaseq    https://github.com/systemPipeR/SPscrnaseq.git
```

To download these workflow templates, users can either run the below `git clone` command from a terminal, or visit the corresponding GitHub page of a
chosen workflow via the provided URLs, and then download it as a Zip file and
uncompress it. Note, the following lines of code need to be run from
a terminal (not R console, *e.g.* terminal in RStudio) on a system where
the `git` software is installed.

```
$ git clone <...> # Provide under <...> URL of chosen workflow from table above.
$ cd <Workflow Name>
```

After a workflow template has been downloaded, one can run it the same way as
outlined [above](#run-wf).

# 6 Useful functionalities

## 6.1 Create workflow templates interactively

It is possible to create a new workflow environment from RStudio. This can be
done by selecting `File -> New File -> R Markdown -> From Template -> systemPipeR New WorkFlow`.
This option creates a template workflow that has the expected directory structure
(see [here](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#3_Directory_structure)).

![](data:image/png;base64...)
**Figure 2:** Selecting workflow template within RStudio.

## 6.2 Return paths to sample data

The paths to the sample data provided by the `systemPipeRdata` package can be returned with the
the `pathList` function.

```
pathList()[1:2]
```

```
## $targets
## [1] "/tmp/RtmprrDnoW/Rinst364b47c88908/systemPipeRdata/extdata/param/targets.txt"
##
## $targetsPE
## [1] "/tmp/RtmprrDnoW/Rinst364b47c88908/systemPipeRdata/extdata/param/targetsPE.txt"
```

# 7 Analysis steps in selected workflows

The following gives an overview of the default data analysis steps used by selected workflow
templates included in the `systemPipeRdata` package (see [Table 1](#wf-bioc-collection)).
The workflows hosted on this project’s [GitHub Organization](#wf-github-collection) are
not considered here.

Any of the workflows included below can be loaded by assigning their name to
the `workflow` argument of the `genWorkenvir` function. The workflow names
can be looked up under the ‘Name’ column of [Table 1](#wf-bioc-collection).

```
library(systemPipeRdata)
genWorkenvir(workflow = "...")
```

## 7.1 Generic template

[ [Vignette](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/new.html) ]

This *Generic* workflow (named `new`) is intended to be used as a template for
creating new workflows from scratch where users can add steps by copying and
pasting existing R or CL steps as needed, and populate them with their own
code. In its current form, this mini workflow will export a test dataset to
multiple files, compress/decompress the exported files, import them back into
R, and then perform a simple statistical analysis and plot the results.

1. R step: export tabular data to files
2. CL step: compress files
3. CL step: uncompress files
4. R step: import files and plot summary statistics

## 7.2 RNA-Seq workflow

[ [Vignette](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRNAseq.html) ]

1. Read preprocessing
   * Quality filtering (trimming)
   * FASTQ quality report
2. Alignments: *`HISAT2`* (or any other RNA-Seq aligner)
3. Alignment stats
4. Read counting
5. Sample-wise correlation analysis
6. Analysis of differentially expressed genes (DEGs)
7. GO term enrichment analysis
8. Gene-wise clustering

## 7.3 ChIP-Seq Workflow

[ [Vignette](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeChIPseq.html) ]

1. Read preprocessing
   * Quality filtering (trimming)
   * FASTQ quality report
2. Alignments: *`Bowtie2`* or *`rsubread`*
3. Alignment stats
4. Peak calling: *`MACS2`*
5. Peak annotation with genomic context
6. Differential binding analysis
7. GO term enrichment analysis
8. Motif analysis

## 7.4 VAR-Seq Workflow

[ [Vignette](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeVARseq.html) ]

1. Read preprocessing
   +Quality filtering (trimming)
   +FASTQ quality report
2. Alignments: bwa or other
3. Variant calling: GATK, BCFtools
4. Variant filtering: VariantTools and VariantAnnotation
5. Variant annotation: VariantAnnotation
6. Combine results from many samples
7. Summary statistics of samp

## 7.5 Ribo-Seq Workflow

[ [Vignette](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRIBOseq.html) ]

1. Read preprocessing
   * Adaptor trimming and quality filtering
   * FASTQ quality report
2. Alignments: *`HISAT2`* (or any other RNA-Seq aligner)
3. Alignment stats
4. Compute read distribution across genomic features
5. Adding custom features to workflow (e.g. uORFs)
6. Genomic read coverage along transcripts
7. Read counting
8. Sample-wise correlation analysis
9. Analysis of differentially expressed genes (DEGs)
10. GO term enrichment analysis
11. Gene-wise clustering
12. Differential ribosome binding (translational efficiency)

## 7.6 scRNA-Seq Workflow

[ [Vignette](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPscrna.html) ]

1. Import of single cell read count data
2. Basic stats on input data
3. QC of cell count data
4. Cell filtering
5. Normalization
6. Identify high variable genes
7. Scaling
8. Embedding with tSNE, UMAP, and PCA
9. Cell clustering and marker gene classification
10. Cell type classification
11. Co-visualizatioin of cell types and clusters

## 7.7 BLAST Workflow

[ [Vignette](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPblast.html) ]

1. Load query sequences
2. Select and prepare BLASTable databases
3. Run BLAST against different databases

## 7.8 Cheminformatics Workflow

[ [Vignette](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/SPcheminfo.html) ]

1. Import small molecules stored in SDF file
2. Visualize small molecule structures
3. Create atom pair and finger print databases for structure similarity searching
4. Compute all-against-all structural similarities
5. Hierarchical clustering and PCA of structural similarities
6. Plot heat map

# 8 Version information

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
## [1] stats4    stats     graphics  grDevices utils
## [6] datasets  methods   base
##
## other attached packages:
##  [1] magrittr_2.0.4              systemPipeRdata_2.14.5
##  [3] systemPipeR_2.16.3          ShortRead_1.68.0
##  [5] GenomicAlignments_1.46.0    SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              MatrixGenerics_1.22.0
##  [9] matrixStats_1.5.0           BiocParallel_1.44.0
## [11] Rsamtools_2.26.0            Biostrings_2.78.0
## [13] XVector_0.50.0              GenomicRanges_1.62.1
## [15] IRanges_2.44.0              S4Vectors_0.48.0
## [17] Seqinfo_1.0.0               BiocGenerics_0.56.0
## [19] generics_0.1.4              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.56
##  [3] bslib_0.10.0        hwriter_1.3.2.1
##  [5] ggplot2_4.0.2       remotes_2.5.0
##  [7] htmlwidgets_1.6.4   latticeExtra_0.6-31
##  [9] lattice_0.22-9      vctrs_0.7.1
## [11] tools_4.5.2         bitops_1.0-9
## [13] parallel_4.5.2      tibble_3.3.1
## [15] pkgconfig_2.0.3     Matrix_1.7-4
## [17] RColorBrewer_1.1-3  S7_0.2.1
## [19] cigarillo_1.0.0     lifecycle_1.0.5
## [21] stringr_1.6.0       compiler_4.5.2
## [23] farver_2.1.2        deldir_2.0-4
## [25] textshaping_1.0.4   codetools_0.2-20
## [27] htmltools_0.5.9     sass_0.4.10
## [29] yaml_2.3.12         pillar_1.11.1
## [31] crayon_1.5.3        jquerylib_0.1.4
## [33] DelayedArray_0.36.0 cachem_1.1.0
## [35] abind_1.4-8         tidyselect_1.2.1
## [37] digest_0.6.39       stringi_1.8.7
## [39] dplyr_1.2.0         bookdown_0.46
## [41] fastmap_1.2.0       grid_4.5.2
## [43] cli_3.6.5           SparseArray_1.10.8
## [45] S4Arrays_1.10.1     dichromat_2.0-0.1
## [47] scales_1.4.0        rmarkdown_2.30
## [49] pwalign_1.6.0       jpeg_0.1-11
## [51] interp_1.1-6        otel_0.2.0
## [53] png_0.1-8           kableExtra_1.4.0
## [55] evaluate_1.0.5      knitr_1.51
## [57] viridisLite_0.4.3   rlang_1.1.7
## [59] Rcpp_1.1.1          glue_1.8.0
## [61] xml2_1.5.2          BiocManager_1.30.27
## [63] formatR_1.14        svglite_2.2.2
## [65] rstudioapi_0.18.0   jsonlite_2.0.0
## [67] R6_2.6.1            systemfonts_1.3.1
```

# 9 Funding

This project was supported by funds from the National Institutes of Health (NIH) and the National Science Foundation (NSF).

# References

H Backman, Tyler W, and Thomas Girke. 2016. “systemPipeR: NGS workflow and report generation environment.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.