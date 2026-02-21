# Code example from 'nempi' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(message=FALSE, out.width="125%", fig.align="center",
                      strip.white=TRUE, warning=FALSE, tidy=TRUE,
                      #out.extra='style="display:block; margin:auto;"',
                      fig.height = 4, fig.width = 8, error=FALSE)
fig.cap0 <- "Heatmap of the simulated log odds. Effects are blue and no effects
are red. Rows denote the observed E-genes and columns the samples annoted by
P-genes. Each P-gene
has been perturbed in many cells. The E-genes are annotated as how they are
attached in the ground truth. E.g. E-genes named '1' are attached to S-gene
'1' in the ground truth."
fig.cap1 <- "Heatmap of the probabilsitic perturbation matrix."
paltmp <- palette()
paltmp[3] <- "blue"
paltmp[4] <- "brown"
palette(paltmp)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("nempi")

## -----------------------------------------------------------------------------
library(nempi)

## ----fig.height=6, fig.width=10, fig.cap=fig.cap0-----------------------------
library(mnem)
seed <- 8675309
Pgenes <- 10
Egenes <- 5
samples <- 100
edgeprob <- 0.5
uninform <- floor((Pgenes*Egenes)*0.1)
Nems <- mw <- 1
noise <- 1
multi <- c(0.2, 0.1)
set.seed(seed)    
simmini <- simData(Sgenes = Pgenes, Egenes = Egenes,
                  Nems = Nems, mw = mw, nCells = samples,
                  uninform = uninform, multi = multi,
                  badCells = floor(samples*0.1), edgeprob=edgeprob)
data <- simmini$data
ones <- which(data == 1)
zeros <- which(data == 0)
data[ones] <- rnorm(length(ones), 1, noise)
data[zeros] <- rnorm(length(zeros), -1, noise)
epiNEM::HeatmapOP(data, col = "RdBu", cexRow = 0.75, cexCol = 0.75,
                  bordercol = "transparent", xrot = 0,
                  dendrogram = "both")

## -----------------------------------------------------------------------------
lost <- sample(1:ncol(data), floor(ncol(data)*0.5))
colnames(data)[lost] <- ""

## ----fig.width=6,fig.height=5-------------------------------------------------
res <- nempi(data)
fit <- pifit(res, simmini, data)
print(fit$auc)

ressvm <- classpi(data)
fit <- pifit(ressvm, simmini, data, propagate = FALSE)
print(fit$auc)

resnn <- classpi(data, method = "nnet")
fit <- pifit(resnn, simmini, data, propagate = FALSE)
print(fit$auc)

resrf <- classpi(data, method = "randomForest")
fit <- pifit(resrf, simmini, data, propagate = FALSE)
print(fit$auc)

col <- rgb(seq(0,1,length.out=10),seq(1,0,length.out=10),
           seq(1,0,length.out=10))
plot(res,heatlist=list(col="RdBu"),barlist=list(col=col))

## ----fig.height=6, fig.width=10, fig.cap=fig.cap1-----------------------------
Gamma <- matrix(0, Pgenes, ncol(data))
rownames(Gamma) <- seq_len(Pgenes)
colnames(Gamma) <- colnames(data)
for (i in seq_len(Pgenes)) {
    Gamma[i, grep(paste0("^", i, "_|_", i,
                        "$|_", i, "_|^", i, "$"),
                 colnames(data))] <- 1
}
Gamma <- apply(Gamma, 2, function(x) return(x/sum(x)))
Gamma[is.na(Gamma)] <- 0

epiNEM::HeatmapOP(Gamma, col = "RdBu", cexRow = 0.75, cexCol = 0.75,
                  bordercol = "transparent", xrot = 0,
                  dendrogram = "both")

colnames(data) <- sample(seq_len(Pgenes), ncol(data), replace = TRUE)
res <- nempi(data, Gamma = Gamma)

fit <- pifit(res, simmini, data)
print(fit$auc)

## -----------------------------------------------------------------------------
Omega <- t(mnem::transitive.closure(res$res$adj))%*%res$Gamma
epiNEM::HeatmapOP(Omega, col = "RdBu", cexRow = 0.75, cexCol = 0.75,
                  bordercol = "transparent", xrot = 0,
                  dendrogram = "both")

## -----------------------------------------------------------------------------
sessionInfo()

