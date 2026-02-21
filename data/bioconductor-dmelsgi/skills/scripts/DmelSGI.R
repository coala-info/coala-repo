# Code example from 'DmelSGI' vignette. See references/ for full tutorial.

## ----DmelSGIstyle, echo=FALSE, results="asis"------------------------------
  BiocStyle::latex(bibstyle="apalike")

## ----DmelSGIopts,include=FALSE---------------------------------------------
library(knitr)
opts_chunk$set(concordance=TRUE, 
               resize.width="0.5\\textwidth",
               dev=c('pdf','png'),
               cache=TRUE,
               tidy = FALSE)

## ----DmelSGIinstallation,eval=FALSE----------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("DmelSGI")

## ----DmelSGIfunctions------------------------------------------------------
fpath <- function(d) { file.path(opts_knit$get("output.dir"), "result", d,"") }

## ----dataAcceess1,results='hide'-------------------------------------------
library("DmelSGI")
data("Interactions", package="DmelSGI")

## ----dataAccess2,eval=FALSE------------------------------------------------
#  ? Interactions

## ----ReanalysisOfHornEtALLoadLibrary, results='hide', message=FALSE--------
library("DmelSGI")
library("RNAinteractMAPK")

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "ReanalysisOfHornEtAl")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

## ----ReanalysisOfHornEtALLoadData------------------------------------------
data("Dmel2PPMAPK", package="RNAinteractMAPK")
print(Dmel2PPMAPK)
PI <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix", screen="mean",
              withoutgroups = c("pos", "neg"))[,,1,]

## ----ReanalysisOfHornEtALNormalize-----------------------------------------
for (j in 1:dim(PI)[2]) {
  for (k in 1:dim(PI)[3]) {
    PI[,j,k] = PI[,j,k] / (sqrt(sum(PI[,j,k] * PI[,j,k]) / (dim(PI)[2]-1)))
  }
}

## ----ReanalysisOfHornEtALMaxVarianceSelection,eval=FALSE-------------------
#  Selected = c()
#  Selected = c(1,2,3)
#  R = 1:dim(PI)[1]
#  Res = PI
#  openVar = rep(-1,dim(PI)[1]+1)
#  openVar[1] = sum(Res * Res) / (dim(PI)[1]*(dim(PI)[2]-1)*dim(PI)[3])
#  for (i in 1:dim(PI)[1]) {
#    H = rep(100000000.0,length(R))
#    for (j in 1:length(R)) {
#      cat("i=",i," j=",j,"\n")
#      k=1:3
#      A = PI[,c(Selected[seq_len(i-1)],R[j]),k,drop=FALSE]
#      dim(A) = c(dim(A)[1],prod(dim(A)[2:3]))
#      B = PI[,-c(Selected[seq_len(i-1)],R[j]),k,drop=FALSE]
#      dim(B) = c(dim(B)[1],prod(dim(B)[2:3]))
#  
#      Res = matrix(0.0, nr=dim(PI)[1],nc=ncol(B))
#      for (z in 1:ncol(B)) {
#        model = lm(B[,z]~A+0)
#        Res[,z] = model$residuals
#      }
#      H[j] = sum(Res * Res) / (dim(PI)[1]*(dim(PI)[2]-1)*dim(PI)[3])
#    }
#    M = which.min(H)
#    cat("selected: ",R[M],"\n")
#    Selected = c(Selected, R[M])
#    openVar[i+1] = H[M]
#    R = R[-M]
#  }

## ----ReanalysisOfHornEtAL--------------------------------------------------
openVar = c(1, 0.584295886914632, 0.49354448724904, 0.440095163032832,
  0.37969110256306, 0.330693818887106, 0.28896777328302, 0.26144276377077,
  0.24550380797587, 0.212282252772014, 0.19041097617251, 0.16974901306481,
  0.15642204582756, 0.141467140253324, 0.12781027389229, 0.11609596000734,
  0.10374891651534, 0.093268306952119, 0.08446425055463, 0.07404659630757,
  0.06599890651265, 0.057244319680828, 0.04944008500553, 0.04161924747819,
  0.03515950952616, 0.028667487889006, 0.02313772533424, 0.01727915218118,
  0.01282727545013, 0.007910401967279, 0.00357968641756,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
)

Selected = c(1, 2, 3, 16, 47, 9, 48, 63, 22, 74, 77, 53, 31, 27, 60, 6,
15, 93, 5, 82, 67, 45, 91, 7, 30, 25, 59, 13, 55, 61, 54, 35,
84, 4, 1, 2, 3, 8, 10, 11, 12, 14, 17, 18, 19, 20, 21, 23, 24,
26, 28, 29, 32, 33, 34, 36, 37, 38, 39, 40, 41, 42, 43, 44, 46,
49, 50, 51, 52, 56, 57, 58, 62, 64, 65, 66, 68, 69, 70, 71, 72,
73, 75, 76, 78, 79, 80, 81, 83, 85, 86, 87, 88, 89, 90, 92)

## ----ReanalysisOfHornEtALbarplot,fig.height=5------------------------------
N = 1:dim(PI)[1]
bp = barplot(100.0*(1-openVar[N+1]),ylim=c(0,100),
             ylab="explained variance [in %]",xlab="number query genes",
             cex.axis=1.5,cex.lab=1.5)
axis(side=1,at=bp[N %% 10 == 0],labels=(N)[N %% 10 == 0],cex.axis=1.5)

## ----QueryGeneSelectionLibrary,message=FALSE,results='hide'----------------
library(DmelSGI)

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "QueryGeneSelection")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

data("datamatrix", package="DmelSGI")

## ----QueryGeneSelectionLoadLibrary, results='hide',message=FALSE-----------
library("DmelSGI")

data("SKDdata",package="DmelSGI")
data("datamatrix",package="DmelSGI")

## ----QueryGeneSelectionPCA-------------------------------------------------
D = apply(SKDdata$D[ ,,1,],
          c(1,3), mean, na.rm=TRUE)
PCA = princomp(D)

## ----QueryGeneSelectionCol-------------------------------------------------
col = ifelse(datamatrix$Anno$target$TID %in% datamatrix$Anno$query$TID,
             "red","gray80")
I = order(datamatrix$Anno$target$TID %in% datamatrix$Anno$query$TID)
S = PCA$scores
S = S[I,]
col = col[I]

## ----QueryGeneSelectionPairs-----------------------------------------------
par(mar=c(0.2,0.2,0.2,0.2))
pairs(S[,1:5],pch=20,cex=0.7,col=col)

## ----ImageProcessingLibrary,message=FALSE,results='hide'-------------------
library("DmelSGI")
library("RColorBrewer")

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "ImageProcessing")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

data("datamatrix",package="DmelSGI")
data("Features",package="DmelSGI")

## ----ImageProcessingGlog,fig.width=4.2,fig.height=4.2----------------------
px = seq(-1.5, 9, length.out=200)
trsf = list(
  log = function(x) log(ifelse(x>0, x, NA_real_)),
 glog = function(x, c=1) log( (x+sqrt(x^2+c^2))/2 ))
colores = c("#202020", "RoyalBlue")

matplot(px, sapply(trsf, do.call, list(px)), type="l", lty=c(2,1), col=colores, lwd=2.5,
        ylab="f(x)", xlab="x")
legend("bottomright", fill=colores, legend=names(trsf))

## ----ImageProcessingBarchartsMainEffectsExampleImagesData------------------
data("mainEffects",package="DmelSGI")

## ----ImageProcessingBarchartsMainEffectsExampleImages----------------------
Main = apply(mainEffects$target,c(1,4),mean,na.rm=TRUE)
m = apply(Main,2,mad,center=0.0)
for (i in 1:dim(Main)[2]) {
  Main[,i] = Main[,i] / m[i]
}
Main = rbind(Main,Fluc=c(0.0,0.0,0.0))

## ----ImageProcessingExamplePhenotypesSingleKDcol---------------------------
ylim = range(Main[c("Fluc","ida","stg","Arpc1"),1:3])
col = brewer.pal(4,"Pastel1")

## ----ImageProcessingExamplePhenotypesSingleKD,resize.width="0.17\\textwidth",fig.show='hold',fig.width=1.5,fig.height=4----
par(mar=c(0.2,2,2,0.2))
barplot(Main["Fluc",c(1:3,13)],main="Fluc", col=col,ylim=ylim)
abline(h=0.0)

barplot(Main["ida",c(1:3,13)],main="ida", col=col,ylim=ylim)
abline(h=0.0)

barplot(Main["stg",c(1:3,13)],main="stg", col=col,ylim=ylim)
abline(h=0.0)

barplot(Main["Arpc1",c(1:3,13)],main="Arpc1", col=col,ylim=ylim)
abline(h=0.0)

plot(-10000,xaxt="n",yaxt="n",bty="n",xlim=c(0,1),ylim=c(0,1),xlab="",ylab="")
legend("topleft",c("nr cells","MI","area","eccent."),fill=brewer.pal(4,"Pastel1"))

## ----ImageProcessingExamplePhenotypesSingleKDRasGAP1,resize.width="0.2\\textwidth",fig.width=2,fig.height=3----
barplot(Main[c("Fluc","RasGAP1"),1],col=brewer.pal(3,"Pastel1")[1],
        ylab=c("cell number","z-score"),yaxp=c(0,1,2),las=2)

## ----QualityControlLoadLibrary, results='hide', message=FALSE--------------
library("beeswarm")
library("RColorBrewer")
library("DmelSGI")
library("hwriter")
library("xtable")

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "QualityControl")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

data("datamatrix", package="DmelSGI")

## ----QualityControlFeatureLoadData-----------------------------------------
data("qualityControlFeature", package="DmelSGI")
data("Features", package="DmelSGI")

## ----QualityControlFeatureCor----------------------------------------------
Fcor = qualityControlFeature$correlation
Fcor = Fcor[order(-Fcor)]

## ----QualityControlFeaturePlot---------------------------------------------
par(mar=c(4.1,4.1,1,1))
plot(Fcor,pch=19,xlab="features",
     ylab=c("correlation of phenotype","between replicates"),
     ylim = range(qualityControlFeature$correlation,finite=TRUE),
     xlim=c(0,sum(is.finite(Fcor))),cex.lab=1.3, cex.axis=1.3)
abline(h=0.6)

## ----QualityControlFeatureTableData----------------------------------------
data("Features", package="DmelSGI")
data("qualityControlFeature", package="DmelSGI")

## ----QualityControlFeatureTable--------------------------------------------
Features = cbind(Features, QC=ifelse(qualityControlFeature$passed, "passed", "failed"),
                 name = hrNames(row.names(Features)))
write.table(Features, file=file.path(resultdir,"FeatureTable.txt"), sep="\t", quote=FALSE)

## ----QualityControlFeatureTableWebpage,echo=FALSE,results='hide'-----------
file.copy(system.file("images/hwriter.css",package="hwriter"),resultdir)
page=openPage(file.path(resultdir,"FeatureTable.html"), link.css="hwriter.css")
hwrite("Features extracted from images", heading=1, page=page)
hwrite("[Download as text file]", link="FeatureTable.txt", page=page)
hwrite(Features, page=page)
closePage(page, splash=FALSE)
size = 110
Page = ceiling(seq_len(nrow(Features)) / size)
for (p in 1:max(Page)) {
  XT = xtable(Features[Page==p,],
              caption=sprintf("Features extracted from images (Part %d/%d)",
                              p,max(Page)))
  if (p==1) {
    con = file(file.path(resultdir,"FeatureTable.tex"))
    label(XT) = "TabFeature"
  } else {
    con = file(file.path(resultdir,"FeatureTable.tex"),open="a")
    writeLines("\\addtocounter{table}{-1}", con=con)
  }
  print(XT, file=con,
        size="tiny",
        caption.placement="top")
  close(con)
}

## ----QualityControlFeatureTablePrint,echo=FALSE,results='asis'-------------
XT = xtable(Features[1:7,],
            caption="Features extracted from images")
print(XT,caption.placement="top")

## ----QualityControlGeneLoadData--------------------------------------------
data("qualityControlGene", package="DmelSGI")

## ----QualityControlGenePlot------------------------------------------------
par(mar=c(4.1,4.5,1,1))
Sample = which(qualityControlGene$Annotation$group == "sample")
corGene = qualityControlGene$correlation[Sample]
corGene = corGene[order(-corGene)]
plot(corGene,
     pch=19,
     xlab="targeted genes",
     ylab=c("cor of phenotypic profile","between dsRNA designs"),
     cex.lab=1.3, cex.axis=1.3)
abline(h=0.7)

## ----QualityControlGeneTableOfPassedGenesTxt-------------------------------
data("qualityControlGene", package="DmelSGI")
PassedSamples = which((qualityControlGene$Annotation$group == "sample")
                      & (qualityControlGene$passed))
A = qualityControlGene$Annotation
A$cor = qualityControlGene$correlation
A = A[,c("TID", "Symbol", "cor", "Name")]
A = A[PassedSamples,]
A = A[order(A$cor),]
A$cor = sprintf("%0.2f", A$cor)
write.table(A, file=file.path(resultdir,"PassedGenes.txt"), sep="\t", 
            quote=FALSE,row.names=FALSE)

## ----QualityControlGeneTableOfPassedGenesWebpage,echo=FALSE,results='hide'----
file.copy(system.file("images/hwriter.css",package="hwriter"),resultdir)
page=openPage(file.path(resultdir,"PassedGenes.html"), link.css="hwriter.css")
hwrite("List of genes that passed the quality control", heading=1, page=page)
hwrite("[Download as text file]", link="PassedGenes.txt", page=page)
hwrite(A, page=page)
closePage(page, splash=FALSE)
XT = xtable(A,caption="List of genes that passed the quality control")
con = file(file.path(resultdir,"PassedGenes.tex"))
label(XT) = "TabPassedGenes"
print(XT, file=con,
      size="footnotesize",
      caption.placement="top")
close(con)

## ----QualityControlGeneTableOfPassedGenesPrint,echo=FALSE,results='asis'----
XT = xtable(A[1:7,],caption="List of genes that passed the quality control")
print(XT,caption.placement="top")

## ----QualityControlComparisonToRohnEtAl------------------------------------
data("SKDdata", package="DmelSGI")
data("mainEffects", package="DmelSGI")
data("RohnEtAl", package="DmelSGI")

RohnEtAl = RohnEtAl[which(RohnEtAl$Computed.Target %in% SKDdata$Anno$target$TID),]
I = match(RohnEtAl$Computed.Target, SKDdata$Anno$target$TID)

RohnEtAlanno = RohnEtAl[,1:3]
RohnEtAl = as.matrix(RohnEtAl[4:29])
D = apply(SKDdata$D[I,,,],c(1,4), mean, na.rm=TRUE)

i=3; j=2
anova(lm(D[,i] ~ RohnEtAl[,j]))
beeswarm(D[,i] ~ RohnEtAl[,j],pch=20, xlab=c(colnames(RohnEtAl)[j],"Rohn et al."),
         ylab=dimnames(D)[[2]][i])
i=13; j=5
anova(lm(D[,i] ~ RohnEtAl[,j]))
beeswarm(D[,i] ~ RohnEtAl[,j],pch=20, xlab=c(colnames(RohnEtAl)[j],"Rohn et al."),
         ylab=dimnames(D)[[2]][i])

## ----FeatureSelectionLoadLibrary, results='hide', message=FALSE------------
library("DmelSGI")
library("RColorBrewer")
library("hwriter")
library("xtable")

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "FeatureSelection")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

## ----FeatureSelectionLoadData,results='hide'-------------------------------
data("stabilitySelection", package="DmelSGI")

## ----FeatureSelectionPlotCor, resize.width="0.7\\textwidth",fig.width=11,fig.height=6----
par(mar=c(12,5,0.5,0.5))
barplot(stabilitySelection$correlation,
        names.arg=hrNames(stabilitySelection$selected),las=2,
        col=ifelse(stabilitySelection$ratioPositive > 0.5,
                   brewer.pal(3,"Pastel1")[2],
                   brewer.pal(3,"Pastel1")[1]),
        ylab = "correlation", cex.lab=1.3)

## ----FeatureSelectionPlotRatio, resize.width="0.7\\textwidth",fig.width=11,fig.height=6----
par(mar=c(12,5,0.5,0.5))
barplot(stabilitySelection$ratioPositive-0.5,
        names.arg=hrNames(stabilitySelection$selected),las=2,
        col=ifelse(stabilitySelection$ratioPositive > 0.5,
                   brewer.pal(3,"Pastel1")[2],
                   brewer.pal(3,"Pastel1")[1]),
        ylab = "ratio positive cor.", cex.lab=1.3,
        offset=0.5)

## ----FeatureSelectionTableOfFeaturesData-----------------------------------
data("stabilitySelection", package="DmelSGI")
data("datamatrix", package="DmelSGI")

## ----FeatureSelectionTableOfFeaturesTxt------------------------------------
df = as.data.frame(stabilitySelection[c("selected","correlation","ratioPositive")],
                   stringsAsFactors=FALSE)
row.names(df) = 1:nrow(df)
df = cbind(df, Name=hrNames(stabilitySelection$selected),
           Selected = ifelse(stabilitySelection$ratioPositive > 0.5,"Selected",""),
           stringsAsFactors=FALSE)
df = df[,c(1,4,2,3,5)]
colnames(df) = c("ID","Name","Correlation","RatioPositive","Selected")
write.table(df, file=file.path(resultdir,"StabilitySelectedFeatures.txt"), sep="\t",
            quote=FALSE,row.names=FALSE)

## ----FeatureSelectionTableOfFeaturesWebpage,echo=FALSE,results='hide'------
file.copy(system.file("images/hwriter.css",package="hwriter"),resultdir)
page=openPage(file.path(resultdir,"StabilitySelectedFeatures.html"), link.css="hwriter.css")
hwrite("Features selected by stability", heading=1, page=page)
hwrite("[Download as text file]", link="StabilitySelectedFeatures.txt", page=page)
hwrite(df, page=page)
closePage(page, splash=FALSE)
XT = xtable(df,caption="List of features selected by stability")
label(XT) = "TabStabilitySelection"
print(XT, file=file.path(resultdir,"StabilitySelectedFeatures.tex"),
      caption.placement="top")

## ----FeatureSelectionTable,results='asis'----------------------------------
XT = xtable(df[1:7,],caption="List of features selected by stability")
label(XT) = "TabStabilitySelection"
print(XT,caption.placement="top")

## ----PIscoresLibrary,message=FALSE,results='hide'--------------------------
library("DmelSGI")
library("RColorBrewer")

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "PairwiseInteractionScores")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

data("datamatrix", package="DmelSGI")

## ----PIscoresExamplePhenotypesDoubleKDdata---------------------------------
data("mainEffects",package="DmelSGI")
data("pimatrix",package="DmelSGI")

## ----PIscoresExamplePhenotypesDoubleKD-------------------------------------
examples = data.frame(
  ph = c("area","mitoticIndex"),
  targetGenes = c("FBgn0014020","FBgn0033029"),
  queryGenes=c("FBgn0030276","FBgn0261456"),
  stringsAsFactors=FALSE)

Effects = array(0, dim=c(nrow(examples), 4, nrow(pimatrix$Anno$phenotype)))
for (i in seq_len(nrow(examples))) {
  I = match(examples$targetGenes[i], pimatrix$Anno$target$TID)
  J = match(examples$queryGenes[i],    pimatrix$Anno$query$TID)
  B = pimatrix$Anno$query$Batch[J]
  TP = pimatrix$Anno$target$TargetPlate[I]
  Effects[i,1,] = apply(mainEffects$target[I,,B,],2,
                        mean, na.rm=TRUE)
  Effects[i,2,] = apply(mainEffects$query[J,,TP,],  2,
                        mean, na.rm=TRUE)
  Effects[i,3,] = Effects[i,1,] + Effects[i,2,]
  Effects[i,4,] = apply(pimatrix$D[I,,J,,],3,mean) + Effects[i,3,]
}

for (i in seq_len(nrow(examples))) {
  tg = pimatrix$Anno$target$Symbol[match(examples$targetGenes[i],pimatrix$Anno$target$TID)]
  qg = pimatrix$Anno$query$Symbol[match(examples$queryGenes[i],
                                     pimatrix$Anno$query$TID)]
  pdf(file.path(resultdir,sprintf("ExamplePhenotypes-doubleKD-%s-%s.pdf",
              tg,qg)),height=8)
  par(mfrow=c(1,2),mar=c(18,3,3,0.2))
  K=1
  bp = barplot(Effects[i,,K],main="number cells",
               col=brewer.pal(3,"Pastel1")[1],cex.main=2,cex.axis=1.5)
  abline(h=0.0)
  lines(c(bp[4]-0.5,bp[4]+0.5),c(Effects[i,3,K],Effects[i,3,K]))
  arrows(x0=bp[4],Effects[i,3,K],x1=bp[4],Effects[i,4,K],code=3,
         length=min(0.25,abs(Effects[i,4,K] - Effects[i,3,K])))
  axis(side=1,at=bp,labels=c(sprintf("%s+ctrl.",tg),
                             sprintf("%s+ctrl.",qg),"expected",
                             sprintf("%s+%s",tg,qg)),col=NA,cex.axis=1.8,las=2)
  if (examples$ph[i] == "area") {
    K = 5
  } else {
    K = 2
  }
  bp = barplot(Effects[i,,K],main=ifelse(K==2,"mitotic index","nuclear area"),
               col=brewer.pal(3,"Pastel1")[2],cex.main=2,cex.axis=1.5)
  abline(h=0.0)
  lines(c(bp[4]-0.5,bp[4]+0.5),c(Effects[i,3,K],Effects[i,3,K]))
  arrows(x0=bp[4],Effects[i,3,K],x1=bp[4],Effects[i,4,K],code=3)
  axis(side=1,at=bp,labels=c(sprintf("%s + ctrl.",tg),
                             sprintf("%s + ctrl.",qg),"expected",
                             sprintf("%s + %s",tg,qg)),col=NA,
       cex.axis=1.8,las=2)
  dev.off()
}


## ----PIscoresExamplePhenotypesDoubleKDSWISNFdata---------------------------
data("Interactions", package="DmelSGI")

f = "4x.count"
names = c("mor","brm","Bap60","Snr1","osa")

## ----PIscoresExamplePhenotypesDoubleKDSWISNF,resize.width="0.4\\textwidth",fig.width=6,fig.height=4.5----
bp=barplot(Interactions$piscore[names, "RasGAP1", f],
           ylim=c(-0.6,0.6),ylab=sprintf("pi-score (%s)",hrNames(f)),
           las=2,cex.axis=1.5,cex.names=1.5,cex.lab=1.5,yaxp=c(-0.5,0.5,2))
abline(h=0)

## ----PIscoresMainResultTable1----------------------------------------------
library("DmelSGI")

data("Interactions",package="DmelSGI")

## ----PIscoresMainResultTable2----------------------------------------------
PI = Interactions$piscore
PADJ = Interactions$padj
PI[is.na(PADJ)] = NA

## ----PIscoresMainResultTable3----------------------------------------------
dim(PI) = c(prod(dim(PI)[1:2]),dim(PI)[3])
dim(PADJ) = c(prod(dim(PADJ)[1:2]),dim(PADJ)[3])

## ----PIscoresMainResultTable4----------------------------------------------
V = cbind(PI, PADJ)
V = V[,rep(seq_len(dim(PI)[2]),each=2)+rep(c(0,dim(PI)[2]),times=dim(PI)[2])]
colnames(V) = sprintf("%s.%s",rep(c("pi-score","padj"),times=dim(PI)[2]),
        rep(hrNames(Interactions$Anno$phenotype$phenotype),
                          each=2))

## ----PIscoresMainResultTable5----------------------------------------------
target =       rep(Interactions$Anno$target$Symbol,
                   times=dim(Interactions$piscore)[2])
query =        rep(Interactions$Anno$query$Symbol,
                   each=dim(Interactions$piscore)[1])

df =  data.frame(targetGene=target, 
                 queryGene=query, 
                 V)

write.table(df, file=file.path(resultdir,"interactions.txt"),sep="\t",
            row.names=FALSE,quote=FALSE)

## ----PIscoresGIQualityControlMainEffectsAcrossPhenotypes-------------------
data("mainEffects", package="DmelSGI")
D = apply(mainEffects$target, c(1,4), mean, na.rm=TRUE)
colnames(D) = hrNames(colnames(D))

## ----PIscoresGIQualityControl-mainEffects-Features1-11,resize.width="0.7\\textwidth",fig.width=11.5,fig.height=11.5----
par(mar=c(0.2,0.2,0.2,0.2))
pairs(D[,1:11],pch=20,cex=0.5)

## ----PIscoresGIQualityControl-mainEffects-Features12-21,resize.width="0.7\\textwidth",fig.width=11.5,fig.height=11.5----
par(mar=c(0.2,0.2,0.2,0.2))
pairs(D[,c(1,12:21)],pch=20,cex=0.5)

## ----PIscoresGIQualityControlMainEffectsAcrossBatches----------------------
data("mainEffects", package="DmelSGI")
data("pimatrix", package="DmelSGI")
D = apply(mainEffects$target[,,,2], c(1,3), mean, na.rm=TRUE)

## ----PIscoresGIQualityControl-mainEffect-batches1to12,resize.width="0.7\\textwidth",fig.width=11.5,fig.height=11.5----
par(mar=c(0.2,0.2,0.2,0.2))
pairs(D,pch=20,cex=0.5)

## ----PIscoresGIQualityControl-mainEffect-batches1and12---------------------
par(mar=c(4.5,4.5,1,1))
plot(D[,1],D[,12],pch=20,
     xlab="mitotic index [glog] in batch 1",
     ylab="mitotic index [glog] in batch 12",
     main="",cex=1.5,cex.lab=2,cex.axis=2,cex.main=2)
text(x=1,y=-2.0,sprintf("cor = %0.2f",cor(D[,3],D[,4])),cex=2)

## ----PIscoresGIQualityControlPIscoreAcrossPhenotypes1----------------------
data("Interactions", package="DmelSGI")
D = Interactions$piscore
dim(D) = c(prod(dim(D)[1:2]),dim(D)[3])
colnames(D) = hrNames(Interactions$Anno$phenotype$phenotype)

## ----PIscoresGIQualityControlPIscoreAcrossPhenotypes2----------------------
set.seed(1043289201)
S = sample(1:dim(D)[1],1000)
D1 = D[S,]

## ----PIscoresGIQualityControl-piscore-Features1-11,resize.width="0.7\\textwidth",fig.width=11.5,fig.height=11.5----
par(mar=c(0.2,0.2,0.2,0.2))
pairs(D1[,1:11],pch=20,cex=0.5)

## ----PIscoresGIQualityControl-piscore-Features12-21,resize.width="0.7\\textwidth",fig.width=11.5,fig.height=11.5----
par(mar=c(0.2,0.2,0.2,0.2))
pairs(D1[,c(1,12:21)],pch=20,cex=0.5)

## ----PIscoresGIQualityControlPIscoreAcrossPhenotypes3----------------------
set.seed(1043289201)
S = sample(1:dim(D)[1],2000)
D1 = D[S,]

## ----PIscoresGIQualityControlPIscoreAcrossPhenotypes4----------------------
colnames(D1) = hrNames(colnames(D1))
for (i in c(2,16)) {
  X = D1[,c(1,i)]
  pdf(file=file.path(resultdir,sprintf("GeneticInteractionQC-piscore-cellnumber-%s.pdf",
                   gsub("[ ,()]","",colnames(X)[2]))))
  s = mad(X[,2],na.rm=TRUE) / mad(X[,1],na.rm=TRUE)
  r = max(abs(X[,1]),na.rm=TRUE)
  r = c(-r,r)
  X[which(X[,2] > s*r[2]),2] = s*r[2]
  X[which(X[,2] < s*r[1]),2] = s*r[1]
  par(mar=c(4.5,4.5,1,1))
  plot(X[,2],X[,1],pch=20,
       xlab=sprintf("pi-score (%s)",colnames(X)[2]),
       ylab=sprintf("pi-score (%s)",colnames(X)[1]),
       main="",cex=1.5,cex.lab=2,cex.axis=2,cex.main=2,xlim=s*r,ylim=r)
  dev.off()
  cat("correlation nrCells - ",dimnames(D1)[[2]][i]," = ",
      cor(X[,2],X[,1],use="pairwise.complete"),"\n")
}

## ----PIscoresGIQualityControlPIscoreAcrossPhenotypes5----------------------
data("pimatrix", package="DmelSGI")
D = pimatrix$D
D1 = (D[,1,,1,] + D[,1,,2,]) / 2.0
D2 = (D[,2,,1,] + D[,2,,2,]) / 2.0
dim(D1) = c(prod(dim(D1)[1:2]),dim(D1)[3])
dim(D2) = c(prod(dim(D2)[1:2]),dim(D2)[3])
colnames(D1) = colnames(D2) = hrNames(pimatrix$Anno$phenotype$phenotype)

for (i in c(1,2,16)) {
  cc = cor(D1[,i],D2[,i],use="pairwise.complete")
  cat("correlation between replicates ",dimnames(D1)[[2]][i]," = ",cc,"\n")
}

## ----PIscoresGIQualityControlPIscoreNumberInteractions1--------------------
data("Interactions", package="DmelSGI")
p.value.cutoff = 0.01
N = matrix(NA_integer_, nr=nrow(Interactions$Anno$phenotype), nc=2)
colnames(N) = c("pos","neg")
for (i in 1:nrow(Interactions$Anno$phenotype)) {
  PI = Interactions$piscore[,,i]
  N[i,2] = sum(PI[Interactions$padj[,,i] <= p.value.cutoff] > 0)
  N[i,1] = sum(PI[Interactions$padj[,,i] <= p.value.cutoff] < 0)
}

## ----PIscoresGIQualityControlPIscoreNumberInteractions2--------------------
N = N / prod(dim(Interactions$piscore)[1:2])

## ----PIscoresGIQualityControl-nrOfInteractions,fig.width=7,fig.height=6----
par(mar=c(15,5,0.5,0.5))
barplot(t(N),col=c("cornflowerblue","yellow"),
        names.arg=hrNames(Interactions$Anno$phenotype$phenotype),
        las=2, ylab ="fraction of interactions",
        cex.names=1.2,cex.axis=1.5,cex.lab=1.5)

## ----PIscoresGIQualityControlPIscoreNumberInteractions3--------------------
isinteraction = rep(FALSE, prod(dim(Interactions$piscore)[1:2]))
Ncum = rep(NA_integer_, nrow(Interactions$Anno$phenotype))
for (i in 1:nrow(Interactions$Anno$phenotype)) {
  isinteraction[Interactions$padj[,,i] <= p.value.cutoff] = TRUE
  Ncum[i] = sum(isinteraction) / prod(dim(Interactions$piscore)[1:2])
}

## ----PIscoresGIQualityControl-nrOfInteractionsCumulative,fig.width=7,fig.height=6----
par(mar=c(15,5,0.5,0.5),xpd=NA)
bp=barplot(Ncum, col=brewer.pal(3,"Pastel1")[2],
        ylab="fraction of interactions",las=2,
        names.arg = rep("",length(Ncum)),cex.axis=1.5,cex.lab=1.5)
text(bp,-0.01,hrNames(Interactions$Anno$phenotype$phenotype),adj=c(1,0.5),srt=38,cex=1.2)

## ----GeneticInteractionCubeLoadLibrary,results='hide',message=FALSE--------
library("DmelSGI")
library("grid")
library("RColorBrewer")
library("gplots")
library("beeswarm")

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "GeneticInteractionCube")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

dir.create(file.path("Figures","GeneticInteractionCube"), showWarnings=FALSE)

## ----GeneticInteractionCubeData--------------------------------------------
data("Interactions", package="DmelSGI")

## ----GeneticInteractionCubeNormalize1,eval=FALSE---------------------------
#  data("pimatrix", package="DmelSGI")
#  D = pimatrix$D
#  D2 = aperm(D, c(1,3,2,4,5))
#  dim(D2) = c(prod(dim(D2)[1:2]),prod(dim(D2)[3:4]),dim(D2)[5])
#  
#  SD = apply(D2,c(1,3),sd, na.rm=TRUE)
#  MSD = apply(SD, 2, function(x) { median(x,na.rm=TRUE) } )

## ----GeneticInteractionCubeNormalize2--------------------------------------
MSD = c(0.0833528975114521, 0.134136618342975, 0.0498996012784751,
0.204772216536139, 0.0142975582945938, 0.0428299793772605, 0.0576235314621808,
0.0833934805305705, 0.0328437541652814, 0.147643254412127, 0.0866394118952878,
0.140840565863283, 0.0154131573539473, 0.0286467941877466, 0.0496616658001497,
0.0164694485385577, 0.233130597062897, 0.222961290060361, 0.00228512594775289,
0.0773453995034531, 0.0892678802977647)

D = Interactions$piscore
for (i in 1:dim(D)[3]) {
  D[,,i] = D[,,i] / MSD[i]
}

## ----GeneticInteractionCubeCut---------------------------------------------
cuts = c(-Inf,
         seq(-6, -2, length.out=(length(DmelSGI:::colBY)-3)/2),
         0.0,
         seq(2, 6, length.out=(length(DmelSGI:::colBY)-3)/2),
         +Inf)

## ----GeneticInteractionCubeHClust------------------------------------------
ordTarget = orderDim(D, 1)
ordQuery = orderDim(D, 2)
ordFeat  = orderDim(D, 3)
Ph = c("4x.intNucH7","4x.count","4x.LCD2", "4x.ratioMitotic",
       "10x.meanNonmitotic.nucleus.DAPI.m.majoraxis", "4x.areaNucAll", 
       "10x.meanNonmitotic.cell.Tub.m.eccentricity", 
       "4x.areapH3All", "4x.intH3pH4")
D1 = D[ordTarget, ordQuery, Ph]
dimnames(D1)[[3]] = hrNames(dimnames(D1)[[3]])

## ----GeneticInteractionCubeDPiMlibrary-------------------------------------
library("DmelSGI")
library("RColorBrewer")
library("gplots")
library("grid")
data("Interactions",package="DmelSGI")
data("FBgn2anno",package="DmelSGI")
data("DPiM",package="DmelSGI")

## ----GeneticInteractionCubeDPiMcor-----------------------------------------
PI = Interactions$piscore
dim(PI) = c(dim(PI)[1],prod(dim(PI)[2:3]))
C = cor(t(PI))
row.names(C) = colnames(C) = Interactions$Anno$target$TID

## ----GeneticInteractionCubeDPiMsets----------------------------------------
m1 = match(DPiM$interactions$Interactor_1, Interactions$Anno$target$TID)
m2 = match(DPiM$interactions$Interactor_2, Interactions$Anno$target$TID)
I = which(!is.na(m1) & !is.na(m2) & (m1 != m2))
I = cbind(m1[I],m2[I])
ccDPiM = C[I]
Iall = upper.tri(C)
Iall[I] = FALSE
Iall[cbind(I[,2],I[,1])] = FALSE
ccall = C[Iall]

## ----GeneticInteractionCubeDPiM,fig.width=10,fig.height=4------------------
par(mar=c(5,5,0.2,5),xpd=NA)

d1 = density(ccDPiM, from=-1,to=1)
d2 = density(ccall, from=-1,to=1)

plot(d2, main="", col=brewer.pal(9, "Set1")[2],lwd=5,
     xlab="correlation of interaction profiles",ylim=c(0,1.5),
     cex.lab=1.8,cex.axis=1.8)
lines(d1$x,d1$y,col=brewer.pal(9, "Set1")[1],lwd=5)
legend("topleft",c("co-purified in DPiM","not captured by DPiM"),bty="n",
       fill = brewer.pal(9, "Set1")[1:2],cex=1.8)

## ----GIlandscapeLoadLibrary,results='hide',message=FALSE-------------------
library("DmelSGI")
library("igraph")
library("RSVGTipsDevice")
library("hwriter")
library("grid")

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "GeneticInteractionLandscape")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

## ----GIlandscapeLoadData---------------------------------------------------
data("Interactions", package="DmelSGI")

## ----GIlandscapeNormalization1,eval=FALSE----------------------------------
#  data("pimatrix", package="DmelSGI")
#  D = pimatrix$D
#  D2 = aperm(D, c(1,3,2,4,5))
#  dim(D2) = c(prod(dim(D2)[1:2]),prod(dim(D2)[3:4]),dim(D2)[5])
#  
#  SD = apply(D2,c(1,3),sd, na.rm=TRUE)
#  MSD = apply(SD, 2, function(x) { median(x,na.rm=TRUE) } )

## ----GIlandscapeNormalization2---------------------------------------------
Sel = 1:1293
MSD = c(0.0833528975114521, 0.134136618342975, 0.0498996012784751,
0.204772216536139, 0.0142975582945938, 0.0428299793772605, 0.0576235314621808,
0.0833934805305705, 0.0328437541652814, 0.147643254412127, 0.0866394118952878,
0.140840565863283, 0.0154131573539473, 0.0286467941877466, 0.0496616658001497,
0.0164694485385577, 0.233130597062897, 0.222961290060361, 0.00228512594775289,
0.0773453995034531, 0.0892678802977647)

## ----GIlandscapeNormalization3---------------------------------------------
PI = Interactions$piscore
for (i in 1:dim(PI)[3]) {
  PI[,,i] = PI[,,i] / MSD[i]
}
dim(PI) = c(dim(PI)[1],prod(dim(PI)[2:3]))

## ----GIlandscapeNrInteractions---------------------------------------------
nint = apply(Interactions$padj <= 0.01,1,sum)
Nint = matrix(nint,nrow=length(nint),ncol=length(nint))
Nint[t(Nint) < Nint] = t(Nint)[t(Nint) < Nint]
row.names(Nint) = colnames(Nint) = Interactions$Anno$target$Symbol

## ----GIlandscapeLoadGeneClusters-------------------------------------------
data("SelectedClusters", package="DmelSGI")
SelectedClusters = c(SelectedClusters,
      list(allOthers = Interactions$Anno$target$Symbol[
        !( Interactions$Anno$target$Symbol %in% unlist(SelectedClusters))]))
Labels = SelectedClusters

## ----GIlandscapeCol--------------------------------------------------------
set.seed(26323)
Col = c("SWI/SNF" = "#ED1C24", 
        "Condensin / Cohesin" = "#B8D433", 
        "Cytokinesis" = "#67BF6B", 
        "SAC" = "#3C58A8", 
        "DREAM complex" = "#B64F9D", 
        "Centrosome / Mitotic spindle" = "#EF4123", 
        "CCT" = "#8CC63F", 
        "Sequence-specific TFs" = "#67C4A4", 
        "26S Proteasome" = "#3A51A3", 
        "CSN" = "#F17A22", 
        "RNA helicase" = "#6CBE45", 
        "APC/C" = "#66C9D7", 
        "Ribosomal biogenesis" = "#4A50A2", 
        "Condensin / Cohesin (2)" = "#ED127A", 
        "SAGA & Mediator" = "#F1B61C", 
        "Cell-cell signalling" = "#61BB46", 
        "Vesicle trafficking and cytoskeleton" = "#2CB4E8", 
        "DNA repair and apoptosis" = "#6950A1", 
        "ARP2/3 complex" = "#ED1940", 
        "Tor signalling" = "#D54097", 
        "Ras / MAPK signalling" = "#65BC46", 
        "RNA PolII" = "#4074BA", 
        "Wnt signalling" = "#8E4F9F")

col = rep("gray80",nrow(Interactions$Anno$target))
names(col) = Interactions$Anno$target$Symbol
for (i in 1:length(Labels)) {
  col[Labels[[i]]] = Col[i]
}

## ----GIlandscapePCA--------------------------------------------------------
dimPCA = 25
PCA = prcomp(PI)
X = sweep(PI,2,PCA$center) %*% PCA$rotation[,1:dimPCA]
X = sweep(X,2,apply(X,2,sd), FUN="/")
theCorrPCA = cor(t(X), use = "pairwise.complete.obs")
row.names(theCorrPCA) = colnames(theCorrPCA) = Interactions$Anno$target$Symbol

## ----GIlandscapeDist-------------------------------------------------------
D = 2 - 2*theCorrPCA
D[lower.tri(D,diag=TRUE)] = NA

## ----GIlandscapeEdgeList---------------------------------------------------
thresholdDist = 0.8
wedges = data.frame(V1 = rep(Interactions$Anno$target$Symbol,times=dim(D)[1]),
                    V2 = rep(Interactions$Anno$target$Symbol,each=dim(D)[1]),
                    nint = as.vector(Nint),
                    weight = as.vector(D),stringsAsFactors=FALSE)
wedges = wedges[which(wedges$weight <= thresholdDist),]

## ----GIlandscapeigraph-----------------------------------------------------
g <- graph.data.frame(wedges, directed=FALSE)
V(g)$color = col[V(g)$name]
V(g)$frame.color = ifelse(V(g)$name %in% SelectedClusters$allOthers, 
                          "#666666","#000000")
V(g)$size = 1.5
V(g)$size[!(V(g)$name %in% Labels$allOthers)] = 2.5
V(g)$label = rep("",length(V(g)$name))
E(g)$color <- "#e7e7e7"
E(g)$color[E(g)$nint > 5] <- "#cccccc"

## ----GIlandscapeFruchtermanReingold----------------------------------------
set.seed(234816)
a = 0.07
b = 2.0
co <- layout.fruchterman.reingold(graph=g,
                          params=list(weights=(thresholdDist - E(g)$weight),
                          area=a*vcount(g)^2,
                          repulserad=b*a*vcount(g)^2*vcount(g)))

## ----GIlandscapeUnitBox----------------------------------------------------
co[,1] = 2*(co[,1] - min(co[,1])) / diff(range(co[,1]))-1
co[,2] = 2*(co[,2] - min(co[,2])) / diff(range(co[,2]))-1
row.names(co) = V(g)$name

## ----GIlandscapePermuteVertices--------------------------------------------
g = permute.vertices(graph=g, permutation = 
                       rank((!(V(g)$name %in% SelectedClusters$allOthers)),
                            ties.method="random"))
co = co[V(g)$name,]

## ----GIlandscape-graph,resize.width="0.9\\textwidth",fig.width=14,fig.height=10----
# par(mar=c(0.1,0.1,0.1,0.1))
plot(g, layout=co)
plotHairballLabels(g, co, Labels[-length(Labels)], Col)

## ----GIlandscapeHairballSVG,echo=FALSE,results='hide',eval=FALSE-----------
#  # Plot the genetic interaction landscape as SVG
#  devSVGTips(file.path(resultdir,"GIlandscape-graph.svg"), toolTipMode=1,
#             title="Genetic interaction landscape",
#             width = 10, height = 10)
#  par(xpd=NA,mar=c(5,5,5,5))
#  plot(0,type='n',
#       xlim=range(co, na.rm=TRUE),
#       ylim=range(co, na.rm=TRUE),
#       xlab='', ylab='',
#       main="Genetic interaction landscape",
#       xaxt="n",yaxt="n")
#  invisible(sapply(1:(dim(co)[1]), function(i) {
#    setSVGShapeToolTip(desc=V(g)$name[i])
#    points(co[i,1], co[i,2],bg=col[V(g)$name[i]],cex=1.5,pch=21)
#    }))
#  dev.off()

## ----GIlandscapeHairballHwriter,echo=FALSE,results='hide'------------------
# Write a HTML webpage to access the SVG graphic
Lpng = "GIlandscape-graph.png"
Lpdf = "<center><a href=GIlandscape-graph.pdf>[pdf]</a> - <a href=GIlandscape-graph.svg>[svg]</a></center>"
M = sprintf("%s<br>%s",hwriteImage(Lpng,table=FALSE),Lpdf)

file.copy(system.file(file.path("images","hwriter.css"),package="hwriter"),file.path(resultdir,"hwriter.css"))
page = openPage(file.path(resultdir,"GIlandscape-index.html"),link.css="hwriter.css")
hwrite(M, page=page)
hwriteImage("GIlandscape-phenotypes.png",link="GIlandscape-phenotypes.pdf",page=page)
closePage(page,splash=FALSE)

## ----GIlandscapeHairballZoominA1-------------------------------------------
A =  SelectedClusters[c("APC/C","SAC","Centrosome / Mitotic spindle",
                        "Condensin / Cohesin","26S Proteasome")]
genesA = c("Arp10","fzy","vih","Klp61F","polo")
gsubA = induced.subgraph(g, which(V(g)$name %in% c(unlist(A),
                                                    genesA)))

## ----GIlandscapeHairballZoominA2-------------------------------------------
data("SelectedClustersComplexes",package="DmelSGI")
V(gsubA)$color[which(V(gsubA)$name %in% SelectedClustersComplexes$gammaTuRC)] = "orange2"
V(gsubA)$color[which(V(gsubA)$name %in% SelectedClustersComplexes$'Dynein/Dynactin')] = "yellow2"
V(gsubA)$label = V(gsubA)$name
V(gsubA)$size = 8
V(gsubA)$label.cex = 0.4
V(gsubA)$label.color = "#222222"
E(gsubA)$color = "#777777"

## ----GIlandscape-graph-zoomin-A--------------------------------------------
set.seed(38383)
LA = layout.fruchterman.reingold(gsubA,params=list(area=121^2*40))
plot(gsubA,layout=LA)

## ----GIlandscapeHairballZoominB1-------------------------------------------
B =  SelectedClusters[c("Tor signalling","Ribosomal biogenesis","RNA helicase",
                        "Ribosomal biogenesis","RNA helicase",
                        "DNA repair and apoptosis","Cell-cell signalling",
                        "Vesicle trafficking and cytoskeleton")]
B$'Tor signalling' = B$'Tor signalling'[!(B$'Tor signalling' %in% 
                                          c("trc","InR","gig","Tsc1","Pten"))]
genesB = c("Dbp45A","hpo","14-3-3epsilon",
           "CG32344", "CG9630", "kz", "pit", "Rs1","CG8545","twin")
gsubB = induced.subgraph(g, which(V(g)$name %in% c(unlist(B),
                                                  genesB)))

## ----GIlandscapeHairballZoominB2-------------------------------------------
PolI = c("CG3756","l(2)37Cg","RpI1","RpI12","RpI135","Tif-IA")
PolIII = c("Sin","RpIII128","CG5380","CG12267","CG33051","CG7339")
V(gsubB)$color[which(V(gsubB)$name %in% PolI)] = "orange2"
V(gsubB)$color[which(V(gsubB)$name %in% PolIII)] = "yellow2"

V(gsubB)$label = V(gsubB)$name
V(gsubB)$size = 8
V(gsubB)$label.cex = 0.4
V(gsubB)$label.color = "#222222"
E(gsubB)$color = "#777777"

## ----GIlandscape-graph-zoomin-B--------------------------------------------
set.seed(122138)
LB = layout.fruchterman.reingold(gsubB,params=list(area=121^2*40))
plot(gsubB,layout=LB)

## ----DirectionalInteractionsLibrary,results='hide',message=FALSE-----------
library("DmelSGI")
library("abind")
library("igraph")

basedir = getBaseDir()
resultdir = file.path( basedir, "result", "DirectionalInteractions")
dir.create(resultdir, recursive = TRUE,showWarnings=FALSE)

data("Interactions", package="DmelSGI")
data("pimatrix", package="DmelSGI")
data("mainEffects", package="DmelSGI")
data("SelectedClustersComplexes", package="DmelSGI")

## ----DirectionalInteractionsMainEffects------------------------------------
pi  = pimatrix$D
mt  = mainEffects$target
mq  = mainEffects$query

## ----DirectionalInteractionsNormalize--------------------------------------
myrange = function(x) diff(quantile(x, probs=c(0.01, 0.99), na.rm=TRUE))
featureSD = apply(pi, 5, myrange)
for(k in seq(along=featureSD)){
  pi[,,,,k] = pi[,,,,k]/featureSD[k]
  mt[,,,k]  = mt[,,,k]/featureSD[k]
  mq[,,,k]  = mq[,,,k]/featureSD[k]
}

## ----DirectionalInteractionsRearrage---------------------------------------
data = array(NA_real_, dim=c(21, 3, dim(pi)[1:4]))
for(it in seq_len(dim(pi)[1])) {
  targetplate = pimatrix$Anno$target$TargetPlate[ it ]
  for(dt in seq_len(dim(pi)[2])) {
    for(iq in seq_len(dim(pi)[3])) {
      batch = pimatrix$Anno$query$Batch[iq]
      xt = mt[it, dt, batch, ]
      for(dq in seq_len(dim(pi)[4])) {
        y    = pi[it, dt, iq, dq, ]
        xq   = mq[iq, dq, targetplate, ]
        nay  = sum(is.na(y))
        naxq = sum(is.na(xq))
        if((nay>1)||(naxq>1)) {
        } else {
          data[, 1, it, dt, iq, dq] = xt
          data[, 2, it, dt, iq, dq] = xq
          data[, 3, it, dt, iq, dq] = y
        } # else
      }
    }
  }
}

dimnames(data) = list(pimatrix$Anno$phenotype$phenotype,
                      c("xt","xq","pi"),
                      pimatrix$Anno$target$Symbol,
                      1:2,
                      pimatrix$Anno$query$Symbol,
                      1:2)


## ----DirectionalInteractionsFit,eval=FALSE---------------------------------
#  resCoef = array(NA_real_, dim=c(3, dim(pi)[1:4]))
#  resSq = array(NA_real_, dim=c(3, dim(pi)[1:4]))
#  resPV = array(NA_real_, dim=c(2, dim(pi)[1:4]))
#  for(it in seq_len(dim(pi)[1])) {
#    for(dt in seq_len(dim(pi)[2])) {
#      for(iq in seq_len(dim(pi)[3])) {
#        for(dq in seq_len(dim(pi)[4])) {
#          if (all(is.finite(data[, , it, dt, iq, dq]))) {
#            model = lm(data[,3,it,dt,iq,dq] ~
#                         data[,1,it,dt,iq,dq]+data[,2,it,dt,iq,dq])
#            a = anova(model)
#            resCoef[, it, dt, iq, dq] = model$coefficients
#            resSq[1, it, dt, iq, dq] = a[1,2]
#            resSq[2, it, dt, iq, dq] = a[2,2]
#            resSq[3, it, dt, iq, dq] = a[3,2]
#            resPV[1, it, dt, iq, dq] = a[1,5]
#            resPV[2, it, dt, iq, dq] = a[2,5]
#          } # else
#        }
#      }
#    }
#  }
#  
#  dimnames(resCoef) = list(c("const","xt","xq"),
#                     pimatrix$Anno$target$Symbol,
#                     1:2,
#                     pimatrix$Anno$query$Symbol,
#                     1:2)
#  
#  dimnames(resSq) = list(c("xt","xq","res"),
#                           pimatrix$Anno$target$Symbol,
#                           1:2,
#                           pimatrix$Anno$query$Symbol,
#                           1:2)
#  
#  dimnames(resPV) = list(c("xt","xq"),
#                           pimatrix$Anno$target$Symbol,
#                           1:2,
#                           pimatrix$Anno$query$Symbol,
#                           1:2)
#  
#  fitepistasis = list(Coef = resCoef, Sq = resSq)
#  # save(fitepistasis, file="fitepistasis.rda")

## ----DirectionalInteractionsLoadFit,results='hide'-------------------------
data("fitepistasis", package="DmelSGI")

## ----DirectionalInteractions-example2pheno-sti-Cdc23,fig.width=5*1.3,fig.height=4*1.3----
plot2Phenotypes(data,"sti","Cdc23",1,5,lwd=3,cex.axis=1.3,cex.lab=1.3,cex=1.3)

## ----DirectionalInteractions-example21pheno-sti-Cdc23,fig.width=8,fig.height=4----
plotPIdata(data,"sti","Cdc23",cex.axis=1.3,cex.lab=1.3)

## ----DirectionalInteractionsResSQ------------------------------------------
resSq = fitepistasis$Sq
x = apply(resSq,2:5,sum, na.rm=TRUE)
resSq[1,,,,] = resSq[1,,,,] / x
resSq[2,,,,] = resSq[2,,,,] / x
resSq[3,,,,] = resSq[3,,,,] / x

## ----DirectionalInteractionsTH---------------------------------------------
NSIG = (apply(Interactions$padj <= 0.01,1:2,sum,na.rm=TRUE))
SQ = apply(resSq[,,,,], c(1,2,4),mean,na.rm=TRUE)
Coef = apply(fitepistasis$Coef[,,,,], c(1,2,4),mean,na.rm=TRUE)

thT = quantile(as.vector(SQ["xt",,]),probs=c(0.1,0.95))
thQ = quantile(as.vector(SQ["xq",,]),probs=c(0.1,0.95))

## ----DirectionalInteractionsEdges------------------------------------------
IT = which((NSIG >= 1) & (SQ["xt",,] > thT[2]) & (SQ["xq",,] < thQ[1]),arr.ind=TRUE)
IQ = which((NSIG >= 1) & (SQ["xq",,] > thQ[2]) & (SQ["xt",,] < thT[1]),arr.ind=TRUE)
IT = cbind(Interactions$Anno$target$Symbol[IT[,1]],
           Interactions$Anno$query$Symbol[IT[,2]])
IQ = cbind(Interactions$Anno$target$Symbol[IQ[,1]],
           Interactions$Anno$query$Symbol[IQ[,2]])

ET = data.frame(geneFrom = IT[,2], geneTo = IT[,1],
                sign = sign((Coef["xt",,])[IT]),
                coef = (Coef["xt",,])[IT],
                coefRev = NA,
                sqFrom = (SQ["xq",,])[IT],
                sqTo = (SQ["xt",,])[IT],
                mode = "target",
                stringsAsFactors=FALSE)
ITREV = cbind(IT[,2],IT[,1])
B = (ITREV[,1] %in% dimnames(Coef)[[2]]) &
  (ITREV[,2] %in% dimnames(Coef)[[3]])
ET$coefRev[B] = (Coef["xq",,])[ITREV[B,]]
EQ = data.frame(geneFrom = IQ[,1], geneTo = IQ[,2],
                sign = sign((Coef["xq",,])[IQ]),
                coef = (Coef["xq",,])[IQ],
                coefRev = NA,
                sqFrom = (SQ["xt",,])[IQ],
                sqTo = (SQ["xq",,])[IQ],
                mode = "query",
                stringsAsFactors=FALSE)
IQREV = cbind(IQ[,2],IQ[,1])
B = (IQREV[,1] %in% dimnames(Coef)[[2]]) &
  (IQREV[,2] %in% dimnames(Coef)[[3]])
EQ$coefRev[B] = (Coef["xt",,])[IQREV[B,]]
edges = rbind(ET,EQ)
edges$color = ifelse(edges$sign<0, "dodgerblue", "crimson")

## ----DirectionalInteractionsKey--------------------------------------------
key = sprintf("%s__%s",edges$geneFrom,edges$geneTo)
k = key[duplicated(key)]
g = tapply(edges$sign[key %in%  k],key[key %in%  k], function(x) { 
  length(unique(x)) > 1})
if (any(g)) {
  cat(sum(key %in% names(which(g))),
      " edges with contraditing sign are removed.\n")
  edges = edges[!(key %in% names(which(g))),]
}
key = sprintf("%s__%s",edges$geneFrom,edges$geneTo)
edges = edges[!duplicated(key),]
  
key = sprintf("%s__%s",edges$geneFrom,edges$geneTo)
key2 = sprintf("%s__%s",edges$geneTo,edges$geneFrom)
if (any(key %in% key2)) {
  cat(sum(key %in% key2)," edges with contraditing direction are removed.\n")
  edges = edges[!((key %in% key2) | (key2 %in% key)),]
}

## ----DirectionalInteractionsTable------------------------------------------
E = data.frame(edges[,c("geneFrom","geneTo")],
               effect=ifelse( edges$sign == 1, "aggravating", "alleviating"))
write.table(E, file=file.path(resultdir,"DirectionalEpistaticInteractions.txt"),
            sep="\t",row.names=FALSE,quote=FALSE)


## ----DirectionalInteractionsSelectedClusters-------------------------------
SelectedClustersComplexes = 
  SelectedClustersComplexes[c("Cytokinesis","Condensin/Cohesin",
                              "SAC","Apc/C","gammaTuRC","Dynein/Dynactin")]
SelectedClustersComplexes$'Dynein/Dynactin' = c(SelectedClustersComplexes$'Dynein/Dynactin',
                                                "Klp61F")
SelectedClustersComplexes$polo = "polo"
SelectedClustersComplexes[["vih"]] = "vih"
SelectedClustersComplexes[["Elongin-B"]] = "Elongin-B"
SelectedClustersComplexes[["Skp2"]] = "Skp2"

QG = unlist(SelectedClustersComplexes)
edges2 = edges
edges2 = edges2[(edges2$geneFrom %in% QG) & (edges2$geneTo %in% QG),]
nodes2 = list()
for (cl in names(SelectedClustersComplexes)) {
  nodes2[[cl]] = unique(c(edges2$geneFrom, edges2$geneTo))
  nodes2[[cl]] = nodes2[[cl]][nodes2[[cl]] %in% 
                                  SelectedClustersComplexes[[cl]] ]
}
cat(sprintf("Writing graph with %d nodes and %d edges.\n", 
            length(nodes2), nrow(edges2)))
  
out = c("digraph DirectionalInteractions {",
        paste("graph [size=\"10,10\" ratio=0.35 mode=major outputorder=edgesfirst overlap=false",
        "rankdir = \"LR\"];",sep=" "),
        "graph [splines=true];")

## ----DirectionalInteractionsDF---------------------------------------------
de = data.frame(
  from=c("CG31687","xxx","CG31687","xxx","Gl","xxx4","xxx4","rod","abcd1","polo","Grip75",
         "xxx2","Bub3","xxx3","Grip84","feo","xxx5","Apc10"),
  to  =c("xxx","cenB1A","xxx","Elongin-B","xxx4","Cdc23","vih","polo","polo","feo","xxx2",
         "Bub3","xxx3","Klp61F","polo","xxx5","glu","sti"),
  stringsAsFactors=FALSE)
for (i in seq_len(nrow(de))) {
  out <- c(out, rep(sprintf("\"%s\" -> \"%s\" [style=invis];",de$from[i],de$to[i]),5))
}
dg = c(de$from,de$to)
dg = unique(dg[!(dg %in% Interactions$Anno$target$Symbol)])
out <- c(out, sprintf("%s [style=invis]\n",dg))

## ----DirectionalInteractions-Mitosis---------------------------------------
  out <- c(out,
#           "newrank=true;",
#           "1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> 9 [style=invis];",
        sprintf("\"%s\" -> \"%s\" [color=\"%s\" penwidth=3 arrowsize=2];",
                edges2$geneFrom, edges2$geneTo, edges2$color))
for (cl in seq_along(SelectedClustersComplexes)) {
  out = c(out,sprintf("subgraph cluster%s {",LETTERS[cl]))
  out = c(out,
          sprintf(paste("\"%s\" [label=\"%s\" shape=ellipse style=filled fillcolor=\"%s\"",
                  "labelfontsize=%d margin=\"0.02,0.02\" tooltip=\"%s\"];"),
                  nodes2[[cl]], nodes2[[cl]], 
                  "#F5ECE5",
                  20, nodes2[[cl]]))
  out = c(out, sprintf("label=\"%s\";",names(SelectedClustersComplexes)[cl]))
  out = c(out," }")
}
out = c(out,"}")

file = file.path(resultdir,"DirectionalInteractions-Mitosis")
writeLines(out, con=sprintf("%s.dot",file) )

## ----DirectionalInteractions-Mitosis-dot, eval=FALSE-----------------------
#  system(sprintf("dot %s.dot -Tpdf -o%s.pdf",file,file))

## ----DirectionalInteractions-Mitosis-plots,resize.width="0.24\\textwidth",fig.show='hold',fig.width=4,fig.height=4----
plot2Phenotypes(data,"polo","Grip84",2,3,lwd=1,cex.axis=0.5,cex.lab=0.5,cex=0.5,length = 0.1)
plot2Phenotypes(data,"BubR1","Elongin-B",5,19,lwd=1,cex.axis=0.5,cex.lab=0.5,cex=0.5,length = 0.1)
plot2Phenotypes(data,"rod","SMC2",1,4,lwd=1,cex.axis=0.5,cex.lab=0.5,cex=0.5,length = 0.1)
plot2Phenotypes(data,"Cdc23","SMC2",1,4,lwd=1,cex.axis=0.5,cex.lab=0.5,cex=0.5,length = 0.1)
plot2Phenotypes(data,"Klp61F","Cdc16",1,2,lwd=1,cex.axis=0.5,cex.lab=0.5,cex=0.5,length = 0.1)
plot2Phenotypes(data,"ald","l(1)dd4",4,19,lwd=1,cex.axis=0.5,cex.lab=0.5,cex=0.5,length = 0.1)
plot2Phenotypes(data,"ald","Dlic",2,19,lwd=1,cex.axis=0.5,cex.lab=0.5,cex=0.5,length = 0.1)

## ----DirectionalInteractionsExamples,fig.show='hold',resize.width="0.3\\textwidth",fig.width=10,fig.height=10,eval=FALSE----
#  Genes = list("sti"=c("sti","Cdc23"),
#               "RasGAP1" = c("RasGAP1", "dalao", "Snr1", "osa","brm", "mor",
#                             "Bap60", "Dsor1", "Pvr", "Sos", "pnt"))
#  
#  for (g in seq_along(Genes)) {
#    QG = Genes[[g]]
#  
#    edges2 = edges
#    edges2 = edges2[(edges2$geneFrom %in% QG)  & (edges2$geneTo %in% QG),]
#    cat(sprintf("Writing graph with %d nodes and %d edges.\n", length(nodes2), nrow(edges2)))
#    edges2$color[edges2$color == "crimson"] = "#DB1D3D"
#    edges2$color[edges2$color == "dodgerblue"] = "#4C86C6"
#    edges2$width = 5
#    edges2$arrow.size = 2
#  
#    genes = data.frame(gene = unique(c(edges2$geneFrom,edges2$geneTo)),stringsAsFactors=FALSE)
#    genes$color = rep("#F5ECE5",nrow(genes))
#    genes$frame.color = NA
#    genes$label.color = "black"
#    genes$label.cex=1.3
#    genes$size=50
#    g = graph.data.frame(edges2,vertices = genes)
#  
#    set.seed(3122)
#    plot(g)
#  }

## ----DirectionalInteractions-SWISNF-plots,resize.width="0.24\\textwidth",fig.show='hold',fig.width=4,fig.height=4----
plot2Phenotypes(data,"Snr1","RasGAP1",1,5,lwd=2,cex.axis=1,cex.lab=1,cex=1,length = 0.2)
plot2Phenotypes(data,"Snr1","RasGAP1",1,13,lwd=2,cex.axis=1,cex.lab=1,cex=1,length = 0.2)
plot2Phenotypes(data,"brm","RasGAP1",1,5,lwd=2,cex.axis=1,cex.lab=1,cex=1,length = 0.2)
plot2Phenotypes(data,"brm","RasGAP1",1,13,lwd=2,cex.axis=1,cex.lab=1,cex=1,length = 0.2)
plot2Phenotypes(data,"mor","RasGAP1",1,5,lwd=2,cex.axis=1,cex.lab=1,cex=1,length = 0.2)
plot2Phenotypes(data,"mor","RasGAP1",1,13,lwd=2,cex.axis=1,cex.lab=1,cex=1,length = 0.2)

## ----DirectionalInteractionsLoadDI,fig.show='hold',resize.width="0.29\\textwidth",fig.width=7,fig.height=7,eval=FALSE----
#  data("TID2HUGO", package="DmelSGI")
#  data("Interactions", package="DmelSGI")
#  HugoNames = sapply(TID2HUGO, function(x) {
#    if(length(x) > 0) {
#      j=0
#      for (i in 1:nchar(x[1])) {
#        if (length(unique(substr(x,1,i))) == 1) {
#          j=i
#        }
#      }
#      res = paste(substr(x,1,j)[1],paste(substr(x,j+1,nchar(x)),collapse="/"),sep="")
#    } else {
#      res = ""
#    }
#    res
#  })
#  HugoNames = paste(Interactions$Anno$target$Symbol," (",HugoNames,")",sep="")
#  names(HugoNames) = Interactions$Anno$target$Symbol
#  
#  
#  data("Intogen", package="DmelSGI")
#  
#  SelCancer = sapply(TID2HUGO, function(x) { any(x %in% Intogen$symbol) })
#  SelCancer = Interactions$Anno$target$Symbol[which(Interactions$Anno$target$TID %in%
#                                                      names(which(SelCancer)))]
#  
#  Genes = list("Pten" = c("Pten","gig"),
#               "Arp3" = c("Arp3","Sos"),
#               "Myb" = c("Myb","mip120","mip130","polo","fzy","Elongin-B","CtBP",
#                         "sti","pav","tum","feo","Rho1","dia","scra","SMC4"),
#               "nonC" = c("nonC","spen"),
#               "Nup75" = c("Nup75","Sin3A","CtBP","jumu","RecQ4"))
#  
#  for (g in seq_along(Genes)) {
#    QG = Genes[[g]]
#  
#    edges2 = edges
#    edges2 = edges2[(edges2$geneFrom %in% QG)  & (edges2$geneTo %in% QG),]
#    edges2 = edges2[(edges2$geneFrom %in% QG[1])  | (edges2$geneTo %in% QG[1]),]
#    cat(sprintf("Writing graph with %d nodes and %d edges.\n", length(nodes2), nrow(edges2)))
#    edges2$color[edges2$color == "crimson"] = "#DB1D3D"
#    edges2$color[edges2$color == "dodgerblue"] = "#4C86C6"
#    edges2$width = 5
#    edges2$arrow.size = 2
#  
#    genes = data.frame(gene = unique(c(edges2$geneFrom,edges2$geneTo)),stringsAsFactors=FALSE)
#    genes$color = rep("#DDDDDC",nrow(genes))
#    genes$color[genes$gene %in% SelCancer] = "#777777"
#    genes$frame.color = NA
#    genes$label.color = "black"
#    genes$label.cex=1.5
#    genes$size=50
#    g = graph.data.frame(edges2,vertices = genes)
#    V(g)$name = HugoNames[V(g)$name]
#  
#    set.seed(3122)
#    plot(g)
#    legend("bottomright", inset = c(-0.07,-0.07),fill=c("#777777", "#DDDDDC"),
#          c("genes recurrently mutated in cancer","not recurrently mutated"),cex=0.5)
#  }
#  

## ----DmelSGIsessioninfo----------------------------------------------------
sessionInfo()

