# Code example from 'kebabs' vignette. See references/ for full tutorial.

## ----Init,echo=FALSE,message=FALSE,results='hide'-------------------
options(width=70)
options(useFancyQuotes=FALSE)
knitr::opts_knit$set(width=70)
set.seed(0)
library(kebabs)
kebabsVersion <- packageDescription("kebabs")$Version
kebabsDateRaw <- packageDescription("kebabs")$Date
kebabsDateYear <- as.numeric(substr(kebabsDateRaw, 1, 4))
kebabsDateMonth <- as.numeric(substr(kebabsDateRaw, 6, 7))
kebabsDateDay <- as.numeric(substr(kebabsDateRaw, 9, 10))
kebabsDate <- paste(month.name[kebabsDateMonth], " ",
                     kebabsDateDay, ", ",
                     kebabsDateYear, sep="")

## ----eval=F---------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("kebabs")

## -------------------------------------------------------------------
library(kebabs)

## ----eval=FALSE-----------------------------------------------------
# vignette("kebabs")

## ----eval=FALSE-----------------------------------------------------
# help(kebabs)

## -------------------------------------------------------------------
data(TFBS)

## -------------------------------------------------------------------
enhancerFB
length(enhancerFB)

## ----eval=FALSE-----------------------------------------------------
# hist(width(enhancerFB), breaks=30, xlab="Sequence Length",
#      main="Distribution of Sequence Lengths", col="lightblue")

## ----echo=FALSE,results='hide'--------------------------------------
pdf("001.pdf", width=8, height=5.5)
hist(width(enhancerFB), breaks=30, xlab="Sequence Length",
     main="Distribution of Sequence Lengths", col="lightblue")
dev.off()

## -------------------------------------------------------------------
showAnnotatedSeq(enhancerFB, sel=3)

## -------------------------------------------------------------------
head(yFB)

## -------------------------------------------------------------------
table(yFB)

## -------------------------------------------------------------------
numSamples <- length(enhancerFB)
trainingFraction <- 0.7
train <- sample(1:numSamples, trainingFraction * numSamples)
test <- c(1:numSamples)[-train]

## -------------------------------------------------------------------
specK2 <- spectrumKernel(k=2)

## -------------------------------------------------------------------
model <- kbsvm(x=enhancerFB[train], y=yFB[train], kernel=specK2,
               pkg="e1071", svm="C-svc", cost=15)

## -------------------------------------------------------------------
pred <- predict(model, enhancerFB[test])
head(pred)
head(yFB[test])

## -------------------------------------------------------------------
evaluatePrediction(pred, yFB[test], allLabels=unique(yFB))

## -------------------------------------------------------------------
gappyK1M3  <- gappyPairKernel(k=1, m=3)
model <- kbsvm(x=enhancerFB[train], y=yFB[train],
               kernel=gappyK1M3, pkg="e1071", svm="C-svc",
               cost=15)
pred <- predict(model, enhancerFB[test])
evaluatePrediction(pred, yFB[test], allLabels=unique(yFB))

## -------------------------------------------------------------------
gappyK1M3  <- gappyPairKernel(k=1, m=3)
model <- kbsvm(x=enhancerFB[train], y=yFB[train],
               kernel=gappyK1M3, pkg="LiblineaR", svm="C-svc",
               cost=15)
pred <- predict(model, enhancerFB[test])
evaluatePrediction(pred, yFB[test], allLabels=unique(yFB))

## -------------------------------------------------------------------
gappyK1M3  <- gappyPairKernel(k=1, m=3)
model <- kbsvm(x=enhancerFB[train], y=yFB[train],
               kernel=gappyK1M3, pkg="LiblineaR", svm="l1rl2l-svc",
               cost=5)
pred <- predict(model, enhancerFB[test])
evaluatePrediction(pred, yFB[test], allLabels=unique(yFB))

## ----eval=FALSE-----------------------------------------------------
# ?kbsvm

## -------------------------------------------------------------------
specK2 <- spectrumKernel(k=2)

## -------------------------------------------------------------------
specK2 <- spectrumKernel(k=2, normalized=FALSE)

## -------------------------------------------------------------------
mismK3M1 <- mismatchKernel(k=3, m=1)

## -------------------------------------------------------------------
gappyK1M2 <- gappyPairKernel(k=1, m=2)

## -------------------------------------------------------------------
motifCollection1 <- c("A[CG]T","C.G","C..G.T","G[^A][AT]",
                      "GT.A[CA].[CT]G")
motif1 <- motifKernel(motifCollection1)

## -------------------------------------------------------------------
gappyK1M2ps <- gappyPairKernel(k=1, m=2, distWeight=1,
                               normalized=FALSE)

## -------------------------------------------------------------------
seq1 <- AAStringSet(c("GACGAGGACCGA","AGTAGCGAGGT","ACGAGGTCTTT",
                      "GGACCGAGTCGAGG"))
positionMetadata(seq1) <- c(3, 5, 2, 10)

## -------------------------------------------------------------------
wdK3 <- spectrumKernel(k=3, distWeight=1, mixCoef=c(0.5,0.33,0.17),
                       normalized=FALSE)
km <- getKernelMatrix(wdK3, seq1)
km

## -------------------------------------------------------------------
positionMetadata(seq1) <- NULL
km <- getKernelMatrix(wdK3, seq1)
km

## ----eval=F---------------------------------------------------------
# curve(linWeight(x, sigma=5), from=-25, to=25, xlab="p - q", ylab="weight",
#       main="Predefined Distance Weighting Functions", col="green", lwd=2)
# curve(expWeight(x, sigma=5), from=-25, to=25, col="blue", lwd=2, add=TRUE)
# curve(gaussWeight(x, sigma=5), from=-25, to=25, col="red", lwd=2, add=TRUE)
# curve(swdWeight(x), from=-25, to=25, col="orange", lwd=2, add=TRUE)
# legend("topright", inset=0.03, title="Weighting Functions", c("linWeight",
#        "expWeight", "gaussWeight", "swdWeight"), col=c("green", "blue",
#        "red", "orange"), lwd=2)
# text(19, 0.55, expression(paste(sigma, " = 5")))

## ----echo=FALSE,results='hide'--------------------------------------
pdf("002.pdf", width=8, height=5.5)
curve(linWeight(x, sigma=5), from=-25, to=25, xlab="p - q", ylab="weight",
      main="Predefined Distance Weighting Functions", col="green", lwd=2)
curve(expWeight(x, sigma=5), from=-25, to=25, col="blue", lwd=2, add=TRUE)
curve(gaussWeight(x, sigma=5), from=-25, to=25, col="red", lwd=2, n=201,
      add=TRUE)
curve(swdWeight(x), from=-25, to=25, col="orange", lwd=2, add=TRUE)
legend("topright", inset=0.03, title="Weighting Functions", c("linWeight",
       "expWeight", "gaussWeight", "swdWeight"), col=c("green", "blue",
       "red", "orange"), lwd=2)
text(19, 0.55, expression(paste(sigma, " = 5")))
dev.off()

## -------------------------------------------------------------------
swdWeight <- function(d)
{
    if (missing(d))
        return(function(d) swdWeight(d))

    1 / (2 * (abs(d) + 1))
}
swdK3 <- spectrumKernel(k=3, distWeight=swdWeight(),
                        mixCoef=c(0.5,0.33,0.17))

## -------------------------------------------------------------------
data(TFBS)
names(enhancerFB) <- paste("Sample", 1:length(enhancerFB), sep="_")
enhancerFB
kmSWD <- getKernelMatrix(swdK3, x=enhancerFB, selx=1:5)
kmSWD[1:5, 1:5]

## -------------------------------------------------------------------
udWeight <- function(d, base=2)
{
    if (missing(d))
        return(function(d) udWeight(d, base=base))

    return(base^(-d))
}

specudK3 <- spectrumKernel(k=3, distWeight=udWeight(base=4),
                           mixCoef=c(0, 0.3, 0.7))
kmud <- getKernelMatrix(specudK3, x=enhancerFB, selx=1:5)

## ----eval=FALSE-----------------------------------------------------
# getGenesWithExonIntronAnnotation <- function(geneList, genomelib,
#                                              txlib)
# {
#     library(BSgenome)
#     library(genomelib, character.only=TRUE)
#     library(txlib, character.only=TRUE)
#     genome <- getBSgenome(genomelib)
#     txdb <- eval(parse(text=txlib))
#     exonsByGene <- exonsBy(txdb, by ="gene")
# 
#     ## generate exon/intron annotation
#     annot <- rep("", length(geneList))
#     geneRanges <- GRanges()
#     exonsSelGenes <- exonsByGene[geneList]
# 
#     if (length(exonsSelGenes) != length(geneList))
#         stop("some genes are not found")
# 
#     for (i in 1:length(geneList))
#     {
#         exons <- unlist(exonsSelGenes[i])
#         exonRanges <- ranges(exons)
#         chr <-  as.character(seqnames(exons)[1])
#         strand <- as.character(strand(exons)[1])
#         numExons <- length(width(exonRanges))
# 
#         for (j in 1:numExons)
#         {
#             annot[i] <-
#                 paste(annot[i],
#                       paste(rep("e", width(exonRanges)[j]),
#                             collapse=""), sep="")
# 
#             if (j < numExons)
#             {
#                 annot[i] <-
#                     paste(annot[i],
#                           paste(rep("i", start(exonRanges)[j+1] -
#                                 end(exonRanges)[j] - 1),
#                           collapse=""), sep="")
#             }
#         }
# 
#         geneRanges <-
#             c(geneRanges,
#               GRanges(seqnames=Rle(chr),
#                       strand=Rle(strand(strand)),
#                       ranges=IRanges(start=start(exonRanges)[1],
#                                      end=end(exonRanges)[numExons])))
#     }
# 
#     ## retrieve gene sequences
#     seqs <- getSeq(genome, geneRanges)
#     names(seqs) <- geneList
#     ## assign annotation
#     annotationMetadata(seqs, annCharset="ei") <- annot
#     seqs
# }
# 
# ## get gene sequences for HBA1 and HBA2 with exon/intron annotation
# ## 3039 and 3040 are the geneID values for HBA1 and HBA2
# hba <- getGenesWithExonIntronAnnotation(c("3039", "3040"),
#            "BSgenome.Hsapiens.UCSC.hg19",
#            "TxDb.Hsapiens.UCSC.hg19.knownGene")

## ----eval=FALSE-----------------------------------------------------
# annotationCharset(hba)
# showAnnotatedSeq(hba, sel=1, start=1, end=400)

## ----eval=FALSE-----------------------------------------------------
# specK2 <- spectrumKernel(k=2)
# specK2a <- spectrumKernel(k=2, annSpec=TRUE)
# erK2 <- getExRep(hba, specK2, sparse=FALSE)
# erK2[, 1:6]
# erK2a <- getExRep(hba, specK2a, sparse=FALSE)
# erK2a[, 1:6]

## ----eval=FALSE-----------------------------------------------------
# km <- linearKernel(erK2)
# km
# kma <- linearKernel(erK2a)
# kma

## -------------------------------------------------------------------
data(CCoil)
ccseq
ccannot[1:3]
head(yCC)
yCC <- as.numeric(yCC)
## delete annotation metadata
annotationMetadata(ccseq) <- NULL
annotationMetadata(ccseq)
gappy <- gappyPairKernel(k=1, m=10)
train <- sample(1:length(ccseq), 0.8 * length(ccseq))
test <- c(1:length(ccseq))[-train]
model <- kbsvm(ccseq[train], y=yCC[train], kernel=gappy,
               pkg="LiblineaR", svm="C-svc", cost=100)
pred <- predict(model, ccseq[test])
evaluatePrediction(pred, yCC[test], allLabels=unique(yCC))

## -------------------------------------------------------------------
## assign annotation metadata
annotationMetadata(ccseq, annCharset="abcdefg") <- ccannot
annotationMetadata(ccseq)[1:5]
annotationCharset(ccseq)
showAnnotatedSeq(ccseq, sel=2)
gappya <- gappyPairKernel(k=1, m=10, annSpec=TRUE)
model <- kbsvm(ccseq[train], y=yCC[train], kernel=gappya,
               pkg="LiblineaR", svm="C-svc", cost=100)
pred <- predict(model, ccseq[test])
evaluatePrediction(pred, yCC[test], allLabels=unique(yCC))

## -------------------------------------------------------------------
## grid search with two kernels and 6 hyperparameter values
## using the balanced accuracy as performance objective
model <- kbsvm(ccseq[train], y=yCC[train],
               kernel=c(gappy, gappya), pkg="LiblineaR", svm="C-svc",
               cost=c(1, 10, 50, 100, 200, 500), explicit="yes", cross=5,
               perfParameters="ALL", perfObjective="BACC",
               showProgress=TRUE)
result <- modelSelResult(model)
result

## -------------------------------------------------------------------
perfData <- performance(result)
perfData
which(perfData$BACC[1, ] == max(perfData$BACC[1, ]))
which(perfData$BACC[2, ] == max(perfData$BACC[2, ]))

## ----eval=FALSE-----------------------------------------------------
# plot(result, sel="BACC")

## ----echo=FALSE,results='hide'--------------------------------------
pdf("005.pdf", width=7, height=5)
plot(result, sel="BACC")
dev.off()

## -------------------------------------------------------------------
## position-independent spectrum kernel normalized
specK2 <- spectrumKernel(k=3)
#
## annotation specific spectrum normalized
specK2a <- spectrumKernel(k=3, annSpec=TRUE)
#
## spectrum kernel with presence normalized
specK2p <- spectrumKernel(k=3, presence=TRUE)
#
## mixed spectrum normalized
specK2m <- spectrumKernel(k=3, mixCoef=c(0.5, 0.33, 0.17))
#
## position-specific spectrum normalized
specK2ps <- spectrumKernel(k=3, distWeight=1)
#
## mixed position-specific spectrum kernel normalized
## also called weighted degree kernel normalized
specK2wd <- spectrumKernel(k=3, dist=1,
                             mixCoef=c(0.5, 0.33, 0.17))
#
## distance-weighted spectrum normalized
specK2lin <- spectrumKernel(k=3, distWeight=linWeight(sigma=10))
specK2exp <- spectrumKernel(k=3, distWeight=expWeight(sigma=10))
specK2gs <- spectrumKernel(k=3, distWeight=gaussWeight(sigma=10))
#
## shifted weighted degree with equal position weighting normalized
specK2swd <- spectrumKernel(k=3, distWeight=swdWeight(),
                              mixCoef=c(0.5, 0.33, 0.17))
#
## distance-weighted spectrum kernel with user defined distance
## weighting
udWeight <- function(d, base=2)
{
    if (!(is.numeric(base) && length(base==1)))
        stop("parameter 'base' must be a single numeric value\n")

    if (missing(d))
        return(function(d) udWeight(d, base=base))

    if (!is.numeric(d))
        stop("'d' must be a numeric vector\n")

    return(base^(-d))
}
specK2ud <- spectrumKernel(k=3, distWeight=udWeight(b=2))

## -------------------------------------------------------------------
specK25 <- spectrumKernel(k=2:5)
specK25
train <- 1:100
model <- kbsvm(x=enhancerFB[train], y=yFB[train],
               kernel=specK25, pkg="LiblineaR", svm="C-svc",
               cost=c(1, 5, 10, 20, 50, 100), cross=5, explicit="yes",
               showProgress=TRUE)
modelSelResult(model)

## -------------------------------------------------------------------
kernelList1 <- list(spectrumKernel(k=3), mismatchKernel(k=3, m=1),
                    gappyPairKernel(k=2, m=4))

## -------------------------------------------------------------------
kernelList2 <- c(spectrumKernel(k=2:4), gappyPairKernel(k=1, m=2:5))

## -------------------------------------------------------------------
specK2 <- spectrumKernel(k=2)
km <- getKernelMatrix(specK2, x=enhancerFB)
class(km)
dim(km)
km[1:3, 1:3]

## ----eval=FALSE-----------------------------------------------------
# heatmap(km, symm=TRUE)

## -------------------------------------------------------------------
specK2 <- spectrumKernel(k=2)
km <- specK2(x=enhancerFB)
km[1:3, 1:3]

## -------------------------------------------------------------------
km <- getKernelMatrix(specK2, x=enhancerFB, selx=c(1, 4, 25, 137, 300))
km

## -------------------------------------------------------------------
seqs1 <- enhancerFB[1:200]
seqs2 <- enhancerFB[201:500]
km <- getKernelMatrix(specK2, x=seqs1, y=seqs2)
dim(km)
km[1:4, 1:5]

## -------------------------------------------------------------------
km <- getKernelMatrix(specK2, x=enhancerFB, selx=1:200,
                      y=enhancerFB, sely=201:500)
dim(km)

## -------------------------------------------------------------------
specK2 <- spectrumKernel(k=2, normalized=FALSE)
erd <- getExRep(enhancerFB, selx=1:5, kernel=specK2, sparse=FALSE)
erd

## -------------------------------------------------------------------
specK6 <- spectrumKernel(k=6, normalized=FALSE)
erd <- getExRep(enhancerFB, selx=1:5, kernel=specK6,
                sparse=FALSE)
dim(erd)
erd[, 1:6]

## -------------------------------------------------------------------
specK6 <- spectrumKernel(k=6, normalized=FALSE)
erd <- getExRep(enhancerFB, kernel=specK6, sparse=FALSE)
dim(erd)
object.size(erd)
ers <- getExRep(enhancerFB, kernel=specK6, sparse=TRUE)
dim(ers)
object.size(ers)
ers[1:5, 1:6]

## -------------------------------------------------------------------
library(apcluster)
gappyK1M4 <- gappyPairKernel(k=1, m=4)
km <- getKernelMatrix(gappyK1M4, enhancerFB)
apres <- apcluster(s=km, p=0.8)
length(apres)

## ----eval=FALSE-----------------------------------------------------
# aggres <- aggExCluster(km, apres)
# plot(aggres)

## ----echo=FALSE,results='hide'--------------------------------------
aggres <- aggExCluster(km, apres)
pdf("004.pdf")
plot(aggres)
dev.off()

## -------------------------------------------------------------------
exrep <- getExRep(enhancerFB, gappyK1M4, sparse=FALSE)
apres1 <- apcluster(s=linearKernel, x=exrep, p=0.1)
length(apres1)

## -------------------------------------------------------------------
exrep <- getExRep(x=enhancerFB, selx=1:5, gappyK1M4, sparse=FALSE)
dim(exrep)
erquad <- getExRepQuadratic(exrep)
dim(erquad)
erquad[1:5, 1:5]

## -------------------------------------------------------------------
gappyK1M4 <- gappyPairKernel(k=1, m=4)
exrep <- getExRep(enhancerFB, gappyK1M4, sparse=FALSE)
numSamples <- length(enhancerFB)
trainingFraction <- 0.8
train <- sample(1:numSamples, trainingFraction * numSamples)
test <- c(1:numSamples)[-train]
model <- kbsvm(x=exrep[train, ], y=yFB[train], kernel=gappyK1M4,
               pkg="kernlab", svm="C-svc", cost=15)
pred <- predict(model, exrep[test, ])
evaluatePrediction(pred, yFB[test], allLabels=unique(yFB))

## -------------------------------------------------------------------
## compute symmetric kernel matrix for training samples
kmtrain <- getKernelMatrix(gappyK1M4, x=enhancerFB, selx=train)
model1 <- kbsvm(x=kmtrain, y=yFB[train], kernel=gappyK1M4,
                pkg="e1071", svm="C-svc", cost=15)
## compute rectangular kernel matrix of test samples against support vectors
kmtest <- getKernelMatrix(gappyK1M4, x=enhancerFB, y=enhancerFB, selx=test,
                          sely=train)
pred1 <- predict(model1, kmtest)
evaluatePrediction(pred1, yFB[test], allLabels=unique(yFB))

## -------------------------------------------------------------------
preddec <- predict(model, exrep[test, ], predictionType="decision")
evaluatePrediction(pred, yFB[test], allLabels=unique(yFB),
                   decValues=preddec)

## -------------------------------------------------------------------
perf <- evaluatePrediction(pred, yFB[test], allLabels=unique(yFB),
        decValues=preddec, print=FALSE)
perf

## ----eval=FALSE-----------------------------------------------------
# rocdata <- computeROCandAUC(preddec, yFB[test], unique(yFB))
# plot(rocdata, main="Receiver Operating Characteristics", col="red", lwd=2)

## ----echo=FALSE,results='hide'--------------------------------------
rocdata <- computeROCandAUC(preddec, yFB[test], unique(yFB))
pdf("008.pdf")
plot(rocdata, main="Receiver Operating Characteristics", col="red", lwd=2)
dev.off()

## -------------------------------------------------------------------
data(CCoil)
ccseq
head(yCC)
head(ccgroups)
gappyK1M6 <- gappyPairKernel(k=1, m=6)
model <- kbsvm(x=ccseq, y=as.numeric(yCC), kernel=gappyK1M6,
               pkg="LiblineaR", svm="C-svc", cost=30, cross=3,
               noCross=2, groupBy=ccgroups, perfObjective="BACC",
               perfParameters=c("ACC", "BACC"))
cvResult(model)

## -------------------------------------------------------------------
specK24 <- spectrumKernel(k=2:4)
gappyK1M24 <- gappyPairKernel(k=1, m=2:4)
gridKernels <- c(specK24, gappyK1M24)
cost <- c(1, 10, 100, 1000, 10000)
model <- kbsvm(x=enhancerFB, y=yFB, kernel=gridKernels,
               pkg="LiblineaR", svm="C-svc", cost=cost, cross=3,
               explicit="yes", showProgress=TRUE)
modelSelResult(model)

## -------------------------------------------------------------------
specK34 <- spectrumKernel(k=3:4)
gappyK1M34 <- gappyPairKernel(k=1, m=3:4)
gridKernels <- c(specK34, gappyK1M34)
pkgs <- c("e1071", "LiblineaR", "LiblineaR")
svms <- c("C-svc","C-svc","l1rl2l-svc")
cost <- c(50, 50, 12)
model <- kbsvm(x=enhancerFB, y=yFB, kernel=gridKernels,
               pkg=pkgs, svm=svms, cost=cost, cross=10,
               explicit="yes", showProgress=TRUE,
               showCVTimes=TRUE)
modelSelResult(model)

## -------------------------------------------------------------------
specK34 <- spectrumKernel(k=3:4)
gappyK1M34 <- gappyPairKernel(k=1, m=3:4)
gridKernels <- c(specK34, gappyK1M34)
cost <- c(10, 50, 100)
model <- kbsvm(x=enhancerFB, y=yFB, kernel=gridKernels,
               pkg="LiblineaR", svm="C-svc", cost=cost, cross=10,
               explicit="yes", nestedCross=4)
modelSelResult(model)
cvResult(model)

## -------------------------------------------------------------------
performance(cvResult(model))$foldErrors

## -------------------------------------------------------------------
head(yReg)
gappyK1M2 <- gappyPairKernel(k=1, m=2)
model <- kbsvm(x=enhancerFB, y=yReg, kernel=gappyK1M2,
               pkg="e1071", svm="nu-svr", nu=c(0.5, 0.6, 0.7, 0.8),
               cross=10, showProgress=TRUE)
modelSelResult(model)

## -------------------------------------------------------------------
numSamples <- length(enhancerFB)
trainingFraction <- 0.7
train <- sample(1:numSamples, trainingFraction * numSamples)
test <- c(1:numSamples)[-train]
model <- kbsvm(x=enhancerFB[train], y=yReg[train],
               kernel=gappyK1M2, pkg="e1071", svm="nu-svr",
               nu=0.7)
pred <- predict(model, enhancerFB[test])
mse <- sum((yReg[test] - pred)^2)/length(test)
mse
featWeights <- featureWeights(model)
colnames(featWeights)[which(featWeights > 0.4)]

## -------------------------------------------------------------------
model <- kbsvm(x=enhancerFB[train], y=yReg[train],
               kernel=spectrumKernel(k=2), pkg="e1071", svm="nu-svr",
               nu=0.7)
pred <- predict(model, enhancerFB[test])
featWeights <- featureWeights(model)
colnames(featWeights)[which(featWeights > 0.4)]

## -------------------------------------------------------------------
model <- kbsvm(x=enhancerFB[train], y=yReg[train],
               kernel=spectrumKernel(k=2), pkg="e1071", svm="nu-svr",
               nu=c(0.5, 0.55, 0.6), cross=10, nestedCross=5)
modelSelResult(model)
cvResult(model)
model <- kbsvm(x=enhancerFB[train], y=yReg[train],
               kernel=gappyPairKernel(k=1,m=2), pkg="e1071",
               svm="nu-svr", nu=c(0.6, 0.65, 0.7), cross=10,
               nestedCross=5)
modelSelResult(model)
cvResult(model)

## -------------------------------------------------------------------
data(CCoil)
gappya <- gappyPairKernel(k=1,m=11, annSpec=TRUE)
model <- kbsvm(x=ccseq, y=as.numeric(yCC), kernel=gappya,
               pkg="e1071", svm="C-svc", cost=15)
featureWeights(model)[,1:5]
GCN4 <- AAStringSet(c("MKQLEDKVEELLSKNYHLENEVARLKKLV",
                      "MKQLEDKVEELLSKYYHTENEVARLKKLV"))
names(GCN4) <- c("GCN4wt", "GCN_N16Y,L19T")
annCharset <- annotationCharset(ccseq)
annot <- c("abcdefgabcdefgabcdefgabcdefga",
           "abcdefgabcdefgabcdefgabcdefga")

annotationMetadata(GCN4, annCharset=annCharset) <- annot
predProf <- getPredictionProfile(GCN4, gappya,
                                 featureWeights(model),
                                 modelOffset(model))
predProf

## ----eval=FALSE-----------------------------------------------------
# plot(predProf, sel=1, ylim=c(-0.4, 0.2), heptads=TRUE, annotate=TRUE)

## ----echo=FALSE,results='hide'--------------------------------------
pdf("006.pdf", width=7, height=5.5)
plot(predProf, sel=1, ylim=c(-0.4, 0.2), heptads=TRUE, annotate=TRUE)
dev.off()

## ----eval=FALSE-----------------------------------------------------
# plot(predProf, sel=c(1, 2), ylim=c(-0.4, 0.2), heptads=TRUE, annotate=TRUE)

## ----echo=FALSE,results='hide'--------------------------------------
pdf("007.pdf", width=7, height=5.5)
plot(predProf, sel=c(1, 2), ylim=c(-0.4, 0.2), heptads=TRUE, annotate=TRUE)
dev.off()

## -------------------------------------------------------------------
table(yMC)
gappyK1M2 <- gappyPairKernel(k=1, m=2)
model <- kbsvm(x=enhancerFB[train], y=yMC[train],
               kernel=gappyK1M2, pkg="LiblineaR",
               svm="C-svc", cost=300)
pred <- predict(model, enhancerFB[test])
evaluatePrediction(pred, yMC[test], allLabels=unique(yMC))

## -------------------------------------------------------------------
featWeights <- featureWeights(model)
length(featWeights)
featWeights[[1]][1:5]
featWeights[[2]][1:5]
featWeights[[3]][1:5]

## -------------------------------------------------------------------
predProf <- getPredictionProfile(enhancerFB, gappyK1M2,
                                 featureWeights(model)[[2]],
                                 modelOffset(model)[2])
predProf

## ----eval=FALSE-----------------------------------------------------
# toBibtex(citation("kebabs"))

