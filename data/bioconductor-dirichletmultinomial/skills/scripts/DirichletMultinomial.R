# Code example from 'DirichletMultinomial' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----library, message = FALSE-------------------------------------------------
library(DirichletMultinomial)
library(lattice)
library(parallel)

## ----colors---------------------------------------------------------
options(width=70, digits=2)
full <- FALSE
.qualitative <- DirichletMultinomial:::.qualitative

## ----data-input-----------------------------------------------------
fl <- system.file(package="DirichletMultinomial", "extdata", "Twins.csv")
count <- t(as.matrix(read.csv(fl, row.names=1)))
count[1:5, 1:3]

## ----taxon-counts---------------------------------------------------
cnts <- log10(colSums(count))
densityplot(
    cnts, xlim=range(cnts),
    xlab="Taxon representation (log 10 count)"
)

## ----fit------------------------------------------------------------
if (full) {
    fit <- mclapply(1:7, dmn, count=count, verbose=TRUE)
    save(fit, file=file.path(tempdir(), "fit.rda"))
} else data(fit)
fit[[4]]

## ----min-laplace, figure=TRUE---------------------------------------
lplc <- sapply(fit, laplace)
plot(lplc, type="b", xlab="Number of Dirichlet Components", ylab="Model Fit")
(best <- fit[[which.min(lplc)]])

## ----mix-weight-----------------------------------------------------
mixturewt(best)
head(mixture(best), 3)

## ----fitted---------------------------------------------------------
splom(log(fitted(best)))

## ----posterior-mean-diff--------------------------------------------
p0 <- fitted(fit[[1]], scale=TRUE) # scale by theta
p4 <- fitted(best, scale=TRUE)
colnames(p4) <- paste("m", 1:4, sep="")
(meandiff <- colSums(abs(p4 - as.vector(p0))))
sum(meandiff)

## ----table-1--------------------------------------------------------
diff <- rowSums(abs(p4 - as.vector(p0)))
o <- order(diff, decreasing=TRUE)
cdiff <- cumsum(diff[o]) / sum(diff)
df <- cbind(Mean=p0[o], p4[o,], diff=diff[o], cdiff)
DT::datatable(df) |>
    DT::formatRound(colnames(df), digits = 4)

## ----heatmap-similarity---------------------------------------------
heatmapdmn(count, fit[[1]], best, 30)

## ----twin-pheno-----------------------------------------------------
fl <- system.file(package="DirichletMultinomial", "extdata", "TwinStudy.t")
pheno0 <- scan(fl)
lvls <- c("Lean", "Obese", "Overwt")
pheno <- factor(lvls[pheno0 + 1], levels=lvls)
names(pheno) <- rownames(count)
table(pheno)

## ----subsets--------------------------------------------------------
counts <- lapply(levels(pheno), csubset, count, pheno)
sapply(counts, dim)
keep <- c("Lean", "Obese")
count <- count[pheno %in% keep,]
pheno <- factor(pheno[pheno %in% keep], levels=keep)

## ----fit-several----------------------------------------------------
if (full) {
    bestgrp <- dmngroup(
        count, pheno, k=1:5, verbose=TRUE, mc.preschedule=FALSE
    )
    save(bestgrp, file=file.path(tempdir(), "bestgrp.rda"))
} else data(bestgrp)

## ----best-several---------------------------------------------------
bestgrp
lapply(bestgrp, mixturewt)
c(
    sapply(bestgrp, laplace),
    'Lean+Obese' = sum(sapply(bestgrp, laplace)),
    Single = laplace(best)
)

## ----confusion------------------------------------------------------
xtabs(~pheno + predict(bestgrp, count, assign=TRUE))

## ----cross-validate-------------------------------------------------
if (full) {
    ## full leave-one-out; expensive!
    xval <- cvdmngroup(
        nrow(count), count, c(Lean=1, Obese=3), pheno,
        verbose=TRUE, mc.preschedule=FALSE
    )
    save(xval, file=file.path(tempdir(), "xval.rda"))
} else data(xval)

## ----ROC-dmngroup---------------------------------------------------
bst <- roc(pheno[rownames(count)] == "Obese",
predict(bestgrp, count)[,"Obese"])
bst$Label <- "Single"
two <- roc(pheno[rownames(xval)] == "Obese", xval[,"Obese"])
two$Label <- "Two group"
both <- rbind(bst, two)
pars <- list(superpose.line=list(col=.qualitative[1:2], lwd=2))
xyplot(
    TruePostive ~ FalsePositive, group=Label, both,
    type="l", par.settings=pars,
    auto.key=list(lines=TRUE, points=FALSE, x=.6, y=.1),
    xlab="False Positive", ylab="True Positive"
)

## ----sessionInfo----------------------------------------------------
sessionInfo()

