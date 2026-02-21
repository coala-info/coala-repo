# Code example from 'swfdrQ' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")

## ----eval=FALSE---------------------------------------------------------------
# library("BiocManager")
# BiocManager::install("swfdr")

## -----------------------------------------------------------------------------
library(swfdr)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("qvalue")
# library(qvalue)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
library(qvalue)

## -----------------------------------------------------------------------------
N <- 1000

## ----D0_raw, cache=TRUE-------------------------------------------------------
set.seed(12345)
dataset0 <- matrix(rnorm(6*N), ncol=6)
head(dataset0, 3)

## ----D0, cache=TRUE-----------------------------------------------------------
# compute t-tests on each row of a matrix
dataset_p <- function(D, group1=c(1,2,3), group2=c(4,5,6)) {
  t.test.groups <- function(x) {
    t.test(x[group1], x[group2])$p.value
  }
  round(apply(D, 1, t.test.groups), 5) # rounding for legibility 
}
D0 <- data.frame(p=dataset_p(dataset0), truth=0)
summary(D0$p)

## ----D1, cache=TRUE-----------------------------------------------------------
dataset1 <- matrix(c(rnorm(3*N, 0, 1), rnorm(3*N, 2, 1)), ncol=6)
head(dataset1, 3)
D1 <- data.frame(p=dataset_p(dataset1), truth=1)
summary(D1$p)

## -----------------------------------------------------------------------------
D2 <- rbind(D0, D1)
dim(D2)
table(D2$truth)

## ----Dhist, fig.width=7.5, fig.height=2.2-------------------------------------
par(mfrow=c(1,3), las=1, mar=c(3,4,2,1))
p_hist <- function(p, breaks=20, freq=F, ylim=c(0, 7.2), ...) {
  hist(p, breaks=breaks, freq=freq, ylim=ylim, xlab="", ...)
}
p_hist(D0$p, col="#666666", main="p-values in D0")
p_hist(D1$p, col="#cccccc", main="p-values in D1")
p_hist(D2$p, col="#999999", main="p-values in D2")

## ----Dqs, cache=TRUE----------------------------------------------------------
library(qvalue)
D0q <- qvalue(D0$p)
D1q <- qvalue(D1$p)
D2q <- qvalue(D2$p)
c(D0=D0q$pi0, D1=D1q$pi0, D2=D2q$pi0)

## -----------------------------------------------------------------------------
summary(D0q)

## -----------------------------------------------------------------------------
# extract number of hits with values below a threshold
hit_counts <- function(x, threshold=0.05) {
  counts <- c(sum(x$pvalues<threshold), sum(x$qvalues<threshold))
  names(counts) <- paste0(c("p<", "q<"), threshold)
  counts
}
hit_counts(D0q)

## -----------------------------------------------------------------------------
hit_counts(D1q)

## -----------------------------------------------------------------------------
hit_counts(D2q)

## -----------------------------------------------------------------------------
# compare expected and observed p-values or q-values
confusion_matrix <- function(truth, x,
                             criterion=c("qvalues", "pvalues"),
                             threshold=0.05) {
  criterion <- match.arg(criterion)
  data = data.frame(truth, x[[criterion]]<threshold)
  colnames(data)[2] = paste0(substring(criterion,1,1), "<", threshold)
  table(data)
}

## -----------------------------------------------------------------------------
confusion_matrix(D2$truth, D2q, "p")

## -----------------------------------------------------------------------------
confusion_matrix(D2$truth, D2q, "q")

## ----DX_pi0, cache=TRUE-------------------------------------------------------
D2_lm_pi0 <- lm_pi0(D2$p, X=D2$truth)

## -----------------------------------------------------------------------------
names(D2_lm_pi0)

## ----eval=FALSE---------------------------------------------------------------
# D2_lm_pi0

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(D2_lm_pi0, components=c("call", "lambda"))

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(D2_lm_pi0, components="X")

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(D2_lm_pi0, components="pi0")

## ----D2_lm_q, cache=TRUE------------------------------------------------------
D2_lm_q <- lm_qvalue(D2$p, X=D2$truth)

## ----eval=FALSE---------------------------------------------------------------
# D2_lm_q

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(D2_lm_q, components="hits")

## -----------------------------------------------------------------------------
confusion_matrix(D2$truth, D2_lm_q)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
D2conf <- confusion_matrix(D2$truth, D2_lm_q, "q", 0.05)

## ----D2_noisy, cache=TRUE-----------------------------------------------------
D2_noisy <- data.frame(p=D2[, "p"],
                       truth.noisy=D2[, "truth"]+rnorm(2*N, 0, 0.4))
head(D2_noisy, 3)

## ----D2_noisy_lm_q------------------------------------------------------------
D2_noisy_lm_q <- lm_qvalue(D2_noisy$p, X=D2_noisy$truth.noisy)

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(D2_noisy_lm_q, components="hits")

## ----D2calls_noisy------------------------------------------------------------
confusion_matrix(D2$truth, D2_noisy_lm_q)
confusion_matrix(D2$truth, D2_noisy_lm_q, threshold=0.1)

## ----GWAS, cache=TRUE---------------------------------------------------------
GWAS <- BMI_GIANT_GWAS_sample
dim(GWAS)
head(GWAS)

## ----GWAS_pi0, cache=TRUE-----------------------------------------------------
GWAS_lm_pi0 <- lm_pi0(GWAS$p, X=GWAS[, c("N", "Freq_MAF_Hapmap")])

## -----------------------------------------------------------------------------
GWAS_lm_pi0

## ----GWAS_lm_qvalue, cache=TRUE-----------------------------------------------
GWAS_lm_qvalue <- lm_qvalue(GWAS$p, X=GWAS[, c("N", "Freq_MAF_Hapmap")])

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# GWAS_lm_qvalue

## ----echo=FALSE, eval=TRUE----------------------------------------------------
print(GWAS_lm_qvalue, components="hits")

## -----------------------------------------------------------------------------
hit_counts(GWAS_lm_qvalue)

## ----GWAS_lm_qvalue_0, cache=TRUE---------------------------------------------
GWAS_lm_qvalue_0 <- lm_qvalue(GWAS$p)

## ----eval=TRUE, echo=FALSE----------------------------------------------------
print(GWAS_lm_qvalue_0, components=c("pi0", "hits"))

## ----GWAS_qvalue, cache=TRUE--------------------------------------------------
GWAS_qvalue = qvalue(GWAS$p)
summary(GWAS_qvalue)

## ----GWAS_lm_qvalue_spline, cache=TRUE----------------------------------------
GWAS_lm_qvalue_smooth <- lm_qvalue(GWAS$p, smoothing="smooth.spline")

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
table(GWAS_lm_qvalue_smooth$pi0)

