# Code example from 'v02-workflow' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(dpi=40,fig.width=7)

## ----loaddata, message=FALSE--------------------------------------------------
library("pRolocdata")
data("thpLOPIT_unstimulated_rep1_mulvey2021")
data("thpLOPIT_unstimulated_rep3_mulvey2021")
data("thpLOPIT_lps_rep1_mulvey2021")
data("thpLOPIT_lps_rep3_mulvey2021")

## ----summarydata--------------------------------------------------------------
thpLOPIT_unstimulated_rep1_mulvey2021
thpLOPIT_lps_rep1_mulvey2021

## ----ldpkg, message=FALSE-----------------------------------------------------
library("bandle")
library("pheatmap")
library("viridis")
library("dplyr")
library("ggplot2")
library("gridExtra")

## ----datadim------------------------------------------------------------------
dim(thpLOPIT_unstimulated_rep1_mulvey2021)
dim(thpLOPIT_unstimulated_rep3_mulvey2021)
dim(thpLOPIT_lps_rep1_mulvey2021)
dim(thpLOPIT_lps_rep3_mulvey2021)

## ----cmnprots-----------------------------------------------------------------
thplopit <- commonFeatureNames(c(thpLOPIT_unstimulated_rep1_mulvey2021,  ## unstimulated rep
                                 thpLOPIT_unstimulated_rep3_mulvey2021,  ## unstimulated rep
                                 thpLOPIT_lps_rep1_mulvey2021,           ## 12h-LPS rep
                                 thpLOPIT_lps_rep3_mulvey2021))          ## 12h-LPS rep

## ----listmsnsets--------------------------------------------------------------
thplopit

## ----exampledata, fig.height=10, fig.width=10---------------------------------
## create a character vector of title names for the plots
plot_id <- c("Unstimulated replicate 1", "Unstimulated replicate 2",
             "12h-LPS replicate 1", "12h-LPS replicate 2")

## Let's set the stock colours of the classes to plot to be transparent
setStockcol(NULL)
setStockcol(paste0(getStockcol(), "90"))

## plot the data
par(mfrow = c(2,2))
for (i in seq(thplopit))
    plot2D(thplopit[[i]], main = plot_id[i])
addLegend(thplopit[[4]], where = "topleft", cex = .75)

## ----lengthmrk----------------------------------------------------------------
(mrkCl <- getMarkerClasses(thplopit[[1]], fcol = "markers"))

## -----------------------------------------------------------------------------
K <- length(mrkCl)

## ----sethyppar----------------------------------------------------------------
pc_prior <- matrix(NA, ncol = 3, K)
pc_prior[seq.int(1:K), ] <- matrix(rep(c(1, 60, 100),
                                       each = K), ncol = 3)
head(pc_prior)

## ----runhyppar----------------------------------------------------------------
gpParams <- lapply(thplopit,
                   function(x) fitGPmaternPC(x, hyppar = pc_prior))

## ----plotgps, fig.height=10, fig.width=10-------------------------------------
par(mfrow = c(4, 3))
plotGPmatern(thplopit[[1]], gpParams[[1]])

## ----setweightprior-----------------------------------------------------------
set.seed(1)
dirPrior = diag(rep(1, K)) + matrix(0.001, nrow = K, ncol = K)
predDirPrior <- prior_pred_dir(object = thplopit[[1]],
                               dirPrior = dirPrior,
                               q = 15)

## -----------------------------------------------------------------------------
predDirPrior$meannotAlloc

## -----------------------------------------------------------------------------
predDirPrior$tailnotAlloc

## ----fig.height=3, fig.width=4------------------------------------------------
hist(predDirPrior$priornotAlloc, col = getStockcol()[1])

## ----try, fig.height=3, fig.width=4-------------------------------------------
set.seed(1)
dirPrior = diag(rep(1, K)) + matrix(0.0005, nrow = K, ncol = K)
predDirPrior <- prior_pred_dir(object = thplopit[[1]],
                               dirPrior = dirPrior,
                               q = 15)

predDirPrior$meannotAlloc
predDirPrior$tailnotAlloc
hist(predDirPrior$priornotAlloc, col = getStockcol()[1])

## ----runbandle, message=FALSE-------------------------------------------------
control <- list(thplopit[[1]], thplopit[[2]])
treatment <- list(thplopit[[3]], thplopit[[4]])

params <- bandle(objectCond1 = control, 
                 objectCond2 = treatment,
                 numIter = 10,       # usually 10,000
                 burnin = 5L,        # usually 5,000
                 thin = 1L,          # usually 20
                 gpParams = gpParams,
                 pcPrior = pc_prior,
                 numChains = 4,     # usually >=4
                 dirPrior = dirPrior,
                 seed = 1)

## -----------------------------------------------------------------------------
params

## ----gelman-------------------------------------------------------------------
calculateGelman(params)

## ----tracedens, fig.height=8, fig.width=8-------------------------------------
plotOutliers(params)

## ----pressure, echo=FALSE, fig.cap="", out.width = "100%"---------------------
knitr::include_graphics("figs/traceplot.png")

## ----rmchains-----------------------------------------------------------------
params_converged <- params[-c(1, 4)]

## ----viewnew------------------------------------------------------------------
params_converged

## ----processbandle------------------------------------------------------------
params_converged <- bandleProcess(params_converged)

## -----------------------------------------------------------------------------
bandle_out <- summaries(params_converged)

## -----------------------------------------------------------------------------
length(bandle_out)
class(bandle_out[[1]])

## ----results = "hide"---------------------------------------------------------
bandle_out[[1]]@posteriorEstimates
bandle_out[[1]]@diagnostics
bandle_out[[1]]@bandle.joint

## ----predictlocation----------------------------------------------------------
## Add the bandle results to a MSnSet
xx <- bandlePredict(control, 
                    treatment, 
                    params = params_converged, 
                    fcol = "markers")
res_0h <- xx[[1]]
res_12h <- xx[[2]]

## ----showappended, eval=FALSE-------------------------------------------------
# fvarLabels(res_0h[[1]])
# fvarLabels(res_0h[[2]])
# 
# fvarLabels(res_12h[[1]])
# fvarLabels(res_12h[[2]])

## ----thresholddata------------------------------------------------------------
## threshold results using 1% FDR
res_0h[[1]] <- getPredictions(res_0h[[1]], 
                              fcol = "bandle.allocation",  
                              scol = "bandle.probability",    
                              mcol = "markers", 
                              t = .99)

res_12h[[1]] <- getPredictions(res_12h[[1]], 
                               fcol = "bandle.allocation",
                               scol = "bandle.probability", 
                               mcol = "markers",      
                               t = .99)

## ----threshold2---------------------------------------------------------------
## add outlier probability
fData(res_0h[[1]])$bandle.outlier.t <- 1 -  fData(res_0h[[1]])$bandle.outlier
fData(res_12h[[1]])$bandle.outlier.t <- 1 -  fData(res_12h[[1]])$bandle.outlier

## threshold again, now on the outlier probability
res_0h[[1]] <- getPredictions(res_0h[[1]], 
                              fcol = "bandle.allocation.pred",  
                              scol = "bandle.outlier.t",    
                              mcol = "markers", 
                              t = .99)

res_12h[[1]] <- getPredictions(res_12h[[1]], 
                               fcol = "bandle.allocation.pred",
                               scol = "bandle.outlier.t", 
                               mcol = "markers",      
                               t = .99)

## ----appendtosecond-----------------------------------------------------------
## Add results to second replicate at 0h
res_alloc_0hr <- fData(res_0h[[1]])$bandle.allocation.pred.pred
fData(res_0h[[2]])$bandle.allocation.pred.pred <- res_alloc_0hr

## Add results to second replicate at 12h
res_alloc_12hr <- fData(res_12h[[1]])$bandle.allocation.pred.pred
fData(res_12h[[2]])$bandle.allocation.pred.pred <- res_alloc_12hr

## ----plotmyres, fig.height=14, fig.width=5------------------------------------
par(mfrow = c(5, 2))

plot2D(res_0h[[1]], main = "Unstimulated - replicate 1 \n subcellular markers", 
       fcol = "markers")
plot2D(res_0h[[1]], main = "Unstimulated - replicate 1 \nprotein allocations (1% FDR)", 
       fcol = "bandle.allocation.pred.pred")

plot2D(res_0h[[2]], main = "Unstimulated - replicate 2 \nsubcellular markers", 
       fcol = "markers")
plot2D(res_0h[[2]], main = "Unstimulated - replicate 2 \nprotein allocations (1% FDR)", 
       fcol = "bandle.allocation.pred.pred")

plot2D(res_0h[[1]], main = "12h LPS - replicate 1 \nsubcellular markers", 
       fcol = "markers")
plot2D(res_0h[[1]], main = "12h LPS - replicate 1 \nprotein allocations (1% FDR)", 
       fcol = "bandle.allocation.pred.pred")

plot2D(res_0h[[2]], main = "12h LPS - replicate 2 \nsubcellular markers", 
       fcol = "markers")
plot2D(res_0h[[2]], main = "12h LPS - replicate 2 \nprotein allocations (1% FDR)", 
       fcol = "bandle.allocation.pred.pred")

plot(NULL, xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
addLegend(res_0h[[1]], where = "topleft", cex = .8)

## -----------------------------------------------------------------------------
## Remove the markers from the MSnSet
res0hr_unknowns <- unknownMSnSet(res_0h[[1]], fcol = "markers")
res12h_unknowns <- unknownMSnSet(res_12h[[1]], fcol = "markers")

## -----------------------------------------------------------------------------
res1 <- fData(res0hr_unknowns)$bandle.allocation.pred.pred
res2 <- fData(res12h_unknowns)$bandle.allocation.pred.pred

res1_tbl <- table(res1)
res2_tbl <- table(res2)

## ----fig.height=4, fig.width=8------------------------------------------------
par(mfrow = c(1, 2))
barplot(res1_tbl, las = 2, main = "Predicted location: 0hr",
        ylab = "Number of proteins")
barplot(res2_tbl, las = 2, main = "Predicted location: 12hr",
        ylab = "Number of proteins")

## ----allocspost, fig.height=4, fig.width=8------------------------------------
pe1 <- fData(res0hr_unknowns)$bandle.probability
pe2 <- fData(res12h_unknowns)$bandle.probability

par(mfrow = c(1, 2))
boxplot(pe1 ~ res1, las = 2, main = "Posterior: control",
        ylab = "Probability")
boxplot(pe2 ~ res2, las = 2, main = "Posterior: treatment",
        ylab = "Probability")

## -----------------------------------------------------------------------------
res0hr_mixed <- unknownMSnSet(res0hr_unknowns, fcol = "bandle.allocation.pred.pred")
res12hr_mixed <- unknownMSnSet(res12h_unknowns, fcol = "bandle.allocation.pred.pred")

## -----------------------------------------------------------------------------
nrow(res0hr_mixed)
nrow(res12hr_mixed)

## -----------------------------------------------------------------------------
fn1 <- featureNames(res0hr_mixed)
fn2 <- featureNames(res12hr_mixed)

## ----plot_mixed, fig.height=10, fig.width=10----------------------------------
g <- vector("list", 9)
for (i in 1:9) g[[i]] <- mcmc_plot_probs(params_converged, fn1[i], cond = 1)
do.call(grid.arrange, g)

## ----plot_mixed2, fig.height=10, fig.width=10---------------------------------
g <- vector("list", 9)
for (i in 1:9) g[[i]] <- mcmc_plot_probs(params_converged, fn1[i], cond = 2)
do.call(grid.arrange, g)

## -----------------------------------------------------------------------------
head(fData(res0hr_mixed)$bandle.joint)

## ----heatmap_control----------------------------------------------------------
bjoint_0hr_mixed <- fData(res0hr_mixed)$bandle.joint
pheatmap(bjoint_0hr_mixed, cluster_cols = FALSE, color = viridis(n = 25), 
         show_rownames = FALSE, main = "Joint posteriors for unlabelled proteins at 0hr")

## ----heatmap_treatment--------------------------------------------------------
bjoint_12hr_mixed <- fData(res12hr_mixed)$bandle.joint
pheatmap(bjoint_12hr_mixed, cluster_cols = FALSE, color = viridis(n = 25),
         show_rownames = FALSE, main = "Joint posteriors for unlabelled proteins at 12hr")

## -----------------------------------------------------------------------------
dl <- diffLocalisationProb(params_converged)
head(dl)

## ----cutoffres----------------------------------------------------------------
length(which(dl[order(dl, decreasing = TRUE)] > 0.95))

## ----extractdifflocp, fig.height=4, fig.width=6-------------------------------
plot(dl[order(dl, decreasing = TRUE)],
     col = getStockcol()[2], pch = 19, ylab = "Probability",
     xlab = "Rank", main = "Differential localisation rank plot")

## -----------------------------------------------------------------------------
candidates <- names(dl)

## ----alluvial, warning=FALSE, message=FALSE-----------------------------------
msnset_cands <- list(res_0h[[1]][candidates, ], 
                     res_12h[[1]][candidates, ])

## ----dataframeres-------------------------------------------------------------
# construct data.frame
df_cands <- data.frame(
    fData(msnset_cands[[1]])[, c("bandle.differential.localisation", 
                                 "bandle.allocation.pred.pred")],
    fData(msnset_cands[[2]])[, "bandle.allocation.pred.pred"])

colnames(df_cands) <- c("differential.localisation", 
                        "0hr_location", "12h_location")

# order by highest differential localisation estimate
df_cands <- df_cands %>% arrange(desc(differential.localisation))
head(df_cands)

## ----plotres, fig.height=8, fig.width=8---------------------------------------
## set colours for organelles and unknown
cols <- c(getStockcol()[seq(mrkCl)], "grey")
names(cols) <- c(mrkCl, "unknown")

## plot
alluvial <- plotTranslocations(msnset_cands, 
                               fcol = "bandle.allocation.pred.pred", 
                               col = cols)
alluvial + ggtitle("Differential localisations following 12h-LPS stimulation")

## ----tbllocs------------------------------------------------------------------
(tbl <- plotTable(msnset_cands, fcol = "bandle.allocation.pred.pred"))

## ----plotlysos, fig.height=8, fig.width=8-------------------------------------
secretory_prots <- unlist(lapply(msnset_cands, function(z) 
    c(which(fData(z)$bandle.allocation.pred.pred == "Golgi Apparatus"),
      which(fData(z)$bandle.allocation.pred.pred == "Endoplasmic Reticulum"),
      which(fData(z)$bandle.allocation.pred.pred == "Plasma Membrane"),
      which(fData(z)$bandle.allocation.pred.pred == "Lysosome"))))
secretory_prots <- unique(secretory_prots)

msnset_secret <- list(msnset_cands[[1]][secretory_prots, ],
                      msnset_cands[[2]][secretory_prots, ])

secretory_alluvial <- plotTranslocations(msnset_secret, 
                                         fcol = "bandle.allocation.pred.pred", 
                                         col = cols)
secretory_alluvial + ggtitle("Movements of secretory proteins")

## ----plotdfprof---------------------------------------------------------------
head(df_cands)

## ----protprof, fig.height=7, fig.width=8--------------------------------------
par(mfrow = c(2, 1))

## plot lysosomal profiles
lyso <- which(fData(res_0h[[1]])$bandle.allocation.pred.pred == "Lysosome")
plotDist(res_0h[[1]][lyso], pcol = cols["Lysosome"], alpha = 0.04)
matlines(exprs(res_0h[[1]])["B2RUZ4", ], col = cols["Lysosome"], lwd = 3)
title("Protein SMIM1 (B2RUZ4) at 0hr (control)")

## plot plasma membrane profiles
pm <- which(fData(res_12h[[1]])$bandle.allocation.pred.pred == "Plasma Membrane")
plotDist(res_12h[[1]][pm], pcol = cols["Plasma Membrane"], alpha = 0.04)
matlines(exprs(res_12h[[1]])["B2RUZ4", ], col = cols["Plasma Membrane"], lwd = 3)
title("Protein SMIM1 (B2RUZ4) at 12hr-LPS (treatment)")

## ----plotpcacands, fig.height=6, fig.width=9----------------------------------
par(mfrow = c(1, 2))
plot2D(res_0h[[1]], fcol = "bandle.allocation.pred.pred",
       main = "Unstimulated - replicate 1 \n predicted location")
highlightOnPlot(res_0h[[1]], foi = "B2RUZ4")

plot2D(res_12h[[1]], fcol = "bandle.allocation.pred.pred",
       main = "12h-LPS - replicate 1 \n predicted location")
highlightOnPlot(res_12h[[1]], foi = "B2RUZ4")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

