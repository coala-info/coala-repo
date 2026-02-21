# Code example from 'Codelink_Introduction' vignette. See references/ for full tutorial.

## ----include=FALSE,cache=FALSE------------------------------------------------
library(codelink)
library(knitr)
opts_chunk$set(fig.align = 'center', concordance=TRUE,width=50,fig.show="hold", tidy = TRUE, comment = "", highlight = FALSE, prompt = TRUE)
knit_hooks$set(no.mar = function(before, options, envir) {
    if (before) par(mar = rep(0,4))  # no margins.
})

## ----eval=FALSE---------------------------------------------------------------
# # NOT RUN #
# library(codelink)
# # to read data as CodelinkSet object:
# f = list.files(pattern="TXT")
# codset = readCodelinkSet(filename=f)
# # NOT RUN #

## ----eval=FALSE---------------------------------------------------------------
# # NOT RUN #
# pdata=read.AnnotatedDataFrame("targets.txt")
# codset=readCodelinkSet(filename=pdata$FileName, phenoData=pdata)
# # NOT RUN #

## -----------------------------------------------------------------------------
# sample dataset.
data(codset)
codset

## -----------------------------------------------------------------------------
data(codelink.example)
print(is(codelink.example))
tmp=Codelink2CodelinkSet(codelink.example)
tmp

## -----------------------------------------------------------------------------
w = createWeights(codset)
## NOTE: a proper replacement function will be provided later:
assayDataElement(codset,"weight")=w

## -----------------------------------------------------------------------------
# get signal intensities. alias: getInt()
head(exprs(codset))

# get background intensities.
head(getBkg(codset))

# get SNR values.
head(getSNR(codset))

# get flags.
head(getFlag(codset))

# get weights.
head(getWeight(codset))

# get phenoData:
head(pData(codset))


## -----------------------------------------------------------------------------
codset = codCorrect(codset, method = "half", offset = 0)

## -----------------------------------------------------------------------------
codset = codNormalize(codset, method = "quantile")

## ----eval=FALSE---------------------------------------------------------------
# # NOT RUN
# codset = codNormalize(codset, method = "loess", weights=getWeight(codset), loess.method="fast")
# # NOT RUN

## ----fig.cap="MA plot (left) and density plot (right).",fig.height=4,fig.width=4,out.width='.49\\linewidth'----
codPlot(codset) # by default MA plot.
codPlot(codset, what="density")

## ----fig.cap="Pseudo image plot of an array",fig.height=1,fig.width=3---------
codPlot(codset, what="image")

## -----------------------------------------------------------------------------
fit = lmFit(codset, design=c(1,1,2,2), weights=getWeight(codset))
fit2 = eBayes(fit)
topTable(fit2)

## -----------------------------------------------------------------------------
citation(package="codelink")

## -----------------------------------------------------------------------------
sessionInfo()

