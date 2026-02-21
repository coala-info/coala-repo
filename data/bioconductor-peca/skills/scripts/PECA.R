# Code example from 'PECA' vignette. See references/ for full tutorial.

### R code from vignette source 'PECA.Rnw'

###################################################
### code chunk number 1: peptides_data
###################################################
filePath <- system.file("extdata", "peptides.tsv", package="PECA")
data <- read.csv(file=filePath, sep="\t")
head(data)


###################################################
### code chunk number 2: peptides_peca
###################################################
library(PECA)
group1 <- c("A1", "A2", "A3")
group2 <- c("B1", "B2", "B3")
results <- PECA_tsv(filePath, group1, group2)


###################################################
### code chunk number 3: peptides_results
###################################################
head(results)


###################################################
### code chunk number 4: microarray_data
###################################################
library(SpikeIn)
data(SpikeIn133)


###################################################
### code chunk number 5: microarray_peca
###################################################
data <- SpikeIn133[,c(1,15,29,2,16,30)]
results <- PECA_AffyBatch(normalize="true", affy=data)


###################################################
### code chunk number 6: microarray_results
###################################################
head(results)


