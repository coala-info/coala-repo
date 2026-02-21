# Code example from 'SIMD' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install(c('edgeR', 'statmod','methylMnM'))
# 
# library(edgeR)
# library(statmod)
# library(methylMnM)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("SIMD")

## -----------------------------------------------------------------------------
library(SIMD)

## -----------------------------------------------------------------------------
datafile <- system.file("extdata", package="methylMnM")
filepath <- datafile[1]

## -----------------------------------------------------------------------------
dirwrite <- paste(setwd(getwd()), "/", sep="")

## -----------------------------------------------------------------------------
data(example_data)
allcpgfile <- EM_H1ESB1_MeDIP_sigleCpG
readshort <- paste(filepath, "/H1ESB1_MeDIP_18.extended.txt", sep="")
writefile <- paste(dirwrite, "EM2_H1ESB1_MeDIP_sigleCpG.bed", sep="")
reportfile <- paste(dirwrite, "EM2_H1ESB1_MeDIP_sigleCpG_report.bed", sep="")
EMalgorithm(cpgsitefile=readshort, allcpgfile=allcpgfile, category="1",
            writefile=writefile, reportfile=reportfile)

## -----------------------------------------------------------------------------
data(example_data)
data1 <- EM2_H1ESB1_MeDIP_sigleCpG
data2 <- EM2_H1ESB2_MeDIP_sigleCpG
data3 <- H1ESB1_MRE_sigleCpG
data4 <- H1ESB2_MRE_sigleCpG
datafile <- cbind(data1,data2,data3,data4)
allcpg <- all_CpGsite_bin_chr18
mrecpg <- three_mre_cpg
dirwrite <-paste(setwd(getwd()), "/", sep="")

writefile <- paste(dirwrite, "pval_EM_H1ESB1_H1ESB21.bed", sep="")
reportfile <- paste(dirwrite, "report_pvalH1ESB1_H1ESB21.bed", sep="")

EMtest(datafile=datafile, chrstring=NULL, cpgfile=allcpg,mrecpgfile=mrecpg, 
       writefile=writefile, reportfile=reportfile,mreratio=3/7, psd=2, 
       mkadded=1, f=1)

