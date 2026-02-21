# Code example from 'SAFEmanual3' vignette. See references/ for full tutorial.

### R code from vignette source 'SAFEmanual3.Rnw'

###################################################
### code chunk number 1: initialize
###################################################
library(breastCancerUPP)
library(hgu133a.db)
library(safe)


###################################################
### code chunk number 2: SAFEmanual3.Rnw:79-80
###################################################
options(width = 150)


###################################################
### code chunk number 3: SAFEmanual3.Rnw:91-96
###################################################
data(upp)
ex.upp <- exprs(upp) 
p.upp <- pData(upp)
data(p53.stat)
p.upp <- cbind(p.upp, p53 = p53.stat$p53)


###################################################
### code chunk number 4: SAFEmanual3.Rnw:101-109
###################################################
grade.3 <- which(p.upp$grade == 3)
p3.upp <- p.upp[grade.3,]
genes <- unlist(as.list(hgu133aSYMBOL))
drop <- grep("AFFX", names(genes))
genes <- genes[-drop]
e3.upp <- ex.upp[match(names(genes), rownames(ex.upp)),
                 grade.3]
table(p53 = p3.upp$p53)


###################################################
### code chunk number 5: SAFEmanual3.Rnw:115-118
###################################################
set.seed(12345)
results <- safe(e3.upp, p3.upp$p53, platform = "hgu133a.db",
                annotate = "REACTOME", print.it = FALSE)


###################################################
### code chunk number 6: SAFEmanual3.Rnw:126-127 (eval = FALSE)
###################################################
## safe.toptable(results, number = 10)


###################################################
### code chunk number 7: SAFEmanual3.Rnw:130-131
###################################################
safe.toptable(results, number = 10)


###################################################
### code chunk number 8: SAFEmanual3.Rnw:139-140
###################################################
gene.results(results, cat.name = "REACTOME:R-HSA-69183", gene.names = genes)


###################################################
### code chunk number 9: plot0
###################################################
safeplot(results, cat.name = "REACTOME:R-HSA-69183", gene.names = genes)


###################################################
### code chunk number 10: SAFEmanual3.Rnw:157-162
###################################################
entrez <- unlist(mget(names(genes),hgu133aENTREZID))
C.mat <- getCmatrix(gene.list = as.list(reactomeEXTID2PATHID),
                    present.genes = entrez,prefix = "REACTOME:",
                    min.size = 10, max.size = 500)
results <- safe(e3.upp, p3.upp$p53, C.mat, print.it = FALSE)


###################################################
### code chunk number 11: SAFEmanual3.Rnw:169-171 (eval = FALSE)
###################################################
## C.mat2 <- getCmatrix(gene.list = as.list(hgu133aPFAM),
##                      present.genes = rownames(e3.upp))


###################################################
### code chunk number 12: SAFEmanual3.Rnw:176-179 (eval = FALSE)
###################################################
## GO.list <- as.list(hgu133aGO2ALLPROBES)
## C.mat2 <- getCmatrix(keyword.list = GO.list, GO.ont = "CC", 
##             present.genes = rownames(e3.upp))


###################################################
### code chunk number 13: SAFEmanual3.Rnw:184-197
###################################################
RS.list <- list(Genes21 = c("ACTB","RPLP0","MYBL2","BIRC5","BAG1","GUSB",
                            "CD68","BCL2","MMP11","AURKA","GSTM1","ESR1",
                            "TFRC","PGR","CTSL2","GRB7","ERBB2","MKI67",
                            "GAPDH","CCNB1","SCUBE2"),
                Genes16 = c("MYBL2","BIRC5","BAG1","CD68","BCL2","MMP11",
                            "AURKA","GSTM1","ESR1","PGR","CTSL2","GRB7",
                            "ERBB2","MKI67","CCNB1","SCUBE2"))
RS.list <- lapply(RS.list,function(x)
                  return(names(genes[which(genes %in% x)])))
C.mat2 <- getCmatrix(keyword.list = RS.list,
                     present.genes = rownames(e3.upp))
results1 <- safe(e3.upp, p3.upp$er, C.mat2, print.it = FALSE)
safe.toptable(results1, number = 2, description = FALSE)


###################################################
### code chunk number 14: SAFEmanual3.Rnw:213-217
###################################################
results2 <- safe(e3.upp, p3.upp$p53, C.mat, local = "t.Welch",
                 Pi.mat = 1, print.it = FALSE)
cbind(Student = round(results@local.stat[1:3], 3),
      Welch   = round(results2@local.stat[1:3], 3))


###################################################
### code chunk number 15: SAFEmanual3.Rnw:223-228
###################################################
y.vec <- c("p53-/er-","p53-/er+","p53+/er-",
           "p53+/er+")[1+p3.upp$er+2*p3.upp$p53]
table(PHENO = y.vec)
results2 <- safe(e3.upp, y.vec, C.mat, local = "f.ANOVA", 
                 Pi.mat = 1, print.it = FALSE)


###################################################
### code chunk number 16: SAFEmanual3.Rnw:234-236
###################################################
results2 <- safe(e3.upp, p3.upp$size, C.mat, local = "t.LM", 
                 Pi.mat = 1, print.it = FALSE)


###################################################
### code chunk number 17: SAFEmanual3.Rnw:242-245
###################################################
y.vec <- rep(1:27,2)*rep(c(-1,1), each = 27)
results2 <- safe(e3.upp, y.vec, C.mat, local = "t.paired", 
                 Pi.mat = 1, print.it = FALSE)


###################################################
### code chunk number 18: SAFEmanual3.Rnw:251-262
###################################################
local.WilcoxSignRank<-function(X.mat, y.vec, ...){
return(function(data, vector = y.vec, ...) {
  n <- ncol(data)/2
  x <- data[, vector > 0][, order( vector[vector > 0])]
  y <- data[, vector < 0][, order(-vector[vector < 0])]
  ab <- abs(x-y)
  pm <- sign(x-y)
  pm.rank <- (pm == 1) * t(apply(ab, 1, rank))
  return(as.numeric(apply(pm.rank, 1, sum) - n*(n+1)/4))
} )
} 


###################################################
### code chunk number 19: SAFEmanual3.Rnw:264-268
###################################################
results3 <-  safe(e3.upp, y.vec, C.mat, local = "WilcoxSignRank",
                  Pi.mat = 1, print.it = FALSE)
cbind(Paired.t  = round(results2@local.stat[1:3], 3),
      Sign.Rank = results3@local.stat[1:3])


###################################################
### code chunk number 20: SAFEmanual3.Rnw:277-278
###################################################
library(survival)


###################################################
### code chunk number 21: surv
###################################################
layout(matrix(1:2,2,1), heights=c(4,2))
plot(survfit(Surv(p3.upp$t.rfs, p3.upp$e.rfs) ~ 1), 
     xlab = "Time (days)", ylim = c(.4,1))


###################################################
### code chunk number 22: SAFEmanual3.Rnw:288-293
###################################################
drop <- is.na(p3.upp$t.rfs)
Xy <- getCOXresiduals(e3.upp[,!drop], p3.upp$t.rfs[!drop], 
                      p3.upp$e.rfs[!drop])
results2 <- safe(Xy$X.star, Xy$y.star, C.mat, 
                 Pi.mat = 1, print.it = FALSE)  


###################################################
### code chunk number 23: SAFEmanual3.Rnw:301-305
###################################################
table(ER = p3.upp$er, p53 = p3.upp$p53)
Xy <- getXYresiduals(e3.upp, p3.upp$p53, Z.mat = p3.upp$er)
results2 <- safe(Xy$X.star, Xy$y.star, C.mat, 
                 Pi.mat = 1, print.it = FALSE)


###################################################
### code chunk number 24: SAFEmanual3.Rnw:319-322
###################################################
results2 <- safe(e3.upp, p3.upp$p53, C.mat, 
                 global = "AveDiff", print.it = FALSE)
cor(results@global.pval, results2@global.pval, method = "spearman")


###################################################
### code chunk number 25: SAFEmanual3.Rnw:331-335
###################################################
set.seed(12345)
results2 <- safe(e3.upp, p3.upp$p53, C.mat, global = "Fisher",
                 args.global = list(one.sided=F, genelist.length = 200),
                 Pi.mat = 1, print.it = FALSE)


###################################################
### code chunk number 26: SAFEmanual3.Rnw:360-365
###################################################
set.seed(12345)
results2 <- safe(e3.upp, p3.upp$er, C.mat2, 
                 method = "bootstrap.t", print.it = FALSE)
round(cbind(Perm = results1@global.pval,
            Boot.t = results2@global.pval),4)


###################################################
### code chunk number 27: SAFEmanual3.Rnw:384-391 (eval = FALSE)
###################################################
## #Initialize parallel backend
## library(doParallel)
## registerDoParallel(cores=4)
## 
## set.seed(12345)
## results <- safe(e3.upp, p3.upp$p53, platform = "hgu133a.db",
##                 annotate = "REACTOME", print.it = FALSE, parallel=TRUE)


###################################################
### code chunk number 28: plot2
###################################################
safeplot(results, cat.name = "REACTOME:R-HSA-140877", gene.names = genes)


###################################################
### code chunk number 29: plot3 (eval = FALSE)
###################################################
## safedag(results2, filter = 1)


###################################################
### code chunk number 30: plot4 (eval = FALSE)
###################################################
## safedag(results2, filter = 1, top = "GO:0044430")


