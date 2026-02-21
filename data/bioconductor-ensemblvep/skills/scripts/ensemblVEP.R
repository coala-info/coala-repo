# Code example from 'ensemblVEP' vignette. See references/ for full tutorial.

### R code from vignette source 'ensemblVEP.Rnw'

###################################################
### code chunk number 1: setup
###################################################
library(ensemblVEP)


###################################################
### code chunk number 2: man_page (eval = FALSE)
###################################################
## ?ensemblVEP
## ?VEPFlags


###################################################
### code chunk number 3: default_VEPFlags
###################################################
param <- VEPFlags()
param
flags(param)


###################################################
### code chunk number 4: rtn_GRanges
###################################################
fl <- system.file("extdata", "gl_chr1.vcf", package="VariantAnnotation")
gr <- ensemblVEP(fl)
head(gr, 3)


###################################################
### code chunk number 5: set_vcf
###################################################
param <- VEPFlags(flags=list(vcf=TRUE))
vep <- ensemblVEP(fl, param)


###################################################
### code chunk number 6: rtn_VCF
###################################################
info(vep)$CSQ


###################################################
### code chunk number 7: parseCSQToGRanges
###################################################
vcf <- readVcf(fl, "hg19")
csq <- parseCSQToGRanges(vep, VCFRowID=rownames(vcf))
head(csq, 3)


###################################################
### code chunk number 8: map_rownames
###################################################
vcf[csq$"VCFRowID"]


###################################################
### code chunk number 9: output_file_default
###################################################
flags(param)$output_file


###################################################
### code chunk number 10: output_file_filename
###################################################
flags(param)$output_file <- "/mypath/myfile"


###################################################
### code chunk number 11: ouput_slot
###################################################
## Write a vcf file to myfile.vcf:
myparam <- VEPFlags(flags=list(vcf=TRUE,
                        output_file="/path/myfile.vcf"))
## Write a gvf file to myfile.gvf:
myparam <- VEPFlags(flags=list(gvf=TRUE,
                        output_file="/path/myfile.gvf"))
## Write a tab delimited file to myfile.txt:
myparam <- VEPFlags(flags=list(output_file="/path/myfile.txt"))


###################################################
### code chunk number 12: samplefile
###################################################
fl <- system.file("extdata", "ex2.vcf", package="VariantAnnotation")


###################################################
### code chunk number 13: runtime1 (eval = FALSE)
###################################################
## param <- VEPFlags(flags=list(regulatory=TRUE))
## gr <- ensemblVEP(fl, param) 


###################################################
### code chunk number 14: runtime2 (eval = FALSE)
###################################################
## param <- VEPFlags(flag=list(format="vcf",
##                       terms="SO",
##                       symbol=TRUE))
## gr <- ensemblVEP(fl, param) 


###################################################
### code chunk number 15: runtime3 (eval = FALSE)
###################################################
## param <- VEPFlags(flags=list(coding_only=TRUE,
##                       check_existing=TRUE,
##                       symbol=TRUE))
## gr <- ensemblVEP(fl, param) 


###################################################
### code chunk number 16: sessionInfo
###################################################
sessionInfo()


