# Code example from 'sSeq' vignette. See references/ for full tutorial.

### R code from vignette source 'sSeq.Rnw'

###################################################
### code chunk number 1: hammer
###################################################
library(sSeq);
data(Hammer2months);
head(countsTable); 
conds.Hammer=c("A","A","B","B"); 


###################################################
### code chunk number 2: res1
###################################################
#exact test to get differential expressed genes
res1 = nbTestSH( countsTable, conds.Hammer, "A", "B");


###################################################
### code chunk number 3: seeResult
###################################################
head(res1);


###################################################
### code chunk number 4: AvsB_ASDplot
###################################################
disp1 <- nbTestSH( countsTable, conds.Hammer, "A", "B", SHonly=TRUE, plotASD=TRUE);


###################################################
### code chunk number 5: seeResult
###################################################
head(disp1);


###################################################
### code chunk number 6: dispPlot
###################################################
plotDispersion(disp1, legPos="bottomright")


###################################################
### code chunk number 7: variancePlot
###################################################
 rV = rowVars(countsTable);
 mu = rowMeans(countsTable); 
 SH.var =  (disp1$SH * mu^2 + mu)
 smoothScatter(log(rV)~log(mu), main="Variance Plot", ylab='log(variance)', 
   xlab='log(mean)', col=blues9[5], cex.axis=1.8)
 points( log(SH.var)~log(mu), col="black", pch=16)
 leg1 =  expression(paste("log(", hat("V")[g]^"sSeq", ")", sep=''));
 leg2 =  expression(paste("log(", hat("V")[g]^"MM", ")", sep=''));
 legend("bottomright", legend=c(leg1,leg2), col=c("black",blues9[5]), 
   pch=c(16, 1), cex=2)


###################################################
### code chunk number 8: ecdf
###################################################
#obtain the p-values for the comparison AvsA.
conds2.Hammer = c("A","B");
res1.2 =  nbTestSH( countsTable[,1:2], conds2.Hammer, "A", "B");
#draw the ECDF plot;
dd = data.frame(AvsA=res1.2$pval, AvsB=res1$pval);
ecdfAUC(dd, col.line=c("green", "red"), main = "ECDF, Hammer", drawRef = TRUE, rm1=TRUE)


###################################################
### code chunk number 9: MV_volcano
###################################################
drawMA_vol(countsTable, conds.Hammer, res1$pval, cutoff=0.05);


###################################################
### code chunk number 10: pairedDesign_data
###################################################
data(Tuch); 
head(countsTable); 
conds2 = c("normal", "normal", "normal", "tumor", "tumor", "tumor");
coLevels=data.frame(subjects=c(1,2,3,1,2,3));


###################################################
### code chunk number 11: pairedDesign
###################################################
res2 = nbTestSH(countsTable, conds2, "normal", "tumor", 
   coLevels= coLevels, pairedDesign=TRUE, pairedDesign.dispMethod="pooled");


###################################################
### code chunk number 12: seeResult
###################################################
head(res2)
countsTable[order(res2$pval),][1:25,]


