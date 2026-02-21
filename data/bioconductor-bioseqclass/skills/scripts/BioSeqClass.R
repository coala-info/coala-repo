# Code example from 'BioSeqClass' vignette. See references/ for full tutorial.

### R code from vignette source 'BioSeqClass.Rnw'

###################################################
### code chunk number 1: install (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("BioSeqClass")


###################################################
### code chunk number 2: install2 (eval = FALSE)
###################################################
## source("http://www.biosino.org/download/BioSeqClass/BioSeqClass.R")
## BioSeqClass()


###################################################
### code chunk number 3: load
###################################################
library(BioSeqClass)


###################################################
### code chunk number 4: homologReduction
###################################################
  library(BioSeqClass)
  # Example data in BioSeqClass.
  file=file.path(path.package("BioSeqClass"),"example","acetylation_K.fasta")
  posfile = file.path(path.package("BioSeqClass"), 
       "example", "acetylation_K.site")
  # Only a part of lysine acetylation sites are used for demo.
  posfile1=tempfile()
  write.table(read.table(posfile,sep='\t',header=F)[1:20,], posfile1, 
    sep='\t', quote=F, row.names=F, col.names=F)
  seqList = getTrain(file, posfile1, aa="K", w=7, identity=0.4)


###################################################
### code chunk number 5: readData
###################################################
  tmpDir=file.path(path.package('BioSeqClass'), 'example')
  tmpFile1=file.path(tmpDir, 'acetylation_K.pos40.pep')
  tmpFile2=file.path(tmpDir, 'acetylation_K.neg40.pep')
  posSeq=as.matrix(read.csv(tmpFile1,header=F,sep='\t',row.names=1))[,1]
  negSeq=as.matrix(read.csv(tmpFile2,header=F,sep='\t',row.names=1))[,1]
  seq=c(posSeq,negSeq)  
  classLable=c(rep("+1",length(posSeq)),rep("-1",length(negSeq)) ) 
  length(seq)


###################################################
### code chunk number 6: featureSelect
###################################################
  # Use 0-1 binary coding.
  feature1 = featureBinary(seq,elements("aminoacid"))
  dim(feature1)
  # Use the compostion of paired amino acids.
  feature2 = featureGapPairComposition(seq,0,elements("aminoacid"))
  dim(feature2)


###################################################
### code chunk number 7: classModel
###################################################
  data = data.frame(feature1,classLable)
  # Use support vector machine and 5 fold cross validation to do classification.
  LIBSVM_CV5 = classify(data, classifyMethod='libsvm',
               cv=5, svm.kernel='linear',svm.scale=F)
  LIBSVM_CV5[["totalPerformance"]]
  # Features selection is done by envoking "CfsSubsetEval" method in WEKA.
  FS_LIBSVM_CV5 = classify(data, classifyMethod='libsvm',
                  cv=5, evaluator='CfsSubsetEval', search='BestFirst',
                  svm.kernel='linear', svm.scale=F)
  
  FS_LIBSVM_CV5[["totalPerformance"]] ## Accuracy is increased by feature selection.
  # Selected features:
  colnames(data)[FS_LIBSVM_CV5$features[[1]]]


###################################################
### code chunk number 8: featureTest (eval = FALSE)
###################################################
##   fileName = tempfile()
##   # Note: It may be time consuming.
##   testFeatureSet = featureEvaluate(seq, classLable, fileName, cv=5, 
##     ele.type='aminoacid', featureMethod=c('Binary','GapPairComposition'),
##     classifyMethod='libsvm',
##     group=c('aaH', 'aaV', 'aaZ', 'aaP', 'aaF', 'aaS', 'aaE'), g=0,
##     hydro.methods=c('kpm', 'SARAH1'), hydro.indexs=c('hydroE', 'hydroF', 'hydroC') )
##   summary = read.csv(fileName,sep="\t",header=T)      
##   # Plot the result of 'featureEvaluate'
##   require("scatterplot3d")     
##   tmp1 = summary[,"Feature_Function"]
##   tmp2 = as.factor(sapply(as.vector(summary[,'Feature_Parameter']),
##          function(x){unlist(strsplit(x,split='; '))[1]}))
##   testResult = data.frame(as.integer(tmp2), as.integer(tmp1), summary[,"acc"])
##   s3d=scatterplot3d(testResult,
##       color=c('red','blue')[testResult[,2]], pch=19, xlab='Parameter',
##       ylab='Feature Coding',
##       zlab='Accuracy', lab=c(9,3,7),       
##       x.ticklabs=gsub('class: ','',sort(unique(tmp2))), 
##       type='h',ylim=c(0,3),y.margin.add=2.5,
##       y.ticklabs=c('',gsub('feature','',sort(unique(tmp1))),'') )


###################################################
### code chunk number 9: featureComSelect (eval = FALSE)
###################################################
##   feature.index = 1:3
##   tmp <- testFeatureSet[[1]]$data
##   tmp1 <- testFeatureSet[[feature.index[1]]]$model
##   colnames(tmp) <- paste(
##     tmp1["Feature_Function"],
##     tmp1["Feature_Parameter"],
##     colnames(tmp),sep=" ; ")      
##   data <- tmp[,-ncol(tmp)]  
##   for(i in 2:length(feature.index) ){
##     tmp <- testFeatureSet[[feature.index[i]]]$data
##     tmp1 <- testFeatureSet[[feature.index[i]]]$model
##     colnames(tmp) <- paste(
##       tmp1["Feature_Function"],
##       tmp1["Feature_Parameter"],
##       colnames(tmp),sep=" ; ")    
##     data <- data.frame(data, tmp[,-ncol(tmp)] )
##   }
##   name <- colnames(data)
##   data <- data.frame(data, tmp[,ncol(tmp)] )  ## Combined features
##   # Use 'selectFFS' to do feature forward selection.
##   # Note: It may be time consuming.
##   combineFeatureResult = selectFFS(data,accCutoff=0.005,
##     classifyMethod="knn",cv=5)  ## It is time consuming.
##   tmp = sapply(combineFeatureResult,function(x){
##     c(length(x$features),x$performance["acc"])})
##   plot(tmp[1,],tmp[2,],xlab="Feature Number",ylab="Accuracy",
##     , pch=19)
##   lines(tmp[1,],tmp[2,])


###################################################
### code chunk number 10: BioSeqClass.Rnw:488-489
###################################################
sessionInfo()


