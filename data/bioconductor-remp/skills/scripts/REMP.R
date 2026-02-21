# Code example from 'REMP' vignette. See references/ for full tutorial.

### R code from vignette source 'REMP.Rnw'

###################################################
### code chunk number 1: REMP.Rnw:27-35
###################################################
library(knitr)
options(width=72)

listing <- function(x, options) {
  paste("\\begin{lstlisting}[basicstyle=\\ttfamily,breaklines=true]\n",
    x, "\\end{lstlisting}\n", sep = "")
}
knit_hooks$set(source=listing, output=listing)


###################################################
### code chunk number 2: bioconductorREMPrelease (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("REMP")


###################################################
### code chunk number 3: bioconductorREMPdev (eval = FALSE)
###################################################
## library(devtools)
## install_github("YinanZheng/REMP")


###################################################
### code chunk number 4: loadREMP
###################################################
library(REMP)


###################################################
### code chunk number 5: grooMethy
###################################################
# Get GM12878 methylation data (450k array)
GM12878_450k <- getGM12878('450k') 
GM12878_450k <- grooMethy(GM12878_450k)
GM12878_450k


###################################################
### code chunk number 6: SeqGR
###################################################
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)
getLocations(IlluminaHumanMethylation450kanno.ilmn12.hg19)


###################################################
### code chunk number 7: remparcel
###################################################
data(Alu.hg19.demo)
remparcel <- initREMP(arrayType = "450k",
                     REtype = "Alu",
                     annotation.source = "AH",
                     genome = "hg19",
                     RE = Alu.hg19.demo,
                     ncore = 1)
remparcel


###################################################
### code chunk number 8: saveParcel
###################################################
saveParcel(remparcel)


###################################################
### code chunk number 9: rempredict
###################################################
remp.res <- remp(GM12878_450k, 
                 REtype = 'Alu', 
                 parcel = remparcel, 
                 ncore = 1, 
                 seed = 777)


###################################################
### code chunk number 10: rempprint
###################################################
remp.res

# Display more detailed information
details(remp.res)


###################################################
### code chunk number 11: rempaccessors
###################################################
# Predicted RE-CpG methylation value (Beta value)
rempB(remp.res)

# Predicted RE-CpG methylation value (M value)
rempM(remp.res)

# Genomic location information of the predicted RE-CpG
# Function inherit from class 'RangedSummarizedExperiment'
rowRanges(remp.res)

# Standard error-scaled permutation importance of predictors
rempImp(remp.res)

# Retrive seed number used for the reesults
metadata(remp.res)$Seed


###################################################
### code chunk number 12: remptrim
###################################################
# Any predicted CpG values with quality score less than
# threshold (default = 1.7) will be replaced with NA. 
# CpGs contain more than missingRate * 100% (default = 20%) 
# missing rate across samples will be discarded. 
remp.res <- rempTrim(remp.res, threshold = 1.7, missingRate = 0.2)
details(remp.res)


###################################################
### code chunk number 13: rempaggregate
###################################################
remp.res <- rempAggregate(remp.res, NCpG = 2)
details(remp.res)


###################################################
### code chunk number 14: rempdecodeAnnot
###################################################
# By default gene symbol annotation will be added 
remp.res <- decodeAnnot(remp.res)
rempAnnot(remp.res)


###################################################
### code chunk number 15: rempplot
###################################################
remplot(remp.res, main = "Alu methylation (GM12878)", col = "blue")


###################################################
### code chunk number 16: remprofile
###################################################
# Use Alu.hg19.demo for demonstration
remp.res <- remprofile(GM12878_450k, 
                       REtype = "Alu", 
                       annotation.source = "AH", 
                       genome = "hg19", 
                       RE = Alu.hg19.demo)
details(remp.res)

# All accessors and utilites for REMProduct are applicable
remp.res <- rempAggregate(remp.res)
details(remp.res)


