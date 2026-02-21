# Code example from 'derfinderHelper' vignette. See references/ for full tutorial.

## ----'installDer', eval = FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("derfinderHelper")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'citation'---------------------------------------------------------------
## Citation info
citation("derfinderHelper")

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    derfinderHelper = citation("derfinderHelper")[1],
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[3],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    R = citation(),
    IRanges = citation("IRanges")[1],
    Matrix = citation("Matrix")[1],
    S4Vectors = RefManageR::BibEntry(
        bibtype = "manual", key = "S4Vectors",
        author = "Hervé Pagès and Michael Lawrence and Patrick Aboyoun",
        title = "S4Vectors: S4 implementation of vector-like and list-like objects",
        year = 2017, doi = "10.18129/B9.bioc.S4Vectors"
    ),
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1]
)

## ----'createData'-------------------------------------------------------------
## Create some toy data
suppressPackageStartupMessages(library("IRanges"))
set.seed(20140923)
toyData <- DataFrame(
    "sample1" = Rle(sample(0:10, 1000, TRUE)),
    "sample2" = Rle(sample(0:10, 1000, TRUE)),
    "sample3" = Rle(sample(0:10, 1000, TRUE)),
    "sample4" = Rle(sample(0:10, 1000, TRUE)),
    "sample5" = Rle(sample(0:15, 1000, TRUE)),
    "sample6" = Rle(sample(0:15, 1000, TRUE)),
    "sample7" = Rle(sample(0:15, 1000, TRUE)),
    "sample8" = Rle(sample(0:15, 1000, TRUE)),
    "sample9" = Rle(sample(0:20, 1000, TRUE)),
    "sample10" = Rle(sample(0:20, 1000, TRUE)),
    "sample11" = Rle(sample(0:20, 1000, TRUE)),
    "sample12" = Rle(sample(0:20, 1000, TRUE)),
    "sample13" = Rle(sample(0:100, 1000, TRUE)),
    "sample14" = Rle(sample(0:100, 1000, TRUE)),
    "sample15" = Rle(sample(0:100, 1000, TRUE)),
    "sample16" = Rle(sample(0:100, 1000, TRUE))
)

## Lets say that we have 4 groups
group <- factor(rep(toupper(letters[1:4]), each = 4))

## Note that some groups have higher coverage, we can adjust for this in the model
sampleDepth <- sapply(toyData, sum)
sampleDepth

## ----'createModels'-----------------------------------------------------------
## Build the model matrices
mod <- model.matrix(~ sampleDepth + group)
mod0 <- model.matrix(~sampleDepth)

## Explore them
mod
mod0

## ----'calculateFstats'--------------------------------------------------------
library("derfinderHelper")
fstats <- fstats.apply(data = toyData, mod = mod, mod0 = mod0, scalefac = 1)
fstats

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("derfinderHelper.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("derfinderHelper.Rmd", tangle = TRUE)

## ----reproducibility1, echo=FALSE---------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproducibility2, echo=FALSE---------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproducibility3, echo=FALSE-------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

