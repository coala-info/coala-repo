# Code example from 'dream' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"------------------------------------------------------------
knitr::opts_chunk$set(
  tidy = FALSE, cache = TRUE,
  dev = "png",
  package.startup.message = FALSE,
  message = FALSE, error = FALSE, warning = TRUE
)
options(width = 100)

## ----kable, echo=FALSE, message=FALSE, warnings=FALSE, results='asis'-----------------------------
library("pander")
tab <- rbind(
  c("precision weights to model measurement error in RNA-seq counts", "limma/voom", "@Law2014"),
  c("ability to model multiple random effects", "lme4", "@Bates2015"),
  c("random effects estimated separately for each gene", "variancePartition", "@hoffman2016"),
  c("hypothesis testing for fixed effects in linear mixed models", "lmerTest", "Kuznetsova, et al. -@kuznetsova2017"),
  c("small sample size hypothesis test", "pbkrtest", "Halekoh, et al. -@halekoh2014"),
  # c('emprical Bayes moderated t-test', 'limma/eBayes', '@smyth2004'),
  c("", "", "")
)
colnames(tab) <- c("Model property", "Package", "Reference")

panderOptions("table.split.table", Inf)
panderOptions("table.alignment.default", "left")

pander(tab, style = "rmarkdown")

## ----preprocess, eval=TRUE, results='hide'--------------------------------------------------------
library("variancePartition")
library("edgeR")
library("BiocParallel")
data(varPartDEdata)

# filter genes by number of counts
isexpr <- rowSums(cpm(countMatrix) > 0.1) >= 5

# Standard usage of limma/voom
dge <- DGEList(countMatrix[isexpr, ])
dge <- calcNormFactors(dge)

# make this vignette faster by analyzing a subset of genes
dge <- dge[1:1000, ]

## ----dupCor, eval=TRUE----------------------------------------------------------------------------
# apply duplicateCorrelation is two rounds
design <- model.matrix(~Disease, metadata)
vobj_tmp <- voom(dge, design, plot = FALSE)
dupcor <- duplicateCorrelation(vobj_tmp, design, block = metadata$Individual)

# run voom considering the duplicateCorrelation results
# in order to compute more accurate precision weights
# Otherwise, use the results from the first voom run
vobj <- voom(dge, design, plot = FALSE, block = metadata$Individual, correlation = dupcor$consensus)

# Estimate linear mixed model with a single variance component
# Fit the model for each gene,
dupcor <- duplicateCorrelation(vobj, design, block = metadata$Individual)

# But this step uses only the genome-wide average for the random effect
fitDupCor <- lmFit(vobj, design, block = metadata$Individual, correlation = dupcor$consensus)

# Fit Empirical Bayes for moderated t-statistics
fitDupCor <- eBayes(fitDupCor)

## ----lmm, eval=TRUE, message=FALSE, fig.height=2, results='hide'----------------------------------
# Specify parallel processing parameters
# this is used implicitly by dream() to run in parallel
param <- SnowParam(4, "SOCK", progressbar = TRUE)

# The variable to be tested must be a fixed effect
form <- ~ Disease + (1 | Individual)

# estimate weights using linear mixed model of dream
vobjDream <- voomWithDreamWeights(dge, form, metadata, BPPARAM = param)

# Fit the dream model on each gene
# For the hypothesis testing, by default,
# dream() uses the KR method for <= 20 samples,
# otherwise it uses the Satterthwaite approximation
fitmm <- dream(vobjDream, form, metadata)
fitmm <- eBayes(fitmm)

## ----lmm.print------------------------------------------------------------------------------------
# Examine design matrix
head(fitmm$design, 3)

# Get results of hypothesis test on coefficients of interest
topTable(fitmm, coef = "Disease1", number = 3)

## ----contrast, eval=TRUE, fig.width=8, fig.height=3-----------------------------------------------
form <- ~ 0 + DiseaseSubtype + Sex + (1 | Individual)

L <- makeContrastsDream(form, metadata,
  contrasts = c(
    compare2_1 = "DiseaseSubtype2 - DiseaseSubtype1",
    compare1_0 = "DiseaseSubtype1 - DiseaseSubtype0"
  )
)

# Visualize contrast matrix
plotContrasts(L)

## ----fit.contrast---------------------------------------------------------------------------------
# fit dream model with contrasts
fit <- dream(vobjDream, form, metadata, L)
fit <- eBayes(fit)

# get names of available coefficients and contrasts for testing
colnames(fit)

# extract results from first contrast
topTable(fit, coef = "compare2_1", number = 3)

## ----maual.contrasts, fig.width=8, fig.height=4---------------------------------------------------
L2 <- makeContrastsDream(form, metadata,
  contrasts =
    c(Test1 = "DiseaseSubtype0 - (DiseaseSubtype1 + DiseaseSubtype2)/2")
)

plotContrasts(L2)

# fit dream model to evaluate contrasts
fit <- dream(vobjDream[1:10, ], form, metadata, L = L2)
fit <- eBayes(fit)

topTable(fit, coef = "Test1", number = 3)

## ----joint.test, fig.height=3, message=FALSE------------------------------------------------------
# extract results from first contrast
topTable(fit, coef = c("DiseaseSubtype2", "DiseaseSubtype1"), number = 3)

## ----kr, eval=FALSE-------------------------------------------------------------------------------
# fitmmKR <- dream(vobjDream, form, metadata, ddf = "Kenward-Roger")
# fitmmKR <- eBayes(fitmmKR)

## ----vp-------------------------------------------------------------------------------------------
# Note: this could be run with either vobj from voom()
# or vobjDream from voomWithDreamWeights()
# The resuylts are similar
form <- ~ (1 | Individual) + (1 | Disease)
vp <- fitExtractVarPartModel(vobj, form, metadata)

plotVarPart(sortCols(vp))

## ----define---------------------------------------------------------------------------------------
# Compare p-values and make plot
p1 <- topTable(fitDupCor, coef = "Disease1", number = Inf, sort.by = "none")$P.Value
p2 <- topTable(fitmm, number = Inf, sort.by = "none")$P.Value

plotCompareP(p1, p2, vp$Individual, dupcor$consensus)

## ----parallel, eval=FALSE-------------------------------------------------------------------------
# # Request 4 cores, and enable the progress bar
# # This is the ideal for Linux, OS X and Windows
# param <- SnowParam(4, "SOCK", progressbar = TRUE)
# fitmm <- dream(vobjDream, form, metadata, BPPARAM = param)

## ----sessionInfo, echo=FALSE----------------------------------------------------------------------
sessionInfo()

