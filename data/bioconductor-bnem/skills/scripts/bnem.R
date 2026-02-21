# Code example from 'bnem' vignette. See references/ for full tutorial.

## ----global_options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(message=FALSE, out.width="125%", fig.align="center",
                      strip.white=TRUE, warning=FALSE, #tidy=TRUE,
                      #out.extra='style="display:block; margin:auto;"',
                      fig.height = 4, fig.width = 8, error=FALSE)
fig.cap0 <- "PKN and GTN. The prior knowledge network without any logics 
(PKN, left) and the ground truth (GTN, right). Red 'tee' arrows depict
repression the others activation of 
the child. The stimulated S-genes are diamond shaped. Blue diamond edges 
in the PKN depict the existence of activation and repression in one arrow."
fig.cap1 <- "GTN and greedy optimum. The GTN (left) and the greedy 
optmimum (right)."
fig.cap2 <- "Expected and observed data. The expected data pattern 
(bottom row) of S-gene S1 and the observed data patterns of the 
E-genes attached to S1."
fig.cap3 <- "BCR signalling. The PKN (left) and the greedy optimum 
with an empty start network (right)."


## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("bnem")

## -----------------------------------------------------------------------------
library(bnem)

## -----------------------------------------------------------------------------
set.seed(9247)
sim <- simBoolGtn(Sgenes = 10, maxEdges = 10, keepsif = TRUE, negation=0.1,
                  layer=1)
fc <- addNoise(sim,sd=1)
expression <- sim$expression
CNOlist <- sim$CNOlist
model <- sim$model
bString <- sim$bString
ERS <- sim$ERS
PKN <- sim$PKN
children <- unique(gsub(".*=|!", "", PKN$reacID))
stimuli <- unique(gsub("=.*|!", "", PKN$reacID))
stimuli <- stimuli[which(!(stimuli %in% children))]

## ----fig.width = 15, fig.height = 5, fig.cap = fig.cap0-----------------------
library(mnem)
par(mfrow=c(1,2))
plotDnf(PKN$reacID, stimuli = stimuli)
plotDnf(model$reacID[as.logical(sim$bString)], stimuli = stimuli)

## -----------------------------------------------------------------------------
## we start with the empty graph:
initBstring <- reduceGraph(rep(0, length(model$reacID)), model, CNOlist)
## or a fully connected graph:
## initBstring <- reduceGraph(rep(1, length(model$reacID)), model, CNOlist)

## paralellize for several threads on one machine or multiple machines
## see package "snowfall" for details
parallel <- NULL # NULL for serialization
## or distribute to 30 threads on four different machines:
## parallel <- list(c(4,16,8,2), c("machine1", "machine2", "machine3",
## "machine4"))

## greedy search:
greedy <- bnem(search = "greedy",
               fc=fc,
               expression=expression, # not used, if fc is defined
               CNOlist=CNOlist,
               model=model,
               parallel=parallel,
               initBstring=initBstring,
               draw = FALSE, # TRUE: draw network at each step
               verbose = FALSE, # TRUE: print changed (hyper-)edges and
               ## score improvement
               maxSteps = Inf,
               method = "s"
               )

greedy2 <- bnem(search = "greedy",
                fc=fc,
                expression=expression,
                CNOlist=CNOlist,
                model=model,
                parallel=parallel,
                initBstring=initBstring,
                draw = FALSE,
                verbose = FALSE,
                maxSteps = Inf,
                method = "cosine"
                )

## -----------------------------------------------------------------------------
greedy$scores # rank correlation = normalized
greedy2$scores # scaled log foldchanges

accuracy <- function(gtn,inferred) {
  sens <- sum(gtn == 1 & inferred == 1)/
    (sum(gtn == 1 & inferred == 1) + sum(gtn == 1 & inferred == 0))
  spec <- sum(gtn == 0 & inferred == 0)/
      (sum(gtn == 0 & inferred == 0) + sum(gtn == 0 & inferred == 1))
  return(c(sens,spec))
}

accuracy(bString,greedy$bString)
accuracy(bString,greedy2$bString)
resString <- greedy2$bString

## ----fig.width = 15, fig.height = 5, fig.cap = fig.cap1-----------------------
par(mfrow=c(1,2))
## GTN:
plotDnf(model$reacID[as.logical(bString)], main = "GTN", stimuli = stimuli)
## greedy optimum:
plotDnf(model$reacID[as.logical(resString)], main = "greedy optimum",
        stimuli = stimuli)

## accuracy of the expected response scheme (can be high even, if
## the networks differ):
ERS.res <- computeFc(CNOlist,
                     t(simulateStatesRecursive(CNOlist, model, resString)))
ERS.res <- ERS.res[, which(colnames(ERS.res) %in% colnames(ERS))]
print(sum(ERS.res == ERS)/length(ERS))

## ----fig.width = 15, fig.height = 10, fig.cap = fig.cap3----------------------
fitinfo <- validateGraph(CNOlist, fc=fc, expression=expression, model = model,
                         bString = resString,
                         Sgene = 4, Egenes = 1000, cexRow = 0.8,
                         cexCol = 0.7,
                         xrot = 45,
                         Colv = TRUE, Rowv = TRUE, dendrogram = "both",
                         bordercol = "lightgrey",
                         aspect = "iso", sub = "")

## -----------------------------------------------------------------------------
## genetic algorithm:
genetic <- bnem(search = "genetic",
           fc=fc,
           expression=expression,
           parallel = parallel,
           CNOlist=CNOlist,
           model=model,
           initBstring=initBstring,
           popSize = 10,
           stallGenMax = 10,
           draw = FALSE,
           verbose = FALSE
           )

## ----eval = FALSE-------------------------------------------------------------
# ## exhaustive search:
# exhaustive <- bnem(search = "exhaustive",
#                    parallel = parallel,
#                    CNOlist=CNOlist,
#                    fc=fc,
#                    expression=expression,
#                    model=model
#                    )

## -----------------------------------------------------------------------------
set.seed(9247)
sim <- simBoolGtn(Sgenes = 4, maxEdges = 50, dag = FALSE,
                  negation = 0, allstim = TRUE,frac=0.1)
fc <- addNoise(sim,sd=1)
expression <- sim$expression
CNOlist <- sim$CNOlist
model <- sim$model
bString <- sim$bString
ERS <- sim$ERS
PKN <- sim$PKN
children <- unique(gsub(".*=|!", "", PKN$reacID))
stimuli <- unique(gsub("=.*|!", "", PKN$reacID))
stimuli <- stimuli[which(!(stimuli %in% children))]

## ----fig.width = 15, fig.height = 5, fig.cap = fig.cap0-----------------------
par(mfrow=c(1,2))
plotDnf(sim$PKN$reacID, stimuli = stimuli)
plotDnf(sim$model$reacID[as.logical(bString)], stimuli = stimuli)

## -----------------------------------------------------------------------------
greedy3 <- bnem(search = "greedy",
                CNOlist=CNOlist,
                fc=fc,
                expression=expression,
                model=model,
                parallel=parallel,
                initBstring=bString*0,
                draw = FALSE,
                verbose = FALSE,
                maxSteps = Inf,
                method = "cosine"
                )
resString2 <- greedy3$bString

## ----fig.width = 15, fig.height = 5, fig.cap = fig.cap1-----------------------
par(mfrow=c(1,2))
plotDnf(model$reacID[as.logical(bString)], main = "GTN", stimuli = stimuli)
plotDnf(model$reacID[as.logical(resString2)], main = "greedy optimum",
        stimuli = stimuli)

accuracy(bString,resString2)
ERS.res <- computeFc(CNOlist, t(simulateStatesRecursive(CNOlist, model,
                                                        resString2)))
ERS.res <- ERS.res[, which(colnames(ERS.res) %in% colnames(ERS))]
print(sum(ERS.res == ERS)/length(ERS))

## -----------------------------------------------------------------------------
egenes <- list()

for (i in PKN$namesSpecies) {
    egenes[[i]] <- rownames(fc)[grep(i, rownames(fc))]
}
initBstring <- reduceGraph(rep(0, length(model$reacID)), model, CNOlist)
greedy2b <- bnem(search = "greedy",
                 CNOlist=CNOlist,
                 fc=fc,
                 expression=expression,
                 egenes=egenes,
                 model=model,
                 parallel=parallel,
                 initBstring=initBstring,
                 draw = FALSE,
                 verbose = FALSE,
                 maxSteps = Inf,
                 method = "cosine"
                 )
resString3 <- greedy2b$bString

## -----------------------------------------------------------------------------
accuracy(bString,resString3)
ERS.res <- computeFc(CNOlist,
                     t(simulateStatesRecursive(CNOlist, model, resString3)))
ERS.res <- ERS.res[, which(colnames(ERS.res) %in% colnames(ERS))]
print(sum(ERS.res == ERS)/length(ERS))

## ----eval = FALSE-------------------------------------------------------------
# residuals <- findResiduals(resString3, CNOlist, model, fc, verbose = FALSE)
# ## verbose = TRUE plots the residuals matrices

## -----------------------------------------------------------------------------
data(bcr)
## head(fc)
fc <- bcr$fc
expression <- bcr$expression

## -----------------------------------------------------------------------------
library(CellNOptR)
negation <- FALSE # what happens if we allow negation?
sifMatrix <- numeric()
for (i in "BCR") {
    sifMatrix <- rbind(sifMatrix, c(i, 1, c("Pi3k")))
    sifMatrix <- rbind(sifMatrix, c(i, 1, c("Tak1")))
    if (negation) {
        sifMatrix <- rbind(sifMatrix, c(i, -1, c("Pi3k")))
        sifMatrix <- rbind(sifMatrix, c(i, -1, c("Tak1")))
    }
}
for (i in c("Pi3k", "Tak1")) {
    for (j in c("Ikk2", "p38", "Jnk", "Erk", "Tak1", "Pi3k")) {
        if (i %in% j) { next() }
        sifMatrix <- rbind(sifMatrix, c(i, 1, j))
        if (negation) {
            sifMatrix <- rbind(sifMatrix, c(i, -1, j))
        }
    }
}
for (i in c("Ikk2", "p38", "Jnk")) {
    for (j in c("Ikk2", "p38", "Jnk")) {
        if (i %in% j) { next() }
        sifMatrix <- rbind(sifMatrix, c(i, 1, j))
        if (negation) {
            sifMatrix <- rbind(sifMatrix, c(i, -1, j))
        }
    }
}
file <- tempfile(pattern="interaction",fileext=".sif")
write.table(sifMatrix, file = file, sep = "\t",
            row.names = FALSE, col.names = FALSE, quote = FALSE)
PKN <- readSIF(file)

## -----------------------------------------------------------------------------
CNOlist <- dummyCNOlist(stimuli = "BCR",
                        inhibitors = c("Tak1", "Pi3k", "Ikk2",
                                       "Jnk", "p38", "Erk"),
                        maxStim = 1, maxInhibit = 3)

model <- preprocessing(CNOlist, PKN)

## -----------------------------------------------------------------------------
initBstring <- rep(0, length(model$reacID))
bcrRes <- bnem(search = "greedy",
                   fc=fc,
                   CNOlist=CNOlist,
                   model=model,
                   parallel=parallel,
                   initBstring=initBstring,
                   draw = FALSE,
                   verbose = FALSE,
                   method = "cosine"
                   )

## ----fig.width = 10, fig.height = 5, fig.cap = fig.cap3-----------------------
par(mfrow=c(1,3))
plotDnf(PKN$reacID, main = "PKN", stimuli = "BCR")
plotDnf(bcrRes$graph, main = "greedy optimum (empty start)",
        stimuli = "BCR")

## -----------------------------------------------------------------------------
sessionInfo()

