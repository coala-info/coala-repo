Code

* Show All Code
* Hide All Code

# Introduction to derfinderPlot

Leonardo Collado-Torres1,2\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Center for Computational Biology, Johns Hopkins University

\*lcolladotor@gmail.com

#### 29 October 2025

#### Package

derfinderPlot 1.44.0

# 1 Basics

## 1.1 Install *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)*

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* is a `R` package available via the [Bioconductor](http://bioconductor/packages/derfinderPlot) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("derfinderPlot")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with RNA-seq data. A *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* user is not expected to deal with those packages directly but will need to be familiar with *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* and for some plots with *[ggbio](https://bioconductor.org/packages/3.22/ggbio)*.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `derfinder` or `derfinderPlot` tags and check [the older posts](https://support.bioconductor.org/t/derfinder/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)*

We hope that *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("derfinderPlot")
```

```
## To cite package 'derfinderPlot' in publications use:
##
##   Collado-Torres L, Jaffe AE, Leek JT (2017). _derfinderPlot: Plotting
##   functions for derfinder_. doi:10.18129/B9.bioc.derfinderPlot
##   <https://doi.org/10.18129/B9.bioc.derfinderPlot>,
##   https://github.com/leekgroup/derfinderPlot - R package version
##   1.44.0, <http://www.bioconductor.org/packages/derfinderPlot>.
##
##   Collado-Torres L, Nellore A, Frazee AC, Wilks C, Love MI, Langmead B,
##   Irizarry RA, Leek JT, Jaffe AE (2017). "Flexible expressed region
##   analysis for RNA-seq with derfinder." _Nucl. Acids Res._.
##   doi:10.1093/nar/gkw852 <https://doi.org/10.1093/nar/gkw852>,
##   <http://nar.oxfordjournals.org/content/early/2016/09/29/nar.gkw852>.
##
## To see these entries in BibTeX format, use 'print(<citation>,
## bibtex=TRUE)', 'toBibtex(.)', or set
## 'options(citation.bibtex.max=999)'.
```

# 2 Introduction to *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)*

*[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* (Collado-Torres, Jaffe, and Leek, 2017) is an addon package for *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* (Collado-Torres, Nellore, Frazee, Wilks, Love, Langmead, Irizarry, Leek, and Jaffe, 2017) with functions that allow you to visualize the results.

While the functions in *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* assume you generated the data with *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*, they can be used with other `GRanges` objects properly formatted.

The functions in *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* are:

* `plotCluster()` is a tailored *[ggbio](https://bioconductor.org/packages/3.22/ggbio)* (Yin, Cook, and Lawrence, 2012) plot that shows all the regions in a cluster (defined by distance). It shows the base-level coverage for each sample as well as the mean for each group. If these regions overlap any known gene, the gene and the transcript annotation is displayed.
* `plotOverview()` is another tailored *[ggbio](https://bioconductor.org/packages/3.22/ggbio)* (Yin, Cook, and Lawrence, 2012) plot showing an overview of the whole genome. This plot can be useful to observe if the regions are clustered in a subset of a chromosome. It can also be used to check whether the regions match predominantly one part of the gene structure (for example, 3’ overlaps).
* `plotRegionCoverage()` is a fast plotting function using `R` base graphics that shows the base-level coverage for each sample inside a specific region of the genome. If the region overlaps any known gene or intron, the information is displayed. Optionally, it can display the known transcripts. This function is most likely the easiest to use with `GRanges` objects from other packages.

# 3 Example

As an example, we will analyze a small subset of the samples from the *BrainSpan Atlas of the Human Brain* (BrainSpan, 2011) publicly available data.

We first load the required packages.

```
## Load libraries
suppressPackageStartupMessages(library("derfinder"))
library("derfinderData")
library("derfinderPlot")
```

## 3.1 Analyze data

For this example, we created a small table with the relevant phenotype data for 12 samples: 6 from fetal samples and 6 from adult samples. We chose at random a brain region, in this case the primary auditory cortex (core) and for the example we will only look at data from chromosome 21. Other variables include the age in years and the gender. The data is shown below.

```
library("knitr")
## Get pheno table
pheno <- subset(brainspanPheno, structure_acronym == "A1C")

## Display the main information
p <- pheno[, -which(colnames(pheno) %in% c(
    "structure_acronym",
    "structure_name", "file"
))]
rownames(p) <- NULL
kable(p, format = "html", row.names = TRUE)
```

|  | gender | lab | Age | group |
| --- | --- | --- | --- | --- |
| 1 | M | HSB114.A1C | -0.5192308 | fetal |
| 2 | M | HSB103.A1C | -0.5192308 | fetal |
| 3 | M | HSB178.A1C | -0.4615385 | fetal |
| 4 | M | HSB154.A1C | -0.4615385 | fetal |
| 5 | F | HSB150.A1C | -0.5384615 | fetal |
| 6 | F | HSB149.A1C | -0.5192308 | fetal |
| 7 | F | HSB130.A1C | 21.0000000 | adult |
| 8 | M | HSB136.A1C | 23.0000000 | adult |
| 9 | F | HSB126.A1C | 30.0000000 | adult |
| 10 | M | HSB145.A1C | 36.0000000 | adult |
| 11 | M | HSB123.A1C | 37.0000000 | adult |
| 12 | F | HSB135.A1C | 40.0000000 | adult |

We can load the data from *[derfinderData](https://bioconductor.org/packages/3.22/derfinderData)* (Collado-Torres, Jaffe, and Leek, 2025) by first identifying the paths to the BigWig files with `derfinder::rawFiles()` and then loading the data with `derfinder::fullCoverage()`.

```
## Determine the files to use and fix the names
files <- rawFiles(system.file("extdata", "A1C", package = "derfinderData"),
    samplepatt = "bw", fileterm = NULL
)
names(files) <- gsub(".bw", "", names(files))

## Load the data from disk
system.time(fullCov <- fullCoverage(files = files, chrs = "chr21"))
```

```
## 2025-10-29 23:35:38.330333 fullCoverage: processing chromosome chr21
```

```
## 2025-10-29 23:35:38.349911 loadCoverage: finding chromosome lengths
```

```
## 2025-10-29 23:35:38.383338 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB103.bw
```

```
## 2025-10-29 23:35:38.626508 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB114.bw
```

```
## 2025-10-29 23:35:38.825757 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB123.bw
```

```
## 2025-10-29 23:35:38.977422 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB126.bw
```

```
## 2025-10-29 23:35:39.087605 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB130.bw
```

```
## 2025-10-29 23:35:39.23077 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB135.bw
```

```
## 2025-10-29 23:35:39.334555 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB136.bw
```

```
## 2025-10-29 23:35:39.446654 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB145.bw
```

```
## 2025-10-29 23:35:39.598107 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB149.bw
```

```
## 2025-10-29 23:35:39.739112 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB150.bw
```

```
## 2025-10-29 23:35:39.850686 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB154.bw
```

```
## 2025-10-29 23:35:41.006519 loadCoverage: loading BigWig file /home/biocbuild/bbs-3.22-bioc/R/site-library/derfinderData/extdata/A1C/HSB178.bw
```

```
## 2025-10-29 23:35:41.153151 loadCoverage: applying the cutoff to the merged data
```

```
## 2025-10-29 23:35:41.184336 filterData: originally there were 48129895 rows, now there are 48129895 rows. Meaning that 0 percent was filtered.
```

```
##    user  system elapsed
##   2.793   0.108   2.921
```

Alternatively, since the BigWig files are publicly available from *BrainSpan* (see [here](http://download.alleninstitute.org/brainspan/MRF_BigWig_Gencode_v10/bigwig/)), we can extract the relevant coverage data using `derfinder::fullCoverage()`. Note that as of *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* 1.25.16 BigWig files are not supported on Windows: you can find the `fullCov` object inside *[derfinderData](https://bioconductor.org/packages/3.22/derfinderData)* to follow the examples.

```
## Determine the files to use and fix the names
files <- pheno$file
names(files) <- gsub(".A1C", "", pheno$lab)

## Load the data from the web
system.time(fullCov <- fullCoverage(files = files, chrs = "chr21"))
```

Once we have the base-level coverage data for all 12 samples, we can construct the models. In this case, we want to find differences between fetal and adult samples while adjusting for gender and a proxy of the library size.

```
## Get some idea of the library sizes
sampleDepths <- sampleDepth(collapseFullCoverage(fullCov), 1)
```

```
## 2025-10-29 23:35:41.290862 sampleDepth: Calculating sample quantiles
```

```
## 2025-10-29 23:35:41.430746 sampleDepth: Calculating sample adjustments
```

```
## Define models
models <- makeModels(sampleDepths,
    testvars = pheno$group,
    adjustvars = pheno[, c("gender")]
)
```

Next, we can find candidate differentially expressed regions (DERs) using as input the segments of the genome where at least one sample has coverage greater than 3. In this particular example, we chose a low theoretical F-statistic cutoff and used 20 permutations.

```
## Filter coverage
filteredCov <- lapply(fullCov, filterData, cutoff = 3)
```

```
## 2025-10-29 23:35:41.758813 filterData: originally there were 48129895 rows, now there are 90023 rows. Meaning that 99.81 percent was filtered.
```

```
## Perform differential expression analysis
suppressPackageStartupMessages(library("bumphunter"))
system.time(results <- analyzeChr(
    chr = "chr21", filteredCov$chr21,
    models, groupInfo = pheno$group, writeOutput = FALSE,
    cutoffFstat = 5e-02, nPermute = 20, seeds = 20140923 + seq_len(20)
))
```

```
## 2025-10-29 23:35:42.912513 analyzeChr: Pre-processing the coverage data
```

```
## 2025-10-29 23:35:44.675331 analyzeChr: Calculating statistics
```

```
## 2025-10-29 23:35:44.678715 calculateStats: calculating the F-statistics
```

```
## 2025-10-29 23:35:44.857872 analyzeChr: Calculating pvalues
```

```
## 2025-10-29 23:35:44.858549 analyzeChr: Using the following theoretical cutoff for the F-statistics 5.31765507157871
```

```
## 2025-10-29 23:35:44.859962 calculatePvalues: identifying data segments
```

```
## 2025-10-29 23:35:44.868226 findRegions: segmenting information
```

```
## 2025-10-29 23:35:44.898057 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:44.951952 findRegions: identifying region clusters
```

```
## 2025-10-29 23:35:45.105851 calculatePvalues: calculating F-statistics for permutation 1 and seed 20140924
```

```
## 2025-10-29 23:35:45.279721 findRegions: segmenting information
```

```
## 2025-10-29 23:35:45.30767 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:45.375322 calculatePvalues: calculating F-statistics for permutation 2 and seed 20140925
```

```
## 2025-10-29 23:35:45.535481 findRegions: segmenting information
```

```
## 2025-10-29 23:35:45.56098 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:45.605149 calculatePvalues: calculating F-statistics for permutation 3 and seed 20140926
```

```
## 2025-10-29 23:35:45.756183 findRegions: segmenting information
```

```
## 2025-10-29 23:35:45.781943 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:45.826347 calculatePvalues: calculating F-statistics for permutation 4 and seed 20140927
```

```
## 2025-10-29 23:35:45.982038 findRegions: segmenting information
```

```
## 2025-10-29 23:35:46.008044 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:46.055202 calculatePvalues: calculating F-statistics for permutation 5 and seed 20140928
```

```
## 2025-10-29 23:35:46.210656 findRegions: segmenting information
```

```
## 2025-10-29 23:35:46.236497 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:46.281173 calculatePvalues: calculating F-statistics for permutation 6 and seed 20140929
```

```
## 2025-10-29 23:35:46.432621 findRegions: segmenting information
```

```
## 2025-10-29 23:35:46.45871 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:46.50317 calculatePvalues: calculating F-statistics for permutation 7 and seed 20140930
```

```
## 2025-10-29 23:35:46.654348 findRegions: segmenting information
```

```
## 2025-10-29 23:35:46.680569 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:46.725792 calculatePvalues: calculating F-statistics for permutation 8 and seed 20140931
```

```
## 2025-10-29 23:35:46.878832 findRegions: segmenting information
```

```
## 2025-10-29 23:35:46.904646 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:46.949945 calculatePvalues: calculating F-statistics for permutation 9 and seed 20140932
```

```
## 2025-10-29 23:35:47.102903 findRegions: segmenting information
```

```
## 2025-10-29 23:35:47.129066 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:47.175966 calculatePvalues: calculating F-statistics for permutation 10 and seed 20140933
```

```
## 2025-10-29 23:35:47.328105 findRegions: segmenting information
```

```
## 2025-10-29 23:35:47.354211 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:47.398934 calculatePvalues: calculating F-statistics for permutation 11 and seed 20140934
```

```
## 2025-10-29 23:35:47.550706 findRegions: segmenting information
```

```
## 2025-10-29 23:35:47.576753 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:47.622414 calculatePvalues: calculating F-statistics for permutation 12 and seed 20140935
```

```
## 2025-10-29 23:35:47.778148 findRegions: segmenting information
```

```
## 2025-10-29 23:35:47.803993 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:47.848767 calculatePvalues: calculating F-statistics for permutation 13 and seed 20140936
```

```
## 2025-10-29 23:35:48.001778 findRegions: segmenting information
```

```
## 2025-10-29 23:35:48.027629 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:48.073163 calculatePvalues: calculating F-statistics for permutation 14 and seed 20140937
```

```
## 2025-10-29 23:35:49.179917 findRegions: segmenting information
```

```
## 2025-10-29 23:35:49.20562 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:49.249971 calculatePvalues: calculating F-statistics for permutation 15 and seed 20140938
```

```
## 2025-10-29 23:35:49.40217 findRegions: segmenting information
```

```
## 2025-10-29 23:35:49.428525 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:49.473062 calculatePvalues: calculating F-statistics for permutation 16 and seed 20140939
```

```
## 2025-10-29 23:35:49.629144 findRegions: segmenting information
```

```
## 2025-10-29 23:35:49.654576 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:49.698449 calculatePvalues: calculating F-statistics for permutation 17 and seed 20140940
```

```
## 2025-10-29 23:35:49.840563 findRegions: segmenting information
```

```
## 2025-10-29 23:35:49.86785 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:49.912515 calculatePvalues: calculating F-statistics for permutation 18 and seed 20140941
```

```
## 2025-10-29 23:35:50.063504 findRegions: segmenting information
```

```
## 2025-10-29 23:35:50.089109 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:50.133161 calculatePvalues: calculating F-statistics for permutation 19 and seed 20140942
```

```
## 2025-10-29 23:35:50.291537 findRegions: segmenting information
```

```
## 2025-10-29 23:35:50.31717 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:50.361412 calculatePvalues: calculating F-statistics for permutation 20 and seed 20140943
```

```
## 2025-10-29 23:35:50.502852 findRegions: segmenting information
```

```
## 2025-10-29 23:35:50.528338 findRegions: identifying candidate regions
```

```
## 2025-10-29 23:35:50.606136 calculatePvalues: calculating the p-values
```

```
## 2025-10-29 23:35:50.676613 analyzeChr: Annotating regions
```

```
## No annotationPackage supplied. Trying org.Hs.eg.db.
```

```
## Loading required package: org.Hs.eg.db
```

```
## Loading required package: AnnotationDbi
```

```
## Loading required package: Biobase
```

```
## Welcome to Bioconductor
##
##     Vignettes contain introductory material; view with
##     'browseVignettes()'. To cite Bioconductor, see
##     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

```
##
```

```
## Getting TSS and TSE.
```

```
## Getting CSS and CSE.
```

```
## Warning in .set_group_names(grl, use.names, txdb, by): some group names are NAs
## or duplicated
```

```
## Getting exons.
```

```
## Warning in .set_group_names(grl, use.names, txdb, by): some group names are NAs
## or duplicated
```

```
## Annotating genes.
```

```
## ...
```

```
##    user  system elapsed
##  70.671   1.303  71.975
```

```
## Quick access to the results
regions <- results$regions$regions

## Annotation database to use
suppressPackageStartupMessages(library("TxDb.Hsapiens.UCSC.hg19.knownGene"))
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
```

## 3.2 `plotOverview()`

Now that we have obtained the main results using *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*, we can proceed to visualizing the results using *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)*. The easiest to use of all the functions is `plotOverview()` which takes a set of regions and annotation information produced by `bumphunter::matchGenes()`.

Figure [1](#fig:plotOverview) shows the candidate DERs colored by whether their q-value was less than 0.10 or not.

```
## Q-values overview
plotOverview(regions = regions, annotation = results$annotation, type = "qval")
```

```
## 2025-10-29 23:36:55.085381 plotOverview: assigning chromosome lengths from hg19!
```

```
## Scale for x is already present.
## Adding another scale for x, which will replace the existing scale.
## Scale for x is already present.
## Adding another scale for x, which will replace the existing scale.
```

![Location of the DERs in the genome. This plot is was designed for many chromosomes but only one is shown here for simplicity.](data:image/png;base64...)

Figure 1: Location of the DERs in the genome
This plot is was designed for many chromosomes but only one is shown here for simplicity.

Figure [2](#fig:plotOverview2) shows the candidate DERs colored by the type of gene feature they are nearest too.

```
## Annotation overview
plotOverview(
    regions = regions, annotation = results$annotation,
    type = "annotation"
)
```

```
## 2025-10-29 23:36:56.565223 plotOverview: assigning chromosome lengths from hg19!
```

```
## Scale for x is already present.
## Adding another scale for x, which will replace the existing scale.
```

![Location of the DERs in the genome and colored by annotation class. This plot is was designed for many chromosomes but only one is shown here for simplicity.](data:image/png;base64...)

Figure 2: Location of the DERs in the genome and colored by annotation class
This plot is was designed for many chromosomes but only one is shown here for simplicity.

In this particular example, because we are only using data from one chromosome the above plot is not as informative as in a real case scenario. However, with this plot we can quickly observe that nearly all of the candidate DERs are inside an exon.

## 3.3 `plotRegionCoverage()`

The complete opposite of visualizing the candidate DERs at the genome-level is to visualize them one region at a time. `plotRegionCoverage()` allows us to do this quickly for a large number of regions.

Before using this function, we need to process more detailed information using two *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* functions: `annotateRegions()` and `getRegionCoverage()` as shown below.

```
## Get required information for the plots
annoRegs <- annotateRegions(regions, genomicState$fullGenome)
```

```
## 2025-10-29 23:36:57.749948 annotateRegions: counting
```

```
## 2025-10-29 23:36:57.834684 annotateRegions: annotating
```

```
regionCov <- getRegionCoverage(fullCov, regions)
```

```
## 2025-10-29 23:36:57.959112 getRegionCoverage: processing chr21
```

```
## 2025-10-29 23:36:58.019238 getRegionCoverage: done processing chr21
```

Once we have the relevant information we can proceed to plotting the first 10 regions. In this case, we will supply `plotRegionCoverage()` with the information it needs to plot transcripts overlapping these 10 regions (Figures [**??**](#fig:plotRegCov1), [**??**](#fig:plotRegCov2), [**??**](#fig:plotRegCov3), [**??**](#fig:plotRegCov4), [**??**](#fig:plotRegCov5), [**??**](#fig:plotRegCov6), [**??**](#fig:plotRegCov7), [**??**](#fig:plotRegCov8), [**??**](#fig:plotRegCov9), [**??**](#fig:plotRegCov10)).

```
## Plot top 10 regions
plotRegionCoverage(
    regions = regions, regionCoverage = regionCov,
    groupInfo = pheno$group, nearestAnnotation = results$annotation,
    annotatedRegions = annoRegs, whichRegions = 1:10, txdb = txdb, scalefac = 1,
    ask = FALSE, verbose = FALSE
)
```

![Base-pair resolution plot of differentially expressed region 1.](data:image/png;base64...)

Figure 3: Base-pair resolution plot of differentially expressed region 1

![Base-pair resolution plot of differentially expressed region 2.](data:image/png;base64...)

Figure 4: Base-pair resolution plot of differentially expressed region 2

![Base-pair resolution plot of differentially expressed region 3.](data:image/png;base64...)

Figure 5: Base-pair resolution plot of differentially expressed region 3

![Base-pair resolution plot of differentially expressed region 4.](data:image/png;base64...)

Figure 6: Base-pair resolution plot of differentially expressed region 4

![Base-pair resolution plot of differentially expressed region 5.](data:image/png;base64...)

Figure 7: Base-pair resolution plot of differentially expressed region 5

![Base-pair resolution plot of differentially expressed region 6.](data:image/png;base64...)

Figure 8: Base-pair resolution plot of differentially expressed region 6

![Base-pair resolution plot of differentially expressed region 7.](data:image/png;base64...)

Figure 9: Base-pair resolution plot of differentially expressed region 7

![Base-pair resolution plot of differentially expressed region 8.](data:image/png;base64...)

Figure 10: Base-pair resolution plot of differentially expressed region 8

![Base-pair resolution plot of differentially expressed region 9.](data:image/png;base64...)

Figure 11: Base-pair resolution plot of differentially expressed region 9

![Base-pair resolution plot of differentially expressed region 10.](data:image/png;base64...)

Figure 12: Base-pair resolution plot of differentially expressed region 10

The base-level coverage is shown in a log2 scale with any overlapping exons shown in dark blue and known introns in light blue.

## 3.4 `plotCluster()`

In this example, we noticed with the `plotRegionCoverage()` plots that most of the candidate DERs are contained in known exons. Sometimes, the signal might be low or we might have used very stringent cutoffs in the *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* analysis. One way we can observe this is by plotting clusters of regions where a cluster is defined as regions within 300 bp (default option) of each other.

To visualize the clusters, we can use `plotCluster()` which takes similar input to `plotOverview()` with the notable addition of the coverage information as well as the `idx` argument. This argument specifies which region to focus on: it will be plotted with a red bar and will determine the cluster to display.

In Figure [13](#fig:plotCluster) we observe one large candidate DER with other nearby ones that do not have a q-value less than 0.10. In a real analysis, we would probably discard this region as the coverage is fairly low.

```
## First cluster
plotCluster(
    idx = 1, regions = regions, annotation = results$annotation,
    coverageInfo = fullCov$chr21, txdb = txdb, groupInfo = pheno$group,
    titleUse = "pval"
)
```

```
## Parsing transcripts...
```

```
## Parsing exons...
```

```
## Parsing cds...
```

```
## Parsing utrs...
```

```
## ------exons...
```

```
## ------cdss...
```

```
## ------introns...
```

```
## ------utr...
```

```
## aggregating...
```

```
## Done
```

```
## Constructing graphics...
```

![Cluster plot for cluster 1 using ggbio.](data:image/png;base64...)

Figure 13: Cluster plot for cluster 1 using ggbio

The second cluster (Figure [14](#fig:plotCluster2)) shows a larger number of potential DERs (again without q-values less than 0.10) in a segment of the genome where the coverage data is highly variable. This is a common occurrence with RNA-seq data.

```
## Second cluster
plotCluster(
    idx = 2, regions = regions, annotation = results$annotation,
    coverageInfo = fullCov$chr21, txdb = txdb, groupInfo = pheno$group,
    titleUse = "pval"
)
```

```
## Parsing transcripts...
```

```
## Parsing exons...
```

```
## Parsing cds...
```

```
## Parsing utrs...
```

```
## ------exons...
```

```
## ------cdss...
```

```
## ------introns...
```

```
## ------utr...
```

```
## aggregating...
```

```
## Done
```

```
## Constructing graphics...
```

```
## Warning in !vapply(ggl, fixed, logical(1L)) & !vapply(PlotList, is, "Ideogram",
## : longer object length is not a multiple of shorter object length
```

```
## Warning in scale_y_continuous(trans = log2_trans()): log-2 transformation
## introduced infinite values.
```

![Cluster plot for cluster 2 using ggbio.](data:image/png;base64...)

Figure 14: Cluster plot for cluster 2 using ggbio

These plots show an ideogram which helps quickly identify which region of the genome we are focusing on. Then, the base-level coverage information for each sample is displayed in log2. Next, the coverage group means are shown in the log2 scale. The plot is completed with the potential and candidate DERs as well as any known transcripts.

## 3.5 `vennRegions`

*[derfinder](https://bioconductor.org/packages/3.22/derfinder)* has functions for annotating regions given their genomic state. A typical visualization is to then view how many regions overlap known exons, introns, intergenic regions, none of them or several of these groups in a venn diagram. The function `vennRegions()` makes this plot using the output from `derfinder::annotateRegions()` as shown in Figure [15](#fig:vennRegions).

```
## Make venn diagram
venn <- vennRegions(annoRegs)
```

![Venn diagram of regions by annotation class.](data:image/png;base64...)

Figure 15: Venn diagram of regions by annotation class

```
## It returns the actual venn counts information
venn
```

```
##   exon intergenic intron Counts
## 1    0          0      0      0
## 2    0          0      1      2
## 3    0          1      0      4
## 4    0          1      1      0
## 5    1          0      0    259
## 6    1          0      1     35
## 7    1          1      0      0
## 8    1          1      1      0
## attr(,"class")
## [1] "VennCounts"
```

# 4 Reproducibility

This package was made possible thanks to:

* R (R Core Team, 2025)
* *[GenomeInfoDb](https://bioconductor.org/packages/3.22/GenomeInfoDb)* (Arora, Morgan, Carlson, and Pagès, 2017)
* *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* (Lawrence, Huber, Pagès, Aboyoun, Carlson, Gentleman, Morgan, and Carey, 2013)
* *[ggbio](https://bioconductor.org/packages/3.22/ggbio)* (Yin, Cook, and Lawrence, 2012)
* *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* (Wickham, 2016)
* *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* (Lawrence, Huber, Pagès et al., 2013)
* *[plyr](https://CRAN.R-project.org/package%3Dplyr)* (Wickham, 2011)
* *[RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer)* (Neuwirth, 2022)
* *[reshape2](https://CRAN.R-project.org/package%3Dreshape2)* (Wickham, 2007)
* *[scales](https://CRAN.R-project.org/package%3Dscales)* (Wickham, Pedersen, and Seidel, 2025)
* *[biovizBase](https://bioconductor.org/packages/3.22/biovizBase)* (Yin, Lawrence, and Cook, 2025)
* *[bumphunter](https://bioconductor.org/packages/3.22/bumphunter)* (Jaffe, Murakami, Lee, Leek, Fallin, Feinberg, and Irizarry, 2012) and (Jaffe, Murakami, Lee, Leek, Fallin, Feinberg, and Irizarry, 2012)
* *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* (Collado-Torres, Nellore, Frazee et al., 2017)
* *[derfinderData](https://bioconductor.org/packages/3.22/derfinderData)* (Collado-Torres, Jaffe, and Leek, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)* (Team and Maintainer, 2025)

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("derfinderPlot.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("derfinderPlot.Rmd", tangle = TRUE)
```

```
## Clean up
unlink("chr21", recursive = TRUE)
```

Date the vignette was generated.

```
## [1] "2025-10-29 23:37:42 EDT"
```

Wallclock time spent generating the vignette.

```
## Time difference of 2.349 mins
```

`R` session information.

```
## ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-10-29
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
##  package                           * version   date (UTC) lib source
##  abind                               1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
##  AnnotationDbi                     * 1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  AnnotationFilter                    1.34.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  backports                           1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
##  base64enc                           0.1-3     2015-07-28 [2] CRAN (R 4.5.1)
##  bibtex                              0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
##  Biobase                           * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocGenerics                      * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocIO                              1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocManager                         1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
##  BiocParallel                        1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocStyle                         * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  Biostrings                          2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  biovizBase                          1.58.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bit                                 4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
##  bit64                               4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
##  bitops                              1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
##  blob                                1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
##  bookdown                            0.45      2025-10-03 [2] CRAN (R 4.5.1)
##  BSgenome                            1.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bslib                               0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
##  bumphunter                        * 1.52.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cachem                              1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
##  checkmate                           2.3.3     2025-08-18 [2] CRAN (R 4.5.1)
##  cigarillo                           1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cli                                 3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
##  cluster                             2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
##  codetools                           0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
##  colorspace                          2.1-2     2025-09-22 [2] CRAN (R 4.5.1)
##  crayon                              1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
##  curl                                7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
##  data.table                          1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
##  DBI                                 1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
##  DelayedArray                        0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinder                         * 1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinderData                     * 2.27.0    2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinderHelper                     1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinderPlot                     * 1.44.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  dichromat                           2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
##  digest                              0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
##  doRNG                               1.8.6.2   2025-04-02 [2] CRAN (R 4.5.1)
##  dplyr                               1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
##  ensembldb                           2.34.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  evaluate                            1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
##  farver                              2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
##  fastmap                             1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
##  foreach                           * 1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
##  foreign                             0.8-90    2025-03-31 [3] CRAN (R 4.5.1)
##  Formula                             1.2-5     2023-02-24 [2] CRAN (R 4.5.1)
##  generics                          * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
##  GenomeInfoDb                        1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicAlignments                   1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFeatures                   * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFiles                        1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicRanges                     * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  ggbio                               1.58.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  ggplot2                             4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
##  glue                                1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
##  graph                               1.88.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  gridExtra                           2.3       2017-09-09 [2] CRAN (R 4.5.1)
##  gtable                              0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
##  Hmisc                               5.2-4     2025-10-05 [2] CRAN (R 4.5.1)
##  htmlTable                           2.4.3     2024-07-21 [2] CRAN (R 4.5.1)
##  htmltools                           0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
##  htmlwidgets                         1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
##  httr                                1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
##  IRanges                           * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  iterators                         * 1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
##  jquerylib                           0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite                            2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
##  KEGGREST                            1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  knitr                             * 1.50      2025-03-16 [2] CRAN (R 4.5.1)
##  labeling                            0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
##  lattice                             0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
##  lazyeval                            0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
##  lifecycle                           1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
##  limma                               3.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  locfit                            * 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
##  lubridate                           1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
##  magick                              2.9.0     2025-09-08 [2] CRAN (R 4.5.1)
##  magrittr                            2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
##  Matrix                              1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
##  MatrixGenerics                      1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  matrixStats                         1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
##  memoise                             2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
##  nnet                                7.3-20    2025-01-01 [3] CRAN (R 4.5.1)
##  org.Hs.eg.db                      * 3.22.0    2025-10-08 [2] Bioconductor
##  OrganismDbi                         1.52.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  pillar                              1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
##  pkgconfig                           2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
##  plyr                                1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
##  png                                 0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
##  ProtGenerics                        1.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  qvalue                              2.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  R6                                  2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
##  RBGL                                1.86.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  RColorBrewer                        1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
##  Rcpp                                1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
##  RCurl                               1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
##  RefManageR                        * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
##  reshape2                            1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
##  restfulr                            0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
##  rjson                               0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
##  rlang                               1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown                           2.30      2025-09-28 [2] CRAN (R 4.5.1)
##  rngtools                            1.5.2     2021-09-20 [2] CRAN (R 4.5.1)
##  rpart                               4.1.24    2025-01-07 [3] CRAN (R 4.5.1)
##  Rsamtools                           2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  RSQLite                             2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
##  rstudioapi                          0.17.1    2024-10-22 [2] CRAN (R 4.5.1)
##  rtracklayer                         1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Arrays                            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Vectors                         * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S7                                  0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
##  sass                                0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
##  scales                              1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
##  Seqinfo                           * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  sessioninfo                       * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
##  SparseArray                         1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  statmod                             1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
##  stringi                             1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
##  stringr                             1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
##  SummarizedExperiment                1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  tibble                              3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
##  tidyselect                          1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
##  timechange                          0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
##  tinytex                             0.57      2025-04-15 [2] CRAN (R 4.5.1)
##  TxDb.Hsapiens.UCSC.hg19.knownGene * 3.22.1    2025-10-14 [2] Bioconductor
##  UCSC.utils                          1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  VariantAnnotation                   1.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  vctrs                               0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
##  withr                               3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
##  xfun                                0.53      2025-08-19 [2] CRAN (R 4.5.1)
##  XML                                 3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
##  xml2                                1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
##  XVector                             0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  yaml                                2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/RtmpRBi8HU/Rinst118de511329e4
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 5 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-GenomeInfoDb)
S. Arora, M. Morgan, M. Carlson, et al.
*GenomeInfoDb: Utilities for manipulating chromosome and other ‘seqname’ identifiers*.
2017.
DOI: [10.18129/B9.bioc.GenomeInfoDb](https://doi.org/10.18129/B9.bioc.GenomeInfoDb).

[[3]](#cite-brainspan)
BrainSpan.
“Atlas of the Developing Human Brain [Internet]. Funded by ARRA Awards 1RC2MH089921-01, 1RC2MH090047-01, and 1RC2MH089929-01.”
2011.
URL: <http://www.brainspan.org/>.

[[4]](#cite-colladotorres2017derfinderplot)
L. Collado-Torres, A. E. Jaffe, and J. T. Leek.
*derfinderPlot: Plotting functions for derfinder*.
<https://github.com/leekgroup/derfinderPlot> - R package version 1.44.0.
2017.
DOI: [10.18129/B9.bioc.derfinderPlot](https://doi.org/10.18129/B9.bioc.derfinderPlot).
URL: <http://www.bioconductor.org/packages/derfinderPlot>.

[[5]](#cite-colladotorres2025derfinderdata)
L. Collado-Torres, A. Jaffe, and J. Leek.
*derfinderData: Processed BigWigs from BrainSpan for examples*.
R package version 2.27.0.
2025.
DOI: [10.18129/B9.bioc.derfinderData](https://doi.org/10.18129/B9.bioc.derfinderData).
URL: <https://bioconductor.org/packages/derfinderData>.

[[6]](#cite-colladotorres2017flexible)
L. Collado-Torres, A. Nellore, A. C. Frazee, et al.
“Flexible expressed region analysis for RNA-seq with derfinder”.
In: *Nucl. Acids Res.* (2017).
DOI: [10.1093/nar/gkw852](https://doi.org/10.1093/nar/gkw852).
URL: <http://nar.oxfordjournals.org/content/early/2016/09/29/nar.gkw852>.

[[7]](#cite-bumphunter)
A. E. Jaffe, P. Murakami, H. Lee, et al.
“Bump hunting to identify differentially methylated regions in epigenetic epidemiology studies”.
In: *International journal of epidemiology* 41.1 (2012), pp. 200–209.
DOI: [10.1093/ije/dyr238](https://doi.org/10.1093/ije/dyr238).

[[8]](#cite-bumphunterPaper)
A. E. Jaffe, P. Murakami, H. Lee, et al.
“Bump hunting to identify differentially methylated regions in epigenetic epidemiology studies”.
In: *International Journal of Epidemiology* (2012).

[[9]](#cite-lawrence2013software)
M. Lawrence, W. Huber, H. Pagès, et al.
“Software for Computing and Annotating Genomic Ranges”.
In: *PLoS Computational Biology* 9 (8 2013).
DOI: [10.1371/journal.pcbi.1003118](https://doi.org/10.1371/journal.pcbi.1003118).
URL: [[http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1003118](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118)}.](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118%7D.)

[[10]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[11]](#cite-neuwirth2022rcolorbrewer)
E. Neuwirth.
*RColorBrewer: ColorBrewer Palettes*.
R package version 1.1-3.
2022.
DOI: [10.32614/CRAN.package.RColorBrewer](https://doi.org/10.32614/CRAN.package.RColorBrewer).
URL: [https://CRAN.R-project.org/package=RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer).

[[12]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[13]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[14]](#cite-team2025txdb)
B. C. Team and B. P. Maintainer.
*TxDb.Hsapiens.UCSC.hg19.knownGene: Annotation package for TxDb object(s)*.
R package version 3.22.1.
2025.

[[15]](#cite-wickham2007reshaping)
H. Wickham.
“Reshaping Data with the reshape Package”.
In: *Journal of Statistical Software* 21.12 (2007), pp. 1–20.
URL: <http://www.jstatsoft.org/v21/i12/>.

[[16]](#cite-wickham2011split)
H. Wickham.
“The Split-Apply-Combine Strategy for Data Analysis”.
In: *Journal of Statistical Software* 40.1 (2011), pp. 1–29.
URL: <https://www.jstatsoft.org/v40/i01/>.

[[17]](#cite-wickham2016ggplot2)
H. Wickham.
*ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York, 2016.
ISBN: 978-3-319-24277-4.
URL: <https://ggplot2.tidyverse.org>.

[[18]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[19]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[20]](#cite-wickham2025scales)
H. Wickham, T. Pedersen, and D. Seidel.
*scales: Scale Functions for Visualization*.
R package version 1.4.0.
2025.
DOI: [10.32614/CRAN.package.scales](https://doi.org/10.32614/CRAN.package.scales).
URL: [https://CRAN.R-project.org/package=scales](https://CRAN.R-project.org/package%3Dscales).

[[21]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.

[[22]](#cite-yin2012ggbio)
T. Yin, D. Cook, and M. Lawrence.
“ggbio: an R package for extending the grammar of graphics for genomic data”.
In: *Genome Biology* 13.8 (2012), p. R77.

[[23]](#cite-yin2025biovizbase)
T. Yin, M. Lawrence, and D. Cook.
*biovizBase: Basic graphic utilities for visualization of genomic data.*
R package version 1.58.0.
2025.
DOI: [10.18129/B9.bioc.biovizBase](https://doi.org/10.18129/B9.bioc.biovizBase).
URL: <https://bioconductor.org/packages/biovizBase>.