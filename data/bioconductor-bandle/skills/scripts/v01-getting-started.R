# Code example from 'v01-getting-started' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(dpi=40,fig.width=7)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("bandle")

## ----ldpkg, message=FALSE-----------------------------------------------------
library("bandle")

## ----ldpkg2, message=FALSE----------------------------------------------------
library("pheatmap")
library("viridis")
library("dplyr")
library("ggplot2")
library("gridExtra")

## ----loadpkgdat, message=FALSE, warning=FALSE, fig.width=7, fig.height=6------
library("pRolocdata")
data("tan2009r1")

## Let's set the stock colours of the classes to plot to be transparent
setStockcol(NULL)
setStockcol(paste0(getStockcol(), "90")) 

## Plot the data using plot2D from pRoloc
plot2D(tan2009r1,
       main = "An example spatial proteomics datasets", 
       grid = FALSE)
addLegend(tan2009r1, where = "topleft", cex = 0.7, ncol = 2)

## ----simdata, fig.width=8, fig.height=10--------------------------------------
set.seed(1)
tansim <- sim_dynamic(object = tan2009r1,
                      numRep = 6L,
                      numDyn = 100L)

## ----first_rep----------------------------------------------------------------
# To access the first replicate
tansim$lopitrep[[1]]

## ----plotsims-----------------------------------------------------------------
plot_title <- c(paste0("Replicate ", seq(3), " condition", " A"), 
               paste0("Replicate ", seq(3), " condition", " B"))

par(mfrow = c(2, 3))
out <- lapply(seq(tansim$lopitrep), function(z) 
    plot2D(tansim$lopitrep[[z]], grid = FALSE, main = plot_title[z]))

## ----fitgps, fig.height=10, fig.width=8---------------------------------------
par(mfrow = c(4, 3))
gpParams <- lapply(tansim$lopitrep, function(x) 
  fitGPmaternPC(x, hyppar = matrix(c(10, 60, 250), nrow = 1)))

## ----plotgps, fig.height=10, fig.width=8--------------------------------------
par(mfrow = c(4, 3))
plotGPmatern(tansim$lopitrep[[1]], params = gpParams[[1]])

## ----sethyppar----------------------------------------------------------------
K <- length(getMarkerClasses(tansim$lopitrep[[1]], fcol = "markers"))
pc_prior <- matrix(NA, ncol = 3, K)
pc_prior[seq.int(1:K), ] <- matrix(rep(c(10, 60, 250),
                                       each = K), ncol = 3)

## ----runhyppar----------------------------------------------------------------
gpParams <- lapply(tansim$lopitrep,
                   function(x) fitGPmaternPC(x, hyppar = pc_prior))

## ----setweightprior-----------------------------------------------------------
set.seed(1)
dirPrior = diag(rep(1, K)) + matrix(0.001, nrow = K, ncol = K)
predDirPrior <- prior_pred_dir(object = tansim$lopitrep[[1]],
                               dirPrior = dirPrior,
                               q = 15)

## -----------------------------------------------------------------------------
predDirPrior$meannotAlloc

## -----------------------------------------------------------------------------
predDirPrior$tailnotAlloc

## -----------------------------------------------------------------------------
hist(predDirPrior$priornotAlloc, col = getStockcol()[1])

## ----runbandle, message=FALSE, warning=FALSE, error=FALSE, echo = TRUE, results = 'hide'----
## Split the datasets into two separate lists, one for control and one for treatment
control <- tansim$lopitrep[1:3] 
treatment <- tansim$lopitrep[4:6]

## Run bandle
bandleres <- bandle(objectCond1 = control,
                    objectCond2 = treatment,
                    numIter = 100,   # usually 10,000
                    burnin = 5L,    # usually 5,000
                    thin = 1L,      # usually 20
                    gpParams = gpParams,
                    pcPrior = pc_prior,
                    numChains = 3,  # usually >=4
                    dirPrior = dirPrior, 
                    seed = 1)       # set a random seed for reproducibility)

## -----------------------------------------------------------------------------
bandleres

## ----calcGelman---------------------------------------------------------------
calculateGelman(bandleres)

## ----plotoutliers, fig.width=8, fig.height=7----------------------------------
plotOutliers(bandleres)

## -----------------------------------------------------------------------------
bandleres_opt <- bandleres[-2]

## -----------------------------------------------------------------------------
bandleres_opt

## ----processbandle1-----------------------------------------------------------
summaries(bandleres_opt)

## ----processbandle2-----------------------------------------------------------
bandleres_opt <- bandleProcess(bandleres_opt)

## ----processbandle3, results = 'hide'-----------------------------------------
summaries(bandleres_opt)

## ----bandpred-----------------------------------------------------------------
xx <- bandlePredict(control, 
                    treatment, 
                    params = bandleres_opt, 
                    fcol = "markers")
res_control <- xx[[1]]
res_treatment <- xx[[2]]

## ----showlength---------------------------------------------------------------
length(res_control)
length(res_treatment)

## ----viewdata-----------------------------------------------------------------
fvarLabels(res_control[[1]])

## ----fdata, eval=FALSE--------------------------------------------------------
# fData(res_control[[1]])$bandle.probability
# fData(res_control[[1]])$bandle.allocation

## ----setthreshold-------------------------------------------------------------
res_control[[1]] <- getPredictions(res_control[[1]], 
                                   fcol = "bandle.allocation",                   
                                   scol = "bandle.probability",                   
                                   mcol = "markers",                   
                                   t = .99)

res_treatment[[1]] <- getPredictions(res_treatment[[1]], 
                                   fcol = "bandle.allocation",                   
                                   scol = "bandle.probability",                   
                                   mcol = "markers",                   
                                   t = .99)

## -----------------------------------------------------------------------------
## Remove the markers from the MSnSet
res_control_unknowns <- unknownMSnSet(res_control[[1]], fcol = "markers")
res_treated_unknowns <- unknownMSnSet(res_treatment[[1]], fcol = "markers")

## -----------------------------------------------------------------------------
getMarkers(res_control_unknowns, "bandle.allocation.pred")
getMarkers(res_treated_unknowns, "bandle.allocation.pred")

## -----------------------------------------------------------------------------
res1 <- fData(res_control_unknowns)$bandle.allocation.pred
res2 <- fData(res_treated_unknowns)$bandle.allocation.pred

res1_tbl <- table(res1)
res2_tbl <- table(res2)

## ----fig.height=4, fig.width=8------------------------------------------------
par(mfrow = c(1, 2))
barplot(res1_tbl, las = 2, main = "Predicted location: control",
        ylab = "Number of proteins")
barplot(res2_tbl, las = 2, main = "Predicted location: treatment",
        ylab = "Number of proteins")

## ----allocspost, fig.height=4, fig.width=8------------------------------------
pe1 <- fData(res_control_unknowns)$bandle.probability
pe2 <- fData(res_treated_unknowns)$bandle.probability

par(mfrow = c(1, 2))
boxplot(pe1 ~ res1, las = 2, main = "Posterior: control",
        ylab = "Probability")
boxplot(pe2 ~ res2, las = 2, main = "Posterior: treatment",
        ylab = "Probability")

## -----------------------------------------------------------------------------
res1_unlabelled <- unknownMSnSet(res_control_unknowns, 
                                 fcol = "bandle.allocation.pred")
res2_unlabelled <- unknownMSnSet(res_treated_unknowns, 
                                 fcol = "bandle.allocation.pred")

## -----------------------------------------------------------------------------
nrow(res1_unlabelled)
nrow(res2_unlabelled)

## -----------------------------------------------------------------------------
fn1 <- featureNames(res1_unlabelled)
fn2 <- featureNames(res2_unlabelled)

## ----fig.height=10, fig.width=10----------------------------------------------
g <- vector("list", 9)
for (i in 1:9) g[[i]] <- mcmc_plot_probs(bandleres_opt, fn1[i], cond = 1)
do.call(grid.arrange, g)

## ----fig.height=10, fig.width=10----------------------------------------------
g <- vector("list", 9)
for (i in 1:9) g[[i]] <- mcmc_plot_probs(bandleres_opt, fn1[i], cond = 2)
do.call(grid.arrange, g)

## -----------------------------------------------------------------------------
grid.arrange(
  mcmc_plot_probs(bandleres_opt, fname = "Q24253", cond = 1) +
  ggtitle("Distribution of Q24253 in control"),
  mcmc_plot_probs(bandleres_opt, fname = "Q24253", cond = 2) +
    ggtitle("Distribution of Q24253 in treated")
)

## -----------------------------------------------------------------------------
fData(res_control_unknowns)$bandle.joint["Q24253", ]

## ----heatmap_control----------------------------------------------------------
bjoint_control <- fData(res_control_unknowns)$bandle.joint
pheatmap(bjoint_control, cluster_cols = FALSE, color = viridis(n = 25), 
         show_rownames = FALSE, main = "Joint posteriors in the control")

## ----heatmap_treatment--------------------------------------------------------
bjoint_treated <- fData(res_treated_unknowns)$bandle.joint
pheatmap(bjoint_treated, cluster_cols = FALSE, color = viridis(n = 25),
         show_rownames = FALSE, main = "Joint posteriors in the treated")

## -----------------------------------------------------------------------------
dl <- diffLocalisationProb(bandleres_opt)
head(dl)

## ----numtransloc--------------------------------------------------------------
dl <- fData(res_control_unknowns)$bandle.differential.localisation
names(dl) <- featureNames(res_control_unknowns)
head(dl)

## ----extractdiffloc-----------------------------------------------------------
plot(dl[order(dl, decreasing = TRUE)],
     col = getStockcol()[3], pch = 19, ylab = "Probability",
     xlab = "Rank", main = "Differential localisation rank plot")

## -----------------------------------------------------------------------------
## Subset MSnSets for DL proteins > 0.99
ind <- which(dl > 0.99)
res_control_dl0.99 <- res_control_unknowns[ind, ]
res_treated_dl0.99 <- res_treated_unknowns[ind, ]

## Get DL results
dl0.99 <- fData(res_control_dl0.99)$bandle.differential.localisation
(names(dl0.99) <- featureNames(res_control_dl0.99))

## ----alluvial, warning=FALSE, message=FALSE, fig.height=6, fig.width=7--------
## Create an list of the two MSnSets
dl_msnsets <- list(res_control_dl0.99, res_treated_dl0.99)

## Set colours for organelles and unknown
mrkCl <- getMarkerClasses(res_control[[1]], fcol = "markers")
dl_cols <- c(getStockcol()[seq(mrkCl)], "grey")
names(dl_cols) <- c(mrkCl, "unknown")

## Now plot
plotTranslocations(dl_msnsets, 
                   fcol = "bandle.allocation.pred", 
                   col = dl_cols)

## ----chord, warning=FALSE, message=FALSE, fig.height=7, fig.width=7-----------
plotTranslocations(dl_msnsets, 
                   fcol = "bandle.allocation.pred", 
                   col = dl_cols,
                   type = "chord")

## -----------------------------------------------------------------------------
plotTable(dl_msnsets, fcol = "bandle.allocation.pred")

## ----diffloc_boot-------------------------------------------------------------
set.seed(1)
boot_t <- bootstrapdiffLocprob(params = bandleres, top = 100,
                               Bootsample = 5000, decreasing = TRUE)

boxplot(t(boot_t), col = getStockcol()[5],
        las = 2, ylab = "Probability", ylim = c(0, 1),
        main = "Differential localisation \nprobability plot (top 100 proteins)")

## ----diffloc_binom------------------------------------------------------------
bin_t <- binomialDiffLocProb(params = bandleres, top = 100,
                             nsample = 5000, decreasing = TRUE)

boxplot(t(bin_t), col = getStockcol()[5],
        las = 2, ylab = "Probability", ylim = c(0, 1),
        main = "Differential localisation \nprobability plot (top 100 proteins)")

## ----get_pe-------------------------------------------------------------------
# more robust estimate of probabilities
dprobs <- rowMeans(bin_t)

# compute cumulative error, there is not really a false discovery rate in
# Bayesian statistics but you can look at the cumulative error rate
ce <- cumsum(1  - dprobs)

# you could threshold on the interval and this will reduce the number of
# differential localisations
qt <- apply(bin_t, 1, function(x) quantile(x, .025))

## -----------------------------------------------------------------------------
EFDR(dl, threshold = 0.95)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

