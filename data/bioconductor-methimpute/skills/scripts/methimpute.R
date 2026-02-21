# Code example from 'methimpute' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----options, results='hide', message=FALSE, eval=TRUE, echo=FALSE------------
library(methimpute)
options(width=80)

## ----methylation_status_calling_separate, results='markup', message=FALSE, eval=TRUE, fig.width=10, fig.height=7, out.width='\\textwidth', fig.align='center'----
library(methimpute)

# ===== Step 1: Importing the data ===== #

# We load an example file in BSSeeker format that comes with the package
file <- system.file("extdata","arabidopsis_bsseeker.txt.gz", package="methimpute")
bsseeker.data <- importBSSeeker(file)
print(bsseeker.data)

# Because most methylation extractor programs report only covered cytosines,
# we need to inflate the data to inlcude all cytosines (including non-covered sites)
fasta.file <- system.file("extdata","arabidopsis_sequence.fa.gz", package="methimpute")
cytosine.positions <- extractCytosinesFromFASTA(fasta.file,
                                                contexts = c('CG','CHG','CHH'))
methylome <- inflateMethylome(bsseeker.data, cytosine.positions)
print(methylome)


# ===== Step 2: Obtain correlation parameters ===== #

# The correlation of methylation levels between neighboring cytosines is an important
# parameter for the methylation status calling, so we need to get it first. Keep in mind
# that we only use the first 200.000 bp here, that's why the plot looks a bit meagre.
distcor <- distanceCorrelation(methylome, separate.contexts = TRUE)
fit <- estimateTransDist(distcor)
print(fit)


# ===== Step 3: Methylation status calling (and imputation) ===== #

model <- callMethylationSeparate(data = methylome, transDist = fit$transDist,
                                 verbosity = 0)
# The confidence in the methylation status call is given in the column "posteriorMax".
# For further analysis one could split the results into high-confidence
# (posteriorMax >= 0.98) and low-confidence calls (posteriorMax < 0.98) for instance.
print(model)

# Bisulfite conversion rates can be obtained with
1 - model$params$emissionParams$Unmethylated

## ----methylation_status_calling_separate_checkresults, results='markup', message=FALSE, eval=TRUE, fig.width=10, fig.height=2.5, out.width='\\textwidth', fig.align='center'----
plotConvergence(model)
plotTransitionProbs(model)
plotHistogram(model, total.counts = 10)

## ----methylation_status_calling, results='markup', message=FALSE, eval=TRUE, fig.width=10, fig.height=7, out.width='\\textwidth', fig.align='center'----
library(methimpute)

# ===== Step 1: Importing the data ===== #

# We load an example file in BSSeeker format that comes with the package
file <- system.file("extdata","arabidopsis_bsseeker.txt.gz", package="methimpute")
bsseeker.data <- importBSSeeker(file)
print(bsseeker.data)

# Because most methylation extractor programs report only covered cytosines,
# we need to inflate the data to inlcude all cytosines (including non-covered sites)
fasta.file <- system.file("extdata","arabidopsis_sequence.fa.gz", package="methimpute")
cytosine.positions <- extractCytosinesFromFASTA(fasta.file,
                                                contexts = c('CG','CHG','CHH'))
methylome <- inflateMethylome(bsseeker.data, cytosine.positions)
print(methylome)


# ===== Step 2: Obtain correlation parameters ===== #

# The correlation of methylation levels between neighboring cytosines is an important
# parameter for the methylation status calling, so we need to get it first. Keep in mind
# that we only use the first 200.000 bp here, that's why the plot looks a bit meagre.
distcor <- distanceCorrelation(methylome)
fit <- estimateTransDist(distcor)
print(fit)


# ===== Step 3: Methylation status calling (and imputation) ===== #

model <- callMethylation(data = methylome, transDist = fit$transDist)
# The confidence in the methylation status call is given in the column "posteriorMax".
# For further analysis one could split the results into high-confidence
# (posteriorMax >= 0.98) and low-confidence calls (posteriorMax < 0.98) for instance.
print(model)

# Bisulfite conversion rates can be obtained with
1 - model$params$emissionParams$Unmethylated

## ----methylation_status_calling_binned, results='markup', message=FALSE, eval=TRUE, fig.width=10, fig.height=7, out.width='\\textwidth', fig.align='center'----
library(methimpute)

# ===== Step 1: Importing the data ===== #

# We load an example file in BSSeeker format that comes with the package
file <- system.file("extdata","arabidopsis_bsseeker.txt.gz", package="methimpute")
bsseeker.data <- importBSSeeker(file)
print(bsseeker.data)

# Because most methylation extractor programs report only covered cytosines,
# we need to inflate the data to inlcude all cytosines (including non-covered sites)
fasta.file <- system.file("extdata","arabidopsis_sequence.fa.gz", package="methimpute")
cytosine.positions <- extractCytosinesFromFASTA(fasta.file,
                                                contexts = c('CG','CHG','CHH'))
methylome <- inflateMethylome(bsseeker.data, cytosine.positions)
print(methylome)


# ===== Step 2: Binning into 100bp bins ===== #
binnedMethylome <- binMethylome(methylome, binsize = 100, contexts = c('total','CG'))
print(binnedMethylome$CG)


# ===== Step 3: Methylation status calling (and imputation) ===== #

binnedModel <- callMethylation(data = binnedMethylome$CG)
print(binnedModel)

## ----methylation_status_calling_binned_checkresults, results='markup', message=FALSE, eval=TRUE, fig.width=5, fig.height=2.5, out.width='0.5\\textwidth', fig.align='center'----
plotConvergence(binnedModel)
plotTransitionProbs(binnedModel)
plotHistogram(binnedModel, total.counts = 150)

## ----enrichment_analysis, results='markup', message=FALSE, eval=TRUE, fig.width=10, fig.height=4, out.width='0.8\\textwidth', fig.align='center'----
# Define categories to distinguish missing from covered cytosines
model$data$category <- factor('covered', levels=c('missing', 'covered'))
model$data$category[model$data$counts[,'total']>=1] <- 'covered'
model$data$category[model$data$counts[,'total']==0] <- 'missing'

# Note that the plots look a bit ugly because our toy data has only 200.000 datapoints.
data(arabidopsis_genes)
seqlengths(model$data) <- seqlengths(arabidopsis_genes)[seqlevels(model$data)] # this
                          # line should only be necessary for our toy example
plotEnrichment(model$data, annotation=arabidopsis_genes, range = 2000,
               category.column = 'category')
data(arabidopsis_TEs)
plotEnrichment(model$data, annotation=arabidopsis_TEs, range = 2000,
               category.column = 'category')

## ----export_results, results='markup', message=FALSE, eval=TRUE---------------
exportMethylome(model, filename = tempfile())

## ----sessionInfo, eval=TRUE, results="asis"-----------------------------------
toLatex(sessionInfo())

