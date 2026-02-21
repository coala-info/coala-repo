# Code example from 'plrs_vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'plrs_vignette.Rnw'

###################################################
### code chunk number 1: plrs_vignette.Rnw:204-207
###################################################
library(plrs)
data(neveCN17)
data(neveGE17)


###################################################
### code chunk number 2: plrs_vignette.Rnw:215-217
###################################################
neveGE17
neveCN17


###################################################
### code chunk number 3: plrs_vignette.Rnw:236-238
###################################################
# Index of gene PITPNA
idx <- which(fData(neveGE17)$Symbol=="PITPNA")[1]


###################################################
### code chunk number 4: plrs_vignette.Rnw:240-245
###################################################
# Obtain vectors of gene expression (normalized) and
# copy number (segmented and called) data
rna <- exprs(neveGE17)[idx,]
cghseg <- segmented(neveCN17)[idx,]
cghcall <- calls(neveCN17)[idx,]


###################################################
### code chunk number 5: plrs_vignette.Rnw:247-252
###################################################
# Obtain vectors of posterior membership probabilities
probloss <- probloss(neveCN17)[idx,]
probnorm <- probnorm(neveCN17)[idx,]
probgain <- probgain(neveCN17)[idx,]
probamp <- probamp(neveCN17)[idx,]


###################################################
### code chunk number 6: plrs_vignette.Rnw:271-273
###################################################
# Check: how many observations per state?
table(cghcall)


###################################################
### code chunk number 7: plrs_vignette.Rnw:279-286
###################################################
# Set the minimum to 4 observations per state
cghcall2 <- modify.conf(cghcall, min.obs=4, discard=FALSE)
table(cghcall2)

# Set the minimum to 4 observations per state
cghcall2 <- modify.conf(cghcall, min.obs=4, discard=TRUE)
table(cghcall2)


###################################################
### code chunk number 8: plrs_vignette.Rnw:331-335
###################################################
# Fit a model
model <- plrs(rna, cghseg, cghcall, probloss, probnorm, probgain, probamp)
model
plot(model)


###################################################
### code chunk number 9: plrs_vignette.Rnw:369-375
###################################################
# Model selection
modelSelection <- plrs.select(model)
summary(modelSelection)

# Plot selected model
plot(modelSelection)


###################################################
### code chunk number 10: plrs_vignette.Rnw:382-384
###################################################
selectedModel <- modelSelection@model
selectedModel


###################################################
### code chunk number 11: plrs_vignette.Rnw:433-445
###################################################
# Testing the full model with
model <- plrs.test(model, alpha=0.05)
model

# or with
selectedModel <- plrs.test(selectedModel, alpha=0.05)
selectedModel

# Testing the selected model
selectedModel2 <- selectedModel
selectedModel2@selected <- FALSE
plrs.test(selectedModel2, alpha=0.05)


###################################################
### code chunk number 12: plrs_vignette.Rnw:466-472
###################################################
# Compute and plot CBs
selectedModel <- plrs.cb(selectedModel, alpha=0.05)

str(selectedModel@cb)

plot(selectedModel)


###################################################
### code chunk number 13: plrs_vignette.Rnw:480-481
###################################################
plot(selectedModel, col.pts="black", col.cb="pink")


###################################################
### code chunk number 14: plrs_vignette.Rnw:496-501
###################################################
# Testing the full model, no model selection (fast)
neveSeries <- plrs.series(neveGE17[1:200,], neveCN17[1:200,], control.select=NULL)

# Testing the full model and applying model selection
neveSeries2 <- plrs.series(neveGE17[1:200,], neveCN17[1:200,])


###################################################
### code chunk number 15: plrs_vignette.Rnw:512-519
###################################################
# Summary of screening test
neveSeries
summary(neveSeries)

# Summary of screening test and model selection
neveSeries2
summary(neveSeries2)


###################################################
### code chunk number 16: plrs_vignette.Rnw:524-531
###################################################
# Testing results
head(neveSeries@test)
head(neveSeries2@test)

# Coefficients of selected models
head(neveSeries2@coefficients)



