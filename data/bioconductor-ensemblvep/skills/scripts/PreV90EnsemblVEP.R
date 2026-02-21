# Code example from 'PreV90EnsemblVEP' vignette. See references/ for full tutorial.

### R code from vignette source 'PreV90EnsemblVEP.Rnw'

###################################################
### code chunk number 1: setup
###################################################
library(ensemblVEP)


###################################################
### code chunk number 2: man_page (eval = FALSE)
###################################################
## ?ensemblVEP
## ?VEPParam


###################################################
### code chunk number 3: default_VEPParam
###################################################
param <- VEPParam(version=88)
param
basic(param)


###################################################
### code chunk number 4: rtn_GRanges (eval = FALSE)
###################################################
## fl <- system.file("extdata", "gl_chr1.vcf", package="VariantAnnotation")
## gr <- ensemblVEP(fl)


###################################################
### code chunk number 5: structural_vcf
###################################################
fl <- system.file("extdata", "structural.vcf", package="VariantAnnotation")


###################################################
### code chunk number 6: set_vcf
###################################################
param <- VEPParam(dataformat=c(vcf=TRUE), version=88)


###################################################
### code chunk number 7: set_format
###################################################
input(param)$format <- "vcf"


###################################################
### code chunk number 8: rtn_VCF
###################################################
vep <- ensemblVEP(fl, param)


###################################################
### code chunk number 9: rtn_VCF
###################################################
info(vep)$CSQ


###################################################
### code chunk number 10: parseCSQToGRanges
###################################################
vcf <- readVcf(fl, "hg19")
csq <- parseCSQToGRanges(vep, VCFRowID=rownames(vcf))
head(csq, 3)


###################################################
### code chunk number 11: map_rownames
###################################################
vcf[csq$"VCFRowID"]


###################################################
### code chunk number 12: output_file_default
###################################################
input(param)$output_file


###################################################
### code chunk number 13: output_file_filename
###################################################
input(param)$output_file <- "/mypath/myfile"


###################################################
### code chunk number 14: ouput_slot
###################################################
## Write a vcf file to myfile.vcf:
myparam <- VEPParam(dataformat=c(vcf=TRUE),
                    input=c(output_file="/path/myfile.vcf"), version=88)
## Write a gvf file to myfile.gvf:
myparam <- VEPParam(dataformat=c(gvf=TRUE),
                    input=c(output_file="/path/myfile.gvf"), version=88)
## Write a tab delimited file to myfile.txt:
myparam <- VEPParam(input=c(output_file="/path/myfile.txt"), version=88)


###################################################
### code chunk number 15: samplefile
###################################################
fl <- system.file("extdata", "ex2.vcf", package="VariantAnnotation")


###################################################
### code chunk number 16: runtime1 (eval = FALSE)
###################################################
## param <- VEPParam(output=c(regulatory=TRUE), version=88)
## gr <- ensemblVEP(fl, param) 


###################################################
### code chunk number 17: runtime2 (eval = FALSE)
###################################################
## param <- VEPParam(input=c(format="vcf"),
##                   output=c(terms="so"),
##                   identifiers=c(symbol=TRUE), version=88)
## gr <- ensemblVEP(fl, param) 


###################################################
### code chunk number 18: runtime3 (eval = FALSE)
###################################################
## param <- VEPParam(filterqc=c(coding_only=TRUE),
##                   colocatedVariants=c(check_existing=TRUE),
##                   identifiers=c(symbol=TRUE), version=88)
## gr <- ensemblVEP(fl, param) 


###################################################
### code chunk number 19: sessionInfo
###################################################
sessionInfo()


