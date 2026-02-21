# Code example from 'yeastRNASeq' vignette. See references/ for full tutorial.

### R code from vignette source 'yeastRNASeq.Rnw'

###################################################
### code chunk number 1: yeastRNASeq.Rnw:22-23
###################################################
options(width = 70)


###################################################
### code chunk number 2: yeastRNASeq.Rnw:26-27
###################################################
require(yeastRNASeq)


###################################################
### code chunk number 3: yeastRNASeq.Rnw:31-33
###################################################
x <- citation(package = "yeastRNASeq")[[1]]
print(x, bibtex = FALSE)


###################################################
### code chunk number 4: yeastRNASeq.Rnw:38-39
###################################################
citation("yeastRNASeq")


###################################################
### code chunk number 5: yeastRNASeq.Rnw:53-54
###################################################
list.files(file.path(system.file(package = "yeastRNASeq"), "reads"))


###################################################
### code chunk number 6: yeastRNASeq.Rnw:64-70
###################################################
require(ShortRead)
files <- list.files(file.path(system.file(package = "yeastRNASeq"), "reads"),
                    pattern = "bowtie", full.names = TRUE)
names(files) <- gsub("\\.bowtie.*", "", basename(files))
names(files)
aligned <- lapply(files, readAligned, type = "Bowtie")


###################################################
### code chunk number 7: yeastRNASeq.Rnw:78-80
###################################################
data(yeastAligned)
yeastAligned[["mut_1_f"]]


###################################################
### code chunk number 8: yeastRNASeq.Rnw:83-84
###################################################
round(sapply(aligned, length) / 500000, 2)


###################################################
### code chunk number 9: yeastRNASeq.Rnw:91-95
###################################################
data(yeastAnno)
dim(yeastAnno)
head(yeastAnno, n = 2)
table(yeastAnno$gene_biotype)


###################################################
### code chunk number 10: yeastRNASeq.Rnw:99-101
###################################################
data(geneLevelData)
head(geneLevelData, n = 2)


