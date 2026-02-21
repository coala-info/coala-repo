# Code example from 'stageRVignette' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
#if (!requireNamespace("BiocManager", quietly=TRUE))
#    install.packages("BiocManager")
#BiocManager::install("stageR")

## -----------------------------------------------------------------------------
library(stageR)

## ----echo=TRUE,warning=FALSE--------------------------------------------------
library(edgeR) ; library(Biobase) ; library(limma) ; library(utils) ; library(DEXSeq)

## -----------------------------------------------------------------------------
data(hammer.eset, package="stageR")
eset <- hammer.eset ; rm(hammer.eset)

## -----------------------------------------------------------------------------
pData(eset)$Time #typo. Will do it ourself
time <- factor(rep(c("mo2","w2"),each=4),levels=c("w2","mo2"))
pData(eset)$protocol
treat <- factor(c("control","control","SNL","SNL","control","control","SNL","SNL"),levels=c("control","SNL"))
design <- model.matrix(~time*treat)
rownames(design) = paste0(time,treat,rep(1:2,4))
colnames(design)[4] = "timeMo2xTreatSNL"
design

## -----------------------------------------------------------------------------
cpmOffset <- 2
keep <- rowSums(cpm(exprs(eset))>cpmOffset)>=2 #2cpm in 2 samples
dge <- DGEList(exprs(eset)[keep,])
colnames(dge) = rownames(design)
dge <- calcNormFactors(dge)

## -----------------------------------------------------------------------------
## regular analysis
voomObj <- voom(dge,design,plot=TRUE)
fit <- lmFit(voomObj,design)
contrast.matrix <- makeContrasts(treatSNL, treatSNL+timeMo2xTreatSNL, timeMo2xTreatSNL, levels=design)
fit2 <- contrasts.fit(fit, contrast.matrix)
fit2 <- eBayes(fit2)
res <- decideTests(fit2)
summary.TestResults(res) #nr of significant up-/downregulated genes
colSums(summary.TestResults(res)[c(1,3),]) #total nr of significant genes

## -----------------------------------------------------------------------------
uniqueGenesRegular <- which(res[,1]!=0 | res[,2]!=0 | res[,3]!=0)
length(uniqueGenesRegular) #total nr of significant genes

## -----------------------------------------------------------------------------
alpha <- 0.05
nGenes <- nrow(dge)
tableF <- topTableF(fit2, number=nGenes, sort.by="none") #screening hypothesis
pScreen <- tableF$P.Value
names(pScreen) = rownames(tableF)

## -----------------------------------------------------------------------------
pConfirmation <- sapply(1:3,function(i) topTable(fit2, coef=i, number=nGenes, sort.by="none")$P.Value)
dimnames(pConfirmation) <- list(rownames(fit2),c("t1","t2","t1t2"))
stageRObj <- stageR(pScreen=pScreen, pConfirmation=pConfirmation, pScreenAdjusted=FALSE)

## -----------------------------------------------------------------------------
stageRObj <- stageWiseAdjustment(object=stageRObj, method="none", alpha=0.05)

## -----------------------------------------------------------------------------
head(getAdjustedPValues(stageRObj, onlySignificantGenes=FALSE, order=FALSE))
head(getAdjustedPValues(stageRObj, onlySignificantGenes=TRUE, order=TRUE))

## -----------------------------------------------------------------------------
res <- getResults(stageRObj)
head(res)
colSums(res) #stage-wise analysis results

## -----------------------------------------------------------------------------
stageRObj <- stageR(pScreen=pScreen, pConfirmation=pConfirmation, pScreenAdjusted=FALSE)
adjustedPSW <- stageWiseAdjustment(object=stageRObj, method="user", alpha=0.05, adjustment=c(1,1,1))
res <- getResults(adjustedPSW)
colSums(res)

## -----------------------------------------------------------------------------
data("esetProstate", package="stageR") #from stageR package
head(pData(esetProstate))
head(fData(esetProstate))

## -----------------------------------------------------------------------------
tx2gene <- fData(esetProstate)
colnames(tx2gene) <- c("transcript","gene")
barplot(table(table(tx2gene$gene)), main="Distribution of number of tx per gene")

#the dataset contains
length(unique(tx2gene$gene)) #nr genes
median(table(as.character(tx2gene$gene))) #median nr of tx/gene

## -----------------------------------------------------------------------------
### regular DEXSeq analysis
sampleData <- pData(esetProstate)
geneForEachTx <- tx2gene[match(rownames(exprs(esetProstate)),tx2gene[,1]),2]
dxd <- DEXSeqDataSet(countData = exprs(esetProstate),
                     sampleData = sampleData,
                     design = ~ sample + exon + patient + condition:exon,
                     featureID = rownames(esetProstate),
                     groupID = as.character(geneForEachTx))
dxd <- estimateSizeFactors(dxd)
dxd <- estimateDispersions(dxd)
dxd <- testForDEU(dxd, reducedModel=~ sample + exon + patient)
dxr <- DEXSeqResults(dxd)
qvalDxr <- perGeneQValue(dxr)

## -----------------------------------------------------------------------------
pConfirmation <- matrix(dxr$pvalue,ncol=1)
dimnames(pConfirmation) <- list(c(dxr$featureID),c("transcript"))
pScreen <- qvalDxr
tx2gene <- fData(esetProstate)

## -----------------------------------------------------------------------------
stageRObj <- stageRTx(pScreen=pScreen, pConfirmation=pConfirmation, pScreenAdjusted=TRUE, tx2gene=tx2gene)
stageRObj <- stageWiseAdjustment(object=stageRObj, method="dtu", alpha=0.05)

## -----------------------------------------------------------------------------
head(getSignificantGenes(stageRObj))

## -----------------------------------------------------------------------------
head(getSignificantTx(stageRObj))

## -----------------------------------------------------------------------------
padj <- getAdjustedPValues(stageRObj, order=TRUE, onlySignificantGenes=FALSE)
head(padj)

## -----------------------------------------------------------------------------
rowsNotFiltered <- tx2gene[,2]%in%names(qvalDxr)
pConfirmation <- matrix(pConfirmation[rowsNotFiltered,],ncol=1,dimnames=list(dxr$featureID[rowsNotFiltered],"transcript"))
tx2gene <- tx2gene[rowsNotFiltered,]

