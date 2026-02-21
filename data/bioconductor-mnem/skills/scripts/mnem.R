# Code example from 'mnem' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(message=FALSE, out.width="125%", fig.align="center",
                      strip.white=TRUE, warning=FALSE, tidy=TRUE,
                      #out.extra='style="display:block; margin:auto;"',
                      fig.height = 4, fig.width = 8, error=FALSE)
fig.cap0 <- "Heatmap of the simulated log odds. Effects are blue and no effects
are red. Rows denote the observed E-genes and columns the S-genes. Each S-gene
has been perturbed in many cells. The E-genes are annotated as how they are
attached in the ground truth. E.g. E-genes named '1' are attached to S-gene
'1' in the ground truth."
fig.cap01 <- "Mixture NEM result for the simulated data. On top we show
the cell assignment percentages for hard clustering and the mixture weights.
The large circular vertices depict the S-genes, the small ones the
responsibility for the best fitting cell, the diamonds the number of assigned
cells and the boxes the number of assigned E-genes."
fig.cap0em <- "EM Convergence. Convergence plot for the different starts of the
EM algorithm."
fig.cap02 <- "Ground truth causal networks of our simulated mixture of cells"
fig.cap03 <- "Model selection. Raw log likelihood of the models with different
components (left, blue) and penalized log likelihood (right, red)."
fig.cap04 <- "Responsibility distributions. Histograms of the responsibilities
for the best fitting model."
fig.cap05 <- "Heatmap of the simulated binary data. Effects are blue and no
effects
are white. Rows denote the observed E-genes and columns the S-genes. Each S-gene
has been perturbed in many cells. The E-genes are annotated as how they are
attached in the ground truth. E.g. E-genes named '1' are attached to S-gene
'1' in the ground truth."
fig.cap06 <- "Binary data. Mixture NEM result for a binary data set."
fig.cap5 <- "Penalized and raw log likelihood ratios. Blue denotes the raw
log likelihood and red the negative penalized for complexity."
fig.cap6 <- "Histograms of the responsibilities. The responsibilities for the
highest scoring mixture according to the penalized log likelihood."
fig.cap61 <- "Multiple perturbations. Simulated data including samples in
which more than one S-gene has been perturbed."
fig.cap62 <- "Multi sample result. The result of the mixture NEM inference
on data
including samples with multiple perturbations."
fig.cap7 <- "Highest scoring mixture for the Perturb-Seq dataset of cell
cycle regulators. On top we show
the cell assignments for hard clustering and the mixture weights. The large
circular vertices depict the S-genes, the small ones the responsibility for
the best fitting cell, the diamonds the number of assigned cells and the boxes
the number of assigned E-genes."
fig.cap8 <- "Second highest scoring mixture for the Perturb-Seq dataset of cell
cycle regulators. On top we show
the cell assignments for hard clustering and the mixture weights. The large
circular vertices depict the S-genes, the small ones the responsibility for
the best fitting cell, the diamonds the number of assigned cells and the boxes
the number of assigned E-genes."
paltmp <- palette()
paltmp[3] <- "blue"
paltmp[4] <- "brown"
palette(paltmp)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("mnem")

## -----------------------------------------------------------------------------
library(mnem)

## ----fig.height=6, fig.width=10, fig.cap=fig.cap0-----------------------------
seed <- 2
Sgenes <- 3
Egenes <- 10
nCells <- 100
uninform <- 1
mw <- c(0.4, 0.3, 0.3)
Nems <- 3
noise <- 0.5
set.seed(seed)    
simmini <- simData(Sgenes = Sgenes, Egenes = Egenes,
                  Nems = Nems, mw = mw, nCells = nCells, uninform = uninform)
data <- simmini$data
ones <- which(data == 1)
zeros <- which(data == 0)
data[ones] <- rnorm(length(ones), 1, noise)
data[zeros] <- rnorm(length(zeros), -1, noise)
epiNEM::HeatmapOP(data, col = "RdBu", cexRow = 0.75, cexCol = 0.75,
                  bordercol = "transparent", xrot = 0, dendrogram = "both")

## ----fig.cap=fig.cap02--------------------------------------------------------
plot(simmini, data)

## ----fig.height=6, fig.width=14, fig.cap=fig.cap01----------------------------
starts <- 5
bestk <- mnemk(data, ks = 1:5, search = "greedy", starts = starts,
                       parallel = NULL)
plot(bestk$best)
print(fitacc(bestk$best, simmini, strict = TRUE))

## ----fig.cap=fig.cap03--------------------------------------------------------
par(mfrow=c(1,2)) 
plot(bestk$lls, col = "blue", main = "raw log likelihood", type = "b",
     xlab = "number of components", ylab = "score")
plot(bestk$ics, col = "red", main = "penalized log likelihood", type = "b",
     xlab = "number of components", ylab = "score")

## ----fig.height=6.5, fig.width=6, fig.cap=fig.cap0em--------------------------
par(mfrow=c(2,2))
plotConvergence(bestk$best, cex.main = 0.7, cex.lab = 0.7)

## ----fig.cap=fig.cap04, fig.height = 4, fig.width = 4-------------------------
postprobs <- getAffinity(bestk$best$probs, mw = bestk$best$mw)
hist(postprobs, xlab = "responsibilities", main = "")

## ----fig.cap=fig.cap05, fig.height=6, fig.width=14----------------------------
set.seed(seed)
datadisc <- simmini$data
fp <- sample(which(datadisc == 0), floor(0.1*sum(datadisc == 0)))
fn <- sample(which(datadisc == 1), floor(0.1*sum(datadisc == 1)))
datadisc[c(fp,fn)] <- 1 - datadisc[c(fp,fn)]
epiNEM::HeatmapOP(datadisc, col = "RdBu", cexRow = 0.75, cexCol = 0.75,
                  bordercol = "transparent", xrot = 0, dendrogram = "both")

## ----fig.cap=fig.cap06, fig.height=6, fig.width=14----------------------------
result_disc <- mnem(datadisc, k = length(mw), search = "greedy",
                    starts = starts, method = "disc", fpfn = c(0.1,0.1))
plot(result_disc)

## ----fig.height=6, fig.width=10, fig.cap=fig.cap61----------------------------
set.seed(seed)
simmini2 <- simData(Sgenes = Sgenes, Egenes = Egenes,
                   Nems = Nems, mw = mw, nCells = nCells,
                   uninform = uninform, multi = c(0.2, 0.1))
data <- simmini2$data
ones <- which(data == 1)
zeros <- which(data == 0)
data[ones] <- rnorm(length(ones), 1, noise)
data[zeros] <- rnorm(length(zeros), -1, noise)
epiNEM::HeatmapOP(data, col = "RdBu", cexRow = 0.75, cexCol = 0.75,
                  bordercol = "transparent", dendrogram = "both")

## ----fig.height=6, fig.width=10, fig.cap=fig.cap62----------------------------
result <- mnem(data, k = length(mw), search = "greedy", starts = starts)
plot(result)

## ----eval=FALSE---------------------------------------------------------------
# app <- createApp()

## ----fig.height = 3, fig.width = 4, fig.cap = fig.cap5------------------------
data(app)
res2 <- app
maxk <- 5
j <- 2
res <- res2[[j]]
for (i in 2:5) {
    res[[i]]$data <- res[[1]]$data
}
bics <- rep(0, maxk)
ll <- rep(0, maxk)
for (i in seq_len(maxk)) {
    bics[i] <- getIC(res[[i]])
    ll[i] <- max(res[[i]]$ll)
}
ll2 <- ll
ll <- (ll/(max(ll)-min(ll)))*(max(bics)-min(bics))
ll <- ll - min(ll) + min(bics)
ll3 <- seq(min(bics), max(bics[!is.infinite(bics)]), length.out = 5)
par(mar=c(5,5,2,5))
plot(bics, type = "b", ylab = "", col = "red", xlab = "", yaxt = "n",
     ylim = c(min(min(bics,ll)), max(max(bics,ll))), xaxt = "n")
lines(ll, type = "b", col = "blue")
axis(4, ll3, round(seq(min(ll2), max(ll2), length.out = 5)), cex.axis = 0.5)
axis(2, ll3, round(ll3), cex.axis = 0.5)
axis(1, 1:maxk, 1:maxk)
mtext("penalized", side=2, line=3, cex = 1.2)
mtext("raw", side=4, line=3, cex = 1.2)

## ----fig.height = 3, fig.width = 4, fig.cap = fig.cap6------------------------
j <- 2
res <- res2[[j]]
for (i in 2:5) {
    res[[i]]$data <- res[[1]]$data
}
bics <- rep(0, maxk)
ll <- rep(0, maxk)
for (i in seq_len(maxk)) {
    bics[i] <- getIC(res[[i]])
    ll[i] <- max(res[[i]]$ll)
}
ll2 <- ll
ll <- (ll/(max(ll)-min(ll)))*(max(bics)-min(bics))
ll <- ll - min(ll) + min(bics)
ll3 <- seq(min(bics), max(bics[!is.infinite(bics)]), length.out = 5)
i <- which.min(bics)
gamma <- getAffinity(res[[i]]$probs, mw = res[[i]]$mw)
par(mar=c(5,5,2,5))
hist(gamma, main = "Histogram of responsibilities",
     xlab = "responsibilities")

## ----fig.height = 10, fig.width = 20, fig.cap = fig.cap7, echo = FALSE--------
j <- 2
res <- res2[[j]]
for (i in 2:5) {
    res[[i]]$data <- res[[1]]$data
}
bics <- rep(0, maxk)
ll <- rep(0, maxk)
for (i in seq_len(maxk)) {
    bics[i] <- getIC(res[[i]])
    ll[i] <- max(res[[i]]$ll)
}
ll2 <- ll
ll <- (ll/(max(ll)-min(ll)))*(max(bics)-min(bics))
ll <- ll - min(ll) + min(bics)
ll3 <- seq(min(bics), max(bics[!is.infinite(bics)]), length.out = 5)
i <- which.min(bics)
bics[i] <- bics[which.max(bics)]
i2 <- which.min(bics)
res[[i]]$complete <- res[[i2]]$complete <- FALSE
plot(res[[i]])

## ----fig.height = 10, fig.width = 25, fig.cap = fig.cap8, echo = FALSE--------
plot(res[[i2]])

## -----------------------------------------------------------------------------
sessionInfo()

