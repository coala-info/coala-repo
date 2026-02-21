# Code example from 'mvGST' vignette. See references/ for full tutorial.

### R code from vignette source 'mvGST.Rnw'

###################################################
### code chunk number 1: mvGST.Rnw:25-26
###################################################
options(continue=" ")


###################################################
### code chunk number 2: mvGST.Rnw:115-118
###################################################
library(mvGST)
data(mvGSTsamples)
head(obatoclax.pvals)


###################################################
### code chunk number 3: mvGST.Rnw:168-169
###################################################
head(parathyroid.pvals)


###################################################
### code chunk number 4: mvGST.Rnw:265-270
###################################################
library(hgu133plus2.db)
test1 <- profileTable(obatoclax.pvals, gene.ID='affy', 
  affy.chip='hgu133plus2', organism='hsapiens', 
  minsize=10, maxsize=200)
test1


###################################################
### code chunk number 5: mvGST.Rnw:273-277
###################################################
# Get which profile is c(-1, 0)
k <- which(rownames(test1$results.table)=="c(-1, 0)")
num.k <- as.numeric(test1$results.table[k,2])
res <- pickOut(test1, row=k, col=2)


###################################################
### code chunk number 6: mvGST.Rnw:306-307
###################################################
as.data.frame(apply(head(res),2,strtrim,width=60))


###################################################
### code chunk number 7: mvGST.Rnw:325-327
###################################################
temp <- go2Profile(c("GO:0002274", "GO:0002544", "GO:dummy"), test1)
temp


###################################################
### code chunk number 8: mvGST.Rnw:330-335
###################################################
row <- temp$`GO:0002544`
tab <- row$results.table
rn <- rownames(tab)
t <- tab[,1]==1
prof <- unlist(strsplit(rn[t],"c"))[2]


###################################################
### code chunk number 9: mvGST.Rnw:346-349
###################################################
# Get which profile is c(-1, 0)
k <- which(rownames(test1$results.table)=="c(-1, 0)")
num.k <- as.numeric(test1$results.table[k,2])


###################################################
### code chunk number 10: mvGST.Rnw:362-363
###################################################
graphCell(test1, row=k, col=2, print.legend=FALSE, interact=FALSE)


###################################################
### code chunk number 11: mvGST.Rnw:392-395
###################################################
test2 <- profileTable(parathyroid.pvals, gene.ID='ensembl',
   organism='hsapiens')
test2


###################################################
### code chunk number 12: mvGST.Rnw:398-402
###################################################
# Get which profile is c(-1, -1, -1)
k <- which(rownames(test2$results.table)=="c(-1, -1, -1)")
num.k <- as.numeric(test2$results.table[k,1])
res <- pickOut(test2, row=k, col=1)


###################################################
### code chunk number 13: mvGST.Rnw:426-427
###################################################
as.data.frame(apply(head(res),2,strtrim,width=60))


###################################################
### code chunk number 14: mvGST.Rnw:448-449
###################################################
graphCell(test2, row=k, col=1, print.legend=FALSE, interact=FALSE)


###################################################
### code chunk number 15: mvGST.Rnw:484-486 (eval = FALSE)
###################################################
## test3 <- profileTable(parathyroid.pvals, gene.ID='ensembl',
##   organism='hsapiens', mult.adj='SFL')


###################################################
### code chunk number 16: mvGST.Rnw:499-504
###################################################
library(GO.db)
xx <- as.list(GOBPANCESTOR)
ancs <- sort( union( xx$`GO:0001775`, xx$`GO:0007275` ) )[-1]
GOids <- c('GO:0001775','GO:0007275', ancs)
GOids


###################################################
### code chunk number 17: mvGST.Rnw:510-514
###################################################
t <- is.element(test2$group.names, GOids)
frame <- as.data.frame(test2$grouped.raw[t,])
pvals <- frame$OHT_DPN.BP
names(pvals) <- test2$group.names[t]


###################################################
### code chunk number 18: mvGST.Rnw:520-522
###################################################
SFL.pvals <- p.adjust.SFL(pvals, ontology='BP', sig.level=.10)
cbind(pvals, SFL.pvals)


###################################################
### code chunk number 19: mvGST.Rnw:652-720 (eval = FALSE)
###################################################
## ### Objective is to identify gene sets differentially active
## ### in one or more of the following comparisons:
## ## G1 = RS4:11 cell line at low dose   (vs. control)
## ## G2 = RS4:11 cell line at high dose  (vs. control)
## ## G3 = SEM-K2 cell line at low dose   (vs. control)
## ## G4 = SEM-K2 cell line at high dose  (vs. control)
## # 
## ## Read in data
## library(affy)
## data <- ReadAffy(celfile.path="C:\\folder\\data")
## eset <- exprs(rma(data))
## colnames(eset)
## # [1] "CR1.CEL" "CR2.CEL" "CS1.CEL" "CS2.CEL" "HR1.CEL" "HR2.CEL" "HS1.CEL"
## # [8] "HS2.CEL" "LR1.CEL" "LR2.CEL" "LS1.CEL" "LS2.CEL"
## # 
## # Define simple function to convert two-tailed p-values to one-tailed, 
## #  based on means of comparison groups
## # - this assumes null: Mean2=Mean1 and alt: Mean2>Mean1, and
## #   diff = Mean2-Mean1
## p2.p1 <- function(p,diff)
## {
##   p1 <- rep(NA,length(p))
##   t <- diff >=0
##   p1[t] <- p[t]/2
##   p1[!t] <- 1-p[!t]/2
##   return(p1)
## }
## # 
## # Define function to return one-tailed p-values for a specific contrast,
## # sorted in order of geneNames
## p1.ctrst <- function(ctr)
## {
##   ctr <<- ctr
##   ctrst <- makeContrasts(ctr, levels=design)
##   fit.ctrst <- contrasts.fit(fit, ctrst)
##   final.fit.ctrst <- eBayes(fit.ctrst)
##   top.ctrst <- topTableF(final.fit.ctrst, n=nrow(eset))
##   p1 <- p2.p1(top.ctrst$P.Value, top.ctrst[,1])
##   gn <- rownames(top.ctrst)
##   names(p1) <- gn
##   t <- order(gn)
##   return(p1[t])
## }
## # 
## ## Fit model
## library(limma)
## trt <- rep(c('C','H','L'),each=4)
## line <- rep(rep(c('R','S'),each=2),3)
## design <- model.matrix(~0+trt:line)
## head(design)
## colnames(design) <- c('CR','HR','LR','CS','HS','LS')
## fit <- lmFit(eset, design)
## # 
## ## Create contrasts  
## # R: L vs. C   (G1)
## Low.RS4 <- p1.ctrst(ctr="LR-CR")
## # R: H vs. C   (G2)
## High.RS4 <- p1.ctrst("HR-CR")
## # S: L vs. C   (G3)
## Low.SEMK2 <- p1.ctrst("LS-CS")
## # S: H vs. C   (G4)
## High.SEMK2 <- p1.ctrst("HS-CS")
## # 
## ## Assemble object for mvGST
## GN <- names(Low.RS4)
## o.pvals <- cbind(Low.RS4, High.RS4, Low.SEMK2, High.SEMK2)
## rownames(o.pvals) <- GN
## obatoclax.pvals <- o.pvals


###################################################
### code chunk number 20: mvGST.Rnw:738-767 (eval = FALSE)
###################################################
## # Load data
## library("parathyroidSE")
## data("parathyroidGenesSE")
## se <- parathyroidGenesSE
## colnames(se) <- colData(se)$run
## #
## # Fit model
## library("DESeq2")
## dds <- DESeqDataSet(se = se, design = ~ patient + treatment)
## design(dds) <- ~ patient + treatment
## ddsCtrst1 <- DESeq(dds)
## resultsNames(ddsCtrst1)
## #
## # Create contrasts
## res1 <- results(ddsCtrst1, contrast=c("treatment", "OHT", "DPN"))
## res2 <- results(ddsCtrst1, contrast=c("treatment", "OHT", "Control"))
## res3 <- results(ddsCtrst1, contrast=c("treatment", "DPN", "Control"))
## #
## # Assemble object for mvGST
## r1 <- res1[!is.na(res1$pvalue),]
## r2 <- res1[!is.na(res2$pvalue),]
## r3 <- res1[!is.na(res3$pvalue),]
## OHT_DPN <- p2.p1(r1$pvalue,r1$log2FoldChange)
## OHT_Control <- p2.p1(r2$pvalue,r2$log2FoldChange)
## DPN_Control <- p2.p1(r3$pvalue,r3$log2FoldChange)
## p.pvals <- cbind(OHT_DPN,OHT_Control,DPN_Control)
## GN <- rownames(r1)
## rownames(p.pvals) <- GN
## parathyroid.pvals <- p.pvals


