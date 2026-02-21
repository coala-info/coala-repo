# Code example from 'PLLPstatistics' vignette. See references/ for full tutorial.

### R code from vignette source 'PLLPstatistics.Rnw'

###################################################
### code chunk number 1: loadData
###################################################
data("statsTable", package="DonaPLLP2013")
x <- statsTable
dim(x)
head(x)


###################################################
### code chunk number 2: tab
###################################################
table(x$condition)


###################################################
### code chunk number 3: plotConditions
###################################################
splitByCond <-split(x$ratio, x$condition)
plotOrder <- c("WT", "Cxcr4b-/-", "Cxcr7-/-", "Cxcr7-/-Cxcl12aMo", "Cxcl12a-/-", 
               "mem-tFT")
splitByCond <- splitByCond[plotOrder]
stripchart(splitByCond, vertical=TRUE, xlab="Condition", ylab="Lifetime Ratio (-)", 
           group.names=1:length(splitByCond))


###################################################
### code chunk number 4: PLLPstatistics.Rnw:93-100
###################################################
compareConds <- as.data.frame(
    matrix(nr=6, data=c("WT", "WT", "WT", 
                        "WT", "Cxcr7-/-", "Cxcr7-/-",
                        "Cxcr4b-/-", "Cxcr7-/-", "Cxcl12a-/-", 
		                "mem-tFT", "Cxcr7-/-Cxcl12aMo", "Cxcr4b-/-")
          ), stringsAsFactors=FALSE)
colnames(compareConds) <- c("condition 1", "condition 2")


###################################################
### code chunk number 5: PLLPstatistics.Rnw:105-117
###################################################
for (i in seq_len(nrow(compareConds))) {
    res <- t.test(x$ratio[x$condition == compareConds[i,1]],
                  x$ratio[x$condition == compareConds[i,2]])
    compareConds[i, "t"] <- res$statistic
    compareConds[i, "df"] <- res$parameter
    compareConds[i, "mean 1"] <- res$estimate[1]
    compareConds[i, "mean 2"] <- res$estimate[2]
    compareConds[i, "difference in means"] <- res$estimate[2]-res$estimate[1]
    compareConds[i, "p.value"] <- res$p.value
    compareConds[i, "method"] <- res$method
}
compareConds


###################################################
### code chunk number 6: PLLPstatistics.Rnw:123-125
###################################################
compareConds[, "p.adjusted"] <- p.adjust(compareConds[, "p.value"],
 method="bonferroni")


###################################################
### code chunk number 7: PLLPstatistics.Rnw:130-132
###################################################
compareConds[order(compareConds[, "condition 1"], 
                   compareConds[, "difference in means"], decreasing=TRUE), ]


###################################################
### code chunk number 8: plotIndividual
###################################################
myPlotQQ <- function(residuals, main) {
   qqnorm(residuals, main=main)
   qqline(residuals)
}

standardize <- function(x) {(x-mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)}

par(mfrow=c(3, 2))
for (c in unique(x$condition)) {
    dataPts <- standardize(x[x$condition == c, "ratio"])
    myPlotQQ(dataPts, c)
}


###################################################
### code chunk number 9: PLLPstatistics.Rnw:165-174
###################################################
compareCondsMW <- compareConds[, c("condition 1", "condition 2")]
for (i in seq_len(nrow(compareCondsMW))) {
    res <- wilcox.test(x$ratio[x$condition == compareCondsMW[i, 1]],
                       x$ratio[x$condition == compareCondsMW[i, 2]])
    compareCondsMW[i, "W"] <- res$statistic
    compareCondsMW[i, "p.value"] <- res$p.value
    compareCondsMW[i, "method"] <- res$method
}
compareCondsMW


