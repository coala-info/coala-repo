# Using methylscaper to visualize joint methylation and nucleosome occupancy data

Rhonda Bacher1 and Parker Knight1

1University of Florida

#### 30 October 2025

#### Package

methylscaper 1.18.0

# Contents

* [1 Introduction](#introduction)
* [2 Getting Started](#getting-started)
  + [2.1 Installation](#installation)
  + [2.2 Load the package](#load-the-package)
* [3 Visualizing single-cell data](#visualizing-single-cell-data)
  + [3.0.1 Example data for single-cell data](#example-data-for-single-cell-data)
  + [3.0.2 Preprocessing in the Shiny app](#preprocessing-in-the-shiny-app)
  + [3.1 Preprocessing using methylscaper functions](#preprocessing-using-methylscaper-functions)
  + [3.2 Visualization in the Shiny app](#vizinApp)
  + [3.3 Visualization using methylscaper functions](#visualization-using-methylscaper-functions)
    - [3.3.1 Accessing gene positions via biomaRt objects](#accessing-gene-positions-via-biomart-objects)
* [4 Visualizing single-molecule data](#visualizing-single-molecule-data)
  + [4.0.1 Preprocessing in the Shiny app](#preprocessing-in-the-shiny-app-1)
  + [4.0.2 Preprocessing using methylscaper functions](#preprocessing-using-methylscaper-functions-1)
  + [4.0.3 Visualization in the Shiny app](#visualization-in-the-shiny-app)
  + [4.0.4 Visualization using the methylscaper functions](#visualization-using-the-methylscaper-functions)
* [5 Additional summary plots](#additional-summary-plots)
* [6 FAQ](#faq)
* [7 SessionInfo](#sessioninfo)

# 1 Introduction

`methylscaper` is an R package for visualizing data that jointly profile endogenous methylation and chromatin accessibility (MAPit, NOMe-seq, scNMT-seq, nanoNOMe, etc.). The package offers pre-processing for single-molecule data and accepts input from Bismark (or similar alignment programs) for single-cell data. A common interface for visualizing both data types is done by generating ordered representational methylation-state matrices. The package provides a Shiny app to allow for interactive and optimal ordering of the individual DNA molecules to discover methylation patterns and nucleosome positioning.

**Note:** If you use methylscaper in your research, please cite [our manuscript.](https://pubmed.ncbi.nlm.nih.gov/34125875/)

If, after reading this vignette you have questions, please submit your question on GitHub: [Question or Report Issue](https://github.com/rhondabacher/methylscaper/issues). This will notify the package maintainers and benefit other users.

# 2 Getting Started

## 2.1 Installation

For local use of `methylscaper`, it can be installed into R from Bioconductor (using R version >= 4.4.0):

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("methylscaper")
```

## 2.2 Load the package

After successful installation, load the package into the working space.

```
library(methylscaper)
```

To access the Shiny app, simply run:

```
methylscaper()
```

# 3 Visualizing single-cell data

For visualizing single-cell data from methods such as scNMT-seq, methylscaper begins with pre-aligned data. For each cell, there should be two files, one for the GCH sites and another for the HCG sites. The minimal number of columns needed for methylscaper is three: chromosome, position, and methylation status. This type of file is generated via the “Bismark\_methylation\_extractor” script in the Bismark software tool. The extractor function outputs files in four or six column output files (see bedGraph option described here: <https://felixkrueger.github.io/Bismark/options/methylation_extraction/>). Methylscaper will accept these and convert to the three column format internally.

Due to the large file size, methylscaper further processes the data for the visualization analysis to the chromosome level. In the Shiny app, first select all files associated with the endogenous methylation and then select all files associated with accessibility. The files should be named in such a way that the file pairs can be inferred (e.g “Expr1\_Sample1\_met” pairs with “Expr1\_Sample1\_acc”). Finally, indicate the desired chromosome to filter to the chromosome level.

### 3.0.1 Example data for single-cell data

Below we walk through an example using data from Clark et al., 2018, obtained from
[GSE109262](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE109262). For
the sake of this example, we assume that the `GSE109262_RAW.tar`
directory is downloaded locally to `~/Downloads/`.

### 3.0.2 Preprocessing in the Shiny app

In the screenshot below, the data from GSE10926 data on chromosome 19 is ready for processing. When selecting “Browse…”, be sure to select **all** relevant files for each methylation type.

![](data:image/png;base64...)

Screenshot: Preprocessing tab for single-cell data

## 3.1 Preprocessing using methylscaper functions

The preprocessing can also be done in the R console directly, which allows for additional start and end specifications. For the purpose of creating a small example to include in the package, we additionally restricted the data between base pairs 8,947,041 to 8,987,041, which is centered around the *Eef1g* gene. In practice, we advise users to filter to just the chromosome level to keep the region relatively large. The [Visualization tab](vizinApp) allows for a more refined search along the chromosome and is described in a section below.

When using methylscaper within R, rather than specifying all the files individually, simply point to a folder which contains two subfolders with the accessibility and endogenous methylation files. These subfolders must be named “acc” and “met”, respectively.

```
filepath <- "~/Downloads/GSE109262_RAW/"
singlecell_subset <- subsetSC(filepath, chromosome = 19, startPos = 8937041, endPos = 8997041)
# To save for later, save as an rds file and change the folder location as desired:
saveRDS(singlecell_subset, "~/Downloads/singlecell_subset.rds")
```

For a reproducible example, we have provided three cells for [download](https://rbacher.rc.ufl.edu/methylscaper/content/exampledata.html), and below we run an example where we read the data directly from the URLs into R and use the subsetSC function. If you choose to download these files, then the directions above should be followed by moving the files into subfolders named “acc” and “met”.

```
gse_subset_path <- list(
    c(
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936197_ESC_A08_CpG-met_processed.tsv.gz",
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936196_ESC_A07_CpG-met_processed.tsv.gz",
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936192_ESC_A03_CpG-met_processed.tsv.gz"
    ),
    c(
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936197_ESC_A08_GpC-acc_processed.tsv.gz",
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936196_ESC_A07_GpC-acc_processed.tsv.gz",
        "https://rbacher.rc.ufl.edu/methylscaper/data/GSE109262_SUBSET/GSM2936192_ESC_A03_GpC-acc_processed.tsv.gz"
    ),
    c("GSM2936197_ESC_A08_CpG-met_processed", "GSM2936196_ESC_A07_CpG-met_processed", "GSM2936192_ESC_A03_CpG-met_processed"),
    c("GSM2936197_ESC_A08_GpC-acc_processed", "GSM2936196_ESC_A07_GpC-acc_processed", "GSM2936192_ESC_A03_GpC-acc_processed")
)
# This formatting is a list of 4 objects: the met file urls, the acc file urls, the met file names, and the acc file names.
options(timeout = 1000)
singlecell_subset <- subsetSC(gse_subset_path, chromosome = 19, startPos = 8937041, endPos = 8997041)

# To save for later, save as an rds file and change the folder location as desired:
# saveRDS(singlecell_subset, "~/Downloads/singlecell_subset.rds")
```

To fully demonstrate the example using the three cells subset, we skip some explanations of the functions and show the resulting plot. For this particular region only one of the three cells has coverage and thus only one row is shown in the plot (if a cell has no data in the entire region then it is not shown in the plot rather than being plot as missing data). All functions are further explained in detail in the following sections.

```
data("mouse_bm")
gene.select <- subset(mouse_bm, mgi_symbol == "Eef1g")

startPos <- 8966841
endPos <- 8967541
prepSC.out <- prepSC(singlecell_subset, startPos = startPos, endPos = endPos)

orderObj <- initialOrder(prepSC.out)
plotSequence(orderObj, Title = "Eef1g gene", plotFast = TRUE, drawKey = FALSE)
```

![](data:image/png;base64...)

## 3.2 Visualization in the Shiny app

The screenshot below is of the Visualization tab in the methylscaper Shiny app. First, indicate the location of the singlecell\_subset.rds file. Once the file is loaded, we have included preset gene locations for Mouse (GRCm39) and Human (GRCh38), so that a gene can be selected. The input box can also be typed in and genes will begin to appear; this is the easiest way to navigate. The default start and end positions are those of the entire gene, however, a slider will appear that allows the user to refine the genomic location of interest. The start and end positions can also be manually entered. For any other organism, the start and end positions should be entered manually.

In the visualization, two plots will appear. They both represent the same genomic region, but they are colored based on either HCGH or GCH sites. The x-axis represents the genomic location, and the y-axis is each individual cell. The left plot contains the genomic region mapped to HCG sites (sites are indicated by tick marks at the top), and the right plot contains the genomic region mapped to GCH sites. For HCG (i.e. endogenous methylation), methylscaper colors patches in between each HCG site as follows: If two consecutive HCG sites are methylated, a red patch is present. If two consecutive HCG sites are unmethylated, a black patch is present. If two consecutive HCG sites are inconsistently methylated, a gray border or patch appears. For GCH (i.e. accessibility), methylscaper colors patches as follows: yellow patches occur between two methylated sites (an accessible region), black patches occur between two unmethylated sites (inaccessible region), and gray patches occur between inconsistent methylation of consecutive sites. Any missing data (e.g. no reads covered that region for a particular cell) will show up as a white patch in either plot.

![](data:image/png;base64...)

Screenshot: Visualization of the *Tut1* gene

Once a region is chosen, the default ordering by methylscaper is the unweighted PCA. The user is then able to dynamically weight and refine the plot via Shiny’s brushing mechanics. The user can click and drag the mouse across the plot horizontally to choose which bases (i.e. columns) should be weighted in the global PCA ordering. The plot will update and two green lines will appear to indicate the weighting positions (note that these are not included once the plot is downloaded).

With “PCA” selected as the seriation method, the new ordering will be generated with a weighted Principal Components Analysis. The weighting is done on the proportion of methylation within the specified region. We recommend using “PCA” as the ordering method. However, for comparison purposes, we have also included the “ARSA” method. In ARSA the ordering is found by first building a weighted Euclidean distance matrix, which is then passed to the Simulated Annealing algorithm in the seriation package. This method tends to work well on smaller datasets, but due to computational inefficiency, it is generally not recommended for very large datasets at this time.

The next (optional) step is to locally refine the ordering of reads. In this case, select refinement and begin to click and drag the mouse vertically to choose which cells should be reordered. Blue lines will be drawn to indicate the refined cells. PCA is used by default and is also recommended, however, we provide hierarchical clustering as an option for the refinement method in the Shiny app for comparison purposes. Unlike re-weightings, refinements to the sequence plot stack onto each other, and several refinements can be done to a single plot before exporting. However, it is important to note that re-weighting the sites will reorder the entire set of data, and hence will undo any refinements that you may have made.

After making any desired changes, the sequence plot can be saved as either a PNG or PDF file. Additionally, `methylscaper` keeps track of all changes made to the plots in the form of a changes log, which can be saved as a text file.

The final plot and a log indicating the weighting and refinement choices for reproducibility can then be downloaded.

## 3.3 Visualization using methylscaper functions

The visualization can be done using methylscaper functions as well. Each function is described individually below. There are some additional options the user can control when using the functions within the R console.

```
# If you followed the preprocessing code above, then you can do:
# mydata <- readRDS("~/Downloads/singlecell_subset.rds")
# Otherwise, we have also included this subset in the package directly:
mydata <- system.file("extdata", "singlecell_subset.rds", package = "methylscaper")
mydata <- readRDS(mydata)
gene <- "Eef1g"
data("mouse_bm") # for human use human_bm
gene.select <- subset(mouse_bm, mgi_symbol == gene)
# We will further subset the region to a narrow region of the gene: from 8966841bp to 8967541bp
startPos <- 8966841
endPos <- 8967541

# This subsets the data to a specific region and prepares the data for visualization:
prepSC.out <- prepSC(mydata, startPos = startPos, endPos = endPos)

# Next the cells are ordered using the PCA approach and plot
orderObj <- initialOrder(prepSC.out)
plotSequence(orderObj, Title = "Eef1g gene", plotFast = TRUE)
```

![](data:image/png;base64...)

```
# We plot the nucleosome size key by default, however this can be turned off via drawKey = FALSE:
# plotSequence(orderObj, Title = "Eef1g gene", plotFast=TRUE, drawKey = FALSE)
```

The function `prepSC` generates the `gch` and `hcg` objects, which are matrices representing accessibility
and methylation status, respectively. These matrices are used by other
`methylscaper` functions for visualization and summary plots.

The `initialOrder` function computes an ordering of the state matrices, using a given method. By default, the function uses our PCA-based ordering, which we find optimally and efficiently scales to large datasets, though we have written the function to allow any method supported by the `seriation` package to be input to the Method parameter.

To perform the weighted ordering, either on the methylation or accessibility status, we can indicate the positions as follows. The `weightFeature` should be either for ‘met’ (endogenous methylation) or ‘acc’ (accessibility).

```
orderObj <- initialOrder(prepSC.out,
    weightStart = 47, weightEnd = 358, weightFeature = "acc"
)
```

The sequence plot is then generated with the `plotSequence` function. The option ‘plotFast’ sets the plot parameter useRaster to TRUE, which generates a fast-loading bitmap image. To save with high resolution, change ‘plotFast’ to TRUE. In the Shiny app, the download button automatically generates the high resolution version.

```
plotSequence(orderObj, Title = "Eef1g gene", plotFast = TRUE)
```

![](data:image/png;base64...)

We can also refine the ordering of the reads with `refineFunction`,
which reorders a subset of the reads with a given method. The
code below reorders the first 20 cells and generates a new sequence plot.

```
orderObj$order1 <- refineFunction(orderObj, refineStart = 1, refineEnd = 20)
plotSequence(orderObj, Title = "Eef1g gene", plotFast = TRUE)
```

![](data:image/png;base64...)

Within R, there is more control over the output resolution of the plot. For example, we can
control the resolution when outputting as a PNG. Note that saving as PNG with the best quality and size
takes some trial and error. You may need to increase the width/height for a given resolution. Saving as PDF
is automatically high resolution, though you will still want to adjust the width and height to your preference.

```
png("~/save_my_plot.png", width = 4, height = 6, units = "in", res = 300)
plotSequence(orderObj, Title = "Eef1g gene", plotFast = FASLE)
dev.off()
```

### 3.3.1 Accessing gene positions via biomaRt objects

In the Shiny app, we have included pre-downloaded versions of the mouse (GRCm39) and human (GRCh38) gene locations for ease of use. If you wish to use another organism, we demonstrate below how to obtain these from biomaRt.

```
# if (!requireNamespace("biomaRt", quietly = TRUE)) {
#     BiocManager::install("biomaRt")
# }
library(biomaRt)
ensembl <- useMart("ensembl")
# Demonstrating how to get the human annotations.
ensembl <- useDataset("hsapiens_gene_ensembl", mart = ensembl)
my_chr <- c(1:22, "M", "X", "Y") # You can choose to omit this or include additional chromosome
# We only need the start, end, and symbol:
human_bm <- getBM(
    attributes = c("chromosome_name", "start_position", "end_position", "hgnc_symbol"),
    filters = "chromosome_name",
    values = my_chr,
    mart = ensembl
)

## Now that we have the biomart object, we can extract start and ends for methylscaper:
gene_select <- subset(human_bm, human_bm$hgnc_symbol == "GeneX")

# These can then be passed into the prepSC function:
prepSC.out <- prepSC(mydata, startPos = gene_select$startPos, endPos = gene_select$endPos)

# To continue the analysis:
# Next the cells are ordered using the PCA approach and then plot:
orderObj <- initialOrder(prepSC.out)
plotSequence(orderObj, Title = "Gene X", plotFast = TRUE)
```

# 4 Visualizing single-molecule data

For single-molecule data from MAPit type experiments, methylscaper will first preprocess the reads by aligning reads contained in a fasta file to a reference file containing the sequence of interest (also in fasta format). This analysis can also be done in either the Shiny app or in the R console.

### 4.0.1 Preprocessing in the Shiny app

For the Shiny app, the input should be a list of reads in a fasta format and a fasta reference file. The reference sequence file should be input in the 5’ to 3’ orientation (Watson strand). We do not include GCG sites because their status is biologically ambiguous. Thus, we denote GC sites that are not followed by a G as GCH and CG sites that are not preceded by a G as HCG.

The screenshot below shows this preprocessing step. We make use of data from our [manuscript](https://academic.oup.com/bioinformatics/article/37/24/4857/6298588) and the raw data is provided in the methylscaper package. The files can also be downloaded directly from the methylscaper website: [Example Data](https://rbacher.rc.ufl.edu/methylscaper/content/exampledata.html). After selecting ‘Run’, a progress bar will appear in the bottom right. Once completed, the data may be downloaded along with a log file indicating the number of molecules successfully processed.

After selecting ‘Run’, a progress bar will appear in the bottom right. Once completed, the data may be downloaded along with a log file indicating the number of molecules successfully processed.

![](data:image/png;base64...)

Screenshot: Preprocessing tab for single-molecule data

### 4.0.2 Preprocessing using methylscaper functions

To run the preprocessing in the R console, the function `runAlign` may be used. The sequences are aligned to the reference using the `Biostrings` package and then mapped to the methylation- and accessibility-state matrices. For very large datasets, the runAlign function has a multicoreParam parameter for running methylscaper on high-throughput servers rather than locally.

```
# This provides the path to the raw datasets located in the methylscaper package
seq_file <- system.file("extdata", "seq_file.fasta", package = "methylscaper")
ref_file <- system.file("extdata", "reference.fa", package = "methylscaper")

# Next we read the data into R using the read.fasta function from the seqinr package:
fasta <- seqinr::read.fasta(seq_file)
ref <- seqinr::read.fasta(ref_file)[[1]]

# For the vignette we will only run a subset of the molecules
singlemolecule_example <- runAlign(fasta = fasta, ref = ref, fasta_subset = 1:150)

# Once complete, we can save the output as an RDS object
# saveRDS(singlemolecule_example, file="~/methylscaper_singlemolecule_preprocessed.rds")
```

### 4.0.3 Visualization in the Shiny app

![](data:image/png;base64...)

Screenshot: Visualizing the single-molecule data

### 4.0.4 Visualization using the methylscaper functions

Analysis of the single-molecule data in the R console uses the same functions described above in the single-cell section.

```
# If skipping the preprocessing steps above, use our pre-aligned data:
# data(singlemolecule_example)
orderObj <- initialOrder(singlemolecule_example,
    Method = "PCA",
    weightStart = 308, weightEnd = 475, weightFeature = "red"
)
plotSequence(orderObj, Title = "Ordered by PCA", plotFast = TRUE)
```

![](data:image/png;base64...)

# 5 Additional summary plots

Both single-cell and single-molecule data can be additionally summarized using methylscaper functions. The summary plots are restricted to the genomic region selected in the Shiny App or those used in the initialOrder function.

* The methyl\_proportion function calculates the proportion of bases that are methylated within each cell or molecule. A histogram displays these proportions. It should be indicated using the `type` parameter to calculate this over the endogenous methylation profile or the accessibility.
* The methyl\_percent\_sites function calculates the percent of GCH (yellow; accessibility) or HCG (red; endogenous methylation) sites that are methylated across all cells or molecules.
* The methyl\_average\_status function is similar to methyl\_percent\_sites but calculates an average methylation status across all cells or molecules within a specified window.

```
par(mfrow = c(2, 2))
props <- methyl_proportion(orderObj, type = "met", makePlot = TRUE, main = "")
props <- methyl_proportion(orderObj, type = "acc", makePlot = TRUE, main = "")

pcnts <- methyl_percent_sites(orderObj, makePlot = TRUE)
avgs <- methyl_average_status(orderObj, makePlot = TRUE, window_length = 25)
```

![](data:image/png;base64...)

# 6 FAQ

Frequently asked questions will be entered here.

# 7 SessionInfo

```
sessionInfo()
```

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] methylscaper_1.18.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 xfun_0.53
##  [3] bslib_0.9.0                 shinyjs_2.1.0
##  [5] Biobase_2.70.0              lattice_0.22-7
##  [7] vctrs_0.6.5                 tools_4.5.1
##  [9] generics_0.1.4              stats4_4.5.1
## [11] parallel_4.5.1              tibble_3.3.0
## [13] ca_0.71.1                   pkgconfig_2.0.3
## [15] R.oo_1.27.1                 Matrix_1.7-4
## [17] data.table_1.17.8           S4Vectors_0.48.0
## [19] RcppParallel_5.1.11-1       lifecycle_1.0.4
## [21] compiler_4.5.1              Biostrings_2.78.0
## [23] tinytex_0.57                Seqinfo_1.0.0
## [25] codetools_0.2-20            httpuv_1.6.16
## [27] seriation_1.5.8             htmltools_0.5.8.1
## [29] sass_0.4.10                 yaml_2.3.10
## [31] later_1.4.4                 pillar_1.11.1
## [33] crayon_1.5.3                jquerylib_0.1.4
## [35] seqinr_4.2-36               MASS_7.3-65
## [37] R.utils_2.13.0              BiocParallel_1.44.0
## [39] cachem_1.1.0                DelayedArray_0.36.0
## [41] magick_2.9.0                iterators_1.0.14
## [43] TSP_1.2-5                   abind_1.4-8
## [45] foreach_1.5.2               mime_0.13
## [47] digest_0.6.37               bookdown_0.45
## [49] ade4_1.7-23                 fastmap_1.2.0
## [51] grid_4.5.1                  cli_3.6.5
## [53] SparseArray_1.10.0          magrittr_2.0.4
## [55] S4Arrays_1.10.0             Rfast_2.1.5.2
## [57] promises_1.4.0              registry_0.5-1
## [59] rmarkdown_2.30              pwalign_1.6.0
## [61] XVector_0.50.0              matrixStats_1.5.0
## [63] otel_0.2.0                  R.methodsS3_1.8.2
## [65] shiny_1.11.1                evaluate_1.0.5
## [67] knitr_1.50                  GenomicRanges_1.62.0
## [69] IRanges_2.44.0              rlang_1.1.6
## [71] zigg_0.0.2                  Rcpp_1.1.0
## [73] xtable_1.8-4                glue_1.8.0
## [75] BiocManager_1.30.26         BiocGenerics_0.56.0
## [77] jsonlite_2.0.0              R6_2.6.1
## [79] MatrixGenerics_1.22.0       shinyFiles_0.9.3
## [81] fs_1.6.6
```