# Code example from 'VegaMC' vignette. See references/ for full tutorial.

### R code from vignette source 'VegaMC.Rnw'

###################################################
### code chunk number 1: library_VegaMC
###################################################
library(VegaMC)


###################################################
### code chunk number 2: copy_dataset
###################################################
file.copy(system.file("example/breast_Affy500K.txt",
    package="VegaMC"),".")


###################################################
### code chunk number 3: runVegaMC_breast
###################################################
results <-
vegaMC("breast_Affy500K.txt",
	output_file_name="breast.analysis",
	beta=1,	min_region_bp_size=2000, bs=5000,
	html=FALSE, getGenes=FALSE)


###################################################
### code chunk number 4: colnames_results
###################################################
colnames(results)


