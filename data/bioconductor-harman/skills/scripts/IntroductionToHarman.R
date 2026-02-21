# Code example from 'IntroductionToHarman' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo = FALSE, results = 'asis'-------------------------
BiocStyle::markdown()

## ----echo=FALSE, warning=FALSE------------------------------------------------
library(knitr)
library(RColorBrewer)

## -----------------------------------------------------------------------------
library(Harman)
library(HarmanData)
data(OLF)

## -----------------------------------------------------------------------------
table(olf.info)

## -----------------------------------------------------------------------------
olf.info[1:7,]

## -----------------------------------------------------------------------------
head(olf.data)

## ----runharman----------------------------------------------------------------
olf.harman <- harman(olf.data, expt=olf.info$Treatment, batch=olf.info$Batch, limit=0.95)

## -----------------------------------------------------------------------------
str(olf.harman)

## ----fig.height=4, fig.width=7------------------------------------------------
plot(olf.harman)

## ----fig.height=5, fig.width=5------------------------------------------------
arrowPlot(olf.harman, main='Arrowplot of correction')

## -----------------------------------------------------------------------------
summary(olf.harman)

## ----echo=FALSE---------------------------------------------------------------
kable(olf.harman$stats)

## ----fig.height=5, fig.width=5------------------------------------------------
arrowPlot(olf.harman, 1, 8)

## ----fig.height=5, fig.width=5------------------------------------------------
arrowPlot(olf.harman, 8, 9)

## ----fig.height=4, fig.width=7------------------------------------------------
par(mfrow=c(1,2))
pcaPlot(olf.harman, colBy='batch', pchBy='expt', main='Col by Batch')
pcaPlot(olf.harman, colBy='expt', pchBy='batch', main='Col by Expt')

## -----------------------------------------------------------------------------
olf.data.corrected <- reconstructData(olf.harman)

## -----------------------------------------------------------------------------
olf.data.remade <- reconstructData(olf.harman, this='original')
all.equal(as.matrix(olf.data), olf.data.remade)

## ----fig.height=9, fig.width=7------------------------------------------------
olf.data.diff <- abs(as.matrix(olf.data) - olf.data.corrected)

diff_rowvar <- apply(olf.data.diff, 1, var)
by_rowvar <- order(diff_rowvar)

par(mfrow=c(1,1))
image(x=1:ncol(olf.data.diff),
      y=1:nrow(olf.data.diff),
      z=t(olf.data.diff[by_rowvar, ]),
      xlab='Sample',
      ylab='Probeset',
      main='Harman probe adjustments (ordered by variance)',
      cex.main=0.7,
      col=brewer.pal(9, 'Reds'))

## ----cleanup1, echo=FALSE-----------------------------------------------------
rm(list=ls()[grep("olf", ls())])

## -----------------------------------------------------------------------------
require(Harman)
require(HarmanData)
data(IMR90)

## ----echo=FALSE---------------------------------------------------------------
kable(imr90.info)

## -----------------------------------------------------------------------------
table(expt=imr90.info$Treatment, batch=imr90.info$Batch)

## ----fig.height=4, fig.width=7------------------------------------------------
par(mfrow=c(1,2), mar=c(4, 4, 4, 2) + 0.1)
imr90.pca <- prcomp(t(imr90.data), scale. = TRUE)
prcompPlot(imr90.pca, pc_x=1, pc_y=2, colFactor=imr90.info$Batch,
           pchFactor=imr90.info$Treatment, main='IMR90, PC1 v PC2')
prcompPlot(imr90.pca, pc_x=1, pc_y=3, colFactor=imr90.info$Batch,
           pchFactor=imr90.info$Treatment, main='IMR90, PC1 v PC3')

## -----------------------------------------------------------------------------
imr90.hm <- harman(as.matrix(imr90.data), expt=imr90.info$Treatment,
                   batch=imr90.info$Batch)

## ----echo=FALSE---------------------------------------------------------------
kable(imr90.hm$stats)

## ----fig.height=4, fig.width=7------------------------------------------------
plot(imr90.hm, pc_x=1, pc_y=2)
plot(imr90.hm, pc_x=1, pc_y=3)

## ----fig.height=5, fig.width=5------------------------------------------------
arrowPlot(imr90.hm, pc_x=1, pc_y=3)

## ----fig.height=4, fig.width=7------------------------------------------------
imr90.hm <- harman(as.matrix(imr90.data), expt=imr90.info$Treatment,
                   batch=imr90.info$Batch, limit=0.9)
plot(imr90.hm, pc_x=1, pc_y=3)

## ----echo=FALSE---------------------------------------------------------------
kable(imr90.hm$stats)

## ----fig.height=4, fig.width=7------------------------------------------------
imr90.data.corrected <- reconstructData(imr90.hm)
par(mfrow=c(1,2))
prcompPlot(imr90.data, 1, 3, colFactor=imr90.hm$factors$batch, cex=1.5, main='PCA, Original')
prcompPlot(imr90.data.corrected, 1, 3, colFactor=imr90.hm$factors$batch, cex=1.5, main='PCA, Corrected')

## ----cleanup2, echo=FALSE-----------------------------------------------------
rm(list=ls()[grep("imr90", ls())])

## ----affydata, warning=FALSE, message=FALSE, comment=FALSE--------------------
library(affydata, quietly = TRUE, warn.conflicts = FALSE)
data(Dilution)
Dilution.log <- Dilution
intensity(Dilution.log) <- log(intensity(Dilution))
cols <- brewer.pal(nrow(pData(Dilution)), 'Paired')

## ----echo=FALSE---------------------------------------------------------------
kable(pData(Dilution))

## ----fig.height=4, fig.width=4------------------------------------------------
boxplot(Dilution, col=cols)

## ----normalize, fig.height=7, fig.width=9-------------------------------------
Dilution.loess <- normalize(Dilution.log, method="loess")
Dilution.qnt <- normalize(Dilution.log, method="quantiles")

# define a quick PCA and plot function
pca <- function(exprs, pc_x=1, pc_y=2, cols, ...) {
  pca <- prcomp(t(exprs), retx=TRUE, center=TRUE)
  if(is.factor(cols)) {
    factor_names <- levels(cols)
    num_levels <- length(factor_names)
    palette <- rainbow(num_levels)
    mycols <- palette[cols]  
  } else {
    mycols <- cols
  }
  plot(pca$x[, pc_x], pca$x[, pc_y],
       xlab=paste('PC', pc_x, sep=''),
       ylab=paste('PC', pc_y, sep=''),
       col=mycols, ...)
  if(is.factor(cols)) {
    legend(x=min(pca$x[, pc_x]), y=max(pca$x[, pc_y]),
           legend=factor_names, fill=palette, cex=0.5)
  }
}

par(mfrow=c(1,2), mar=c(4, 4, 4, 2) + 0.1)
boxplot(Dilution.loess, col=cols, main='Loess')
boxplot(Dilution.qnt, col=cols, main='Quantile')
pca(exprs(Dilution.loess), cols=cols, cex=1.5, pch=16, main='PCA Loess')
pca(exprs(Dilution.qnt), cols=cols, cex=1.5, pch=16, main='PCA Quantile')

## ----affydata_harman1---------------------------------------------------------
library(Harman)
loess.hm <- harman(exprs(Dilution.loess),
                   expt=pData(Dilution.loess)$liver,
                   batch=pData(Dilution.loess)$scanner)
qnt.hm <- harman(exprs(Dilution.qnt),
                 expt=pData(Dilution.qnt)$liver,
                 batch=pData(Dilution.qnt)$scanner)

## ----echo=FALSE, fig.align='left'---------------------------------------------
kable(loess.hm$stats)

## ----echo=FALSE, fig.align='left'---------------------------------------------
kable(qnt.hm$stats)

## ----affydata_harman2---------------------------------------------------------
loess.hm <- harman(exprs(Dilution.loess),
                   expt=pData(Dilution.loess)$liver,
                   batch=pData(Dilution.loess)$scanner,
                   limit=0.75)
qnt.hm <- harman(exprs(Dilution.qnt),
                 expt=pData(Dilution.qnt)$liver,
                 batch=pData(Dilution.qnt)$scanner,
                 limit=0.75)

## ----echo=FALSE---------------------------------------------------------------
kable(loess.hm$stats)

## ----echo=FALSE---------------------------------------------------------------
kable(qnt.hm$stats)

## ----fig.height=4, fig.width=7------------------------------------------------
par(mfrow=c(2,2), mar=c(4, 4, 4, 2) + 0.1)
plot(loess.hm, 1, 2, pch=17, col=cols)
plot(qnt.hm, 1, 2, pch=17, col=cols)

## ----affydata_reconstruct-----------------------------------------------------
Dilution.loess.hm <- Dilution.loess
Dilution.qnt.hm <- Dilution.qnt
exprs(Dilution.loess.hm) <- reconstructData(loess.hm)
exprs(Dilution.qnt.hm) <- reconstructData(qnt.hm)

## -----------------------------------------------------------------------------
detach('package:affydata')

## ----message=FALSE, warning=FALSE---------------------------------------------
library(bladderbatch)
library(Harman)
# This loads an ExpressionSet object called bladderEset
data(bladderdata)
bladderEset

## ----echo=FALSE---------------------------------------------------------------
kable(pData(bladderEset))

## -----------------------------------------------------------------------------
table(batch=pData(bladderEset)$batch, expt=pData(bladderEset)$outcome)

## ----fig.height=4, fig.width=7------------------------------------------------
par(mfrow=c(1,2))
prcompPlot(exprs(bladderEset), colFactor=pData(bladderEset)$batch,
    pchFactor=pData(bladderEset)$outcome, main='Col by Batch')
prcompPlot(exprs(bladderEset), colFactor=pData(bladderEset)$outcome,
    pchFactor=pData(bladderEset)$batch, main='Col by Expt')

## ----cache=FALSE--------------------------------------------------------------
expt <- pData(bladderEset)$outcome
batch <- pData(bladderEset)$batch
bladder_harman <- harman(exprs(bladderEset), expt=expt, batch=batch)
sum(bladder_harman$stats$correction < 1)

## -----------------------------------------------------------------------------
summary(bladder_harman)

## ----fig.height=4, fig.width=7------------------------------------------------
par(mfrow=c(1,1))
plot(bladder_harman)

## ----fig.height=4, fig.width=7------------------------------------------------
plot(bladder_harman, 1, 3)

## ----fig.height=5, fig.width=5------------------------------------------------
arrowPlot(bladder_harman, 1, 3)

## -----------------------------------------------------------------------------
CorrectedBladderEset <- bladderEset
exprs(CorrectedBladderEset) <- reconstructData(bladder_harman)
comment(bladderEset) <- 'Original'
comment(CorrectedBladderEset) <- 'Corrected'

## ----message=FALSE, warning=FALSE---------------------------------------------
library(limma, quietly=TRUE)
design <- model.matrix(~0 + expt)
colnames(design) <- c("Biopsy", "mTCC", "Normal", "sTCC", "sTCCwCIS")
contrast_matrix <- makeContrasts(sTCCwCIS - sTCC, sTCCwCIS - Normal,
                                 Biopsy - Normal,
                                 levels=design)

fit <- lmFit(exprs(bladderEset), design)
fit2 <- contrasts.fit(fit, contrast_matrix)
fit2 <- eBayes(fit2)
summary(decideTests(fit2))

## -----------------------------------------------------------------------------
fit_hm <- lmFit(exprs(CorrectedBladderEset), design)
fit2_hm <- contrasts.fit(fit_hm, contrast_matrix)
fit2_hm <- eBayes(fit2_hm)
summary(decideTests(fit2_hm))

## ----cleanup_bladderbatch, echo=FALSE-----------------------------------------
rm(list=ls()[!grepl("^pca$", ls())])
detach('package:bladderbatch')

## ----message=FALSE, warning=FALSE---------------------------------------------
library(minfi, quietly = TRUE)
logit2
ilogit2
ilogit2(Inf)
ilogit2(-Inf)

## -----------------------------------------------------------------------------
betas <- seq(0, 1, by=0.05)
betas
newBetas <- shiftBetas(betas, shiftBy=1e-4)
newBetas
range(betas)
range(newBetas)
logit2(betas)
logit2(newBetas)

## ----loadminfidata, message=FALSE, warning=FALSE------------------------------
library(minfiData, quietly = TRUE)
baseDir <- system.file("extdata", package="minfiData")
targets <- read.metharray.sheet(baseDir)

## ----read450K-----------------------------------------------------------------
rgSet <- read.metharray.exp(targets=targets)
mSetSw <- preprocessSWAN(rgSet)

mSet <- preprocessIllumina(rgSet, bg.correct=TRUE, normalize="controls",
                           reference=2)
detP <- detectionP(rgSet)
keep <- rowSums(detP < 0.01) == ncol(rgSet)
mSetIl <- mSet[keep,]
mSetSw <- mSetSw[keep,]

## ----echo=FALSE---------------------------------------------------------------
kable(pData(mSetSw)[,c('Sample_Group', 'person', 'sex', 'status', 'Array',
                       'Slide')])

## ----mdsplots, fig.height=5, fig.width=7--------------------------------------
par(mfrow=c(1, 1))
cancer_by_gender_factor <- as.factor(paste(pData(mSetSw)$sex,
                                           pData(mSetSw)$status)
                                     )

mdsPlot(mSetSw, sampGroups=cancer_by_gender_factor, pch=16)
mdsPlot(mSetSw, sampGroups=as.factor(pData(mSet)$Slide), pch=16)

## -----------------------------------------------------------------------------
table(gender=pData(mSetSw)$sex, slide=pData(mSetSw)$Slide)

## -----------------------------------------------------------------------------
cancer_by_gender_factor <- as.factor(paste(pData(mSetSw)$sex,
                                           pData(mSetSw)$status)
                                     )
table(expt=cancer_by_gender_factor, batch=pData(mSetSw)$Slide)

## -----------------------------------------------------------------------------
table(expt=pData(mSetSw)$status, batch=pData(mSetSw)$Slide)

## ----shift, fig.height=7, fig.width=7-----------------------------------------
par(mfrow=c(2,2))
library(lumi, quietly = TRUE)
shifted_betas <- shiftBetas(betas=getBeta(mSetIl), shiftBy=1e-7)
shifted_ms <- beta2m(shifted_betas)  # same as logit2() from package minfi
plot(density(shifted_ms, 0.05), main="Shifted M-values, shiftBy = 1e-7",
     cex.main=0.7)

shifted_betas <- shiftBetas(betas=getBeta(mSetIl), shiftBy=1e-4)
shifted_ms <- beta2m(shifted_betas)  # same as logit2() from package minfi
plot(density(shifted_ms, 0.05), main="Shifted M-values, shiftBy = 1e-4",
     cex.main=0.7)

plot(density(beta2m(getBeta(mSetSw)), 0.05), main="SWAN normalised M-values",
     cex.main=0.7)

## ----fig.height=4, fig.width=7------------------------------------------------
par(mfrow=c(1,2))
plot(density(shifted_betas, 0.1), main="Beta-values, shiftBy = 1e-4",
     cex.main=0.7)
plot(density(shifted_ms, 0.1), main="M-values, shiftBy = 1e-4",
     cex.main=0.7)

## ----fig.height=4, fig.width=7------------------------------------------------
par(mfrow=c(1,2))
plot(density(shifted_ms, 0.1),
     main="GenomeStudio-like M-values, shiftBy = 1e-4", cex.main=0.7)
plot(density(getM(mSetSw), 0.1), main="SWAN M-values", cex.main=0.7)

## ----fig.height=4, fig.width=7------------------------------------------------
methHarman <- harman(getM(mSetSw), expt=pData(mSetSw)$status,
                     batch=pData(mSetSw)$Slide, limit=0.65)
summary(methHarman)
plot(methHarman, 2, 5)

## -----------------------------------------------------------------------------
ms_hm <- reconstructData(methHarman)
betas_hm <- m2beta(ms_hm)

## -----------------------------------------------------------------------------
library(HarmanData)
data(Infinium5)
lvr.harman[1:2, ]
md.harman[1:2, ]

## -----------------------------------------------------------------------------
betas_sml <- getBeta(mSetSw)[1:1000, ]
betas_hm_sml <- betas_hm[1:1000, ]

myK <- discoverClusteredMethylation(betas_sml, min_cluster_size = 3, cores=2, printInfo = TRUE)
mykClust = kClusterMethylation(betas_sml, row_ks=myK, cores=2)
res <- clusterStats(pre_betas=betas_sml,
                   post_betas=betas_hm_sml,
                   kClusters = mykClust)
res[1:2, ]

## -----------------------------------------------------------------------------
library(HarmanData)
data(episcope)
bad_batches <- c(1, 5, 9, 17, 25)
is_bad_sample <- episcope$pd$array_num %in% bad_batches
myK <- discoverClusteredMethylation(episcope$original[, !is_bad_sample])
mykClust <- kClusterMethylation(episcope$original, row_ks=myK)
res <- clusterStats(pre_betas=episcope$original,
                   post_betas=episcope$harman,
                   kClusters = mykClust)
res[1:2, ]

## ----clust_plot, fig.height=7, fig.width=7------------------------------------
slide_cols <- rep(brewer.pal(9, "Set1"), times=5)[as.factor(episcope$pd$array_num)]
myplot <- function(probe) {
  plot(episcope$original[probe, ],
       main=paste(probe, ". Pre-var: ", round(res[probe, "pre_withinvar"], 5), sep=""),
       xlab="", ylab="Beta", cex=0.7, cex.main=0.9, ylim=c(0, 1), col=slide_cols)
  plot(episcope$harman[probe, ],
       main=paste(probe, ". Post-var: ", round(res[probe, "post_withinvar"], 5), ", LVR: ", round(res[probe, "log2_var_ratio"], 2), sep=""),
       xlab="", ylab="Beta", cex=0.7, cex.main=0.9, ylim=c(0, 1), col=slide_cols)
}
par(mfrow=c(2,2))
myplot("cg04294190")
myplot("cg25465065")

## -----------------------------------------------------------------------------
# Erroneously corrected
res$probe_id[res$log2_var_ratio > log2(1.5) & res$meandiffs > 0.01]
# Batch-effect susceptible
res$probe_id[res$log2_var_ratio < log2(1/1.5) & res$meandiffs > 0.01]

## -----------------------------------------------------------------------------
is_epic <- grepl("BodyFatness|NOVI|URECA", colnames(lvr.harman))
epic_lvr <- na.omit(lvr.harman[, is_epic])
epic_md <- na.omit(md.harman[, is_epic])

sum_batchy_lvr <- apply(epic_lvr, 1, function(p) sum(p < log2(1/1.5)))
sum_geno_lvr <- apply(epic_lvr, 1, function(p) sum(p > log2(1.5)))
sum_md <- apply(epic_md, 1, function(p) sum(p > 0.01))

table(sum_batchy_lvr & sum_md)
table(sum_geno_lvr & sum_md)

## ----limma--------------------------------------------------------------------
library(limma)

group <- factor(pData(mSetSw)$status, levels=c("normal", "cancer"))
id <- factor(pData(mSetSw)$person)
design <- model.matrix(~id + group)
design

## ----fit----------------------------------------------------------------------
fit_hm <- lmFit(ms_hm, design)
fit_hm <- eBayes(fit_hm)

fit <- lmFit(getM(mSetSw), design)
fit <- eBayes(fit)

## ----limma_output-------------------------------------------------------------
summary_fit_hm <- summary(decideTests(fit_hm))
summary_fit <- summary(decideTests(fit))
summary_fit_hm
summary_fit

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
rm(list=ls()[!grepl("^pca$", ls())])
#detach('package:minfiData', force = TRUE)
#detach('package:lumi', force = TRUE)
#detach('package:minfi', force = TRUE)
#detach('package:IlluminaHumanMethylation450kanno.ilmn12.hg19', force = TRUE)

## ----msms, message=FALSE, warning=FALSE---------------------------------------
# Call dependencies
library(msmsEDA)
library(Harman)

data(msms.dataset)
msms.dataset

## ----msms_pp------------------------------------------------------------------
# Preprocess to remove rows which are all 0 and replace NA values with 0.
msms_pp <- pp.msms.data(msms.dataset)

## ----echo=FALSE---------------------------------------------------------------
kable(pData(msms_pp))

## -----------------------------------------------------------------------------
# Create experimental and batch variables
expt <- pData(msms_pp)$treat
batch <- pData(msms_pp)$batch
table(expt, batch)

## ----msms_harman--------------------------------------------------------------
# Log2 transform data, add 1 to avoid infinite values
log_ms_exprs <- log(exprs(msms_pp) + 1, 2)

# Correct data with Harman
hm <- harman(log_ms_exprs, expt=expt, batch=batch)
summary(hm)

## ----fig.height=4, fig.width=7------------------------------------------------
plot(hm)

## -----------------------------------------------------------------------------
# Reconstruct data and convert from Log2, removing 1 as we added it before.
log_ms_exprs_hm <- reconstructData(hm)
ms_exprs_hm <- 2^log_ms_exprs_hm - 1

# Place corrected data into a new 'MSnSet' instance
msms_pp_hm <- msms_pp
exprs(msms_pp_hm) <- ms_exprs_hm

## ----echo=FALSE---------------------------------------------------------------
rm(list=ls()[!grepl("^pca$", ls())])
detach('package:msmsEDA')

## -----------------------------------------------------------------------------
table(imr90.info)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(HarmanData)
library(sva)

modcombat <- model.matrix(~1, data=imr90.info)
imr90.data.cb <- ComBat(dat=as.matrix(imr90.data), batch=imr90.info$Batch, mod=modcombat,
                        par.prior=TRUE, prior.plots=FALSE)

imr90.hr <- harman(imr90.data, expt = imr90.info$Treatment, batch = imr90.info$Batch)
imr90.data.hr <- reconstructData(imr90.hr)

prcompPlot(imr90.data, pc_x = 1, pc_y = 3,
           colFactor = imr90.info$Batch,
           pchFactor = imr90.info$Treatment,
           main='PC1 versus PC3')

arrowPlot(imr90.hr, pc_x = 1, pc_y = 3, main='PC1 versus PC3')

## -----------------------------------------------------------------------------
library(RColorBrewer)

diffMap <- function(a, b, feature_order=1:nrow(a), batch, ...) {

  image(t(abs(a[feature_order, ] - b[feature_order, ])),
      col = brewer.pal(9, "Greys"),
      xaxt='n',
      yaxt='n',
      xlab='Batch',
      ylab='Ordered feature',
      ...)
  axis(1, at=seq(0, 1, length.out=length(batch)), labels=batch)
}

## ----fig.height=7, fig.width=7------------------------------------------------

probe_diffs_hr <- order(rowSums(abs(as.matrix(imr90.data - imr90.data.hr))))
probe_diffs_cb <- order(rowSums(abs(as.matrix(imr90.data - imr90.data.cb))))

diffMap(a=imr90.data, b=imr90.data.hr, feature_order=probe_diffs_hr,
        batch=imr90.info$Batch, main='Original - Harman')

## ----fig.height=7, fig.width=7------------------------------------------------
diffMap(a=imr90.data, b=imr90.data.cb, feature_order=probe_diffs_hr,
        batch=imr90.info$Batch, main='Original - ComBat')

## ----fig.height=7, fig.width=7------------------------------------------------
diffMap(a=imr90.data.hr, b=imr90.data.cb, feature_order=probe_diffs_hr,
        batch=imr90.info$Batch, main='Harman - ComBat')

