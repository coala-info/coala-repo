# Code example from 'randRotationIntro' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(digits = 4)

## ----eval=FALSE---------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("randRotation")

## ----message=FALSE------------------------------------------------------------
library(randRotation)
set.seed(0)
# Dataframe of phenotype data (sample information)
pdata <- data.frame(batch = as.factor(rep(1:3, c(10,10,10))),
                    phenotype = rep(c("Control", "Cancer"), c(5,5)))
features <- 1000

# Matrix with random gene expression data
edata <- matrix(rnorm(features * nrow(pdata)), features)
rownames(edata) <- paste("feature", 1:nrow(edata))

xtabs(data = pdata)

## -----------------------------------------------------------------------------
mod1 <- model.matrix(~1+phenotype, pdata)
head(mod1)

## -----------------------------------------------------------------------------
rr <- initBatchRandrot(Y = edata, X = mod1, coef.h = 2, batch = pdata$batch)

## -----------------------------------------------------------------------------
statistic <- function(Y, batch, mod){
  # (I) Batch effect correction with "Combat" from the "sva" package
  Y <- sva::ComBat(dat = Y, batch = batch, mod = mod)
  
  # (II) Linear model fit
  fit1 <- limma::lmFit(Y, design = mod)
  fit1 <- limma::eBayes(fit1)
  abs(fit1$t[,2])
}

## ----message=FALSE, results='hide'--------------------------------------------
rs1 <- rotateStat(initialised.obj = rr, R = 10, statistic = statistic,
                   batch = pdata$batch, mod = mod1)

## -----------------------------------------------------------------------------
rs1

## -----------------------------------------------------------------------------
p.vals <- pFdr(rs1)
hist(p.vals, col = "lightgreen");abline(h = 100, col = "blue", lty = 2)
qqunif(p.vals)

## -----------------------------------------------------------------------------
library(limma)
library(sva)

edata.combat <- ComBat(dat = edata, batch = pdata$batch, mod = mod1)
fit1 <- lmFit(edata.combat, mod1)
fit1 <- eBayes(fit1)

# P-values from t-statistics
p.vals.nonrot <- topTable(fit1, coef = 2, number = Inf, sort.by="none")$P.Value

hist(p.vals.nonrot, col = "lightgreen");abline(h = 100, col = "blue", lty = 2)
qqunif(p.vals.nonrot)
plot(p.vals, p.vals.nonrot, log = "xy", pch = 20)
abline(0,1, col = 4, lwd = 2)

## -----------------------------------------------------------------------------
# Specification of the full model
mod1 <- model.matrix(~1+phenotype, pdata)

# We select "phenotype" as the coefficient associated with H0
# All other coefficients are considered as "determined" coefficients
rr <- initRandrot(Y = edata, X = mod1, coef.h = 2)

coefs <- function(Y, mod){
  t(coef(lm.fit(x = mod, y = t(Y))))
}

# Specification of the H0 model
mod0 <- model.matrix(~1, pdata)

coef01 <- coefs(edata, mod0)
coef02 <- coefs(randrot(rr), mod0)

head(cbind(coef01, coef02))

all.equal(coef01, coef02)

## -----------------------------------------------------------------------------
coef11 <- coefs(edata, mod1)
coef12 <- coefs(randrot(rr), mod1)

head(cbind(coef11, coef12))

## -----------------------------------------------------------------------------
mod2 <- mod1
mod2[,2] <- mod2[,2] - 0.5

coef11 <- coefs(edata, mod2)
coef12 <- coefs(randrot(rr), mod2)

head(cbind(coef11, coef12))

## ----message=FALSE, results='hold'--------------------------------------------
library(limma)

mod1 = model.matrix(~phenotype, pdata)

## -----------------------------------------------------------------------------
# Linear model fit
fit0 <- lmFit(edata, mod1)
fit0 <- eBayes(fit0)

# P values for phenotype coefficient
p0 <- topTable(fit0, coef = 2, number = Inf, adjust.method = "none",
               sort.by = "none")$P.Value
hist(p0, freq = FALSE, col = "lightgreen", breaks = seq(0,1,0.1))
abline(1,0, col = "blue", lty = 2)
qqunif(p0)

## -----------------------------------------------------------------------------
library(sva)
edata.combat = ComBat(edata, batch = pdata$batch, mod = mod1)

## -----------------------------------------------------------------------------
# Linear model fit
fit1 <- lmFit(edata.combat, mod1)
fit1 <- eBayes(fit1)

# P value for phenotype coefficient
p.combat <- topTable(fit1, coef = 2, number = Inf, adjust.method = "none",
                     sort.by = "none")$P.Value
hist(p.combat, freq = FALSE, col = "lightgreen", breaks = seq(0,1,0.1))
abline(1,0, col = "blue", lty = 2)
qqunif(p.combat)

## -----------------------------------------------------------------------------
init1 <- initBatchRandrot(edata, mod1, coef.h = 2, batch = pdata$batch)

## -----------------------------------------------------------------------------
statistic <- function(Y, batch, mod, coef){
  Y.tmp <- sva::ComBat(dat = Y, batch = batch, mod = mod)

  fit1 <- limma::lmFit(Y.tmp, mod)
  fit1 <- limma::eBayes(fit1)
  # The "abs" is needed for "pFdr" to calculate 2-tailed statistics
  abs(fit1$t[,coef])
}

## ----message=FALSE, results='hide'--------------------------------------------
res1 <- rotateStat(initialised.obj = init1, R = 10, statistic = statistic,
                   batch = pdata$batch, mod = mod1, coef = 2)

## -----------------------------------------------------------------------------
p.rot <- pFdr(res1)
head(p.rot)

hist(p.rot, freq = FALSE, col = "lightgreen", breaks = seq(0,1,0.1))
abline(1,0, col = "blue", lty = 2)
qqunif(p.rot)

## -----------------------------------------------------------------------------
plot(density(log(p.rot/p0)), col = "salmon", "Log p ratios",
     panel.first = abline(v=0, col = "grey"),
     xlim = range(log(c(p.rot/p0, p.combat/p0))))
lines(density(log(p.combat/p0)), col = "blue")
legend("topleft", legend = c("log(p.combat/p0)", "log(p.rot/p0)"),
       lty = 1, col = c("blue", "salmon"))

## -----------------------------------------------------------------------------
plot(p0, p.combat, log = "xy", pch = 20, col = "lightblue", ylab = "")
points(p0, p.rot, pch = 20, col = "salmon")
abline(0,1, lwd = 1.5, col = "black")
legend("topleft", legend = c("p.combat", "p.rot"), pch = 20,
       col = c("lightblue", "salmon"))

## -----------------------------------------------------------------------------
plot(density(log(p.combat/p.rot)), col = "blue",
     main = "log(p.combat / p.rot )", panel.first = abline(v=0, col = "grey"))

## -----------------------------------------------------------------------------
fdr.q  <- pFdr(res1, "fdr.q")
fdr.qu <- pFdr(res1, "fdr.qu")
fdr.BH <- pFdr(res1, "BH")

FDRs <- cbind(fdr.q, fdr.qu, fdr.BH)
ord1 <- order(res1$s0, decreasing = TRUE)

FDRs.sorted <- FDRs[ord1,]

matplot(FDRs.sorted, type = "l", lwd = 2)
legend("bottomright", legend = c("fdr.q", "fdr.qu", "BH"), lty = 1:5, lwd = 2,
       col = 1:6)

head(FDRs.sorted)


## ----warning=FALSE------------------------------------------------------------
edata[,] <- rnorm(length(edata))
group <- as.factor(rep(1:3, 10))

# add group effect for the first 100 features
group.effect <- rep(c(0,0,1), 10)
edata[1:100,] <- t(t(edata[1:100,]) + group.effect)

mod.groups <- model.matrix(~ group)

contrasts1 <- limma::makeContrasts("2vs3" = group2 - group3,
                                   levels = mod.groups)
contrasts1

## -----------------------------------------------------------------------------
mod.cont <- contrastModel(X = mod.groups, C = contrasts1)

## -----------------------------------------------------------------------------
init1 <- initBatchRandrot(edata, mod.cont, batch = pdata$batch)

## ----message=FALSE, results='hide', warning=FALSE-----------------------------
statistic <- function(Y, batch, mod, cont){
  Y.tmp <- sva::ComBat(dat = Y, batch = batch, mod = mod)

  fit1 <- limma::lmFit(Y.tmp, mod)
  
  fit1 <- limma::contrasts.fit(fit1, cont)
  fit1 <- limma::eBayes(fit1)
  
  # The "abs" is needed for "pFdr" to calculate 2-tailed statistics
  abs(fit1$t[,1])
}

res1 <- rotateStat(initialised.obj = init1, R = 20, statistic = statistic,
                   batch = pdata$batch, mod = mod.groups, cont = contrasts1)

## -----------------------------------------------------------------------------
p.rot <- pFdr(res1)
head(p.rot)

hist(p.rot, freq = FALSE, col = "lightgreen", breaks = seq(0,1,0.1))
abline(1,0, col = "blue", lty = 2)
qqunif(p.rot)

## -----------------------------------------------------------------------------
plot(density(res1$s0), main = "", ylim = c(0,1), col = 2)
lines(density(res1$stats[[1]]), col = 1)
legend("topright", col = 1:2, lty = 1,
       legend = c("null-distribution by rotation", "test statistic"))

## ----message=FALSE, results='hide', warning=FALSE-----------------------------
res2 <- rotateStat(initialised.obj = init1, R = 20, statistic = statistic,
                   batch = pdata$batch, mod = mod.groups, cont = contrasts1)

p.rot2 <- pFdr(res2)

plot(density(res2$s0), main = "", ylim = c(0,1), col = 2)
lines(density(res2$stats[[1]]), col = 1)
legend("topright", col = 1:2, lty = 1,
       legend = c("null-distribution by rotation", "test statistic"))

## -----------------------------------------------------------------------------
plot(p.rot, p.rot2, pch = 19, log = "xy")
abline(0,1, col = "red")

## -----------------------------------------------------------------------------
pdata$individual <- sort(c(1:15, 1:15))
colnames(pdata)[2] <- "tissue"
pdata$tissue <- c("Control", "Cancer")
pdata

## -----------------------------------------------------------------------------
edata[,] <- rnorm(length(edata))
for(i in seq(1,ncol(edata),2)){
  tmp1 <- rnorm(nrow(edata))
  edata[,i] <- edata[,i] + tmp1
  edata[,i+1] <- edata[,i+1] + tmp1
}

## -----------------------------------------------------------------------------
library(nlme)
df1 <- data.frame(pdata, d1 = edata[1,])
spl1 <- split(1:nrow(pdata), pdata$batch)

covs1 <- function(., df1, i){
  df1$d1 <- .

  me1 <- lme(d1 ~ tissue, data = df1[i,], random = ~1|individual)
  getVarCov(me1, type = "marginal")[[1]]
}

covs1 <- sapply(spl1,
                function(samps)rowMeans(apply(edata, 1, covs1, df1, samps)))
cov1 <- matrix(rowMeans(covs1), 2, 2)
cormat <- cov2cor(cov1)
cormat

## -----------------------------------------------------------------------------
cormat <-  diag(5) %x% cormat
cormat <- list(cormat, cormat, cormat)

mod1 <- model.matrix(~1+tissue, pdata)
rr1 <- initBatchRandrot(Y = edata, X = mod1, coef.h = 2, batch = pdata$batch,
                        cormat = cormat)

statistic <- function(Y, batch, mod, df1){
  # Batch effect correction
  Y <- limma::removeBatchEffect(Y, batch = batch, design = mod)
  
  apply(Y, 1, function(j){
    df1$d1 <- j
    me0 <- nlme::lme(d1 ~ 1, data = df1, random = ~1|individual, method = "ML")
    me1 <- nlme::lme(d1 ~ tissue, data = df1, random = ~1|individual, method = "ML")
    
    abs(coef(me1)[1,2] / (sqrt(vcov(me1)[2,2])))
  })
  
}

rs1 <- rotateStat(initialised.obj = rr1, R = 4, statistic = statistic, 
                  batch = pdata$batch, mod = mod1, df1 = df1, parallel = TRUE)

p1 <- pFdr(rs1)

hist(p1, freq = FALSE); abline(h = 1, lty = 2, lwd = 2, col = "blue")
qqunif(p1)

## -----------------------------------------------------------------------------
sessionInfo()

