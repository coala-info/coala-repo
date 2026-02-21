# Code example from 'vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'vignette.Rnw'

###################################################
### code chunk number 1: vignette.Rnw:80-81
###################################################
  library(paircompviz)


###################################################
### code chunk number 2: vignette.Rnw:238-240
###################################################
  library(multcomp)
  head(cholesterol)


###################################################
### code chunk number 3: vignette.Rnw:245-246
###################################################
  pairwise.t.test(cholesterol$response, cholesterol$trt)


###################################################
### code chunk number 4: cholesterolHasse
###################################################
  paircomp(obj=cholesterol$response, grouping=cholesterol$trt, test="t")


###################################################
### code chunk number 5: bonfer
###################################################
  paircomp(InsectSprays$count, InsectSprays$spray, test="t",
           compress=TRUE, p.adjust.method="bonferroni")


###################################################
### code chunk number 6: tukeyHasse
###################################################
  library(rpart)       # for car90 dataset
  library(multcomp)    # for glht() and cld() functions
  aovR <- aov(Price ~ Type, data = car90)
  glhtR <- glht(aovR, linfct = mcp(Type = "Tukey"))
  paircomp(glhtR, compress=FALSE)


###################################################
### code chunk number 7: tukeyCld
###################################################
  cldR <- cld(glhtR)
  par(mar=c(4, 3, 5, 1))
  plot(cldR)


###################################################
### code chunk number 8: noCompress
###################################################
  paircomp(InsectSprays$count, InsectSprays$spray, test="t",
           compress=FALSE)


###################################################
### code chunk number 9: compress
###################################################
  paircomp(InsectSprays$count, InsectSprays$spray, test="t",
           compress=TRUE)


###################################################
### code chunk number 10: vignette.Rnw:420-423
###################################################
  data("brokentrans")
  tapply(brokentrans$x, brokentrans$g, mean)
  pairwise.t.test(brokentrans$x, brokentrans$g, pool.sd=FALSE)


###################################################
### code chunk number 11: vignette.Rnw:440-458
###################################################
  library(plyr)
  experiment <- read.csv("result.csv")
  experiment[!is.element(experiment$error, c("broken", "ok")), "error"] <- NA
  experiment <- na.omit(experiment)
  experiment$error <- factor(experiment$error)
  experiment$test <- mapvalues(experiment$type, 
                               from=c("prop", 
                                      "t pool.sd",
                                      "t !pool.sd",
                                      "tukey",
                                      "wilcox"),
                               to=c("pairwise comparisons for proportions",
                                    "t-test with pooled SD",
                                    "t-test without pooled SD",
                                    "Tukey test",
                                    "Wilcoxon rank sum test"))
  experiment$type <- NULL
  #levels(experiment$pkg)


###################################################
### code chunk number 12: vignette.Rnw:472-482
###################################################
  library(xtable)
  ttt <- t(as.data.frame(table(experiment$nlev)))
  sepIndex <- 9
  ttt <- data.frame(rbind(ttt[, 1:sepIndex], ttt[, (sepIndex+1):ncol(ttt)]))
  ttt <- cbind(rep(c('levels', 'frequency'), 2), ttt)
  print(xtable(ttt, align=c('r', 'r', '|', rep('r', sepIndex))),
        floating=FALSE,
        include.rownames=FALSE,
        include.colnames=FALSE,
        hline.after=c(0, 2, 4))


###################################################
### code chunk number 13: vignette.Rnw:493-496
###################################################
  library(reshape)
  ttt <- as.data.frame(table(experiment[, c("test", "error")]) )
  print(xtable(cast(ttt, test~error)), floating=FALSE, include.rownames=FALSE)


###################################################
### code chunk number 14: vignette.Rnw:506-511
###################################################
  ttt <- experiment[experiment$error == 'broken', ]
  ttt$X <- NULL
  ttt$error <- NULL
  colnames(ttt) <- c('package', 'dataset', 'obj', 'grouping', 'levels', 'test')
  print(xtable(ttt), floating=FALSE, include.rownames=FALSE)


###################################################
### code chunk number 15: customHasse
###################################################
  # create adjacency matrix
  e <- matrix(c(0, 0, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 0, 0,
                1, 1, 0, 0, 0, 0, 0, 0,
                1, 0, 0, 0, 0, 0, 0, 0,
                1, 1, 1, 1, 0, 0, 0, 0,
                1, 1, 1, 1, 1, 0, 0, 0,
                1, 1, 1, 1, 1, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0), nrow=8)

  # remove transitive edges
  e <- transReduct(e)

  # draw Hasse diagram
  hasse(e, v=LETTERS[1:8], main="")


