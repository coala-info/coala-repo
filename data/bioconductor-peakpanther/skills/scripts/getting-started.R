# Code example from 'getting-started' vignette. See references/ for full tutorial.

## ----biocstyle, echo = FALSE, results = "asis"--------------------------------
BiocStyle::markdown()

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----init, message = FALSE, echo = FALSE, results = "hide"--------------------
## Silently loading all packages
library(BiocStyle)
library(peakPantheR)
library(faahKO)
library(pander)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("peakPantheR")

## ----eval = FALSE-------------------------------------------------------------
# # Install devtools
# if(!require("devtools")) install.packages("devtools")
# devtools::install_github("phenomecentre/peakPantheR")

## ----eval = FALSE-------------------------------------------------------------
# library(peakPantheR)
# 
# peakPantheR_start_GUI(browser = TRUE)
# #  To exit press ESC in the command line

## ----fig.align="center", out.width = "700px", echo = FALSE--------------------
knitr::include_graphics("figures/example-UI.png")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("faahKO")

## -----------------------------------------------------------------------------
library(faahKO)
## file paths
input_spectraPaths  <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"),
                        system.file('cdf/KO/ko16.CDF', package = "faahKO"),
                        system.file('cdf/KO/ko18.CDF', package = "faahKO"))
input_spectraPaths

## ----eval=FALSE---------------------------------------------------------------
# # targetFeatTable
# input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
#                         c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
#                         "mz", "mzMax"))), stringsAsFactors=FALSE)
# input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390., 522.194778,
#                                 522.2, 522.205222)
# input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440., 496.195038,
#                                 496.2, 496.204962)
# input_targetFeatTable[,c(1,3:8)] <- sapply(input_targetFeatTable[,c(1,3:8)],
#                                             as.numeric)

## ----results = "asis", echo = FALSE-------------------------------------------
# use pandoc for improved readability
input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(), 
                        c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin", 
                        "mz", "mzMax"))), stringsAsFactors=FALSE)
input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390., 522.194778, 
                                522.2, 522.205222)
input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440., 496.195038,
                                496.2, 496.204962)
input_targetFeatTable[,c(1,3:8)] <- sapply(input_targetFeatTable[,c(1,3:8)], 
                                            as.numeric)
rownames(input_targetFeatTable) <- NULL
pander::pandoc.table(input_targetFeatTable, digits = 9)

## ----eval=FALSE---------------------------------------------------------------
# library(faahKO)
# 
# # Define the file paths (3 samples)
# input_spectraPaths  <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"),
#                         system.file('cdf/KO/ko16.CDF', package = "faahKO"),
#                         system.file('cdf/KO/ko18.CDF', package = "faahKO"))
# 
# # Define the targeted features (2 features)
# input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
#                         c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
#                         "mz", "mzMax"))), stringsAsFactors=FALSE)
# input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390.,
#                                 522.194778, 522.2, 522.205222)
# input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440.,
#                                 496.195038, 496.2, 496.204962)
# input_targetFeatTable[,3:8] <- sapply(input_targetFeatTable[,3:8], as.numeric)
# 
# # Define some random compound and spectra metadata
# # cpdMetadata
# input_cpdMetadata     <- data.frame(matrix(data=c('a','b',1,2), nrow=2, ncol=2,
#                             dimnames=list(c(), c('testcol1','testcol2')),
#                             byrow=FALSE), stringsAsFactors=FALSE)
# # spectraMetadata
# input_spectraMetadata <- data.frame(matrix(data=c('c','d','e',3,4,5), nrow=3,
#                             ncol=2,
#                             dimnames=list(c(),c('testcol1','testcol2')),
#                             byrow=FALSE), stringsAsFactors=FALSE)
# 
# # Initialise a simple peakPantheRAnnotation object
# # [3 files, 2 features, no uROI, no FIR]
# initAnnotation <- peakPantheRAnnotation(spectraPaths=input_spectraPaths,
#                                         targetFeatTable=input_targetFeatTable,
#                                         cpdMetadata=input_cpdMetadata,
#                                         spectraMetadata=input_spectraMetadata)
# 
# # Rename and save the annotation to disk
# annotationObject <- initAnnotation
# save(annotationObject,
#         file = './example_annotation_ppR_UI.RData',
#         compress=TRUE)
# 

## ----eval=FALSE---------------------------------------------------------------
# # Define targeted features without uROI and FIR (2 features)
# input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
#                         c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
#                         "mz", "mzMax"))), stringsAsFactors=FALSE)
# input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390.,
#                                 522.194778, 522.2, 522.205222)
# input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440.,
#                                 496.195038, 496.2, 496.204962)
# input_targetFeatTable[,3:8] <- sapply(input_targetFeatTable[,3:8], as.numeric)
# 
# # save to disk
# write.csv(input_targetFeatTable,
#             file = './1-fitParams_example_UI.csv',
#             row.names = FALSE)

## ----results = "asis", echo = FALSE-------------------------------------------
# use pandoc for improved readability
input_targetFeatTable <- data.frame(matrix(vector(), 2, 8, dimnames=list(c(),
                        c("cpdID", "cpdName", "rtMin", "rt", "rtMax", "mzMin",
                        "mz", "mzMax"))), stringsAsFactors=FALSE)
input_targetFeatTable[1,] <- c("ID-1", "Cpd 1", 3310., 3344.888, 3390.,
                                522.194778, 522.2, 522.205222)
input_targetFeatTable[2,] <- c("ID-2", "Cpd 2", 3280., 3385.577, 3440.,
                                496.195038, 496.2, 496.204962)
input_targetFeatTable[,3:8] <- sapply(input_targetFeatTable[,3:8], as.numeric)
rownames(input_targetFeatTable) <- NULL
pander::pandoc.table(input_targetFeatTable, digits = 9)

## ----eval=FALSE---------------------------------------------------------------
# # Define the spectra paths and metada
# input_spectraMeta <- data.frame(matrix(vector(), 3, 3,
#                         dimnames=list(c(),c("filepath","testcol1","testcol2"))),
#                         stringsAsFactors=FALSE)
# input_spectraMeta[1,] <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"),
#                             "c", 3)
# input_spectraMeta[2,] <- c(system.file('cdf/KO/ko16.CDF', package = "faahKO"),
#                             "d", 4)
# input_spectraMeta[3,] <- c(system.file('cdf/KO/ko18.CDF', package = "faahKO"),
#                             "e", 5)
# 
# # save to disk
# write.csv(input_spectraMeta,
#             file = './2-spectraMetaWPath_example_UI.csv',
#             row.names = FALSE)

## ----results = "asis", echo = FALSE-------------------------------------------
# use pandoc for improved readability
input_spectraMeta <- data.frame(matrix(vector(), 3, 3,
                        dimnames=list(c(),c("filepath","testcol1","testcol2"))),
                        stringsAsFactors=FALSE)
input_spectraMeta[1,] <- c(system.file('cdf/KO/ko15.CDF', package = "faahKO"),
                            "c", 3)
input_spectraMeta[2,] <- c(system.file('cdf/KO/ko16.CDF', package = "faahKO"),
                            "d", 4)
input_spectraMeta[3,] <- c(system.file('cdf/KO/ko18.CDF', package = "faahKO"),
                            "e", 5)
rownames(input_spectraMeta) <- NULL
pander::pandoc.table(input_spectraMeta, digits = 0)

## ----eval=FALSE---------------------------------------------------------------
# # Define the feature metada
# input_featMeta <- data.frame(matrix(vector(), 2, 2,
#                     dimnames=list(c(),c("testcol1","testcol2"))),
#                     stringsAsFactors=FALSE)
# input_featMeta[1,] <- c("a", 1)
# input_featMeta[2,] <- c("b", 2)
# 
# # save to disk
# write.csv(input_featMeta,
#             file = './3-featMeta_example_UI.csv',
#             row.names = FALSE)

## ----results = "asis", echo = FALSE-------------------------------------------
# use pandoc for improved readability
input_featMeta <- data.frame(matrix(vector(), 2, 2,
                    dimnames=list(c(),c("testcol1","testcol2"))),
                    stringsAsFactors=FALSE)
input_featMeta[1,] <- c("a", 1)
input_featMeta[2,] <- c("b", 2)
rownames(input_featMeta) <- NULL
pander::pandoc.table(input_featMeta, digits = 0)

## ----echo = FALSE-------------------------------------------------------------
devtools::session_info()

