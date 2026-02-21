# Code example from 'phosphonormalizer' vignette. See references/ for full tutorial.

### R code from vignette source 'phosphonormalizer.Rnw'

###################################################
### code chunk number 1: phosphonormalizer.Rnw:64-70 (eval = FALSE)
###################################################
## 
## 
## ## try http:// if https:// URLs are not supported
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("phosphonormalizer")


###################################################
### code chunk number 2: phosphonormalizer.Rnw:75-94
###################################################


#Load the library
library(phosphonormalizer)
#Specify the column numbers of abundances in the original
#data.frame, from both enriched and non-enriched runs
samplesCols <- data.frame(enriched=3:17, non.enriched=3:17)
#Specify the column numbers of sequence and modification , 
#in the original data.frame from both enriched and non-enriched runs
modseqCols <- data.frame(enriched = 1:2, non.enriched = 1:2)
#The samples and their technical replicates
techRep <- factor(x = c(1,1,1,2,2,2,3,3,3,4,4,4,5,5,5))
#If the parameter plot.fc is set, then the corresponding plots of sample fold changes are produced.
#Here, for demonstration, the fold change distributions are shown for samples 3 vs 1
plot.param <- list(control = c(1), samples = c(3))
# Call the function to perform the pairwise normalization:
norm <- normalizePhospho(enriched = enriched.rd, non.enriched = non.enriched.rd, 
		samplesCols = samplesCols, modseqCols = modseqCols, techRep = techRep, 
	plot.fc = plot.param)


