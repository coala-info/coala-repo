# Code example from 'divergence' vignette. See references/ for full tutorial.

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------


## ----echo=TRUE----------------------------------------------------------------

# load divergence package
library(divergence)

# baseline cohort
mat.base = breastTCGA_Mat[, which(breastTCGA_Group == "NORMAL")]
# make SummarizedExperiment
seMat.base = SummarizedExperiment(assays=list(data=mat.base))

# data conort
mat.data = breastTCGA_Mat[, which(breastTCGA_Group == "TUMOR")]
# make SummarizedExperiment
seMat = SummarizedExperiment(assays=list(data=mat.data))


## ----echo=TRUE----------------------------------------------------------------

# convert normal data to quantiles
assays(seMat.base)$quantile = computeQuantileMatrix(seMat.base)
# view
assays(seMat.base)$quantile[1:5, 1:4]

# convert tumor data to quantiles
assays(seMat)$quantile = computeQuantileMatrix(seMat)
# view
assays(seMat)$quantile[1:5, 1:4]


## ----echo=TRUE----------------------------------------------------------------

baseline1 = computeUnivariateSupport(
  seMat=seMat.base, 
  gamma=0.1, 
  beta=0.99, 
  parallel=FALSE
)


## ----echo=TRUE----------------------------------------------------------------

head(baseline1$Ranges)

baseline1$Support[1:5, 1:4]

baseline1$alpha


## ----echo=TRUE----------------------------------------------------------------

baseline2 = findUnivariateGammaWithSupport(
  seMat=seMat.base, 
  gamma=1:9/10, 
  beta=0.9, 
  alpha=0.005,
  parallel=FALSE
)


## ----echo=TRUE----------------------------------------------------------------

# selected gamma
baseline2$gamma

# alpha value: i.e. number of divergent features per sample in the baseliine cohort
baseline2$alpha

# does the selected gamma meet the alpha threshold required by the user?
baseline2$optimal

# view the alpha values obtained for each of the gamma values searched through
baseline2$alpha_space


## ----echo=TRUE----------------------------------------------------------------

head(baseline2$Ranges)


## ----echo=TRUE----------------------------------------------------------------

assays(seMat)$div = computeUnivariateTernaryMatrix(
  seMat = seMat,
  Baseline = baseline2
)

assays(seMat)$div[1:5, 1:4]


## ----echo=TRUE----------------------------------------------------------------

div.2 = computeUnivariateDigitization(
  seMat = seMat,
  seMat.base = seMat.base,
  computeQuantiles = TRUE,
  gamma = 1:9/10,
  beta = 0.9,
  alpha = 0.01, 
  parallel = FALSE
)

# digitized data matrix
dim(div.2$Mat.div)
div.2$Mat.div[1:5, 1:4]

# digitized baseline matrix
dim(div.2$baseMat.div)
div.2$baseMat.div[1:5, 1:4]

# divergent set size in each data matrix sample
head(div.2$div)

# divergence probability of features
head(div.2$features.div)

# baseline information
head(div.2$Baseline$Ranges)
div.2$Baseline$gamma


## ----echo=TRUE----------------------------------------------------------------

# make a factor of the ER status phenotype
selection = which(colnames(breastTCGA_Mat) %in% colnames(seMat))
groups.ER = breastTCGA_ER[selection]

table(groups.ER, useNA='i')

# perform divergence
div.3 = computeUnivariateDigitization(
  seMat = seMat,
  seMat.base = seMat.base,
  computeQuantiles = FALSE,
  gamma = 1:9/10,
  Groups = groups.ER, 
  classes = c("Positive", "Negative"),
  parallel = FALSE
)

# divergence probability of features
head(div.3$features.div)


## ----echo=TRUE, warning=FALSE-------------------------------------------------

chi.1 = computeChiSquaredTest(
  Mat = assays(seMat)$div,
  Groups = groups.ER,
  classes = c("Positive", "Negative")
)

head(chi.1, 10)


## ----echo=TRUE----------------------------------------------------------------

length(msigdb_Hallmarks)

lapply(msigdb_Hallmarks[1:3], head)


## ----echo=TRUE----------------------------------------------------------------

baseline3 = computeMultivariateSupport(
  seMat=seMat.base, 
  FeatureSets = msigdb_Hallmarks,
  gamma=0.1, 
  beta=0.99
)


## ----echo=TRUE----------------------------------------------------------------

baseline4 = findMultivariateGammaWithSupport(
  seMat = seMat.base,
  FeatureSets = msigdb_Hallmarks,
  gamma=1:9/10, 
  beta=0.9,
  alpha = .01
)

# selected gamma
baseline4$gamma

# alpha value: i.e. number of divergent multivariate features per sample in the baseliine cohort
baseline4$alpha

# does the selected gamma meet the alpha threshold required by the user?
baseline4$optimal

# view the alpha values obtained for each of the gamma values searched through
baseline4$alpha_space


## ----echo=TRUE----------------------------------------------------------------

mat.div.2 = computeMultivariateBinaryMatrix(
  seMat = seMat,
  Baseline = baseline4
)

dim(mat.div.2)

mat.div.2[1:5, 1:4]


## ----echo=TRUE----------------------------------------------------------------

# perform divergence
div.4 = computeMultivariateDigitization(
  seMat = seMat,
  seMat.base = seMat.base,
  FeatureSets = msigdb_Hallmarks,
  computeQuantiles = TRUE,
  gamma = 1:9/10,
  Groups = groups.ER, 
  classes = c("Positive", "Negative")
)

# digitized data matrix
dim(div.4$Mat.div)
div.4$Mat.div[1:5, 1:4]

# digitized baseline matrix
dim(div.4$baseMat.div)
div.4$baseMat.div[1:5, 1:4]

# divergent set size in each data matrix sample
head(div.4$div)

# divergence probability of features
head(div.4$features.div)

# baseline information
div.2$Baseline$gamma
div.2$Baseline$alpha
div.2$Baseline$optimal
div.2$Baseline$alpha_space


## ----echo=TRUE, warning=FALSE-------------------------------------------------

chi.2 = computeChiSquaredTest(
  Mat = div.4$Mat.div,
  Groups = groups.ER,
  classes = c("Positive", "Negative")
)

head(chi.2, 10)


## ----echo=TRUE, warning=FALSE-------------------------------------------------

sessionInfo()


