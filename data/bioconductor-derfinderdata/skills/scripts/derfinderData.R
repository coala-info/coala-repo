# Code example from 'derfinderData' vignette. See references/ for full tutorial.

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    BiocStyle = citation("BiocStyle")[1],
    brainspan = RefManageR::BibEntry(bibtype = "Unpublished", key = "brainspan", title = "Atlas of the Developing Human Brain [Internet]. Funded by ARRA Awards 1RC2MH089921-01, 1RC2MH090047-01, and 1RC2MH089929-01.", author = "BrainSpan", year = 2011, url = "http://developinghumanbrain.org"),
    RefManageR = citation("RefManageR")[1],
    knitr = citation("knitr")[3],
    rmarkdown = citation("rmarkdown")[1]
)

## ----'pheno'------------------------------------------------------------------
## Construct brainspanPheno table
brainspanPheno <- data.frame(
    gender = c("F", "M", "M", "M", "F", "F", "F", "M", "F", "M", "M", "F", "M", "M", "M", "M", "F", "F", "F", "M", "F", "M", "M", "F"),
    lab = c("HSB97.AMY", "HSB92.AMY", "HSB178.AMY", "HSB159.AMY", "HSB153.AMY", "HSB113.AMY", "HSB130.AMY", "HSB136.AMY", "HSB126.AMY", "HSB145.AMY", "HSB123.AMY", "HSB135.AMY", "HSB114.A1C", "HSB103.A1C", "HSB178.A1C", "HSB154.A1C", "HSB150.A1C", "HSB149.A1C", "HSB130.A1C", "HSB136.A1C", "HSB126.A1C", "HSB145.A1C", "HSB123.A1C", "HSB135.A1C"),
    Age = c(-0.442307692307693, -0.365384615384615, -0.461538461538461, -0.307692307692308, -0.538461538461539, -0.538461538461539, 21, 23, 30, 36, 37, 40, -0.519230769230769, -0.519230769230769, -0.461538461538461, -0.461538461538461, -0.538461538461539, -0.519230769230769, 21, 23, 30, 36, 37, 40)
)
brainspanPheno$structure_acronym <- rep(c("AMY", "A1C"), each = 12)
brainspanPheno$structure_name <- rep(c("amygdaloid complex", "primary auditory cortex (core)"), each = 12)
brainspanPheno$file <- paste0("http://download.alleninstitute.org/brainspan/MRF_BigWig_Gencode_v10/bigwig/", brainspanPheno$lab, ".bw")
brainspanPheno$group <- factor(ifelse(brainspanPheno$Age < 0, "fetal", "adult"), levels = c("fetal", "adult"))

## ----'savePheno', eval = FALSE------------------------------------------------
# ## Save pheno table
# save(brainspanPheno, file = "brainspanPheno.RData")

## ----'explorePheno', results = 'asis'-----------------------------------------
library("knitr")

## Explore pheno
p <- brainspanPheno[, -which(colnames(brainspanPheno) %in% c("structure_acronym", "structure_name", "file"))]
kable(p, format = "html", row.names = TRUE)

## ----'verifyPheno'------------------------------------------------------------
## Rename our newly created pheno data
newPheno <- brainspanPheno

## Load the included data
library("derfinderData")

## Verify
identical(newPheno, brainspanPheno)

## ----'getData', eval = FALSE--------------------------------------------------
# library("derfinder")
# 
# ## Determine the files to use and fix the names
# files <- brainspanPheno$file
# names(files) <- gsub(".AMY|.A1C", "", brainspanPheno$lab)
# 
# ## Load the data
# system.time(fullCovAMY <- fullCoverage(
#     files = files[brainspanPheno$structure_acronym == "AMY"], chrs = "chr21"
# ))
# # user  system elapsed
# # 4.505   0.178  37.676
# system.time(fullCovA1C <- fullCoverage(
#     files = files[brainspanPheno$structure_acronym == "A1C"], chrs = "chr21"
# ))
# # user  system elapsed
# # 2.968   0.139  27.704
# 
# ## Write BigWig files
# dir.create("AMY")
# system.time(createBw(fullCovAMY, path = "AMY", keepGR = FALSE))
# # user  system elapsed
# # 5.749   0.332   6.045
# dir.create("A1C")
# system.time(createBw(fullCovA1C, path = "A1C", keepGR = FALSE))
# # user  system elapsed
# # 5.025   0.299   5.323
# 
# ## Check that 12 files were created in each directory
# all(c(length(dir("AMY")), length(dir("A1C"))) == 12)
# # TRUE
# 
# ## Save data for examples running on Windows
# save(fullCovAMY, file = "fullCovAMY.RData")
# save(fullCovA1C, file = "fullCovA1C.RData")

## ----'findData'---------------------------------------------------------------
## Find AMY BigWigs
dir(system.file("extdata", "AMY", package = "derfinderData"))

## Find A1C BigWigs
dir(system.file("extdata", "A1C", package = "derfinderData"))

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("derfinderData.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("derfinderData.Rmd", tangle = TRUE)

## ----reproducibility1, echo=FALSE---------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproducibility2, echo=FALSE---------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproducibility3, echo=FALSE---------------------------------------------
## Session info
library("sessioninfo")
session_info()

## ----vignetteBiblio, results='asis', echo=FALSE-------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

