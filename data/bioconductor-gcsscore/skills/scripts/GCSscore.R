# Code example from 'GCSscore' vignette. See references/ for full tutorial.

### R code from vignette source 'GCSscore.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: GCSscore.Rnw:52-58
###################################################
# load GCSscore package:
library(GCSscore)

# load data.table package for parsing data files
# outside of the GCSscore package:
# library(data.table)


###################################################
### code chunk number 2: GCSscore.Rnw:68-73
###################################################
# get the path to example CEL files in the package directory:
celpath1 <- system.file("extdata/","MN_2_3.CEL", package = "GCSscore")
celpath2 <- system.file("extdata/","MN_4_1.CEL", package = "GCSscore")
# run GCSscore() function directly on the two .CEL files above:
GCSs.single <- GCSscore(celFile1 = celpath1, celFile2 = celpath2)


###################################################
### code chunk number 3: GCSscore.Rnw:78-89
###################################################
# view class of output:
class(GCSs.single)[1]

# convert GCSscore single-run from ExpressionSet to data.table:
GCSs.single.dt <- 
  data.table::as.data.table(cbind(GCSs.single@featureData@data,
                                  GCSs.single@assayData[["exprs"]]))

# preview the beginning and end of the output.
# *remove 'gene_name' column for printing to PDF:
head(GCSs.single.dt[,-c("gene_name","nProbes")])


###################################################
### code chunk number 4: GCSscore.Rnw:110-118
###################################################
# get the path to example CSV file in the package directory:
celtab_path <- system.file("extdata",
                           "Ss2_BATCH_example.csv", 
                           package = "GCSscore")
# read in the .CSV file with fread():
celtab <- data.table::fread(celtab_path)
# view structure of 'celTable' input:
celtab


###################################################
### code chunk number 5: GCSscore.Rnw:121-131
###################################################
# For the following example, the .CEL files are not in the working
# directory.  The path to the .CEL files must be added to allow
# the GCSscore() function to find them:

# adds path to celFile names in batch input:
#   NOTE: this is not necessary if the .CEL files 
#         are in the working directory:
path <- system.file("extdata", package = "GCSscore")
celtab$CelFile1 <- celtab[,paste(path,CelFile1,sep="/")]
celtab$CelFile2 <- celtab[,paste(path,CelFile2,sep="/")]


###################################################
### code chunk number 6: GCSscore.Rnw:136-138
###################################################
# run GCSscore() function with batch input:
GCSs.batch <- GCSscore(celTable = celtab, celTab.names = TRUE)


###################################################
### code chunk number 7: GCSscore.Rnw:143-154
###################################################
# view class of output:
class(GCSs.batch)[1]

# converting GCS-score output from'ExpressionSet' to 'data.table':
GCSs.batch.dt <-
  data.table::as.data.table(cbind(GCSs.batch@featureData@data,
                                  GCSs.batch@assayData[["exprs"]]))

# preview the beginning and output of the batch output:
# *remove 'gene_name' and 'nProbes' columns for printing to PDF:
head(GCSs.batch.dt[,-c("gene_name","nProbes")])


###################################################
### code chunk number 8: GCSscore.Rnw:160-166
###################################################
## find scores greater than 3 SD:
signif <- GCSs.single.dt[abs(Sscore) >= 3]

# View the resulting table:
# removing 'gene_name' and 'nProbes' columns for PDF printing:
head(signif[,-c("gene_name","nProbes")])


###################################################
### code chunk number 9: GCSscore.Rnw:171-179
###################################################
# Calculate p-valus significant
## find the corresponding one-sided p-values:
signif[,p.values.1 := (1 - pnorm(abs(signif[,Sscore])))]
## find the corresponding two-sided p-values
signif[,p.values.2 := 2*(1 - pnorm(abs(signif[,Sscore])))]

# sort the probe_ids by the absolute value of the Sscore:
signif <- signif[order(abs(Sscore),decreasing = TRUE)]


###################################################
### code chunk number 10: GCSscore.Rnw:182-187
###################################################
# View the top of the most differentially expressed genes
# from the GCSs.single output:

# removing 'gene_name' and 'nProbes' columns for PDF printing:
head(signif[,-c("gene_name","nProbes")])


