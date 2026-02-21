# Code example from 'Xhyb' vignette. See references/ for full tutorial.

### R code from vignette source 'Xhyb.Rnw'

###################################################
### code chunk number 1: Xhyb.Rnw:75-76
###################################################
 library("XhybCasneuf")


###################################################
### code chunk number 2: Xhyb.Rnw:92-99
###################################################
## all probe set pairs
data(AffysTissue)
data(CustomsTissue)

## probe set pairs of genes that do not align to each other with BLAST with a E-value smaller than $10^{-10}$
data(AffysTissue.noBl)
data(CustomsTissue.noBl)


###################################################
### code chunk number 3: Xhyb.Rnw:103-113
###################################################
 myXs <- c(seq(55,70, length.out =3),seq(75,125,length=5))

 tiltedmyboxF <- function(X,Y, main){
   par(mar = c(7, 4, 4, 2) + 0.1)
   boxplot(Y~X, col = "skyblue2", ylim=c(-1,1), ylab = expression(rho[xy]), varwidth=T,xaxt = "n", cex.lab = 1.4, main = main, xlab ="")
   axis(1, labels = FALSE)
   text(seq_len(nlevels(X)), par("usr")[3] - 0.15, srt = 45, adj = 1, labels = levels(X), xpd = TRUE)
   text(4, par("usr")[3] - 0.6, adj = 1, labels = expression(Q[xy]^75), xpd = TRUE)
   abline(0,0, lty=2)
  }


###################################################
### code chunk number 4: Xhyb.Rnw:118-126
###################################################
# X11(height = 10, width = 10)
 layout(matrix(1:4, nrow = 2, byrow = F))
  # ALL PAIRS of the custom and affymetrix CDF
  tiltedmyboxF(cut(AffysTissue$alSum, myXs, include.lowest = TRUE, right = TRUE), AffysTissue$peCC, main = "A")
  tiltedmyboxF(cut(CustomsTissue$alSum, myXs, include.lowest = TRUE, right = TRUE), CustomsTissue$peCC, main = "B")
  # EXCLUDE gene pairs with BLAST HIT with E-value < 10^-10
  tiltedmyboxF(cut(AffysTissue.noBl$alSum, myXs, include.lowest = TRUE, right = TRUE), AffysTissue.noBl$peCC, main = "C")
  tiltedmyboxF(cut(CustomsTissue.noBl$alSum, myXs, include.lowest = TRUE, right = TRUE), CustomsTissue.noBl$peCC, main = "D")


###################################################
### code chunk number 5: Xhyb.Rnw:152-170
###################################################
data(AffysTissueMC)
data(CustomsTissueMC)

myboxplot <- function(X, Y, main){
 boxplot(Y~X, col = "skyblue2", ylim=c(-1,1), ylab = expression(cor(rho[x[i]*Y]*a[i])), varwidth=T,xaxt = "n", cex.lab = 1.4, main = main, xlab =expression(Q[xy]^75))
 axis(1, labels = FALSE)
 text(seq_len(nlevels(X))+0.25, par("usr")[3] - 0.12, srt = 20, adj = 1, labels = levels(X), xpd = TRUE)
 abline(0,0, lty=2)
}

 par(mfrow=c(1,2))
 # ALL PAIRS of the Affymetrix CDF
 X <- cut(AffysTissueMC$alSum, myXs, include.lowest = TRUE, right = TRUE)
 myboxplot(X, AffysTissueMC$Mcor, main = "A")
 # ALL PAIRS of the custom-made CDF
 X <- cut(CustomsTissueMC$alSum, myXs, include.lowest = TRUE, right = TRUE)
 myboxplot(X, CustomsTissueMC$Mcor, main = "B")



###################################################
### code chunk number 6: Xhyb.Rnw:188-190
###################################################
data(ex1)
plotExample(ex1)


###################################################
### code chunk number 7: Xhyb.Rnw:194-196
###################################################
data(ex2)
plotExample(ex2)


###################################################
### code chunk number 8: Xhyb.Rnw:200-202
###################################################
data(ex3)
plotExample(ex3)


###################################################
### code chunk number 9: Xhyb.Rnw:236-237
###################################################
runSimulation()


