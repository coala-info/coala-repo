# Code example from 'mQTLUse' vignette. See references/ for full tutorial.

### R code from vignette source 'mQTLUse.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: R
###################################################
# Download raw data files
library(mQTL.NMR)
load_datafiles()
format_mQTL(phenofile,genofile,physiodat,cleandat,cleangen)


###################################################
### code chunk number 3: R
###################################################
# Constant Sum normalization
nmeth<-'CS'
normalise_mQTL(cleandat,CSnorm,nmeth)


###################################################
### code chunk number 4: R
###################################################
align_mQTL(CSnorm,aligdat)


###################################################
### code chunk number 5: R
###################################################
met="rectangle" # choose the statistical summarizing measure ("max","sum","trapez",...)
pre_mQTL(aligdat, reducedF, RedMet="SRV",met, corrT=0.9)


###################################################
### code chunk number 6: R
###################################################
results<- list() # a list to stock the mQTL mapping results
nperm<- 0 # number of permutations if required
results<-process_mQTL(reducedF, cleangen, nperm)


###################################################
### code chunk number 7: R
###################################################
 post_mQTL(results)


###################################################
### code chunk number 8: R
###################################################
summary_mQTL(results,rectangle_SRV,T=8)


###################################################
### code chunk number 9: R
###################################################
circle_mQTL(results, T=8,spacing=0)


###################################################
### code chunk number 10: mQTLUse.Rnw:134-136
###################################################
library("graphics")
circle_mQTL(results, T=8,spacing=0)


###################################################
### code chunk number 11: R
###################################################
simple.plot(file=aligdat,lo=3.02,hi=3.08,k=1:60,title="NMR profile")


###################################################
### code chunk number 12: mQTLUse.Rnw:155-156
###################################################
simple.plot(file=aligdat,lo=3.02,hi=3.08,k=1:60,title="NMR profile")


###################################################
### code chunk number 13: R
###################################################
SRV.plot(file1=aligdat,file2=rectangle_SRV,lo=3.02,hi=3.08,k=1:60,title="Clusters plot")


###################################################
### code chunk number 14: mQTLUse.Rnw:165-166
###################################################
SRV.plot(file1=aligdat,file2=rectangle_SRV,lo=3.02,hi=3.08,k=1:60,title="Cluster plot")


###################################################
### code chunk number 15: R
###################################################
Top_SRV.plot(file1=aligdat,file2=rectangle_SRV,results=results,met=met,intMeth="mean")


###################################################
### code chunk number 16: mQTLUse.Rnw:176-177
###################################################
Top_SRV.plot(file1=aligdat,file2=rectangle_SRV,results=results,met=met,intMeth="mean")


###################################################
### code chunk number 17: R
###################################################
SRV_lod.plot(results,rectangle_SRV,T=1)


###################################################
### code chunk number 18: mQTLUse.Rnw:183-184
###################################################
SRV_lod.plot(results,rectangle_SRV,T=1)


###################################################
### code chunk number 19: mQTLUse.Rnw:196-197
###################################################
sessionInfo()


