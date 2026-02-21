# Code example from 'zenith' vignette. See references/ for full tutorial.

## ----knitr.setup, echo=FALSE--------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
  echo = TRUE,
  warning=FALSE,
  message=FALSE,
  error = FALSE,
  tidy = FALSE,
  cache = FALSE)

## ----standard-----------------------------------------------------------------
# Load packages
library(zenith)
library(edgeR)
library(variancePartition)
library(tweeDEseqCountData)
library(kableExtra)

# Load RNA-seq data from LCL's
data(pickrell)
geneCounts = exprs(pickrell.eset)
df_metadata = pData(pickrell.eset)

# Filter genes
# Note this is low coverage data, so just use as code example
dsgn = model.matrix(~ gender, df_metadata)
keep = filterByExpr(geneCounts, dsgn, min.count=5)

# Compute library size normalization
dge = DGEList(counts = geneCounts[keep,])
dge = calcNormFactors(dge)

# Estimate precision weights using voom
vobj = voomWithDreamWeights(dge, ~ gender, df_metadata)

# Apply dream analysis
fit = dream(vobj, ~ gender, df_metadata)
fit = eBayes(fit)

# Load get_MSigDB database, Hallmark genes
# use gene 'SYMBOL', or 'ENSEMBL' id
# use get_GeneOntology() to load Gene Ontology
msdb.gs = get_MSigDB("H", to="ENSEMBL")
   
# Run zenith analysis, and specific which coefficient to evaluate
res.gsa = zenith_gsa(fit, msdb.gs, 'gendermale', progressbar=FALSE )

# Show top gene sets: head(res.gsa)
kable_styling(kable(head(res.gsa), row.names=FALSE))

## ----plots--------------------------------------------------------------------
# for each cell type select 3 genesets with largest t-statistic
# and 1 geneset with the lowest
# Grey boxes indicate the gene set could not be evaluted because
#    to few genes were represented
plotZenithResults(res.gsa)

## ----session, echo=FALSE------------------------------------------------------
sessionInfo()

