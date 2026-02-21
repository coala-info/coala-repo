# Code example from 'CardinalIO-guide' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----install, eval=FALSE------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("CardinalIO")

## ----library------------------------------------------------------------------
library(CardinalIO)

## ----parse--------------------------------------------------------------------
path <- exampleImzMLFile("continuous")
path
p <- parseImzML(path, ibd=TRUE)
p

## ----fileDescription----------------------------------------------------------
p$fileDescription

## ----fileContent-continuous---------------------------------------------------
p$fileDescription$fileContent[["IMS:1000030"]]

## ----scanSettings-------------------------------------------------------------
p$scanSettingsList

## ----softwareList-------------------------------------------------------------
p$softwareList

## ----instrumentConfigurationList----------------------------------------------
p$instrumentConfigurationList

## ----instrumentConfiguration-componentList------------------------------------
p$instrumentConfigurationList$LTQFTUltra0$componentList

## ----dataProcessingList-------------------------------------------------------
p$dataProcessingList

## ----spectrum-positions-------------------------------------------------------
p$run$spectrumList$positions

## ----spectrum-mzArrays--------------------------------------------------------
p$run$spectrumList$mzArrays

## ----spectrum-intensityArrays-------------------------------------------------
p$run$spectrumList$intensityArrays

## ----ibd-spectra--------------------------------------------------------------
p$ibd$mz
p$ibd$intensity

## ----ibd-spectra-plot---------------------------------------------------------
mz1 <- p$ibd$mz[[1L]]
int1 <- p$ibd$intensity[[1L]]
plot(mz1, int1, type="l", xlab="m/z", ylab="Intensity")

## ----ImzMeta-instance---------------------------------------------------------
e <- ImzMeta()
e

## ----ImzMeta-spectrum-assign--------------------------------------------------
e$spectrumType <- "MS1 spectrum"
e$spectrumRepresentation <- "profile"
e

## ----ImzMeta-spectrum-assign-error, error=TRUE--------------------------------
try({
e$spectrumType <- "spectrum"
})

## ----ImzMeta-to-ImzML---------------------------------------------------------
p2 <- as(e, "ImzML")
p2
p2$fileDescription

## ----ImzML-to-ImzMeta---------------------------------------------------------
e2 <- as(p, "ImzMeta")
e2

## ----write-ImzML--------------------------------------------------------------
p
path2 <- tempfile(fileext=".imzML")
writeImzML(p, file=path2)

## ----create-MS-dataset--------------------------------------------------------
set.seed(2023)
nx <- 3
ny <- 3
nmz <- 500
mz <- seq(500, 510, length.out=nmz)
intensity <- replicate(nx * ny, rlnorm(nmz))
positions <- expand.grid(x=seq_len(nx), y=seq_len(ny))
plot(mz, intensity[,1], type="l", xlab="m/z", ylab="Intensity")

## ----create-ImzMeta-----------------------------------------------------------
meta <- ImzMeta(spectrumType="MS1 spectrum",
    spectrumRepresentation="profile",
    instrumentModel="LTQ FT Ultra",
    ionSource="electrospray ionization",
    analyzer="ion trap",
    detectorType="electron multiplier")
meta

## ----write-ImzMeta------------------------------------------------------------
path3 <- tempfile(fileext=".imzML")
writeImzML(meta, file=path3, positions=positions, mz=mz, intensity=intensity)

## ----session-info-------------------------------------------------------------
sessionInfo()

