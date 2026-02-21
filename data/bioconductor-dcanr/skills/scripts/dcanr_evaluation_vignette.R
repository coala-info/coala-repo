# Code example from 'dcanr_evaluation_vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# #Not evaluated
# simdata <- readRDS('simdata_directory/sim812.rds')
# sim10 <- simdata[[10]]

## ----message=FALSE, warning=FALSE, fig.wide=TRUE, fig.asp=1, fig.cap='Differential network analysis on simulations. Top-left to bottom-right: The original regulatory network used for simulations; the true induced differential network that results from both ADR1 and UME6 knock-downs (KDs); the predicted ADR1 knock-down differential network, and; the predicted UME6 knock-down differential network. Reg and green edges in the regulatory network represent activation and repression respectively. Edges in the differential network are coloured based on the knock-down that results in their differential co-expression. True positives in the predicted network are coloured based on their knock-down while false positives are coloured grey'----
library(dcanr)

#load the data: a simulation
data(sim102) 
#run a standard pipeline with the z-score method
dcnets <- dcPipeline(sim102, dc.func = 'zscore')
#plot the source network, true differential network and inferred networks
op <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
plotSimNetwork(sim102, main = 'Regulatory network')
plotSimNetwork(sim102, what = 'association', main = 'True differential association network')
plot(dcnets$ADR1, main = 'ADR1 KD predicted network')
plot(dcnets$UME6, main = 'UME6 KD predicted network')
par(op)

## -----------------------------------------------------------------------------
#run a standard pipeline with the z-score method with custom params
dcnets_sp <- dcPipeline(sim102,
                        dc.func = 'zscore',
                        cor.method = 'spearman', #use Spearman's correlation
                        thresh = 0.2) #cut-off for creating the network

## -----------------------------------------------------------------------------
sim102_lambdas = c(0.5145742607781790267651, 0.3486682118540171959609)
dcnets_ldgm <- dcPipeline(sim102,
                          dc.func = 'ldgm',
                          cond.args = list(
                            ldgm.lambda = sim102_lambdas
                          ))

## ----eval=FALSE---------------------------------------------------------------
# #emat, a named matrix with samples along the columns and genes along the rows
# #condition, a binary named vector consisiting of 1's and 2's
# #returns a named adjacency matrix or an igraph object
# myInference <- function(emat, condition, ...) {
#   #your code here
#   return(dcnet)
# }

## -----------------------------------------------------------------------------
#custom pipeline function
analysisInbuilt <- function(emat, condition, dc.method = 'zscore', ...) {
  #compute scores
  score = dcScore(emat, condition, dc.method, ...)
  #perform statistical test
  pvals = dcTest(score, emat, condition, ...)
  #adjust tests for multiple testing
  adjp = dcAdjust(pvals, ...)
  #threshold and generate network
  dcnet = dcNetwork(score, adjp, ...)

  return(dcnet)
}

#call the custom pipeline
custom_nets <- dcPipeline(sim102, dc.func = analysisInbuilt)

## ----message=FALSE, warning=FALSE---------------------------------------------
#retrieve results of applying all available methods
allnets <- lapply(dcMethods(), function(m) {
  dcPipeline(sim102, dc.func = m, precomputed = TRUE)
})
names(allnets) <- dcMethods() #name the results based on methods

#get the size of the UME6 KD differential network
netsizes <- lapply(allnets, function(net) {
  length(igraph::E(net$UME6))
})
print(unlist(netsizes))

## -----------------------------------------------------------------------------
#available performance metrics
print(perfMethods())

## ----message=FALSE, warning=FALSE---------------------------------------------
#compute the F1-measure for the prediction made by each method
f1_scores <- lapply(allnets, function (net) {
  dcEvaluate(sim102, net, truth.type = 'association', combine = TRUE)
})
print(sort(unlist(f1_scores), decreasing = TRUE))
#compute the Matthew's correlation coefficient of the z-score inference
z_mcc <- dcEvaluate(sim102, dcnets, perf.method = 'MCC')
print(z_mcc)

## ----message=FALSE, warning=FALSE---------------------------------------------
#compute precision
dcprec <- lapply(allnets, function (net) {
  dcEvaluate(sim102, net, perf.method = 'precision')
})
#compute recall
dcrecall <- lapply(allnets, function (net) {
  dcEvaluate(sim102, net, perf.method = 'recall')
})

## ----echo=FALSE, message=FALSE, warning=FALSE, fig.small=TRUE-----------------
#plot the precision and recall
plot(
  unlist(dcprec),
  unlist(dcrecall),
  type = 'n',
  main = 'Precision v recall',
  xlab = 'Precision',
  ylab = 'Recall',
  xlim = c(-0.25, 1),
  ylim = c(0, 1)
  )
text(
  unlist(dcprec),
  unlist(dcrecall),
  labels = names(allnets),
  type = 'n',
  cex = 1.2
  )

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

