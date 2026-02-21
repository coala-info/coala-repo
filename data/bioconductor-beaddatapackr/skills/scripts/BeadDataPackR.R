# Code example from 'BeadDataPackR' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----Loading, eval=TRUE, echo = TRUE---------------------------------------
    library(BeadDataPackR)
    dataPath <- system.file("extdata", package = "BeadDataPackR")
    tempPath <- tempdir()

## ----Compress, eval=FALSE, echo = TRUE-------------------------------------
#     compressBeadData(txtFile = "example.txt", locsGrn = "example_Grn.locs",
#                      outputFile = "example.bab", path = tempPath, nBytes = 4,
#                      nrow = 326, ncol = 4)

## ----Decompress, eval=FALSE------------------------------------------------
#     decompressBeadData(inputFile = "example.bab", inputPath = tempPath,
#                        outputMask = "restored", outputPath = tempPath,
#                        outputNonDecoded = FALSE, roundValues = TRUE )

## ----readCompressed, eval = FALSE------------------------------------------
#   readCompressedData(inputFile = "example.bab", path = tempPath,
#                      probeIDs = c(10008, 10010) )

## ----extractLocsFile, eval = FALSE-----------------------------------------
#   locs <- extractLocsFile(inputFile = "example.bab", path = tempPath)

## ----sessionInfo, eval=TRUE------------------------------------------------
sessionInfo()

