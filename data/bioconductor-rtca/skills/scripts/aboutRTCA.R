# Code example from 'aboutRTCA' vignette. See references/ for full tutorial.

### R code from vignette source 'aboutRTCA.Rnw'

###################################################
### code chunk number 1: loadLib
###################################################
library(RTCA)


###################################################
### code chunk number 2: dataImport
###################################################
ofile <-  system.file("extdata/testOutput.csv", package="RTCA")
x <- parseRTCA(ofile)


###################################################
### code chunk number 3: dataImportFile (eval = FALSE)
###################################################
## ofile <- file.path("/directory/of/the/file/myFile.txt")


###################################################
### code chunk number 4: printRTCA
###################################################
x


###################################################
### code chunk number 5: annotate
###################################################
pfile <- system.file("extdata/testOutputPhenoData.csv", package="RTCA")
pData <- read.csv(pfile, sep="\t", row.names="Well")
metaData <- data.frame(labelDescription=c(
                         "Rack number",
                         "siRNA catalogue number",
                         "siRNA gene symbol",
                         "siRNA EntrezGene ID",
                         "siRNA targeting accession"
                         ))
phData <- new("AnnotatedDataFrame", data=pData, varMetadata=metaData)


###################################################
### code chunk number 6: annotateAssign
###################################################
phenoData(x) <- phData


###################################################
### code chunk number 7: annotatedx
###################################################
head(pData(x))


###################################################
### code chunk number 8: alternativeAnnotate (eval = FALSE)
###################################################
## x <- parseRTCA(ofile, phenoData=phData)


###################################################
### code chunk number 9: plotRTCA
###################################################
  plot(x[,1:4], type="l", col="black", lty=1:4, xlab="time point", ylab="Cell Index")


###################################################
### code chunk number 10: addTimeLine
###################################################
x <- addAction(x, 22, "trasfection")
x <- addAction(x, 30, "medium change")


###################################################
### code chunk number 11: extractTimeLine
###################################################
timeline(x)


###################################################
### code chunk number 12: timeLineExamples
###################################################
tl <- timeline(x)
show(tl)
tlAdd <- addAction(tl, 35, "normalization"); tlAdd
getAction(tl, 22)
tlComp <- updateAction(tl, 22, "compound transfection")
tlComp
tlRm <- rmAction(tlAdd,35 ); tlRm


###################################################
### code chunk number 13: ratioTransform
###################################################
xRatio <- ratioTransform(x, 35)
plot(xRatio[,1:4], lty=1:4, type="l", col="black",xlab="time point", ylab="Normalized Cell Index")
abline(v=35, col="red", lwd=2)


###################################################
### code chunk number 14: plateView
###################################################
plateView(x, col="orange")


###################################################
### code chunk number 15: sessionInfo
###################################################
toLatex(sessionInfo())


