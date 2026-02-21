# Code example from 'dpeak-example' vignette. See references/ for full tutorial.

### R code from vignette source 'dpeak-example.Rnw'

###################################################
### code chunk number 1: installation
###################################################
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("dpeak")


###################################################
### code chunk number 2: preliminaries
###################################################
options(prompt = "R> ")


###################################################
### code chunk number 3: dpeak-prelim
###################################################
library("dpeak")


###################################################
### code chunk number 4: dpeakread (eval = FALSE)
###################################################
## exampleData <- dpeakRead( peakfile="examplePeak.txt", readfile="exampleSETRead.txt",
##     fileFormat="eland_result", PET=FALSE, fragLen=150 )


###################################################
### code chunk number 5: dpearead-saved
###################################################
data(exampleData)


###################################################
### code chunk number 6: dpeakdata-show
###################################################
exampleData


###################################################
### code chunk number 7: dpeakdata-plot (eval = FALSE)
###################################################
## exportPlot( exampleData, filename="examplePlot_combined.pdf",
## 	strand=FALSE )
## exportPlot( exampleData, filename="examplePlot_strand_1.pdf",
## 	strand=TRUE, extension=1, smoothing=TRUE )


###################################################
### code chunk number 8: dpeakfit
###################################################
exampleFit <- dpeakFit( exampleData, maxComp=5)


###################################################
### code chunk number 9: dpeakfit-show
###################################################
exampleFit


###################################################
### code chunk number 10: dpeakfit-plot (eval = FALSE)
###################################################
## exportPlot( exampleFit, filename="exampleResult_combined.pdf" )
## exportPlot( exampleFit, filename="exampleResult_strand_1.pdf",
## 	strand=TRUE, extension=1, smoothing=TRUE )
## exportPlot( exampleFit, filename="exGOF.pdf", plotType="GOF" )


###################################################
### code chunk number 11: dpeakfit-export
###################################################
exportPeakList( exampleFit, type="txt", filename="result.txt" )
exportPeakList( exampleFit, type="bed", filename="result.bed" )
exportPeakList( exampleFit, type="gff", filename="result.gff" )


