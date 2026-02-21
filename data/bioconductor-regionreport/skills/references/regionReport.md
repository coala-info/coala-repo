Code

* Show All Code
* Hide All Code

# Introduction to regionReport

Leonardo Collado-Torres1,2\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Center for Computational Biology, Johns Hopkins University

\*lcolladotor@gmail.com

#### 30 October 2025

#### Package

regionReport 1.44.0

# 1 Basics

## 1.1 Install *[regionReport](https://bioconductor.org/packages/3.22/regionReport)*

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* is a `R` package available via the [Bioconductor](http://bioconductor/packages/regionReport) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("regionReport")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[regionReport](https://bioconductor.org/packages/3.22/regionReport)* is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with RNA-seq data. That is, packages like *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* that allow you to import the data and *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* for generating differential expression results. A *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* user is not expected to deal with those packages directly.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `regionReport` tag and check [the older posts](https://support.bioconductor.org/t/regionReport/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing *[regionReport](https://bioconductor.org/packages/3.22/regionReport)*

We hope that *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("regionReport")
```

```
## To cite package 'regionReport' in publications use:
##
##   Collado-Torres L, Jaffe AE, Leek JT (2016). "regionReport: Interactive reports for region-level and
##   feature-level genomic analyses [version2; referees: 2 approved, 1 approved with reservations]."
##   _F1000Research_, *4*, 105. doi:10.12688/f1000research.6379.2
##   <https://doi.org/10.12688/f1000research.6379.2>, <http://f1000research.com/articles/4-105/v2>.
##
##   Collado-Torres L, Nellore A, Frazee AC, Wilks C, Love MI, Langmead B, Irizarry RA, Leek JT, Jaffe AE
##   (2017). "Flexible expressed region analysis for RNA-seq with derfinder." _Nucl. Acids Res._.
##   doi:10.1093/nar/gkw852 <https://doi.org/10.1093/nar/gkw852>,
##   <http://nar.oxfordjournals.org/content/early/2016/09/29/nar.gkw852>.
##
##   Collado-Torres L, Jaffe AE, Leek JT (2017). _regionReport: Generate HTML or PDF reports for a set of
##   genomic regions or DESeq2/edgeR results_. doi:10.18129/B9.bioc.regionReport
##   <https://doi.org/10.18129/B9.bioc.regionReport>, https://github.com/leekgroup/regionReport - R package
##   version 1.44.0, <http://www.bioconductor.org/packages/regionReport>.
##
## To see these entries in BibTeX format, use 'print(<citation>, bibtex=TRUE)', 'toBibtex(.)', or set
## 'options(citation.bibtex.max=999)'.
```

# 2 HTML reports for a set differential region results

*[regionReport](https://bioconductor.org/packages/3.22/regionReport)* (Collado-Torres, Jaffe, and Leek, 2016) creates HTML or PDF reports for a set of genomic regions such as *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* (Collado-Torres, Nellore, Frazee, Wilks, Love, Langmead, Irizarry, Leek, and Jaffe, 2017) results or for feature-level analyses performed with *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* (Love, Huber, and Anders, 2014) or *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* (Chen, Chen, Lun, Baldoni, and Smyth, 2025). The HTML reports are styled with *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025) by default but can optionally be styled with *[knitrBootstrap](https://CRAN.R-project.org/package%3DknitrBootstrap)* (Hester, 2024).

This package includes a basic exploration for a general set of genomic regions which can be easily customized to include the appropriate conclusions and/or further exploration of the results. Such a report can be generated using `renderReport()`. *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* has a separate template for running a basic exploration analysis of *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*
results by using `derfinderReport()`. `derfinderReport()` is specific to single base-level approach *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* results. A third template is included for exploring *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* or *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* differential expression results.

All reports are written in [R Markdown](http://rmarkdown.rstudio.com/)
format and include all the code for making the plots and explorations in the report itself. For all templates, *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* relies on
*[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014), *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)*
(Allaire, Xie, Dervieux et al., 2025), `DT` (Xie, Cheng, Tan, and Aden-Buie, 2025) and optionally *[knitrBootstrap](https://CRAN.R-project.org/package%3DknitrBootstrap)*
(Hester, 2024) for generating the report. The reports can be either in HTML or PDF format and can be easily customized.

# 3 Using *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* for *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* results

The plots in *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* for exploring *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* are powered by *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* (Wickham, 2016) and *[pheatmap](https://CRAN.R-project.org/package%3Dpheatmap)* (Kolde, 2025).

## 3.1 Example

The *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* supplementary website [regionReportSupp](http://leekgroup.github.io/regionReportSupp/) has examples of using *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* with *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* results. In particular, please look at [DESeq2.html](http://leekgroup.github.io/regionReportSupp/DESeq2.html) which has the code for generating some *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* results based on the *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* vignette. Then it uses those results to create HTML and PDF versions of the same report. The resulting reports are available in the following locations:

* [HTML version](http://leekgroup.github.io/regionReportSupp/DESeq2-example/index.html)
* [PDF version](http://leekgroup.github.io/regionReportSupp/DESeq2-example/DESeq2Report.pdf)

Note that in both examples we changed the *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* theme to `theme_bw()`. Also, in the PDF version we used the option `device = 'pdf'` instead of the default `device = 'png'` in `DESeq2Report()` since PDF figures are more appropriate for PDF reports: they look better than PNG figures.

If you want to create a similar HTML report as the one linked in this section, simply run `example('DESeq2Report', 'regionReport', ask=FALSE)`. The only difference will be the *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* theme for the plots.

# 4 Using *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* for *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* results

*[regionReport](https://bioconductor.org/packages/3.22/regionReport)* has the `edgeReport()` function that takes as input a `DGEList` object and the results from the differential expression analysis using *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*. `edgeReport()` internally uses *[DEFormats](https://bioconductor.org/packages/3.22/DEFormats)* to convert the results to *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*’s format and then uses `DESeqReport()` to create the final report. The report looks nearly the same whether you performed the differential expression analysis with *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* or *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* in order to make more homogenous the exploratory data analysis step.

## 4.1 Example

The *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* supplementary website [regionReportSupp](http://leekgroup.github.io/regionReportSupp/) has examples of using *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* with *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* results. In particular, please look at [edgeR.html](http://leekgroup.github.io/regionReportSupp/edgeR.html) which has the code for generating some random data with *[DEFormats](https://bioconductor.org/packages/3.22/DEFormats)* and performing the differential expression analysis with *[edgeR](https://bioconductor.org/packages/3.22/edgeR)*. Then it uses those results to create HTML and PDF versions of the same report. The resulting reports are available in the following locations:

* [HTML version](http://leekgroup.github.io/regionReportSupp/edgeR-example/index.html)
* [PDF version](http://leekgroup.github.io/regionReportSupp/edgeR-example/edgeReport.pdf)

Note that in both examples we changed the *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* theme to `theme_linedraw()`. Also, in the PDF version we used the option `device = 'pdf'` instead of the default `device = 'png'` in `edgeReport()` since PDF figures are more appropriate for PDF reports: they look better than PNG figures.

If you want to create a similar HTML report as the one linked in this section, simply run `example('edgeReport', 'regionReport', ask=FALSE)`. The only difference will be the *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* theme for the plots and the amount of data simulated with *[DEFormats](https://bioconductor.org/packages/3.22/DEFormats)*.

# 5 Using *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* for region results

The plots in *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* for region reports are powered by *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* (Collado-Torres, Jaffe, and Leek, 2017), *[ggbio](https://bioconductor.org/packages/3.22/ggbio)* (Yin, Cook, and Lawrence, 2012), and *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* (Wickham, 2016).

## 5.1 Examples

The *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* supplementary website [regionReportSupp](http://leekgroup.github.io/regionReportSupp/) has examples of using *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* with results from *[DiffBind](https://bioconductor.org/packages/3.22/DiffBind)* and *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*. Included as a vignette, this package also has an example using a small data set derived from *[bumphunter](https://bioconductor.org/packages/3.22/bumphunter)*. These represent different uses of *[regionReport](https://bioconductor.org/packages/3.22/regionReport)* for results from ChIP-seq, methylation, and RNA-seq data. In particular, the *[DiffBind](https://bioconductor.org/packages/3.22/DiffBind)* example illustrates how to expand a basic report created with `renderReport()`.

## 5.2 General case

For a general use case, you first have to identify a set of genomic regions of interest and store it as a `GRanges` object. In a typical workflow you will have some variables measured for each of the regions, such as p-values and scores. `renderReport()` uses the set of regions and three main arguments:

* `pvalueVars`: this is a character vector (named optionally) with the names of the variables that are bound between 0 and 1, such as p-values. For each of these variables, `renderReport()` explores the distribution by chromosome, the overall distribution, and makes a table with commonly used cutoffs.
* `densityVars`: is another character vector (named optionally) with another set of variables you wish to explore by making density graphs. This is commonly used for scores and other similar numerical variables.
* `significantVar`: is a logical vector separating the regions into by whether they are statistically significant. For example, this information is used to explore the width of all the regions and compare it the significant ones.

Other parameters control the name of the report, where it’ll be located, the transcripts database used to annotate the nearest genes, graphical parameters, etc.

Here is a short example of how to use `renderReport()`. Note that we are using regions produced by *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* just for convenience sake.

```
## Load derfinder
library("derfinder")
regions <- genomeRegions$regions

## Assign chr length
library("GenomicRanges")
seqlengths(regions) <- c("chr21" = 48129895)

## The output will be saved in the 'derfinderReport-example' directory
dir.create("renderReport-example", showWarnings = FALSE, recursive = TRUE)

## Generate the HTML report
report <- renderReport(regions, "Example run",
    pvalueVars = c(
        "Q-values" = "qvalues", "P-values" = "pvalues"
    ), densityVars = c(
        "Area" = "area", "Mean coverage" = "meanCoverage"
    ),
    significantVar = regions$qvalues <= 0.05, nBestRegions = 20,
    outdir = "renderReport-example"
)
```

See the report created by this example [here](http://leekgroup.github.io/regionReport/reference/renderReport-example/regionExploration.html).

For *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* results created via the expressed regions-level approach you can use `renderReport()` to explore the results. If you use *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* to perform the differential expression analysis of the expressed regions you can then use `DESeq2Report()`.

## 5.3 *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* single base-level case

### 5.3.1 Run *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*

Prior to using `regionReport::derfinderReport()` you must use *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* to analyze a specific data set. While there are many ways to do so, we recommend using **analyzeChr()** with the same *prefix* argument. Then merging the results with **mergeResults()**. This is the recommended pipeline for the single base-level approach.

Below, we run *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* for the example data included in the package. The steps are:

1. Load derfinder
2. Create a directory where we’ll store the results
3. Generate the pre-requisites for the models to use with the example data
4. Generate the statistical models
5. Analyze the example data for chr21
6. Merge the results (only one chr in this case, but in practice there’ll be more)

```
## Load derfinder
library("derfinder")

## The output will be saved in the "derfinderReport-example" directory
dir.create("derfinderReport-example", showWarnings = FALSE, recursive = TRUE)
```

The following code runs *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*.

```
## Save the current path
initialPath <- getwd()
setwd(file.path(initialPath, "derfinderReport-example"))

## Generate output from derfinder

## Collapse the coverage information
collapsedFull <- collapseFullCoverage(list(genomeData$coverage),
    verbose = TRUE
)

## Calculate library size adjustments
sampleDepths <- sampleDepth(collapsedFull,
    probs = c(0.5), nonzero = TRUE,
    verbose = TRUE
)

## Build the models
group <- genomeInfo$pop
adjustvars <- data.frame(genomeInfo$gender)
models <- makeModels(sampleDepths, testvars = group, adjustvars = adjustvars)

## Analyze chromosome 21
analysis <- analyzeChr(
    chr = "21", coverageInfo = genomeData, models = models,
    cutoffFstat = 1, cutoffType = "manual", seeds = 20140330, groupInfo = group,
    mc.cores = 1, writeOutput = TRUE, returnOutput = TRUE
)

## Save the stats options for later
optionsStats <- analysis$optionsStats

## Change the directory back to the original one
setwd(initialPath)
```

For convenience, we have included the *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* results as part of
*[regionReport](https://bioconductor.org/packages/3.22/regionReport)*. Note that the above functions are routinely checked as part
of *[derfinder](https://bioconductor.org/packages/3.22/derfinder)*.

```
## Copy previous results
file.copy(system.file(file.path("extdata", "chr21"),
    package = "derfinder",
    mustWork = TRUE
), "derfinderReport-example", recursive = TRUE)
```

```
## [1] TRUE
```

Next, proceed to merging the results.

```
## Merge the results from the different chromosomes. In this case, there's
## only one: chr21
mergeResults(
    chrs = "chr21", prefix = "derfinderReport-example",
    genomicState = genomicState$fullGenome
)
```

```
## 2025-10-30 02:01:05.935023 mergeResults: Saving options used
```

```
## 2025-10-30 02:01:05.936466 Loading chromosome chr21
```

```
## Neither 'cutoffFstatUsed' nor 'optionsStats' were supplied, so the FWER calculation step will be skipped.
```

```
## 2025-10-30 02:01:06.028658 mergeResults: Saving fullNullSummary
```

```
## 2025-10-30 02:01:06.029607 mergeResults: Re-calculating the p-values
```

```
## 2025-10-30 02:01:06.163359 mergeResults: Saving fullRegions
```

```
## 2025-10-30 02:01:06.164886 mergeResults: assigning genomic states
```

```
## 2025-10-30 02:01:06.30345 annotateRegions: counting
```

```
## 2025-10-30 02:01:06.392646 annotateRegions: annotating
```

```
## 2025-10-30 02:01:06.422676 mergeResults: Saving fullAnnotatedRegions
```

```
## 2025-10-30 02:01:06.423967 mergeResults: Saving fullFstats
```

```
## 2025-10-30 02:01:06.424989 mergeResults: Saving fullTime
```

```
## Load optionsStats
load(file.path("derfinderReport-example", "chr21", "optionsStats.Rdata"), verbose = TRUE)
```

```
## Loading objects:
##   optionsStats
```

### 5.3.2 Create report

Once the *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* output has been generated and merged, use
**derfinderReport()** to create the HTML report.

```
## Load derfindeReport
library("regionReport")
```

```
## Generate the HTML report
report <- derfinderReport(
    prefix = "derfinderReport-example", browse = FALSE,
    nBestRegions = 15, makeBestClusters = TRUE,
    fullCov = list("21" = genomeDataRaw$coverage), optionsStats = optionsStats
)
```

Once the output is generated, you can browse the report from `R` using
**browseURL()** as shown below.

```
## Browse the report
browseURL(report)
```

You can view a pre-compiled version of this report [here](http://leekgroup.github.io/regionReport/reference/derfinderReport-example/basicExploration/basicExploration.html).

### 5.3.3 Notes

Note that the reports require an active Internet connection to render correctly.

The report is self-explanatory and will change some of the text depending on the
input options.

If the report is taking too long to compile (say more than 3 hours), you might
want to consider setting *nBestCluters* to a small number or even set
*makeBestClusters* to `FALSE`.

# 6 Reproducibility

This package was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[biovizBase](https://bioconductor.org/packages/3.22/biovizBase)* (Yin, Lawrence, and Cook, 2025)
* *[bumphunter](https://bioconductor.org/packages/3.22/bumphunter)* (Jaffe, Murakami, Lee, Leek, Fallin, Feinberg, and Irizarry, 2012)
* *[DEFormats](https://bioconductor.org/packages/3.22/DEFormats)* (Oleś, 2025)
* *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* (Collado-Torres, Nellore, Frazee et al., 2017)
* *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* (Collado-Torres, Jaffe, and Leek, 2017)
* *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)* (Love, Huber, and Anders, 2014)
* *[DT](https://CRAN.R-project.org/package%3DDT)* (Xie, Cheng, Tan et al., 2025)
* *[edgeR](https://bioconductor.org/packages/3.22/edgeR)* (Chen, Chen, Lun et al., 2025)
* *[GenomeInfoDb](https://bioconductor.org/packages/3.22/GenomeInfoDb)* (Arora, Morgan, Carlson, and Pagès, 2017)
* *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* (Lawrence, Huber, Pagès, Aboyoun, Carlson, Gentleman, Morgan, and Carey, 2013)
* *[ggbio](https://bioconductor.org/packages/3.22/ggbio)* (Yin, Cook, and Lawrence, 2012)
* *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* (Wickham, 2016)
* *[grid](https://CRAN.R-project.org/package%3Dgrid)* (R Core Team, 2025)
* *[gridExtra](https://CRAN.R-project.org/package%3DgridExtra)* (Auguie, 2017)
* *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* (Lawrence, Huber, Pagès et al., 2013)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014)
* *[knitrBootstrap](https://CRAN.R-project.org/package%3DknitrBootstrap)* (Hester, 2024)
* *[mgcv](https://CRAN.R-project.org/package%3Dmgcv)* (Wood, 2011)
* *[pheatmap](https://CRAN.R-project.org/package%3Dpheatmap)* (Kolde, 2025)
* *[RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer)* (Neuwirth, 2022)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)* (Team and Maintainer, 2025)
* *[whisker](https://CRAN.R-project.org/package%3Dwhisker)* (de Jonge, 2022)

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("regionReport.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("regionReport.Rmd", tangle = TRUE)
```

```
## Clean up
unlink("derfinderReport-example", recursive = TRUE)
```

Date the vignette was generated.

```
## [1] "2025-10-30 02:01:06 EDT"
```

Wallclock time spent generating the vignette.

```
## Time difference of 1.42 secs
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
##  date     2025-10-30
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
##  package              * version   date (UTC) lib source
##  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
##  AnnotationDbi          1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
##  base64enc              0.1-3     2015-07-28 [2] CRAN (R 4.5.1)
##  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
##  Biobase                2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocGenerics         * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocIO                 1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
##  BiocParallel           1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocStyle            * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  Biostrings             2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
##  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
##  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
##  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
##  bookdown               0.45      2025-10-03 [2] CRAN (R 4.5.1)
##  BSgenome               1.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
##  bumphunter           * 1.52.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
##  checkmate              2.3.3     2025-08-18 [2] CRAN (R 4.5.1)
##  cigarillo              1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
##  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
##  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
##  colorspace             2.1-2     2025-09-22 [2] CRAN (R 4.5.1)
##  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
##  curl                   7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
##  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
##  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
##  DEFormats              1.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  DelayedArray           0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinder            * 1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  derfinderHelper        1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  DESeq2                 1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
##  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
##  doRNG                  1.8.6.2   2025-04-02 [2] CRAN (R 4.5.1)
##  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
##  edgeR                  4.8.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  evaluate               1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
##  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
##  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
##  foreach              * 1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
##  foreign                0.8-90    2025-03-31 [3] CRAN (R 4.5.1)
##  Formula                1.2-5     2023-02-24 [2] CRAN (R 4.5.1)
##  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
##  GenomeInfoDb         * 1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicAlignments      1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFeatures        1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicFiles           1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  GenomicRanges        * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  ggplot2                4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
##  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
##  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
##  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
##  Hmisc                  5.2-4     2025-10-05 [2] CRAN (R 4.5.1)
##  htmlTable              2.4.3     2024-07-21 [2] CRAN (R 4.5.1)
##  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
##  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
##  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
##  IRanges              * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  iterators            * 1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
##  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
##  KEGGREST               1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
##  knitrBootstrap         1.0.3     2024-02-06 [2] CRAN (R 4.5.1)
##  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
##  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
##  limma                  3.66.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  locfit               * 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
##  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
##  magrittr               2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
##  markdown               2.0       2025-03-23 [2] CRAN (R 4.5.1)
##  Matrix                 1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
##  MatrixGenerics         1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  matrixStats            1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
##  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
##  nnet                   7.3-20    2025-01-01 [3] CRAN (R 4.5.1)
##  pillar                 1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
##  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
##  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
##  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
##  qvalue                 2.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
##  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
##  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
##  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
##  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
##  regionReport         * 1.44.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
##  reshape2               1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
##  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
##  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
##  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown              2.30      2025-09-28 [2] CRAN (R 4.5.1)
##  rngtools               1.5.2     2021-09-20 [2] CRAN (R 4.5.1)
##  rpart                  4.1.24    2025-01-07 [3] CRAN (R 4.5.1)
##  Rsamtools              2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  RSQLite                2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
##  rstudioapi             0.17.1    2024-10-22 [2] CRAN (R 4.5.1)
##  rtracklayer            1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Arrays               1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Vectors            * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
##  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
##  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
##  Seqinfo              * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
##  SparseArray            1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  statmod                1.5.1     2025-10-09 [2] CRAN (R 4.5.1)
##  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
##  stringr                1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
##  SummarizedExperiment   1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
##  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
##  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
##  UCSC.utils             1.6.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  VariantAnnotation      1.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
##  xfun                   0.53      2025-08-19 [2] CRAN (R 4.5.1)
##  XML                    3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
##  xml2                   1.4.1     2025-10-27 [2] CRAN (R 4.5.1)
##  XVector                0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
##  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/RtmpMXtm6m/Rinst27c90313432f82
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 7 Bibliography

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

[[3]](#cite-auguie2017gridextra)
B. Auguie.
*gridExtra: Miscellaneous Functions for “Grid” Graphics*.
R package version 2.3.
2017.
DOI: [10.32614/CRAN.package.gridExtra](https://doi.org/10.32614/CRAN.package.gridExtra).
URL: [https://CRAN.R-project.org/package=gridExtra](https://CRAN.R-project.org/package%3DgridExtra).

[[4]](#cite-chen2025edger)
Y. Chen, L. Chen, A. T. L. Lun, et al.
“edgeR v4: powerful differential analysis of sequencing data with expanded functionality and improved support for small counts and larger datasets”.
In: *Nucleic Acids Research* 53.2 (2025), p. gkaf018.
DOI: [10.1093/nar/gkaf018](https://doi.org/10.1093/nar/gkaf018).

[[5]](#cite-colladotorres2017derfinderplot)
L. Collado-Torres, A. E. Jaffe, and J. T. Leek.
*derfinderPlot: Plotting functions for derfinder*.
<https://github.com/leekgroup/derfinderPlot> - R package version 1.44.0.
2017.
DOI: [10.18129/B9.bioc.derfinderPlot](https://doi.org/10.18129/B9.bioc.derfinderPlot).
URL: <http://www.bioconductor.org/packages/derfinderPlot>.

[[6]](#cite-colladotorres2016regionreport)
L. Collado-Torres, A. E. Jaffe, and J. T. Leek.
“regionReport: Interactive reports for region-level and feature-level genomic analyses [version2; referees: 2 approved, 1 approved with reservations]”.
In: *F1000Research* 4 (2016), p. 105.
DOI: [10.12688/f1000research.6379.2](https://doi.org/10.12688/f1000research.6379.2).
URL: <http://f1000research.com/articles/4-105/v2>.

[[7]](#cite-colladotorres2017flexible)
L. Collado-Torres, A. Nellore, A. C. Frazee, et al.
“Flexible expressed region analysis for RNA-seq with derfinder”.
In: *Nucl. Acids Res.* (2017).
DOI: [10.1093/nar/gkw852](https://doi.org/10.1093/nar/gkw852).
URL: <http://nar.oxfordjournals.org/content/early/2016/09/29/nar.gkw852>.

[[8]](#cite-hester2024knitrbootstrap)
J. Hester.
*knitrBootstrap: ‘knitr’ Bootstrap Framework*.
R package version 1.0.3.
2024.
DOI: [10.32614/CRAN.package.knitrBootstrap](https://doi.org/10.32614/CRAN.package.knitrBootstrap).
URL: [https://CRAN.R-project.org/package=knitrBootstrap](https://CRAN.R-project.org/package%3DknitrBootstrap).

[[9]](#cite-bumphunter)
A. E. Jaffe, P. Murakami, H. Lee, et al.
“Bump hunting to identify differentially methylated regions in epigenetic epidemiology studies”.
In: *International journal of epidemiology* 41.1 (2012), pp. 200–209.
DOI: [10.1093/ije/dyr238](https://doi.org/10.1093/ije/dyr238).

[[10]](#cite-kolde2025pheatmap)
R. Kolde.
*pheatmap: Pretty Heatmaps*.
R package version 1.0.13.
2025.
DOI: [10.32614/CRAN.package.pheatmap](https://doi.org/10.32614/CRAN.package.pheatmap).
URL: [https://CRAN.R-project.org/package=pheatmap](https://CRAN.R-project.org/package%3Dpheatmap).

[[11]](#cite-lawrence2013software)
M. Lawrence, W. Huber, H. Pagès, et al.
“Software for Computing and Annotating Genomic Ranges”.
In: *PLoS Computational Biology* 9 (8 2013).
DOI: [10.1371/journal.pcbi.1003118](https://doi.org/10.1371/journal.pcbi.1003118).
URL: [[http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1003118](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118)}.](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118%7D.)

[[12]](#cite-love2014moderated)
M. I. Love, W. Huber, and S. Anders.
“Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2”.
In: *Genome Biology* 15 (12 2014), p. 550.
DOI: [10.1186/s13059-014-0550-8](https://doi.org/10.1186/s13059-014-0550-8).

[[13]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[14]](#cite-neuwirth2022rcolorbrewer)
E. Neuwirth.
*RColorBrewer: ColorBrewer Palettes*.
R package version 1.1-3.
2022.
DOI: [10.32614/CRAN.package.RColorBrewer](https://doi.org/10.32614/CRAN.package.RColorBrewer).
URL: [https://CRAN.R-project.org/package=RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer).

[[15]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[16]](#cite-ole2025deformats)
A. Oleś.
*DEFormats: Differential gene expression data formats converter*.
R package version 1.38.0.
2025.
DOI: [10.18129/B9.bioc.DEFormats](https://doi.org/10.18129/B9.bioc.DEFormats).
URL: <https://bioconductor.org/packages/DEFormats>.

[[17]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[18]](#cite-team2025txdb)
B. C. Team and B. P. Maintainer.
*TxDb.Hsapiens.UCSC.hg19.knownGene: Annotation package for TxDb object(s)*.
R package version 3.22.1.
2025.

[[19]](#cite-wickham2016ggplot2)
H. Wickham.
*ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York, 2016.
ISBN: 978-3-319-24277-4.
URL: <https://ggplot2.tidyverse.org>.

[[20]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[21]](#cite-wood2011fast)
S. N. Wood.
“Fast stable restricted maximum likelihood and marginal
likelihood estimation of semiparametric generalized linear models”.
In: *Journal of the Royal Statistical Society (B)* 73.1 (2011), pp. 3–36.
DOI: [10.1111/j.1467-9868.2010.00749.x](https://doi.org/10.1111/j.1467-9868.2010.00749.x).

[[22]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.

[[23]](#cite-xie2025wrapper)
Y. Xie, J. Cheng, X. Tan, et al.
*DT: A Wrapper of the JavaScript Library ‘DataTables’*.
R package version 0.34.0.
2025.
DOI: [10.32614/CRAN.package.DT](https://doi.org/10.32614/CRAN.package.DT).
URL: [https://CRAN.R-project.org/package=DT](https://CRAN.R-project.org/package%3DDT).

[[24]](#cite-yin2012ggbio)
T. Yin, D. Cook, and M. Lawrence.
“ggbio: an R package for extending the grammar of graphics for genomic data”.
In: *Genome Biology* 13.8 (2012), p. R77.

[[25]](#cite-yin2025biovizbase)
T. Yin, M. Lawrence, and D. Cook.
*biovizBase: Basic graphic utilities for visualization of genomic data.*
R package version 1.58.0.
2025.
DOI: [10.18129/B9.bioc.biovizBase](https://doi.org/10.18129/B9.bioc.biovizBase).
URL: <https://bioconductor.org/packages/biovizBase>.

[[26]](#cite-dejonge2022whisker)
E. de Jonge.
*whisker: mustache for R, Logicless Templating*.
R package version 0.4.1.
2022.
DOI: [10.32614/CRAN.package.whisker](https://doi.org/10.32614/CRAN.package.whisker).
URL: [https://CRAN.R-project.org/package=whisker](https://CRAN.R-project.org/package%3Dwhisker).