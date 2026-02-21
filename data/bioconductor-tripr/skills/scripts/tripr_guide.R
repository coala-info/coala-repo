# Code example from 'tripr_guide' vignette. See references/ for full tutorial.

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## For links
library("BiocStyle")
## Track time spent on making the vignette
#startTime <- Sys.time()
## Bib setup
library("RefManageR")
## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    DT = citation("DT")[1],
    ggplot2 = citation("ggplot2")[1],
    golem = citation("golem")[1],
    knitr = citation("knitr")[3],
    plotly = citation("plotly")[1],
    RColorBrewer = citation("RColorBrewer")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    shiny = citation("shiny")[1],
    testthat = citation("testthat")[1],
    biocthis = citation("biocthis")[1],
    shinyjs = citation("shinyjs")[1],
    shinyFiles = citation("shinyFiles")[1],
    plyr = citation("plyr")[1],
    data.table = citation("data.table")[1],
    stringr = citation("stringr")[1],
    stringdist = citation("stringdist")[1],
    plot3D = citation("plot3D")[1], 
    gridExtra = citation("gridExtra")[1],
    dplyr = citation("dplyr")[1],
    pryr = citation("pryr")[1],
    shinyBS = citation("shinyBS")[1],
    fs = citation("fs")[1]
)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
    comment = "#>",
    error = FALSE,
    warning = FALSE,
    message = FALSE,
    crop = NULL
)

## ----echo=FALSE, out.width='50%', fig.align='center'--------------------------
knitr::include_graphics(path = system.file("app", "www", "tripr.png", 
                                           package="tripr", mustWork=TRUE))

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("tripr")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----setup--------------------------------------------------------------------
library(tripr)

## ----demostart, eval=FALSE----------------------------------------------------
# tripr::run_app()

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", "upload_data.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", "Preselection.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "Preselection_Clean_table.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", "Selection.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", "Selection_visual.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "pipeline_overview.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "Clonotypes_pipeline.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "clonotypes_tab.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "highly_similar_pipeline.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "highly_sim_clono_tab.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "repertoires_pipeline.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "repertoires_tab.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "mv_pipeline.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "multiple_tab.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "insert_identity_pipeline.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "Alignment_pipeline.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "alignment_tab.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "visual_clono.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "hist3d_visual.png", 
                                           package="tripr", mustWork=TRUE))

## ----echo=FALSE, out.width='100%', fig.align='center'-------------------------
knitr::include_graphics(path = system.file("app", "www", 
                                            "overview.png", 
                                           package="tripr", mustWork=TRUE))

## ----eval = FALSE-------------------------------------------------------------
#     ?tripr::run_TRIP

## ----eval=FALSE---------------------------------------------------------------
#     fs::path_package("extdata", "dataset", package = "tripr")

## ----eval=FALSE---------------------------------------------------------------
#     c("1_Summary.txt", "2_IMGT-gapped-nt-sequences.txt",
#         "4_IMGT-gapped-AA-sequences.txt", "6_Junction.txt")

## ----eval=FALSE---------------------------------------------------------------
#     datapath <- fs::path_package("extdata", "dataset", package="tripr")
#     output_path <- tools::R_user_dir("tripr", which="cache")
#     cell <- "Bcell"
#     preselection <- "1,2,3,4C:W"
#     selection <- "5"
#     filelist <- c("1_Summary.txt",
#                   "2_IMGT-gapped-nt-sequences.txt",
#                   "4_IMGT-gapped-AA-sequences.txt",
#                   "6_Junction.txt")
#     throughput <- "High Throughput"
#     preselection <- "1,2,3,4C:W"
#     selection <- "5"
#     identity_range <- "88:100"
#     pipeline <- "1"
#     select_clonotype <- "V Gene + CDR3 Amino Acids"
# 
#     run_TRIP(
#         datapath=datapath,
#         output_path=output_path,
#         filelist=filelist,
#         cell=cell,
#         throughput=throughput,
#         preselection=preselection,
#         selection=selection,
#         identity_range=identity_range,
#         pipeline=pipeline,
#         select_clonotype=select_clonotype)

## ----'citation'---------------------------------------------------------------
## Citation info
citation("tripr")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE, message = FALSE----
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

