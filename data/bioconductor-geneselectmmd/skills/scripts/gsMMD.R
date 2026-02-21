# Code example from 'gsMMD' vignette. See references/ for full tutorial.

### R code from vignette source 'gsMMD.Rnw'

###################################################
### code chunk number 1: gsMMD.Rnw:494-510
###################################################
  library(GeneSelectMMD)
  library(ALL)
  data(ALL)
  eSet1 <- ALL[1:100, ALL$BT == "B3" | ALL$BT == "T2"]
  
  mem.str <- as.character(eSet1$BT)
  nSubjects <- length(mem.str)
  memSubjects <- rep(0,nSubjects)
  # B3 coded as 0, T2 coded as 1
  memSubjects[mem.str == "T2"] <- 1
  
  obj.gsMMD <- gsMMD(eSet1, memSubjects, transformFlag = TRUE, 
    transformMethod = "boxcox", scaleFlag = TRUE, quiet = TRUE)
  para <- obj.gsMMD$para
  print(round(para, 3))



###################################################
### code chunk number 2: gsMMD.Rnw:513-531 (eval = FALSE)
###################################################
##   library(GeneSelectMMD)
##   library(ALL)
##   data(ALL)
##   eSet1 <- ALL[1:100, ALL$BT == "B3" | ALL$BT == "T2"]
##   mat <- exprs(eSet1)
##   
##   mem.str <- as.character(eSet1$BT)
##   nSubjects <- length(mem.str)
##   memSubjects <- rep(0,nSubjects)
##   # B3 coded as 0, T2 coded as 1
##   memSubjects[mem.str == "T2"] <- 1
##  
##   obj.gsMMD <- gsMMD.default(mat, memSubjects, iniGeneMethod = "Ttest",
##           transformFlag = TRUE, transformMethod = "boxcox", scaleFlag = TRUE,
##           quiet=TRUE)
##   para <- obj.gsMMD$para
##   print(round(para, 3))
## 


###################################################
### code chunk number 3: gsMMD.Rnw:537-576 (eval = FALSE)
###################################################
##   library(GeneSelectMMD)
##   library(ALL)
##   data(ALL)
##   eSet1 <- ALL[1:100, ALL$BT == "B3" | ALL$BT == "T2"]
##   
##   mem.str <- as.character(eSet1$BT)
##   nSubjects <- length(mem.str)
##   memSubjects <- rep(0,nSubjects)
##   # B3 coded as 0, T2 coded as 1
##   memSubjects[mem.str == "T2"] <- 1
##   
##   myWilcox <-
##   function(x, memSubjects, alpha = 0.05)
##   {
##     xc <- x[memSubjects == 1]
##     xn <- x[memSubjects == 0]
##   
##     m <- sum(memSubjects == 1)
##     res <- wilcox.test(x = xc, y = xn, conf.level = 1 - alpha)
##     res2 <- c(res$p.value, res$statistic - m * (m + 1) / 2)
##     names(res2) <- c("p.value", "statistic")
##   
##     return(res2)
##   }
##   
##   mat <- exprs(eSet1)
##   tmp <- t(apply(mat, 1, myWilcox, memSubjects = memSubjects))
##   colnames(tmp) <- c("p.value", "statistic")
##   memIni <- rep(2, nrow(mat))
##   memIni[tmp[, 1] < 0.05 & tmp[, 2] > 0] <- 1
##   memIni[tmp[, 1] < 0.05 & tmp[, 2] < 0] <- 3
##   
##   print(table(memIni))
## 
##   obj.gsMMD <- gsMMD2(eSet1, memSubjects, memIni, transformFlag = TRUE, 
##        transformMethod = "boxcox", scaleFlag = TRUE, quiet = TRUE)
##   para <- obj.gsMMD$para
##   print(round(para, 3))
## 


###################################################
### code chunk number 4: gsMMD.Rnw:579-620 (eval = FALSE)
###################################################
##   library(GeneSelectMMD)
##   library(ALL)
##   data(ALL)
##   eSet1 <- ALL[1:100, ALL$BT == "B3" | ALL$BT == "T2"]
##   mat <- exprs(eSet1)
##   
##   mem.str <- as.character(eSet1$BT)
##   nSubjects <- length(mem.str)
##   memSubjects <- rep(0,nSubjects)
##   # B3 coded as 0, T2 coded as 1
##   memSubjects[mem.str == "T2"] <- 1
##  
##   myWilcox <-
##   function(x, memSubjects, alpha = 0.05)
##   {
##     xc <- x[memSubjects == 1]
##     xn <- x[memSubjects == 0]
##   
##     m <- sum(memSubjects == 1)
##     res <- wilcox.test(x = xc, y = xn, conf.level = 1 - alpha)
##     res2 <- c(res$p.value, res$statistic - m * (m + 1) / 2)
##     names(res2) <- c("p.value", "statistic")
##   
##     return(res2)
##   }
##   
##   tmp <- t(apply(mat, 1, myWilcox, memSubjects = memSubjects))
##   colnames(tmp) <- c("p.value", "statistic")
##   memIni <- rep(2, nrow(mat))
##   memIni[tmp[, 1] < 0.05 & tmp[, 2] > 0] <- 1
##   memIni[tmp[, 1] < 0.05 & tmp[, 2] < 0] <- 3
##   
##   print(table(memIni))
##   
##   obj.gsMMD <- gsMMD2.default(mat, memSubjects, memIni = memIni,
##           transformFlag = TRUE, transformMethod = "boxcox", scaleFlag = TRUE,
##           quiet=TRUE)
##   para <- obj.gsMMD$para
##   print(round(para, 3))
## 
## 


###################################################
### code chunk number 5: gsMMD.Rnw:659-661
###################################################
  print(round(errRates(obj.gsMMD), 3))



###################################################
### code chunk number 6: gsMMD.Rnw:677-686
###################################################
  plotHistDensity(obj.gsMMD, plotFlag = "case", 
      mytitle = "Histogram of gene expression levels for T2\nimposed with estimated density (case)", 
      plotComponent = TRUE, 
      x.legend = c(0.8, 3), 
      y.legend = c(0.3, 0.4), 
      numPoints = 500,
      cex.main = 1,
      cex = 1)



