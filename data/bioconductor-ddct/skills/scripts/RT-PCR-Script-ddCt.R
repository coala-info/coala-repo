# Code example from 'RT-PCR-Script-ddCt' vignette. See references/ for full tutorial.

### R code from vignette source 'RT-PCR-Script-ddCt.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(width=50)


###################################################
### code chunk number 2: ddCtInstall (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install(ddCt)


###################################################
### code chunk number 3: specifyFiles
###################################################
load.path = "."
save.path = "."


###################################################
### code chunk number 4: The Data
###################################################

Ct.data.file.name       <-  c("")

sample.annotation.file.name  <- NULL
column.for.grouping          <- NULL
useOnlySamplesFromAnno       <- FALSE


###################################################
### code chunk number 5: transform
###################################################
#new.gene.names    <- c("Gen1"="Gene A",
#		        "Gen4"="Gene B",
#			"Gen5"="Gene C",
#			"Gen2"="HK1",
#			"Gen3"="HK2")
new.gene.names    <- NULL
new.sample.names  <- NULL


###################################################
### code chunk number 6: housekeeping
###################################################
name.referenz.sample <- c("Sample2")
name.referenz.gene   <- c("Gene3")


###################################################
### code chunk number 7: threshold
###################################################
Threshold.for.Ct <- 40


###################################################
### code chunk number 8: mean/median
###################################################
TYPEOFCALCULATION <- "mean"


###################################################
### code chunk number 9: eff (eval = FALSE)
###################################################
## EFFICIENCIES <- c("Gene A"=1.9,"Gene B"=1.8,"HK1"=2,"Gene C"=2,"HK2"=2)
## EFFICIENCIES.ERROR <- c("Gene A"=0.01,"Gene B"=0.1,"HK1"=0.05,"Gene C"=0.01,"HK2"=0.2)


###################################################
### code chunk number 10: effizienzen
###################################################
EFFICIENCIES <- NULL


###################################################
### code chunk number 11: eff.error
###################################################
EFFICIENCIES.ERROR <- NULL


###################################################
### code chunk number 12: PlotKind
###################################################
TheKindOfPlot <- c("level","Ct")


###################################################
### code chunk number 13: remaining
###################################################
#REMAIN
names.of.the.genes.REMAIN.in.Output   <- NULL
names.of.the.samples.REMAIN.in.Output <- NULL
#NOT
names.of.the.genes.NOT.in.Output      <- NULL
names.of.the.samples.NOT.in.Output    <- NULL


###################################################
### code chunk number 14: grouping
###################################################
GROUPINGBYSAMPLES <- TRUE


###################################################
### code chunk number 15: plot0
###################################################
own.plot.for.each.object     <- TRUE


###################################################
### code chunk number 16: plot1
###################################################
GroupingForPlot <- NULL
GroupingColor   <- c("#E41A1C","#377EB8","#4DAF4A","#984EA3","#FF7F00")


###################################################
### code chunk number 17: plot2
###################################################
CUTOFF <- NULL


###################################################
### code chunk number 18: plot3
###################################################
BREWERCOL <- c("Set3","Set1","Accent","Dark2","Spectral","PuOr","BrBG")


###################################################
### code chunk number 19: plot4
###################################################
LEGENDE <- TRUE


###################################################
### code chunk number 20: ttest1
###################################################
perform.ttest <- FALSE


###################################################
### code chunk number 21: ttest
###################################################
column.for.ttest <- NULL


###################################################
### code chunk number 22: ttest3
###################################################
column.for.pairs     <- NULL      ## ansonsten NULL


###################################################
### code chunk number 23: ttest4
###################################################
names.of.the.samples.REMAIN.in.ttest <- names.of.the.samples.REMAIN.in.Output
names.of.the.samples.NOT.in.ttest    <- names.of.the.samples.NOT.in.Output



###################################################
### code chunk number 24: RT-PCR-Script-ddCt.Rnw:382-384
###################################################
names.of.the.samples.REMAIN.in.cor <- names.of.the.samples.REMAIN.in.Output
names.of.the.samples.NOT.in.cor    <- names.of.the.samples.NOT.in.Output 


###################################################
### code chunk number 25: lib
###################################################
library(Biobase)
library(lattice)
library(RColorBrewer)
library(ddCt)


###################################################
### code chunk number 26: runastest
###################################################
## in case key parameters were not specified, the script runs in test mode
testMode <- FALSE
if (length(Ct.data.file.name) == 1 & Ct.data.file.name[1]=="")
  testMode <- TRUE
if(testMode) {
  Ct.data.file.name <- "Experiment1.txt"
  load.path <- system.file("extdata", package="ddCt")
  name.referenz.sample <- c("Sample2")
  name.referenz.gene   <- c("Gene3","Gene2")
}


###################################################
### code chunk number 27: readData
###################################################
datadir <- function(x) file.path(load.path, x)
savedir <- function(x) file.path(save.path,x)
file.names <- datadir(Ct.data.file.name)
sho <- paste(gsub(".txt","",Ct.data.file.name),collapse="_")

warningFile <- savedir(paste("warning.output",sho,".txt",sep=""))

CtData <- SDMFrame(file.names)

if (!is.null(Threshold.for.Ct)){
 A <- Ct(CtData)>= Threshold.for.Ct
 coreData(CtData)$Ct[A] <- NA
}

if (! is.null(new.gene.names))   CtData[,2] <- new.gene.names[CtData[,2]]
if (! is.null(new.sample.names)) CtData[,1] <- new.sample.names[CtData[,1]]



if(! is.null(sample.annotation.file.name)){
   info <- datadir(sample.annotation.file.name)
   sampleInformation <- read.AnnotatedDataFrame(info,header=TRUE,sep="\t", row.names=NULL)
 }else{
   sampleInformation <- new("AnnotatedDataFrame",
                            data=data.frame(Sample=sampleNames(CtData)),
			    varMetadata=data.frame(labelDescription=c("unique identifier"),row.names=c("Sample")))
 }

 
 

if(useOnlySamplesFromAnno && !is.null(sample.annotation.file.name)){
  A <- CtData[,"Sample"] %in% pData(sampleInformation)[,"Sample"]
  warning( paste("Es werden folgende Samples entfernt:",paste(unique(CtData[!A,"Sample"]),collapse=", ")))
  CtData <- CtData[A,]
 }


if (is.null(EFFICIENCIES)){
  result <-      ddCtExpression(CtData,
                      calibrationSample=name.referenz.sample,
                      housekeepingGenes=name.referenz.gene,
                      type=TYPEOFCALCULATION,
                      sampleInformation=sampleInformation,
                      warningStream=warningFile)
  } else{
  result <- ddCtwithE(CtData,
                      calibrationSample=name.referenz.sample,
                      housekeepingGenes=name.referenz.gene,  
                      efficiencies=EFFICIENCIES,
                      efficiencies.error=EFFICIENCIES.ERROR,
                      type=TYPEOFCALCULATION,
                      sampleInformation=sampleInformation,
                      warningStream=warningFile)
  }
   
save(result,file=savedir(paste("Result",sho,".RData",sep="")))


###################################################
### code chunk number 28: write (HTML)Tables
###################################################
htmlName   <- paste("HTML",sho,sep="_")
tablesName <- paste("Tables",sho,sep="_")
getDir <- function(dir, ...) {
  if(!file.exists(dir)) {
    dir.create(dir,...)
  }
  return(dir)
}


html.path <- getDir(file.path(save.path,htmlName))
table.path <- getDir(file.path(save.path, tablesName))

if(!is.null(sample.annotation.file.name) & !is.null(column.for.grouping))
 {result<- result[,order(pData(result)[,column.for.grouping])]}

elistWrite(result,file=savedir(paste("allValues",sho,".csv",sep="")))
EE1 <- assayData(result)$exprs
FF1 <- assayData(result)$level.err
if(!is.null(GroupingForPlot)) 
  GFP1 <- pData(result)[,GroupingForPlot]

Ct  <- round(assayData(result)$Ct,2)
lv  <- round(EE1,2)

write.table(cbind(t(EE1),t(FF1)),file=file.path(table.path,"LevelPlusError.txt"),sep="\t",col.names=NA)
write.table(lv,file=file.path(table.path,"level_matrix.txt"),sep = "\t", col.names = NA)
write.table(Ct,file=file.path(table.path,"Ct_matrix.txt"),sep="\t", col.names = NA)

write.htmltable(cbind(rownames(lv),lv),title="Level",file=file.path(html.path,"level"))
write.htmltable(cbind(rownames(Ct),Ct),title="Ct",file=file.path(html.path,"Ct"))


if(is.null(EFFICIENCIES)){
 dCtValues  <- round(assayData(result)$dCt,2)
 ddCtValues <- round(assayData(result)$ddCt,2)
 write.table(dCtValues,file=file.path(table.path,"dCt_matrix.txt"),  sep="\t", col.names=NA)
 write.table(ddCtValues,file=file.path(table.path,"ddCt_matrix.txt"),sep="\t",col.names=NA)

 write.htmltable(cbind(rownames(dCtValues),dCtValues)  ,title="dCt",file=file.path(html.path,"dCt"))
 write.htmltable(cbind(rownames(ddCtValues),ddCtValues),title="ddCt",file=file.path(html.path,"ddCt"))
}



###################################################
### code chunk number 29: plot Level
###################################################
for(KindOfPlot in TheKindOfPlot){
if(KindOfPlot=="level"){
  EE1 <- assayData(result)$exprs
  FF1 <- assayData(result)$level.err
  theTitle <- "Level"
}

if(KindOfPlot=="ddCt"){
  EE1 <- assayData(result)$ddCt
  FF1 <- assayData(result)$ddCt.err
  theTitle <- "ddCt"
}

if(KindOfPlot=="dCt"){
  EE1 <- assayData(result)$dCt
  FF1 <- assayData(result)$dCt.err
  theTitle <- "dCt"
}

if(KindOfPlot=="Ct"){
  EE1 <- assayData(result)$Ct
  FF1 <- assayData(result)$Ct.err
  theTitle <- "Ct"
}



################
## order the set
################

if (!is.null(new.gene.names))
 {EE2  <- EE1[match(new.gene.names,rownames(EE1)),,drop=FALSE]
  FF2  <- FF1[match(new.gene.names,rownames(EE1)),,drop=FALSE]
 } else{
  EE2 <- EE1
  FF2 <- FF1
 }

if (!is.null(new.sample.names))
 {EE  <- EE2[,match(new.sample.names,colnames(EE2)),drop=FALSE]
  FF  <- FF2[,match(new.sample.names,colnames(EE2)),drop=FALSE]
  if(!is.null(GroupingForPlot)) GFP<- GFP1[match(new.sample.names,colnames(EE2))]
 } else{
  EE <- EE2
  FF <- FF2
  if(!is.null(GroupingForPlot)) GFP<- GFP1
 }

###################
## Reducing the set
###################


if (!is.null(names.of.the.genes.REMAIN.in.Output)){
   Gred <- (rownames(EE) %in% names.of.the.genes.REMAIN.in.Output)
}else{
   Gred <- !(rownames(EE) %in% names.of.the.genes.NOT.in.Output)
}


if (!is.null(names.of.the.samples.REMAIN.in.Output)){
   Sred <- (colnames(EE) %in% names.of.the.samples.REMAIN.in.Output)
}else{
   Sred <- !(colnames(EE) %in% names.of.the.samples.NOT.in.Output)
}

EEN <- EE[Gred,Sred,drop=FALSE]
FFN <- FF[Gred,Sred,drop=FALSE]
if(!is.null(GroupingForPlot)) GFPN <- as.factor(as.character(GFP[Sred]))

############
# the color
############

COLORS <- c()
for (i in 1:length(BREWERCOL))
  COLORS <- c(COLORS,brewer.pal(brewer.pal.info[BREWERCOL[i],]$maxcolors,BREWERCOL[i]))
if(GROUPINGBYSAMPLES){
  THECO  <- COLORS[1:sum(Sred)]
} else {
  THECO  <- COLORS[1:sum(Gred)]
}

##########
# plotting
##########
getFileName <- function(prefix="Ct", name) {
  sprintf("%s_Result_%s.pdf", prefix, sho)
}
if(own.plot.for.each.object){
 pdf(w=15,h=15,file=savedir(paste(theTitle,"Result",sho,".pdf",sep="")))
if(GROUPINGBYSAMPLES){
  for(k in 1:dim(EEN)[1]){
    EENN <- EEN[k,,drop=FALSE]
    FFNN <- FFN[k,,drop=FALSE]
    barploterrbar(EENN,EENN-FFNN,EENN+FFNN,barcol=THECO,legend=LEGENDE,columnForDiffBars=GROUPINGBYSAMPLES,theCut=CUTOFF,ylab=theTitle)
  }}else{
    for(k in 1:dim(EEN)[2]){
      EENN <- EEN[,k,drop=FALSE]
      FFNN <- FFN[,k,drop=FALSE]
      barploterrbar(EENN,EENN-FFNN,EENN+FFNN,barcol=THECO,legend=LEGENDE,columnForDiffBars=GROUPINGBYSAMPLES,theCut=CUTOFF,ylab=theTitle)
    }}
 if(GROUPINGBYSAMPLES & !is.null(GroupingForPlot)){
   for(k in 1:dim(EEN)[1]){
     EENN <- EEN[k,,drop=FALSE]
     FFNN <- FFN[k,,drop=FALSE]
     barploterrbar(EENN,EENN-FFNN,EENN+FFNN,barcol=GroupingColor,legend=LEGENDE,columnForDiffBars=GROUPINGBYSAMPLES,theCut=CUTOFF,ylab=theTitle,las=2,names.arg=colnames(EENN),main=rownames(EENN),groups=GFPN)
   }}
 dev.off()
}else{
  barploterrbar(EEN,EEN-FFN,EEN+FFN,barcol=THECO,legend=LEGENDE,las=2,columnForDiffBars=GROUPINGBYSAMPLES,theCut=CUTOFF,ylab=theTitle)
  dev.copy(pdf,w=15,h=15,file=savedir(paste(theTitle,"Result",sho,".pdf",sep="")))
  dev.off()}
}
result.bySample <- errBarchart(result)
print(result.bySample)
pdf(getFileName("errbarplot_bySample_", sho), width=15, height=15)
print(result.bySample)
dev.off()
result.byDetector <- errBarchart(result, by="Detector")
print(result.byDetector)
pdf(getFileName("errbarplot_byDetector_", sho), width=15, height=15)
print(result.byDetector)
dev.off()


###################################################
### code chunk number 30: Korrelation
###################################################
A <- name.referenz.gene 
if (length(A) > 1) { 
 if (!is.null(names.of.the.samples.REMAIN.in.cor)){
   corRed <- (rownames(pData(result)) %in% names.of.the.samples.REMAIN.in.cor)
 }else{
   corRed <- !(rownames(pData(result)) %in% names.of.the.samples.NOT.in.cor)
 }
 result2 <- assayData(result[,corRed])$Ct

 K <- combn(1:length(A),2)
 U <- ncol(K)
 par(mfrow=c(ceiling(sqrt(U)),ceiling(sqrt(U))))
 for (i in 1:U){
  Gen1 <- A[K[1,i]] # der Name des ersten Housekeepinggenes
  Gen2 <- A[K[2,i]] # der Name des zweiten Housekeepinggenes
  BART <- cor(result2[Gen1,],result2[Gen2,],use="pairwise.complete.obs")
  if(!is.na(BART)) {
    plot(result2[Gen1,],result2[Gen2,],xlab=Gen1,ylab=Gen2,pch="*",col="red", main=paste("Correlation:",round(BART,3)))
  } else {
    gen1.allna <- all(is.na(result2[Gen1,]))
    warn <- sprintf("Correlation does not exist, since %s in all Samples are 'Undetermined'\n",ifelse(gen1.allna, Gen1, Gen2))

    plot.new()
    text(0.5,0.5, warn)
  }
  }} else{
   if (!is.null(names.of.the.samples.REMAIN.in.cor)){
   corRed <- (rownames(pData(result)) %in% names.of.the.samples.REMAIN.in.cor)
 }else{
   corRed <- !(rownames(pData(result)) %in% names.of.the.samples.NOT.in.cor)
 }
 result2 <- assayData(result[,corRed])$Ct
  plot(result2[A,],pch="*",col="red", main="Expression HK Gene")
 }


###################################################
### code chunk number 31: TTest
###################################################

myFoldChange <- function(x){
  x <- as.numeric(x)
  if(length(x) == 2 ){
    resu <- 2^(x[1]-x[2])
  }else if( length(x) == 1  ){
    resu <- 2^x
  }else{
    stop("unexpected situation in myFoldChange")
  }
  return(resu)
}


if(perform.ttest){
ttestName   <- paste("tTests",sho,sep="_")
ttest.path <- getDir(file.path(save.path, ttestName))

if (!is.null(names.of.the.samples.REMAIN.in.ttest)){
  ttestRed <- (rownames(pData(result)) %in% names.of.the.samples.REMAIN.in.ttest)
}else{
  ttestRed <- !(rownames(pData(result)) %in% names.of.the.samples.NOT.in.ttest)
}


result3 <- result[,ttestRed]


daten  <- assayData(result3)$dCt # der t-Test wird immer mit den normalisierten Werten gemacht
if( ! column.for.ttest %in% colnames(pData(result3)) )
  stop(paste(" did not find :", column.for.ttest,": in pData ",sep=""))
faktor <- as.character(pData(result3)[,column.for.ttest])
mmm <- nlevels(as.factor(faktor))
if( mmm == 1 ){
  stop( " found only a single group for t-test ")
}else if( mmm == 2 ){
  aa <- matrix(c(1,2), ncol=1) # aa = die paarweisen Vergleiche
}else{
  aa <- combn(1:mmm,2)
}

 
for (k in 1:ncol(aa)){
  
  Groups  <- levels(as.factor(faktor))[aa[,k]]
  subs    <- faktor %in%  Groups
  datenS  <- daten[,subs]
  faktorS <- as.factor(faktor[subs])  # hier wird gewaerleistet dass der neue Faktor genau zwei Elemente hat
  
  if( ! is.null(column.for.pairs) ){
    if( ! column.for.pairs %in% colnames(pData(result)) )
      stop(paste(" did not find :", column.for.pairs,": in pData ",sep=""))
    paarungS <- as.character(pData(result3)[,column.for.pairs])
    paarungS <- paarungS[subs]
    wenigerRes <- 1
    optTest <- "paired "
  }else{
    wenigerRes <- 0
    optTest <- ""
  }



  res  <- matrix(NA,nrow=nrow(datenS),ncol=8-wenigerRes)
  res2 <- matrix(NA,nrow=nrow(datenS),ncol=2-wenigerRes)

  for (i in 1:nrow(datenS)){ 
    a  <- datenS[i,]
    b  <- is.na(a)
    cc <- a[!b]
    d  <- faktorS[!b]
    if( ! is.null(column.for.pairs) ){ 
      paar <- as.character(paarungS[!b])
      ## restrict to valid pair data only
      validPaarItems <- paar[duplicated(paar)]
      valid <- which( as.character(paar) %in% validPaarItems )
      paar <- paar[valid]
      cc <- cc[valid]
      d <- d[valid]
      if(all(table(d) >1)) {
        sel1 <- which(as.character(d) == Groups[1])
        sel2 <- which(as.character(d) == Groups[2])
        stopifnot( all( paar[sel1][order(paar[sel1])] ==paar[sel2][order(paar[sel2])] )   )
        group1 <- cc[sel1][order(paar[sel1])]
        group2 <- cc[sel2][order(paar[sel2])]
        ff <- t.test(x=group1, y=group2, paired=TRUE)
        ff2<- wilcox.test(x=group1, y=group2, paired=TRUE)
      }else{
        ff <- NULL
        ff2 <- NULL
      }
    }else{
      if(all(table(d)>1)) {
        ff <- t.test(cc~d)
        ff2<- wilcox.test(cc~d)
      }else{
        ff  <- NULL
        ff2 <- NULL
      }
    }
    if( !is.null(ff) ){
      res[i,]  <-c(signif(ff$statistic),
	           signif(ff$p.value),
		   ff2$statistic,
		   signif(ff2$p.value),
		   myFoldChange(ff$estimate),
                   ff$parameter["df"],
                   ff$estimate)          ## 2 Stueck oder 1 Stueck (paired)
      
      res2[i,] <-c(names(ff$estimate))  ## 2 Stueck oder 1 Stueck (paired)
     }
  }
  AllGe      <- rownames(assayData(result)$exprs)
  theHKGenes <- rep("",length(AllGe))
  theHKGenes[AllGe %in% name.referenz.gene] <- "X"
  gg <- cbind(AllGe,theHKGenes,res)
  
   myColnames <- c("Name",
		   "Housekeeping Gene",
                   paste("statistic(", optTest,"t.test)", sep=""),
                   paste("pvalue(",    optTest,"t.test)", sep=""),
                   paste("statistic(", optTest,"Wilcox)", sep=""),
                   paste("pvalue(",    optTest,"Wilcox)", sep=""),
                   "foldChange",
                   "degreeOfFreedom"
                   )
  
  if( ! is.null(column.for.pairs) ){
    Mr1 <- res2[,1]
    extraName <- unique(Mr1[!is.na(Mr1)])
    if( length(extraName) < 1 ){
      extraName <- "fehlenUnklar"
    }
    myColnames <- c(myColnames, extraName) 
  }else{
    Mr1 <- res2[,1]
    Mr2 <- res2[,2]
    stopifnot(length(unique(Mr1[!is.na(Mr1)]))==1 & length(unique(Mr2[!is.na(Mr2)]))==1   )
    myColnames <- c(myColnames,
                    unique(Mr1[!is.na(Mr1)]),
                    unique(Mr2[!is.na(Mr2)])
                    ) 
  }
  
  colnames(gg) <- myColnames
  pVSpalte <- paste("pvalue(",    optTest,"t.test)", sep="")
  gg <-gg[order(as.numeric(gg[,pVSpalte])),]
  
  SAVED <- paste("ttest",Groups[1],Groups[2],sep="")
  write.table(gg,file=file.path(ttest.path, paste(SAVED,"txt",sep=".")),sep="\t",row.names=FALSE)
  write.htmltable(gg,file=file.path(ttest.path,SAVED))
}
}


###################################################
### code chunk number 32: BoxplotsHousekkepingGenes
###################################################
if(perform.ttest){
 if (!is.null(names.of.the.samples.REMAIN.in.ttest)){
   ttestRed <- (rownames(pData(result)) %in% names.of.the.samples.REMAIN.in.ttest)
 }else{
   ttestRed <- !(rownames(pData(result)) %in% names.of.the.samples.NOT.in.ttest)
 }
result3 <- result[,ttestRed]
daten   <- assayData(result3)$Ct  # es geht ja hier um die Expressionen der
				 # Housekeeping Gene vor Normalisierung
faktor	<- as.character(pData(result3)[,column.for.ttest])
mmm     <- levels(as.factor((faktor)))
N <- length(mmm)

daten2 <- daten[name.referenz.gene,,drop=FALSE] 
BoxPl <- list()
for (i in 1:N){
 BoxPl[[i]] <- t(daten2[,mmm[i]==faktor])
}

res <- list()
for(i in 1:length(name.referenz.gene)){
 A <- lapply(BoxPl, function(x) x[,i])
 names(A) <- rep(name.referenz.gene[i], N)
 res      <- c(res,A)
}

theColor <- 2 + (1:N)
pdf(file=savedir(paste("HKGenesPerGroup_",sho,".pdf",sep="")),w=15,h=15)
boxplot(res,col=theColor,main="Ct expression of housekeeping genes per group")
dev.off()
}


###################################################
### code chunk number 33: hh
###################################################
if(file.exists(warningFile)){
  bart   <- unlist(read.delim(warningFile,as.is=TRUE,header=FALSE))
  fehler <- sapply(bart, function(y) gsub("simpleWarning in withCallingHandlers\\(\\{: ","",y))
}


###################################################
### code chunk number 34: fehler
###################################################
if(file.exists(warningFile))
  fehler


###################################################
### code chunk number 35: session
###################################################
toLatex(sessionInfo())


