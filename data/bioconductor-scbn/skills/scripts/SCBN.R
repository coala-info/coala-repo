# Code example from 'SCBN' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("SCBN")

## -----------------------------------------------------------------------------
library(SCBN)

## -----------------------------------------------------------------------------
data(orthgenes)
orthgenes[, 6:9] <- round(orthgenes[, 6:9])
orthgenes1 <- orthgenes[!(is.na(orthgenes[,6])|is.na(orthgenes[,7])|
                        is.na(orthgenes[,8])|is.na(orthgenes[,9])), ]
sim_data <- generateDataset(commonTags=5000, uniqueTags=c(100, 300),
                            unmapped=c(400, 200),group=c(1, 2),
                            libLimits=c(.9, 1.1)*1e6,
                            empiricalDist=orthgenes1[, 6],
                            genelength=orthgenes1[, 2], randomRate=1/100,
                            pDifferential=.05, pUp=.5, foldDifference=2)

## -----------------------------------------------------------------------------
data(orthgenes)
head(orthgenes)

## -----------------------------------------------------------------------------
data(sim_data)
head(sim_data)

## -----------------------------------------------------------------------------
data(sim_data)
factor <- SCBN(orth_gene=sim_data, hkind=1:1000, a=0.05)
factor

## -----------------------------------------------------------------------------
data(sim_data)
orth_gene <- sim_data
hkind <- 1:1000
scale <- factor$scbn_val
x <- orth_gene[, 2]
y <- orth_gene[, 4]
lengthx <- orth_gene[, 1]
lengthy <- orth_gene[, 3]
n1 <- sum(x)
n2 <- sum(y)
p_value <- sageTestNew(x, y, lengthx, lengthy, n1, n2, scale)
head(p_value)

