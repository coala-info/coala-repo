# Code example from 'introduction' vignette. See references/ for full tutorial.

### R code from vignette source 'introduction.rnw'

###################################################
### code chunk number 1: introduction.rnw:155-157 (eval = FALSE)
###################################################
## BiocManager::install("SemDist")
## library(SemDist)


###################################################
### code chunk number 2: introduction.rnw:159-160
###################################################
library(SemDist)


###################################################
### code chunk number 3: introduction.rnw:173-176
###################################################
# Examine built-in IA data
data("Info_Accretion_mouse_CC", package="SemDist")
head(IAccr)


###################################################
### code chunk number 4: introduction.rnw:178-182 (eval = FALSE)
###################################################
## # Calculate IA, specify evidence codes
## # Requires downloading annotation data package
## BiocManager::install("org.Hs.eg.db")
## IAccr <- computeIA("MF", "human", evcodes=c("EXP", "IC"))


###################################################
### code chunk number 5: introduction.rnw:189-198
###################################################

# Calculate IA, specify ontology and annotations
ontfile <- system.file("extdata", "mfo_ontology.txt",
                        package="SemDist")
annotations <- system.file("extdata", "MFO_LABELS_TEST.txt", 
                            package="SemDist")
IAccr <- computeIA("my", "values", specify.ont=TRUE, 
                myont=ontfile, specify.annotations=TRUE, 
                annotfile=annotations)


###################################################
### code chunk number 6: introduction.rnw:204-207 (eval = FALSE)
###################################################
## # Calculate IA, specify ontology
## IAccr <- computeIA("MF", "human", specify.ont=TRUE,
##          myont=ontfile, specify.annotations=FALSE)


###################################################
### code chunk number 7: introduction.rnw:229-236
###################################################
# Sample true, prediction files included with SemDist:
truefile <- system.file("extdata", "MFO_LABELS_TEST.txt", 
                        package="SemDist")
predfile <- system.file("extdata", "MFO_PREDS_TEST.txt", 
                        package="SemDist")
predictions <- read.table(predfile, colClasses = "character")
head(predictions)


###################################################
### code chunk number 8: introduction.rnw:245-248
###################################################
rumiTable <- findRUMI("MF", "human", 0.75, truefile, predfile)
avgRU <- mean(rumiTable$RU)
avgMI <- mean(rumiTable$MI)


###################################################
### code chunk number 9: introduction.rnw:258-266
###################################################
# A sample IA file that comes with the SemDist package.
myIA <- system.file("extdata", "myIA.rda", package="SemDist")
load(myIA)

# "MF" and "human" are present only for naming purposes
# since IA is taken from myIA.rda
rumiTable <- findRUMI("MF", "human", 0.75, truefile, predfile, 
                        IAccr = IA)


###################################################
### code chunk number 10: introduction.rnw:278-281
###################################################
avgRUMIvals <- RUMIcurve("MF", "human", 0.05, truefile, predfile)
firstset <- avgRUMIvals[[1]]
plot(firstset$RU, firstset$MI)


###################################################
### code chunk number 11: introduction.rnw:291-295
###################################################
# Minimize distance from origin over all points in RUMI curve:

semdist <- min(sqrt(firstset$MI^2 + firstset$RU^2))
semdist


###################################################
### code chunk number 12: introduction.rnw:307-311
###################################################
rumiout <- RUMIcurve("MF", "human", 0.05, truefile, predfile,
                     add.prec.rec=TRUE, add.weighted=TRUE)
firstset <- rumiout[[1]]
plot(firstset$WRU, firstset$WMI)


