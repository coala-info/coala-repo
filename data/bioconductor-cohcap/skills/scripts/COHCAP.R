# Code example from 'COHCAP' vignette. See references/ for full tutorial.

### R code from vignette source 'COHCAP.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: inputVariables
###################################################
library("COHCAP")

dir = system.file("extdata", package="COHCAP")
beta.file = file.path(dir,"GSE42308_truncated.txt")
sample.file = file.path(dir,"sample_GSE42308.txt")
expression.file = file.path(dir,"expression-Average_by_Island_truncated.txt")
project.folder = getwd()
project.name = "450k_avg_by_island_test"


###################################################
### code chunk number 2: annotation
###################################################
beta.table = COHCAP.annotate(beta.file, project.name, project.folder,
				platform="450k-UCSC")


###################################################
### code chunk number 3: site
###################################################
filtered.sites = COHCAP.site(sample.file, beta.table, project.name,
				project.folder, ref="parental")


###################################################
### code chunk number 4: island
###################################################
island.list = COHCAP.avg.by.island(sample.file, filtered.sites, beta.table,
				project.name, project.folder, ref="parental")


###################################################
### code chunk number 5: integrate
###################################################
COHCAP.integrate.avg.by.island(island.list, project.name, project.folder,
				expression.file, sample.file)


