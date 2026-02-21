# Code example from 'iCheck' vignette. See references/ for full tutorial.

### R code from vignette source 'iCheck.Rnw'

###################################################
### code chunk number 1: iCheck.Rnw:53-126
###################################################
  library(iCheck)

  if (!interactive())
  {
    options(rgl.useNULL = TRUE)
  }

  # generate sample probe data 
  set.seed(1234567)
  es.sim = genSimData.BayesNormal(nCpGs = 110, 
    nCases = 20, nControls = 20,
    mu.n = -2, mu.c = 2,
    d0 = 20, s02 = 0.64, s02.c = 1.5, testPara = "var",
    outlierFlag = FALSE, 
    eps = 1.0e-3, applier = lapply) 
  print(es.sim)

  # create replicates
  dat=exprs(es.sim)
  dat[,1]=dat[,2]
  dat[,3]=dat[,4]
  

  exprs(es.sim)=dat
  es.sim$arrayID=as.character(es.sim$arrayID)
  es.sim$arrayID[1]=es.sim$arrayID[2]
  es.sim$arrayID[3]=es.sim$arrayID[4]
  es.sim$arrayID[5:8]="Hela"

  # since simulated data set does not have 'Pass_Fail',
  #  'Tissue_Descr', 'Batch_Run_Date', 'Chip_Barcode',
  #  'Chip_Address', 'Hybridization_Name', 'Subject_ID', 'gender'
  # we generate them now to illustrate the R functions in the package 

  es.sim$Hybridization_Name = paste(es.sim$arrayID, 1:ncol(es.sim), sep="_")
  # assume the first 4 arrays are genetic control samples
  es.sim$Subject_ID = es.sim$arrayID

  es.sim$Pass_Fail = rep("pass", ncol(es.sim))

  # produce genetic control GC samples
  es.sim$Tissue_Descr=rep("CD4", ncol(es.sim))
  # assume the first 4 arrays are genetic control samples
  es.sim$Tissue_Descr[5:8]="Human Hela Cell"

  es.sim$Batch_Run_Date = 1:ncol(es.sim)
  es.sim$Chip_Barcode = 1:ncol(es.sim)
  es.sim$Chip_Address = 1:ncol(es.sim)

  es.sim$gender=rep(1, ncol(es.sim))
  set.seed(12345)
  pos=sample(x=1:ncol(es.sim), size=ceiling(ncol(es.sim)/2), replace=FALSE) 
  es.sim$gender[pos]=0


  # generate sample probe data 
  es.raw = es.sim[-c(1:10),]
  print(es.raw)
  
  # generate QC probe data 
  es.QC = es.sim[c(1:10),]

  # since simulated data set does not have 'Reporter_Group_Name'
  #  we created it now to illustrate the usage of 'plotQCCurves'.
  fDat=fData(es.QC)
  fDat$Reporter_Group_Name=rep("biotin", 10)
  fDat$Reporter_Group_Name[3:4]="cy3_hyb"
  fDat$Reporter_Group_Name[5:6]="housekeeping"
  fDat$Reporter_Group_Name[7:8]="low_stringency_hyb"
  fData(es.QC)=fDat

  print(es.QC)
  


###################################################
### code chunk number 2: iCheck.Rnw:137-138
###################################################
print(table(es.raw$Pass_Fail, useNA="ifany"))


###################################################
### code chunk number 3: iCheck.Rnw:143-149
###################################################
pos<-which(es.raw$Pass_Fail != "pass")
if(length(pos))
{
  es.raw<-es.raw[, -pos]
  es.QC<-es.QC[, -pos]
}


###################################################
### code chunk number 4: iCheck.Rnw:162-185
###################################################

     plotQCCurves(
         esQC=es.QC,
         probes = c("biotin"), #"cy3_hyb", "housekeeping"),
           #"low_stringency_hyb"),
         labelVariable = "subjID",
         hybName = "Hybridization_Name",
         reporterGroupName = "Reporter_Group_Name",
         requireLog2 = FALSE,
         projectName = "test",
         plotOutPutFlag = FALSE,
         cex = 1,
         ylim = NULL,
         xlab = "",
         ylab = "log2(intensity)",
         lwd = 3,
         mar = c(10, 4, 4, 2) + 0.1,
         las = 2,
         cex.axis = 1,
         sortFlag = TRUE,
         varSort = c("Batch_Run_Date", "Chip_Barcode", "Chip_Address"),
         timeFormat = c("%m/%d/%Y", NA, NA)
       )  


###################################################
### code chunk number 5: iCheck.Rnw:225-245
###################################################

     R2PlotFunc(
         es=es.raw,
         hybName = "Hybridization_Name",
         arrayType = "GC",
         GCid = c("128115", "Hela", "Brain"),
         probs = seq(0, 1, 0.25),
         col = gplots::greenred(75),
         labelVariable = "subjID",
         outFileName = "test_R2_raw.pdf",
         title = "Raw Data R^2 Plot",
         requireLog2 = FALSE,
         plotOutPutFlag = FALSE,
         las = 2,
         keysize = 1,
         margins = c(10, 10),
         sortFlag = TRUE,
         varSort=c("Batch_Run_Date", "Chip_Barcode", "Chip_Address"),
         timeFormat=c("%m/%d/%Y", NA, NA)
       )  


###################################################
### code chunk number 6: iCheck.Rnw:254-268
###################################################
print(table(es.raw$Tissue_Descr, useNA="ifany"))

# for different data sets, the label for GC arrays might
# be different.
pos.del<-which(es.raw$Tissue_Descr == "Human Hela Cell")
cat("No. of GC arrays=", length(pos.del), "\n")

if(length(pos.del))
{
  es.raw<-es.raw[,-pos.del]
  es.QC<-es.QC[,-pos.del]
  print(dims(es.raw))
  print(dims(es.QC))
}


###################################################
### code chunk number 7: iCheck.Rnw:276-296
###################################################

     R2PlotFunc(
         es=es.raw,
         arrayType = c("replicates"),
         GCid = c("128115", "Hela", "Brain"),
         probs = seq(0, 1, 0.25),
         col = gplots::greenred(75),
         labelVariable = "subjID",
         outFileName = "test_R2_raw.pdf",
         title = "Raw Data R^2 Plot",
         requireLog2 = FALSE,
         plotOutPutFlag = FALSE,
         las = 2,
         keysize = 1,
         margins = c(10, 10),
         sortFlag = TRUE,
         varSort=c("Subject_ID", "Hybridization_Name", "Batch_Run_Date", "Chip_Barcode", "Chip_Address"),
         timeFormat=c(NA, NA, "%m/%d/%Y", NA, NA)
       )  



###################################################
### code chunk number 8: iCheck.Rnw:312-321
###################################################
    densityPlots(
      es = es.raw, 
      requireLog2 = FALSE,
      myxlab = "expression level", 
      datExtrFunc = exprs, 
      fileFlag = FALSE, 
      fileFormat = "ps", 
      fileName = "densityPlots_sim.ps")



###################################################
### code chunk number 9: iCheck.Rnw:347-364
###################################################
     quantilePlot(
         dat=exprs(es.raw),
         fileName,
         probs = c(0, 0.05, 0.25, 0.5, 0.75, 0.95, 1),
         plotOutPutFlag = FALSE,
         requireLog2 = FALSE,
         sortFlag = TRUE,
         cex = 1,
         ylim = NULL,
         xlab = "",
         ylab = "log2(intensity)",
         lwd = 3,
         main = "Trajectory plot of quantiles\n(sample arrays)",
         mar = c(15, 4, 4, 2) + 0.1,
         las = 2,
         cex.axis = 1
         )


###################################################
### code chunk number 10: iCheck.Rnw:374-392
###################################################
# note we need to take log2 transformation
# if requireLog2 = TRUE.
requireLog2 = FALSE
if(requireLog2)
{  
  minVec<-apply(log2(exprs(es.raw)), 1, min, na.rm=TRUE)
  # suppose the cutoff is 0.5
  print(sum(minVec< 0.5))
  pos.del<-which(minVec<0.5)

  cat("Number of gene probes with outlying expression levels>>",
  length(pos.del), "\n")
  if(length(pos.del))
  {
    es.raw<-es.raw[-pos.del,]
  }
}



###################################################
### code chunk number 11: iCheck.Rnw:407-432
###################################################

     plotSamplep95p05(
         es=es.raw,
         labelVariable = "memSubj",
         requireLog2 = FALSE,
         projectName = "test",
         plotOutPutFlag = FALSE,
         cex = 1,
         ylim = NULL,
         xlab = "",
         ylab = "",
         lwd = 1.5,
         mar = c(10, 4, 4, 2) + 0.1,
         las = 2,
         cex.axis=1.5,
         title = "Trajectory of p95/p05",
         cex.legend = 1.5,
         cex.lab = 1.5,
         legendPosition = "topright",
         cut1 = 10,
         cut2 = 6,
         sortFlag = TRUE,
         varSort = c("Batch_Run_Date", "Chip_Barcode", "Chip_Address"),
         timeFormat = c("%m/%d/%Y", NA, NA),
         verbose = FALSE)


###################################################
### code chunk number 12: iCheck.Rnw:441-454
###################################################
p95<-quantile(exprs(es.raw), prob=0.95)
p05<-quantile(exprs(es.raw), prob=0.05)

r<-p95/p05
pos.del<-which(r<6)
print(pos.del)

if(length(pos.del))
{
  es.raw<-es.raw[,-pos.del]
  es.QC<-es.QC[,-pos.del]
}



###################################################
### code chunk number 13: iCheck.Rnw:471-480
###################################################

     pcaObj<-getPCAFunc(es=es.raw,
                labelVariable = "subjID",
                requireLog2 = FALSE,
                corFlag = FALSE
              
               
     )



###################################################
### code chunk number 14: iCheck.Rnw:487-508
###################################################

     pca2DPlot(pcaObj=pcaObj,
               plot.dim = c(1,2),
               labelVariable = "memSubj",
               outFileName = "test_pca_raw.pdf",
               title = "Scatter plot of pcas (memSubj)",
               plotOutPutFlag = FALSE,
               mar = c(5, 4, 4, 2) + 0.1,
               lwd = 1.5,
               equalRange = TRUE,
               xlab = NULL,
               ylab = NULL,
               xlim = NULL,
               ylim = NULL,
               cex.legend = 1.5,
               cex = 1.5,
               cex.lab = 1.5,
               cex.axis = 1.5,
               legendPosition = "topright"
             
               )


###################################################
### code chunk number 15: iCheck.Rnw:517-519
###################################################
tt <- es.raw
es.q<-lumiN(tt, method="quantile")


###################################################
### code chunk number 16: iCheck.Rnw:532-560
###################################################
     pcaObj<-getPCAFunc(es=es.q,
                labelVariable = "subjID",
                requireLog2 = FALSE,
                corFlag = FALSE
                
     )


     pca2DPlot(pcaObj=pcaObj,
               plot.dim = c(1,2),
               labelVariable = "memSubj",
               outFileName = "test_pca_raw.pdf",
               title = "Scatter plot of pcas (memSubj)\n(log2 transformed and quantile normalized)",
               plotOutPutFlag = FALSE,
               mar = c(5, 4, 4, 2) + 0.1,
               lwd = 1.5,
               equalRange = TRUE,
               xlab = NULL,
               ylab = NULL,
               xlim = NULL,
               ylim = NULL,
               cex.legend = 1.5,
               cex = 1.5,
               cex.lab = 1.5,
               cex.axis = 1.5,
               legendPosition = "topright"
               )



###################################################
### code chunk number 17: iCheck.Rnw:588-600
###################################################

res.limma=lmFitWrapper(
  es=es.q, 
  formula=~as.factor(memSubj), 
  pos.var.interest = 1,
  pvalAdjMethod="fdr", 
  alpha=0.05, 
  probeID.var="probe", 
  gene.var="gene", 
  chr.var="chr", 
  verbose=TRUE)



###################################################
### code chunk number 18: iCheck.Rnw:610-626
###################################################

res.glm=glmWrapper(
  es=es.q,
  formula = xi~as.factor(memSubj), 
  pos.var.interest = 1,
  family=gaussian,
  logit=FALSE, 
  pvalAdjMethod="fdr", 
  alpha = 0.05, 
  probeID.var = "probe", 
  gene.var = "gene", 
  chr.var = "chr", 
  applier=lapply,
  verbose=TRUE 
  )



###################################################
### code chunk number 19: iCheck.Rnw:634-650
###################################################

res.lkh=lkhrWrapper(
  es=es.q,
  formulaReduced = xi~as.factor(memSubj), 
  formulaFull = xi~as.factor(memSubj)+gender, 
  family=gaussian,
  logit=FALSE, 
  pvalAdjMethod="fdr", 
  alpha = 0.05, 
  probeID.var = "probe", 
  gene.var = "gene", 
  chr.var = "chr", 
  applier=lapply,
  verbose=TRUE 
  )



###################################################
### code chunk number 20: iCheck.Rnw:665-681
###################################################

    boxPlots(
      resFrame = res.limma$frame, 
      es = es.sim, 
      col.resFrame = c("probeIDs", "stats", "pval", "p.adj"), 
      var.pheno = "memSubj", 
      var.probe = "probe", 
      var.gene = "gene", 
      var.chr = "chr", 
      nTop = 20, 
      myylab = "expression level", 
      datExtrFunc = exprs, 
      fileFlag = FALSE, 
      fileFormat = "ps", 
      fileName = "boxPlots_sim.ps")



###################################################
### code chunk number 21: iCheck.Rnw:690-707
###################################################

    # regard memSubj as continuos for illustration purpose
    scatterPlots(
      resFrame = res.limma$frame, 
      es = es.sim, 
      col.resFrame = c("probeIDs", "stats", "pval", "p.adj"), 
      var.pheno = "memSubj", 
      var.probe = "probe", 
      var.gene = "gene", 
      var.chr = "chr", 
      nTop = 20, 
      myylab = "expression level", 
      datExtrFunc = exprs, 
      fileFlag = FALSE, 
      fileFormat = "ps", 
      fileName = "scatterPlots_sim.ps")



###################################################
### code chunk number 22: sessionInfo
###################################################
toLatex(sessionInfo())


