# Code example from 'OncoSimulR' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-------------------------------------------
## use collapse for bookdown, to collapse all the source and output
## blocks from one code chunk into a single block
time0 <- Sys.time()
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE)
options(width = 70)
require(BiocStyle)
require(pander)


## https://bookdown.org/yihui/rmarkdown-cookbook/time-chunk.html
all_times <- list()  # store the time for each chunk
knitr::knit_hooks$set(time_it = local({
  now <- NULL
  function(before, options) {
    if (before) {
      now <<- Sys.time()
    } else {
      res <- difftime(Sys.time(), now, units = "secs")
      all_times[[options$label]] <<- as.double(res)
    }
  }
}))

knitr::opts_chunk$set(time_it = TRUE)

## ----fundinglogo_I, eval=TRUE,echo=FALSE----------------------------
knitr::include_graphics("logo-micin-aei-uefeder.png", dpi = 250)

## ----fundinglogo2_I, eval=TRUE,echo=FALSE---------------------------
knitr::include_graphics("logo-micin-aei.png", dpi = 700)

## ----frelats, eval=TRUE,echo=FALSE, fig.cap="Relationships between the main functions in OncoSimulR."----
knitr::include_graphics("relfunct.png")

## ----firstload------------------------------------------------------
## Load the package
library(OncoSimulR)

## ----rzx0, echo=FALSE-----------------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## ----ex-dag-inf-----------------------------------------------------
## For reproducibility
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## Simulate a DAG
g1 <- simOGraph(4, out = "rT")

## Simulate 10 evolutionary trajectories
s1 <- oncoSimulPop(10, allFitnessEffects(g1, drvNames = 1:4),
                   onlyCancer = TRUE,
                   mc.cores = 2, ## adapt to your hardware
                   seed = NULL) ## for reproducibility of vignette

## Sample those data uniformly, and add noise
d1 <- samplePop(s1, timeSample = "unif", propError = 0.1)

## You would now run the appropriate inferential method and
## compare observed and true. For example

## require(Oncotree)
## fit1 <- oncotree.fit(d1)

## Now, you'd compare fitted and original. This is well beyond
## the scope of this document (and OncoSimulR itself).


## ----hidden-rng-exochs, echo = FALSE--------------------------------
## set.seed(NULL)

## ----hiddenochs, echo=FALSE-----------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## ----exochs---------------------------------------------------------
## For reproducibility
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## Specify fitness effects.

## Numeric values arbitrary, but set the intermediate genotype en
## route to ui as mildly deleterious so there is a valley.

## As in Ochs and Desai, the ui and uv genotypes
## can never appear.

u <- 0.2; i <- -0.02; vi <- 0.6; ui <- uv <- -Inf

od <- allFitnessEffects(
    epistasis = c("u" = u,  "u:i" = ui,
                  "u:v" = uv, "i" = i,
                  "v:-i" = -Inf, "v:i" = vi))

## For the sake of extending this example, also turn i into a
## mutator gene

odm <- allMutatorEffects(noIntGenes = c("i" = 50))

## How do mutation and fitness look like for each genotype?
evalAllGenotypesFitAndMut(od, odm, addwt = TRUE)

## ----exochsb--------------------------------------------------------
## Set a small initSize, as o.w. unlikely to pass the valley
initS <- 10
## The number of replicates is tiny, for the sake of speed
## of creation of the vignette. Even fewer in Windows, since we run on a single
## core

if(.Platform$OS.type == "windows") {
    nruns <- 4
} else {
    nruns <- 10
}

od_sim <- oncoSimulPop(nruns, od, muEF = odm,
                       fixation = c("u", "i, v"), initSize = initS,
                       model = "McFL",
                       mu = 1e-4, detectionDrivers = NA,
					   finalTime = NA,
                       detectionSize = NA, detectionProb = NA,
                       onlyCancer = TRUE,
					   mc.cores = 2, ## adapt to your hardware
                       seed = NULL) ## for reproducibility
## What is the frequency of each final genotype?
sampledGenotypes(samplePop(od_sim))

## ----hidden-rng-exochs33, echo = FALSE------------------------------
## set.seed(NULL)

## ----hiddenrng0szen, echo=FALSE-------------------------------------
set.seed(7)
RNGkind("L'Ecuyer-CMRG")

## ----exszendro------------------------------------------------------
## For reproducibility
set.seed(7)
RNGkind("L'Ecuyer-CMRG")


## Repeat the following loop for different combinations of whatever
## interests you, such as number of genes, or distribution of the
## c and sd (which affect how rugged the landscape is), or
## reference genotype, or evolutionary model, or stopping criterion,
## or sampling procedure, or ...

##  Generate a random fitness landscape, from the Rough Mount
##  Fuji model, with g genes, and c ("slope" constant) and
##  reference chosen randomly (reference is random by default and
##  thus not specified below). Require a minimal number of
##  accessible genotypes

g <- 6
c <- runif(1, 1/5, 5)
rl <- rfitness(g, c = c, min_accessible_genotypes = g)

## Plot it if you want; commented here as it takes long for a
## vignette

## plot(rl)

## Obtain landscape measures from MAGELLAN. Export to MAGELLAN and
## call your own copy of MAGELLAN's binary

## to_Magellan(rl, file = "rl1.txt") ## (Commented out here to avoid writing files)

## or use the binary copy provided with OncoSimulR
## see also below.

Magellan_stats(rl) ## (Commented out here to avoid writing files)

## Simulate evolution in that landscape many times (here just 10)
simulrl <- oncoSimulPop(10, allFitnessEffects(genotFitness = rl),
                        keepPhylog = TRUE, keepEvery = 1,
                        onlyCancer = TRUE,
                        initSize = 4000,
                        seed = NULL, ## for reproducibility
                        mc.cores = 2) ## adapt to your hardware

## Obtain measures of evolutionary predictability
diversityLOD(LOD(simulrl))
diversityPOM(POM(simulrl))
sampledGenotypes(samplePop(simulrl, typeSample = "whole"))

## ----hidden-rng-exszend, echo = FALSE-------------------------------
## set.seed(NULL)

## ----ex-tomlin1-----------------------------------------------------
sd <- 0.1 ## fitness effect of drivers
sm <- 0 ## fitness effect of mutator
nd <- 20 ## number of drivers
nm <- 5  ## number of mutators
mut <- 10 ## mutator effect

fitnessGenesVector <- c(rep(sd, nd), rep(sm, nm))
names(fitnessGenesVector) <- 1:(nd + nm)
mutatorGenesVector <- rep(mut, nm)
names(mutatorGenesVector) <- (nd + 1):(nd + nm)

ft <- allFitnessEffects(noIntGenes = fitnessGenesVector,
                        drvNames = 1:nd)
mt <- allMutatorEffects(noIntGenes = mutatorGenesVector)


## ----hiddentom, echo=FALSE------------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## ----ex-tomlin2-----------------------------------------------------
## For reproducibility
set.seed(2)
RNGkind("L'Ecuyer-CMRG")


ddr <- 4
st <- oncoSimulPop(4, ft, muEF = mt,
                   detectionDrivers = ddr,
                   finalTime = NA,
                   detectionSize = NA,
                   detectionProb = NA,
                   onlyCancer = TRUE,
                   keepEvery = NA,
                   mc.cores = 2, ## adapt to your hardware
                   seed = NULL) ## for reproducibility

## How long did it take to reach cancer?
unlist(lapply(st, function(x) x$FinalTime))


## ----hidden-rng-tom, echo = FALSE-----------------------------------
## set.seed(NULL)

## ----exusagebau-----------------------------------------------------
K <- 4
sp <- 1e-5
sdp <- 0.015
sdplus <- 0.05
sdminus <- 0.1

cnt <- (1 + sdplus)/(1 + sdminus)
prod_cnt <- cnt - 1
bauer <- data.frame(parent = c("Root", rep("D", K)),
                    child = c("D", paste0("s", 1:K)),
                    s = c(prod_cnt, rep(sdp, K)),
                    sh = c(0, rep(sp, K)),
                    typeDep = "MN")
fbauer <- allFitnessEffects(bauer)
(b1 <- evalAllGenotypes(fbauer, order = FALSE, addwt = TRUE))

## How does the fitness landscape look like?
plot(b1, use_ggrepel = TRUE) ## avoid overlapping labels

## ----hiddenbau, echo=FALSE------------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## ----exusagebau2----------------------------------------------------
## For reproducibility
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

totalpops <- 5
initSize <- 100
sb1 <- oncoSimulPop(totalpops, fbauer, model = "Exp",
                    initSize = initSize,
                    onlyCancer = FALSE,
					mc.cores = 2, ## adapt to your hardware
                    seed = NULL) ## for reproducibility

## What proportion of the simulations reach 4x initSize?
sum(summary(sb1)[, "TotalPopSize"] > (4 * initSize))/totalpops


## ----hidden-rng-exbau, echo = FALSE---------------------------------
## set.seed(NULL)

## ----hiddenbau22, echo=FALSE----------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## ----hhhhbbbb22-----------------------------------------------------

totalpops <- 5
initSize <- 100
sb2 <- oncoSimulPop(totalpops, fbauer, model = "Exp",
                    initSize = initSize,
                    onlyCancer = TRUE,
					detectionSize = 10 * initSize,
					mc.cores = 2, ## adapt to your hardware
                    seed = NULL) ## for reproducibility

## How long did it take to reach cancer?
unlist(lapply(sb2, function(x) x$FinalTime))

## ----hidden-rng-exbau22, echo = FALSE-------------------------------
## set.seed(NULL)

## ----oex1intro------------------------------------------------------
## Order effects involving three genes.

## Genotype "D, M" has different fitness effects
## depending on whether M or D mutated first.
## Ditto for genotype "F, D, M".

## Meaning of specification: X > Y means
## that X is mutated before Y.


o3 <- allFitnessEffects(orderEffects = c(
                            "F > D > M" = -0.3,
                            "D > F > M" = 0.4,
                            "D > M > F" = 0.2,
                            "D > M"     = 0.1,
                            "M > D"     = 0.5))

## With the above specification, let's double check
## the fitness of the possible genotypes

(oeag <- evalAllGenotypes(o3, addwt = TRUE, order = TRUE))


## ----hiddoef, echo=FALSE--------------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## ----exusageoe2-----------------------------------------------------
## For reproducibility
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

totalpops <- 5
soe1 <- oncoSimulPop(totalpops, o3, model = "Exp",
                    initSize = 500,
                    onlyCancer = FALSE,
					mc.cores = 2, ## adapt to your hardware
                    seed = NULL) ## for reproducibility

## What proportion of the simulations do not end up extinct?
sum(summary(soe1)[, "TotalPopSize"] > 0)/totalpops


## ----hidden-rng-exoef, echo = FALSE---------------------------------
## set.seed(NULL)

## ----sswm-rfitness-funct--------------------------------------------
## oncoSimul object  -> measures of clonal interference
##    they are not averaged over time. One value for sampled time
clonal_interf_per_time <- function(x) {
    x <- x$pops.by.time
    y <- x[, -1, drop = FALSE]
    shannon <- apply(y, 1, OncoSimulR:::shannonI)
    tot <- rowSums(y)
    half_tot <- tot * 0.5
    five_p_tot <- tot * 0.05
    freq_most_freq <- apply(y/tot, 1, max)
    single_more_half <- rowSums(y > half_tot)
    ## whether more than 1 clone with more than 5% pop.
    how_many_gt_5p <- rowSums(y > five_p_tot)
    several_gt_5p <- (how_many_gt_5p > 1)
    return(cbind(shannon, ## Diversity of clones
                 freq_most_freq, ## Frequency of the most freq. clone
                 single_more_half, ## Any clone with a frequency > 50%?
                 several_gt_5p, ## Are there more than 1 clones with
                                ## frequency > 5%?
                 how_many_gt_5p ## How many clones are there with
                                ## frequency > 5%
                 ))
}

## ----sswm-rfitness0, eval=FALSE-------------------------------------
# set.seed(1)
# r7b <- rfitness(7, scale = c(1.2, 0, 1))
# 
# ## Large pop sizes: clonal interference
# (sr7b <- oncoSimulIndiv(allFitnessEffects(genotFitness = r7b),
#                        model = "McFL",
#                        mu = 1e-6,
#                        onlyCancer = FALSE,
#                        finalTime = 400,
#                        initSize = 1e7,
#                        keepEvery = 4,
#                        detectionSize = 1e10))
# 
# plot(sr7b, show = "genotypes")
# 
# colMeans(clonal_interf_per_time(sr7b))

## ----sswm-rfitness, eval=FALSE--------------------------------------
# ## Small pop sizes: a single clone most of the time
# (sr7c <- oncoSimulIndiv(allFitnessEffects(genotFitness = r7b),
#                        model = "McFL",
#                        mu = 1e-6,
#                        onlyCancer = FALSE,
#                        finalTime = 60000,
#                        initSize = 1e3,
#                        keepEvery = 4,
#                        detectionSize = 1e10))
# 
# plot(sr7c, show = "genotypes")
# 
# colMeans(clonal_interf_per_time(sr7c))
# 
# 
# 
# ## Even smaller fitness differences, but large pop. sizes
# set.seed(1); r7b2 <- rfitness(7, scale = c(1.05, 0, 1))
# 
# (sr7b2 <- oncoSimulIndiv(allFitnessEffects(genotFitness = r7b2),
#                        model = "McFL",
#                        mu = 1e-6,
#                        onlyCancer = FALSE,
#                        finalTime = 3500,
#                        initSize = 1e7,
#                        keepEvery = 4,
#                        detectionSize = 1e10))
# sr7b2
# plot(sr7b2, show = "genotypes")
# colMeans(clonal_interf_per_time(sr7b2))
# 
# 
# ## Increase pop size further
# (sr7b3 <- oncoSimulIndiv(allFitnessEffects(genotFitness = r7b2),
#                        model = "McFL",
#                        mu = 1e-6,
#                        onlyCancer = FALSE,
#                        finalTime = 1500,
#                        initSize = 1e8,
#                        keepEvery = 4,
#                        detectionSize = 1e10))
# sr7b3
# plot(sr7b3, show = "genotypes")
# colMeans(clonal_interf_per_time(sr7b3))
# 

## ----rzx011, results="hide",message=FALSE, echo=TRUE, include=TRUE----
library(OncoSimulR)
library(graph)
library(igraph)
igraph_options(vertex.color = "SkyBlue2")

## ----rzx02, echo=FALSE, results='hide'----------------------------
options(width = 68)

## -----------------------------------------------------------------
packageVersion("OncoSimulR")

## ----f7b3v, fig.width=6.5, fig.height=10--------------------------
## 1. Fitness effects: here we specify an
##    epistatic model with modules.
sa <- 0.1
sb <- -0.2
sab <- 0.25
sac <- -0.1
sbc <- 0.25
sv2 <- allFitnessEffects(epistasis = c("-A : B" = sb,
                                       "A : -B" = sa,
                                       "A : C" = sac,
                                       "A:B" = sab,
                                       "-A:B:C" = sbc),
                         geneToModule = c(
                             "A" = "a1, a2",
                             "B" = "b",
                             "C" = "c"),
                         drvNames = c("a1", "a2", "b", "c"))
evalAllGenotypes(sv2, addwt = TRUE)

## 2. Simulate the data. Here we use the "McFL" model and set
##    explicitly parameters for mutation rate, initial size, size
##    of the population that will end the simulations, etc

RNGkind("Mersenne-Twister")
set.seed(983)
ep1 <- oncoSimulIndiv(sv2, model = "McFL",
                      mu = 5e-6,
                      sampleEvery = 0.025,
                      keepEvery = 0.5,
                      initSize = 2000,
                      finalTime = 3000,
                      onlyCancer = FALSE)

## ----iep1x1,fig.width=6.5, fig.height=4.5, fig.cap="Plot of drivers of an epistasis simulation."----
## 3. We will not analyze those data any further. We will only plot
## them.  For the sake of a small plot, we thin the data.
plot(ep1, show = "drivers", xlim = c(0, 1500),
     thinData = TRUE, thinData.keep = 0.5)

## ----fepancr1, fig.width=5----------------------------------------
## 1. Fitness effects:
pancr <- allFitnessEffects(
    data.frame(parent = c("Root", rep("KRAS", 4),
                   "SMAD4", "CDNK2A",
                   "TP53", "TP53", "MLL3"),
               child = c("KRAS","SMAD4", "CDNK2A",
                   "TP53", "MLL3",
                   rep("PXDN", 3), rep("TGFBR2", 2)),
               s = 0.1,
               sh = -0.9,
               typeDep = "MN"),
    drvNames = c("KRAS", "SMAD4", "CDNK2A", "TP53",
	             "MLL3", "TGFBR2", "PXDN"))

## ----figfpancr1, fig.width=5, fig.cap="Plot of DAG corresponding to fitnessEffects object."----
## Plot the DAG of the fitnessEffects object
plot(pancr)

## ----theformerunnamed6--------------------------------------------
## 2. Simulate from it. We change several possible options.

set.seed(1) ## Fix the seed, so we can repeat it
## We set a small finalTime to speed up the vignette


ep2 <- oncoSimulIndiv(pancr, model = "McFL",
                     mu = 1e-6,
                     sampleEvery = 0.02,
                     keepEvery = 1,
                     initSize = 1000,
                     finalTime = 20000,
                     detectionDrivers = 3,
                     onlyCancer = FALSE)


## ----iep2x2, fig.width=6.5, fig.height=5, fig.cap= "Plot of genotypes of a simulation from a DAG."----
## 3. What genotypes and drivers we get? And play with limits
##    to show only parts of the data. We also aggressively thin
##    the data.
par(cex = 0.7)
plot(ep2, show = "genotypes", xlim = c(500, 1800),
     ylim = c(0, 2400),
     thinData = TRUE, thinData.keep = 0.3)

## -----------------------------------------------------------------
citation("OncoSimulR")

## ----colnames_benchmarks, echo = FALSE, eval = TRUE---------------

data(benchmark_1)
data(benchmark_1_0.05)
data(benchmark_2)
data(benchmark_3)

colnames(benchmark_1)[
    match(c(
	"time_per_simul",
    "size_mb_per_simul", "NumClones.Median", "NumIter.Median",
	"FinalTime.Median", "TotalPopSize.Median", "TotalPopSize.Mean",
	"TotalPopSize.Max.", "keepEvery",  "Attempts.Median",
	"Attempts.Mean", "Attempts.Max.",
	"PDBaseline", "n2", "onlyCancer"),
	 colnames(benchmark_1)
	)] <- c("Elapsed Time, average per simulation (s)",
	              "Object Size, average per simulation (MB)",
				  "Number of Clones, median",
				  "Number of Iterations, median",
				  "Final Time, median",
				  "Total Population Size, median",
				   "Total Population Size, mean",
				  "Total Population Size, max.",
				  "keepEvery",
				  "Attempts until Cancer, median",
				  "Attempts until Cancer, mean",
				  "Attempts until Cancer, max.",
				  "PDBaseline", "n2", "onlyCancer"
				  )


colnames(benchmark_1_0.05)[
    match(c("time_per_simul",
    "size_mb_per_simul", "NumClones.Median", "NumIter.Median",
	"FinalTime.Median", "TotalPopSize.Median", "TotalPopSize.Mean",
	"TotalPopSize.Max.",
	"keepEvery",
	"PDBaseline", "n2", "onlyCancer", "Attempts.Median"),
	colnames(benchmark_1_0.05))] <- c("Elapsed Time, average per simulation (s)",
	              "Object Size, average per simulation (MB)",
				  "Number of Clones, median",
				  "Number of Iterations, median",
				  "Final Time, median",
				  "Total Population Size, median",
				  "Total Population Size, mean",
				  "Total Population Size, max.",
				  "keepEvery",
				  "PDBaseline", "n2", "onlyCancer",
				  "Attempts until Cancer, median"
				  )


colnames(benchmark_2)[match(c("Model", "fitness", "time_per_simul",
    "size_mb_per_simul", "NumClones.Median", "NumIter.Median",
	"FinalTime.Median", "TotalPopSize.Median", "TotalPopSize.Mean",
	"TotalPopSize.Max."), colnames(benchmark_2))] <-  c("Model",
				  "Fitness",
	"Elapsed Time, average per simulation (s)",
	              "Object Size, average per simulation (MB)",
				  "Number of Clones, median",
				  "Number of Iterations, median",
				  "Final Time, median",
				  "Total Population Size, median",
				  "Total Population Size, mean",
				  "Total Population Size, max."
				  )

colnames(benchmark_3)[match(c("Model", "fitness", "time_per_simul",
    "size_mb_per_simul", "NumClones.Median", "NumIter.Median",
	"FinalTime.Median", "TotalPopSize.Median", "TotalPopSize.Mean",
	"TotalPopSize.Max."), colnames(benchmark_3))] <-  c("Model",
				  "Fitness",
	"Elapsed Time, average per simulation (s)",
	              "Object Size, average per simulation (MB)",
				  "Number of Clones, median",
				  "Number of Iterations, median",
				  "Final Time, median",
				  "Total Population Size, median",
				  "Total Population Size, mean",
				  "Total Population Size, max."
				  )

## ----timing1, eval=FALSE------------------------------------------
# ## Specify fitness
# pancr <- allFitnessEffects(
#     data.frame(parent = c("Root", rep("KRAS", 4),
#                    "SMAD4", "CDNK2A",
#                    "TP53", "TP53", "MLL3"),
#                child = c("KRAS","SMAD4", "CDNK2A",
#                    "TP53", "MLL3",
#                    rep("PXDN", 3), rep("TGFBR2", 2)),
#                s = 0.1,
#                sh = -0.9,
#                typeDep = "MN"),
#     drvNames = c("KRAS", "SMAD4", "CDNK2A", "TP53",
# 	             "MLL3", "TGFBR2", "PXDN"))
# 
# Nindiv <- 100 ## Number of simulations run.
#               ## Increase this number to decrease sampling variation
# 
# ## keepEvery = 1
# t_exp1 <- system.time(
#     exp1 <- oncoSimulPop(Nindiv, pancr,
#                          onlyCancer = TRUE,
#                          detectionProb = "default",
#                          detectionSize = NA,
#                          detectionDrivers = NA,
#                             finalTime = NA,
#                             keepEvery = 1,
#                             model = "Exp",
#                             mc.cores = 1))["elapsed"]/Nindiv
# 
# 
# t_mc1 <- system.time(
#     mc1 <- oncoSimulPop(Nindiv, pancr,
#                         onlyCancer = TRUE,
#                         detectionProb = "default",
#                         detectionSize = NA,
#                         detectionDrivers = NA,
#                            finalTime = NA,
#                            keepEvery = 1,
#                            model = "McFL",
#                            mc.cores = 1))["elapsed"]/Nindiv
# 
# ## keepEvery = NA
# t_exp2 <- system.time(
#     exp2 <- oncoSimulPop(Nindiv, pancr,
#                          onlyCancer = TRUE,
#                          detectionProb = "default",
#                          detectionSize = NA,
#                             detectionDrivers = NA,
#                             finalTime = NA,
#                             keepEvery = NA,
#                             model = "Exp",
#                             mc.cores = 1))["elapsed"]/Nindiv
# 
# 
# t_mc2 <- system.time(
#     mc2 <- oncoSimulPop(Nindiv, pancr,
#                         onlyCancer = TRUE,
#                         detectionProb = "default",
#                         detectionSize = NA,
#                            detectionDrivers = NA,
#                            finalTime = NA,
#                            keepEvery = NA,
#                            model = "McFL",
#                            mc.cores = 1))["elapsed"]/Nindiv
# 
# 

## ----eval=FALSE---------------------------------------------------
# cat("\n\n\n t_exp1 = ", t_exp1, "\n")
# object.size(exp1)/(Nindiv * 1024^2)
# cat("\n\n")
# summary(unlist(lapply(exp1, "[[", "NumClones")))
# summary(unlist(lapply(exp1, "[[", "NumIter")))
# summary(unlist(lapply(exp1, "[[", "FinalTime")))
# summary(unlist(lapply(exp1, "[[", "TotalPopSize")))

## ----bench1, eval=TRUE, echo = FALSE------------------------------

panderOptions('table.split.table', 99999999)
panderOptions('table.split.cells', 900)  ## For HTML
## panderOptions('table.split.cells', 8) ## For PDF

set.alignment('right')
panderOptions('round', 2)
panderOptions('big.mark', ',')
panderOptions('digits', 2)

pander(benchmark_1[1:4, c("Elapsed Time, average per simulation (s)",
 	              "Object Size, average per simulation (MB)",
 				  "Number of Clones, median",
 				  "Number of Iterations, median",
 				  "Final Time, median",
 				  "Total Population Size, median",
 				  "Total Population Size, max.",
 				  "keepEvery")],
				  justify = c('left', rep('right', 8)), ##  o.w. hlines not right
				  ## caption = "\\label{tab:bench1}Benchmarks of Exp and McFL  models using the default `detectionProb` with two settings of `keepEvery`."
				  )

## ----timing2, eval = FALSE----------------------------------------
# t_exp3 <- system.time(
#     exp3 <- oncoSimulPop(Nindiv, pancr,
#                          onlyCancer = TRUE,
#                          detectionProb = c(PDBaseline = 5e4,
#                                            p2 = 0.1, n2 = 5e5,
#                                            checkSizePEvery = 20),
#                          detectionSize = NA,
#                          detectionDrivers = NA,
#                             finalTime = NA,
#                             keepEvery = 1,
#                             model = "Exp",
#                             mc.cores = 1))["elapsed"]/Nindiv
# 
# t_exp4 <- system.time(
#     exp4 <- oncoSimulPop(Nindiv, pancr,
#                          onlyCancer = TRUE,
#                          detectionProb = c(PDBaseline = 5e4,
#                                            p2 = 0.1, n2 = 5e5,
#                                            checkSizePEvery = 20),
#                          detectionSize = NA,
#                          detectionDrivers = NA,
#                             finalTime = NA,
#                             keepEvery = NA,
#                             model = "Exp",
#                             mc.cores = 1))["elapsed"]/Nindiv
# 
# 
# 
# t_exp5 <- system.time(
#     exp5 <- oncoSimulPop(Nindiv, pancr,
#                          onlyCancer = TRUE,
#                          detectionProb = c(PDBaseline = 5e5,
#                                            p2 = 0.1, n2 = 5e7),
#                          detectionSize = NA,
#                          detectionDrivers = NA,
#                             finalTime = NA,
#                             keepEvery = 1,
#                             model = "Exp",
#                             mc.cores = 1))["elapsed"]/Nindiv
# 
# t_exp6 <- system.time(
#     exp6 <- oncoSimulPop(Nindiv, pancr,
#                          onlyCancer = TRUE,
#                          detectionProb = c(PDBaseline = 5e5,
#                                            p2 = 0.1, n2 = 5e7),
#                          detectionSize = NA,
#                          detectionDrivers = NA,
#                             finalTime = NA,
#                             keepEvery = NA,
#                             model = "Exp",
#                             mc.cores = 1))["elapsed"]/Nindiv
# 

## ----bench1b, eval=TRUE, echo = FALSE-----------------------------
panderOptions('table.split.table', 99999999)
panderOptions('table.split.cells', 900)  ## For HTML
## panderOptions('table.split.cells', 8) ## For PDF

set.alignment('right')
panderOptions('round', 2)
panderOptions('big.mark', ',')
panderOptions('digits', 2)

pander(benchmark_1[5:8, c("Elapsed Time, average per simulation (s)",
 	              "Object Size, average per simulation (MB)",
 				  "Number of Clones, median",
 				  "Number of Iterations, median",
 				  "Final Time, median",
 				  "Total Population Size, median",
 				  "Total Population Size, max.",
 				  "keepEvery",
				  "PDBaseline",
				  "n2")],
				  justify = c('left', rep('right', 10)), ##  o.w. hlines not right
## 				  round = c(rep(2, 3), rep(0, 7)),
## 				  digits = c(rep(2, 3), rep(1, 7)),
	  ## caption = "\\label{tab:bench1b}Benchmarks of Exp and McFL models modifying the default `detectionProb` with two settings of `keepEvery`."
    )


## ----bench1c, eval=TRUE, echo = FALSE-----------------------------
panderOptions('table.split.table', 99999999)
panderOptions('table.split.cells', 900)  ## For HTML
## panderOptions('table.split.cells', 12) ## For PDF
set.alignment('right')
panderOptions('round', 2)
panderOptions('big.mark', ',')
panderOptions('digits', 2)

pander(benchmark_1[1:8, c(
"Attempts until Cancer, median",
"Attempts until Cancer, mean",
"Attempts until Cancer, max.",
				  "PDBaseline",
				  "n2")],
				  justify = c('left', rep('right', 5)), ##  o.w. hlines not right
## 				  round = c(rep(2, 3), rep(0, 7)),
## 				  digits = c(rep(2, 3), rep(1, 7)),
	  ## caption = "\\label{tab:bench1c}Number of attempts until cancer."
    )
## ## data(benchmark_1)
## knitr::kable(benchmark_1[1:8, c("Attempts.Median",
##                                 "PDBaseline", "n2"), drop = FALSE],
##     booktabs = TRUE,
## 	row.names = TRUE,
## 	col.names = c("Attempts until cancer", "PDBaseline", "n2"),
##     caption = "Median number of attempts until cancer.",
## 	align = "r")


## ----bench1d, eval=TRUE, echo = FALSE-----------------------------
panderOptions('table.split.table', 99999999)
panderOptions('table.split.cells', 900)  ## For HTML
## panderOptions('table.split.cells', 8) ## For PDF
panderOptions('table.split.cells', 15) ## does not fit otherwise
set.alignment('right')
panderOptions('round', 3)

pander(benchmark_1[9:16,
    c("Elapsed Time, average per simulation (s)",
 	              "Object Size, average per simulation (MB)",
 				  "Number of Clones, median",
 				  "Number of Iterations, median",
 				  "Final Time, median",
 				  "Total Population Size, median",
				  "Total Population Size, mean",
 				  "Total Population Size, max.",
 				  "keepEvery",
				  "PDBaseline",
				  "n2")],
				  justify = c('left', rep('right', 11)), ##  o.w. hlines not right
## caption = "\\label{tab:timing3} Benchmarks of models in Table \\@ref(tab:bench1) and \\@ref(tab:bench1b) when run with `onlyCancer = FALSE`."
				  )


## ----bench1dx0, eval=TRUE, echo = FALSE---------------------------
panderOptions('table.split.table', 99999999)
## panderOptions('table.split.cells', 900)  ## For HTML
panderOptions('table.split.cells', 19)

set.alignment('right')
panderOptions('round', 3)

pander(benchmark_1[ , c("Elapsed Time, average per simulation (s)",
 	              "Object Size, average per simulation (MB)",
				  "Number of Clones, median",
				  "Number of Iterations, median",
				  "Final Time, median", "Total Population Size, median",
				  "Total Population Size, mean", "Total Population Size, max.",
 	              "keepEvery", "PDBaseline", "n2", "onlyCancer")],
				  justify = c('left', rep('right', 12)), ##  o.w. hlines not right
				  ## caption = "\\label{tab:allr1bck}Benchmarks of all models in Tables \\@ref(tab:bench1), \\@ref(tab:bench1b),  and \\@ref(tab:timing3)."
				  )

## ----bench1dx, eval=TRUE, echo = FALSE----------------------------
## data(benchmark_1_0.05)
## knitr::kable(benchmark_1_0.05[, c("time_per_simul",
##     "size_mb_per_simul", "NumClones.Median", "NumIter.Median",
## 	"FinalTime.Median", "TotalPopSize.Median", "TotalPopSize.Mean",
## 	"TotalPopSize.Max.",
## 	"keepEvery",
## 	"PDBaseline", "n2", "onlyCancer")],
##     booktabs = TRUE,
## 	col.names = c("Elapsed Time, average per simulation (s)",
## 	              "Object Size, average per simulation (MB)",
## 				  "Number of Clones, median",
## 				  "Number of Iterations, median",
## 				  "Final Time, median",
## 				  "Total Population Size, median",
## 				  "Total Population Size, mean",
## 				  "Total Population Size, max.",
## 				  "keepEvery",
## 				  "PDBaseline", "n2", "onlyCancer"
## 				  ),
## ##    caption = "Benchmarks of models in Table \@ref(tab:bench1) and
## ##   \@ref(tab:bench1b) when run with `onlyCancer = FALSE`",
## 	align = "c")

panderOptions('table.split.table', 99999999)
## panderOptions('table.split.cells', 900)  ## For HTML
panderOptions('table.split.cells', 19)

set.alignment('right')
panderOptions('round', 3)

pander(benchmark_1_0.05[ , c("Elapsed Time, average per simulation (s)",
 	              "Object Size, average per simulation (MB)",
				  "Number of Clones, median",
				  "Number of Iterations, median",
				  "Final Time, median",
				  "Total Population Size, median",
				  "Total Population Size, mean", "Total Population Size, max.",
 	              "keepEvery", "PDBaseline", "n2", "onlyCancer")],
				  justify = c('left', rep('right', 12)), ##  o.w. hlines not right
 	              ## caption = "\\label{tab:timing3xf}Benchmarks of all models in Table \\@ref(tab:allr1bck) using $s=0.05$ (instead of $s=0.1$)."
)


## ----fitusualb, echo = TRUE, eval = FALSE-------------------------
# pancr <- allFitnessEffects(
#     data.frame(parent = c("Root", rep("KRAS", 4),
#                    "SMAD4", "CDNK2A",
#                    "TP53", "TP53", "MLL3"),
#                child = c("KRAS","SMAD4", "CDNK2A",
#                    "TP53", "MLL3",
#                    rep("PXDN", 3), rep("TGFBR2", 2)),
#                s = 0.1,
#                sh = -0.9,
#                typeDep = "MN"),
#     drvNames = c("KRAS", "SMAD4", "CDNK2A", "TP53",
# 	             "MLL3", "TGFBR2", "PXDN"))
# 
# 
# ## Random fitness landscape with 6 genes
# ## At least 50 accessible genotypes
# rfl6 <- rfitness(6, min_accessible_genotypes = 50)
# attributes(rfl6)$accessible_genotypes ## How many accessible
# rf6 <- allFitnessEffects(genotFitness = rfl6)
# 
# 
# ## Random fitness landscape with 12 genes
# ## At least 200 accessible genotypes
# rfl12 <- rfitness(12, min_accessible_genotypes = 200)
# attributes(rfl12)$accessible_genotypes ## How many accessible
# rf12 <- allFitnessEffects(genotFitness = rfl12)
# 
# 
# 
# 
# ## Independent genes; positive fitness from exponential distribution
# ## with mean around 0.1, and negative from exponential with mean
# ## around -0.02. Half of genes positive fitness effects, half
# ## negative.
# 
# ng <- 200 re_200 <- allFitnessEffects(noIntGenes = c(rexp(ng/2, 10),
# -rexp(ng/2, 50)))
# 
# ng <- 500
# re_500 <- allFitnessEffects(noIntGenes = c(rexp(ng/2, 10),
#                                            -rexp(ng/2, 50)))
# 
# ng <- 2000
# re_2000 <- allFitnessEffects(noIntGenes = c(rexp(ng/2, 10),
#                                             -rexp(ng/2, 50)))
# 
# ng <- 4000
# re_4000 <- allFitnessEffects(noIntGenes = c(rexp(ng/2, 10),
#                                             -rexp(ng/2, 50)))
# 

## ----exp-usual-r, eval = FALSE, echo = TRUE-----------------------
# 
# oncoSimulPop(Nindiv,
#             fitness,
#             detectionProb = NA,
#             detectionSize = 1e6,
#             initSize = 500,
#             detectionDrivers = NA,
#             keepPhylog = TRUE,
#             model = "Exp",
#             errorHitWallTime = FALSE,
#             errorHitMaxTries = FALSE,
#             finalTime = 5000,
#             onlyCancer = FALSE,
#             mc.cores = 1,
#             sampleEvery = 0.5,
# 			keepEvery = 1)

## ----mc-usual-r, eval = FALSE, echo = TRUE------------------------
# initSize <- 1000
# oncoSimulPop(Nindiv,
#               fitness,
#                detectionProb = c(
#                    PDBaseline = 1.4 * initSize,
#                    n2 = 2 * initSize,
#                    p2 = 0.1,
#                    checkSizePEvery = 4),
#                initSize = initSize,
#                detectionSize = NA,
#                detectionDrivers = NA,
#                keepPhylog = TRUE,
#                model = "McFL",
#                errorHitWallTime = FALSE,
#                errorHitMaxTries = FALSE,
#                finalTime = 5000,
#                max.wall.time = 10,
#                onlyCancer = FALSE,
#                mc.cores = 1,
# 			   keepEvery = 1)
# 

## ----benchustable, eval=TRUE, echo = FALSE------------------------
## data(benchmark_2)

## knitr::kable(benchmark_2[, c("Model", "fitness", "time_per_simul",
##     "size_mb_per_simul", "NumClones.Median", "NumIter.Median",
## 	"FinalTime.Median", "TotalPopSize.Median", "TotalPopSize.Mean",
## 	"TotalPopSize.Max.")],
##     booktabs = TRUE,
## 	col.names = c("Model",
## 				  "Fitness",
## 	"Elapsed Time, average per simulation (s)",
## 	              "Object Size, average per simulation (MB)",
## 				  "Number of Clones, median",
## 				  "Number of Iterations, median",
## 				  "Final Time, median",
## 				  "Total Population Size, median",
## 				  "Total Population Size, mean",
## 				  "Total Population Size, max."
## 				  ),
## 	align = "c")

panderOptions('table.split.table', 99999999)
panderOptions('table.split.cells', 900)  ## For HTML
## panderOptions('table.split.cells', 8) ## For PDF

## set.alignment('right', row.names = 'center')
panderOptions('table.alignment.default', 'right')

panderOptions('round', 3)

pander(benchmark_2[ , c(
    "Model", "Fitness",
    "Elapsed Time, average per simulation (s)",
 	              "Object Size, average per simulation (MB)",
 				  "Number of Clones, median",
 				  "Number of Iterations, median",
 				  "Final Time, median",
 				  "Total Population Size, median",
 				  "Total Population Size, mean",
 				  "Total Population Size, max.")],
				  justify = c('left', 'left', rep('right', 8)),
				  ## caption = "\\label{tab:timingusual}Benchmarks under some common use cases, set 1."
				  )


## ----benchustable2, eval=TRUE, echo = FALSE-----------------------
## data(benchmark_3)

## knitr::kable(benchmark_3[, c("Model", "fitness", "time_per_simul",
##     "size_mb_per_simul", "NumClones.Median", "NumIter.Median",
## 	"FinalTime.Median", "TotalPopSize.Median", "TotalPopSize.Mean",
## 	"TotalPopSize.Max.")],
##     booktabs = TRUE,
## 	col.names = c("Model",
## 				  "Fitness", "Elapsed Time, average per simulation (s)",
## 	              "Object Size, average per simulation (MB)",
## 				  "Number of Clones, median",
## 				  "Number of Iterations, median",
## 				  "Final Time, median",
## 				  "Total Population Size, median",
## 				  "Total Population Size, mean",
## 				  "Total Population Size, max."
## 				  ),
## 	align = "c")

panderOptions('table.split.table', 99999999)
panderOptions('table.split.cells', 900)  ## For HTML
## panderOptions('table.split.cells', 8) ## For PDF


panderOptions('round', 3)
panderOptions('table.alignment.default', 'right')

pander(benchmark_3[ , c(
    "Model", "Fitness",
    "Elapsed Time, average per simulation (s)",
 	              "Object Size, average per simulation (MB)",
 				  "Number of Clones, median",
 				  "Number of Iterations, median",
 				  "Final Time, median",
 				  "Total Population Size, median",
 				  "Total Population Size, mean",
 				  "Total Population Size, max.")],
				  justify = c('left', 'left', rep('right', 8)),
				  ## caption = "\\label{tab:timingusual2}Benchmarks under some common use cases, set 2."
				  )

## ----exp10000, echo = TRUE, eval = FALSE--------------------------
# ng <- 10000
# u <- allFitnessEffects(noIntGenes = c(rep(0.1, ng/2),
#                                       rep(-0.1, ng/2)))
# 
# t_e_10000 <- system.time(
#     e_10000 <- oncoSimulPop(5, u, model = "Exp", mu = 1e-7,
#                             detectionSize = 1e6,
#                             detectionDrivers = NA,
#                             detectionProb = NA,
#                             keepPhylog = TRUE,
#                             onlyCancer = FALSE,
#                             mutationPropGrowth = TRUE,
#                             mc.cores = 1))

## ----exp10000-out, echo = TRUE, eval = FALSE----------------------
# t_e_10000
# ##    user  system elapsed
# ##   4.368   0.196   4.566
# 
# summary(e_10000)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      5017      1180528       415116       143    7547
# ## 2      3726      1052061       603612       131    5746
# ## 3      4532      1100721       259510       132    6674
# ## 4      4150      1283115       829728        99    6646
# ## 5      4430      1139185       545958       146    6748
# 
# print(object.size(e_10000), units = "MB")
# ## 863.9 Mb
# 

## ----exp10000b, eval = FALSE, echo = TRUE-------------------------
# t_e_10000b <- system.time(
#     e_10000b <- oncoSimulPop(5,
#                              u,
#                              model = "Exp",
#                              mu = 1e-7,
#                              detectionSize = 1e6,
#                              detectionDrivers = NA,
#                              detectionProb = NA,
#                              keepPhylog = TRUE,
#                              onlyCancer = FALSE,
#                              keepEvery = NA,
#                              mutationPropGrowth = TRUE,
#                              mc.cores = 1
#                              ))
# 

## ----exp10000b-out, echo = TRUE, eval = FALSE---------------------
# t_e_10000b
# ##    user  system elapsed
# ##   5.484   0.100   5.585
# 
# summary(e_10000b)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      2465      1305094       727989        91    6447
# ## 2      2362      1070225       400329       204    8345
# ## 3      2530      1121164       436721       135    8697
# ## 4      2593      1206293       664494       125    8149
# ## 5      2655      1186994       327835       191    8572
# 
# print(object.size(e_10000b), units = "MB")
# ## 488.3 Mb
# 

## ----exp50000, echo = TRUE, eval = FALSE--------------------------
# ng <- 50000
# u <- allFitnessEffects(noIntGenes = c(rep(0.1, ng/2),
#                                       rep(-0.1, ng/2)))
# t_e_50000 <- system.time(
#     e_50000 <- oncoSimulPop(5,
#                             u,
#                             model = "Exp",
#                             mu = 1e-7,
#                             detectionSize = 1e6,
#                             detectionDrivers = NA,
#                             detectionProb = NA,
#                             keepPhylog = TRUE,
#                             onlyCancer = FALSE,
#                             keepEvery = NA,
#                             mutationPropGrowth = FALSE,
#                             mc.cores = 1
#                             ))
# 
# 
# t_e_50000
# ##    user  system elapsed
# ##  44.192   1.684  45.891
# 
# summary(e_50000)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      7367      1009949       335455     75.00   18214
# ## 2      8123      1302324       488469     63.65   17379
# ## 3      8408      1127261       270690     72.57   21144
# ## 4      8274      1138513       318152     80.59   20994
# ## 5      7520      1073131       690814     70.00   18569
# 
# print(object.size(e_50000), units = "MB")
# ## 7598.6 Mb

## ----exp50000np, echo = TRUE, eval = FALSE------------------------
# ng <- 50000
# u <- allFitnessEffects(noIntGenes = c(rep(0.1, ng/2),
#                                       rep(-0.1, ng/2)))
# t_e_50000np <- system.time(
#     e_50000np <- oncoSimulPop(5,
#                               u,
#                               model = "Exp",
#                               mu = 1e-7,
#                               detectionSize = 1e6,
#                               detectionDrivers = NA,
#                               detectionProb = NA,
#                               keepPhylog = TRUE,
#                               onlyCancer = FALSE,
#                               keepEvery = 1,
#                               mutationPropGrowth = FALSE,
#                               mc.cores = 1
#                               ))
# 
# t_e_50000np
# ##   user  system elapsed
# ## 42.316   2.764  45.079
# 
# summary(e_50000np)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1     13406      1027949       410074     71.97   19469
# ## 2     12469      1071325       291852     66.00   17834
# ## 3     11821      1089834       245720     90.00   16711
# ## 4     14008      1165168       505607     77.61   19675
# ## 5     14759      1074621       205954     87.68   20597
# 
# print(object.size(e_50000np), units = "MB")
# ## 12748.4 Mb
# 

## ----exp50000mpg, echo = TRUE, eval = FALSE-----------------------
# 
# ng <- 50000
# u <- allFitnessEffects(noIntGenes = c(rep(0.1, ng/2),
#                                       rep(-0.1, ng/2)))
# 
# t_e_50000c <- system.time(
#     e_50000c <- oncoSimulPop(5,
#                              u,
#                              model = "Exp",
#                              mu = 1e-7,
#                              detectionSize = 1e6,
#                              detectionDrivers = NA,
#                              detectionProb = NA,
#                              keepPhylog = TRUE,
#                              onlyCancer = FALSE,
#                              keepEvery = NA,
#                              mutationPropGrowth = TRUE,
#                              mc.cores = 1
#                              ))
# 
# t_e_50000c
# ##    user  system elapsed
# ## 84.228   2.416  86.665
# 
# summary(e_50000c)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1     11178      1241970       344479     84.74   27137
# ## 2     12820      1307086       203544     91.94   33448
# ## 3     10592      1126091       161057     83.81   26064
# ## 4     11883      1351114       148986     65.68   25396
# ## 5     10518      1101392       253523     99.79   26082
# 
# print(object.size(e_50000c), units = "MB")
# ## 10904.9 Mb
# 

## ----sizedetail, eval = FALSE, echo = TRUE------------------------
# r1 <- oncoSimulIndiv(u,
#                      model = "Exp",
#                      mu = 1e-7,
#                      detectionSize = 1e6,
#                      detectionDrivers = NA,
#                      detectionProb = NA,
#                      keepPhylog = TRUE,
#                      onlyCancer = FALSE,
#                      mutationPropGrowth = TRUE
#                      )
# summary(r1)[c(1, 8)]
# ##   NumClones  FinalTime
# ## 1      3887        345
# 
# print(object.size(r1), units = "MB")
# ## 160 Mb
# 
# ## Size of the two largest objects inside:
# sizes <- lapply(r1, function(x) object.size(x)/(1024^2))
# sort(unlist(sizes), decreasing = TRUE)[1:2]
# ## Genotypes pops.by.time
# ##       148.28        10.26
# 
# dim(r1$Genotypes)
# ## [1] 10000  3887

## ----mc50000_1, echo = TRUE, eval = FALSE-------------------------
# ng <- 50000
# u <- allFitnessEffects(noIntGenes = c(rep(0.1, ng/2),
#                                       rep(-0.1, ng/2)))
# 
# t_mc_50000_nmpg <- system.time(
#     mc_50000_nmpg <- oncoSimulPop(5,
#                                   u,
#                                   model = "McFL",
#                                   mu = 1e-7,
#                                   detectionSize = 1e6,
#                                   detectionDrivers = NA,
#                                   detectionProb = NA,
#                                   keepPhylog = TRUE,
#                                   onlyCancer = FALSE,
#                                   keepEvery = NA,
#                                   mutationPropGrowth = FALSE,
#                                   mc.cores = 1
#                                   ))
# t_mc_50000_nmpg
# ##   user  system elapsed
# ##  30.46    0.54   31.01
# 
# 
# summary(mc_50000_nmpg)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      1902      1002528       582752     284.2   31137
# ## 2      2159      1002679       404858     274.8   36905
# ## 3      2247      1002722       185678     334.5   42429
# ## 4      2038      1009606       493574     218.4   32519
# ## 5      2222      1004661       162628     291.0   38470
# 
# print(object.size(mc_50000_nmpg), units = "MB")
# ## 2057.6 Mb
# 

## ----mc50000_kp, echo = TRUE, eval = FALSE------------------------
# t_mc_50000_nmpg_k <- system.time(
#     mc_50000_nmpg_k <- oncoSimulPop(5,
#                                     u,
#                                     model = "McFL",
#                                     mu = 1e-7,
#                                     detectionSize = 1e6,
#                                     detectionDrivers = NA,
#                                     detectionProb = NA,
#                                     keepPhylog = TRUE,
#                                     onlyCancer = FALSE,
#                                     keepEvery = 1,
#                                     mutationPropGrowth = FALSE,
#                                     mc.cores = 1
#                                     ))
# 
# t_mc_50000_nmpg_k
# ##    user  system elapsed
# ##  30.000   1.712  31.714
# 
# summary(mc_50000_nmpg_k)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      8779      1000223       136453     306.7   38102
# ## 2      7442      1006563       428150     345.3   35139
# ## 3      8710      1003509       224543     252.3   35659
# ## 4      8554      1002537       103889     273.7   36783
# ## 5      8233      1003171       263005     301.8   35236
# 
# print(object.size(mc_50000_nmpg_k), units = "MB")
# ## 8101.4 Mb

## ----mc50000_popx, echo = TRUE, eval = FALSE----------------------
# ng <- 50000
# u <- allFitnessEffects(noIntGenes = c(rep(0.1, ng/2),
#                                       rep(-0.1, ng/2)))
# 
# t_mc_50000_nmpg_3e6 <- system.time(
#     mc_50000_nmpg_3e6 <- oncoSimulPop(5,
#                                       u,
#                                       model = "McFL",
#                                       mu = 1e-7,
#                                       detectionSize = 3e6,
#                                       detectionDrivers = NA,
#                                       detectionProb = NA,
#                                       keepPhylog = TRUE,
#                                       onlyCancer = FALSE,
#                                       keepEvery = NA,
#                                       mutationPropGrowth = FALSE,
#                                       mc.cores = 1
#                                       ))
# t_mc_50000_nmpg_3e6
# ##    user  system elapsed
# ##  77.240   1.064  78.308
# 
# summary(mc_50000_nmpg_3e6)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      5487      3019083       836793     304.5   65121
# ## 2      4812      3011816       789146     286.3   53087
# ## 3      4463      3016896      1970957     236.6   45918
# ## 4      5045      3028142       956026     360.3   63464
# ## 5      4791      3029720       916692     358.1   55012
# 
# print(object.size(mc_50000_nmpg_3e6), units = "MB")
# ## 4759.3 Mb
# 

## ----mc50000_mux, echo = TRUE, eval = FALSE-----------------------
# 
# t_mc_50000_nmpg_5mu <- system.time(
#     mc_50000_nmpg_5mu <- oncoSimulPop(5,
#                                       u,
#                                       model = "McFL",
#                                       mu = 5e-7,
#                                       detectionSize = 1e6,
#                                       detectionDrivers = NA,
#                                       detectionProb = NA,
#                                       keepPhylog = TRUE,
#                                       onlyCancer = FALSE,
#                                       keepEvery = NA,
#                                       mutationPropGrowth = FALSE,
#                                       mc.cores = 1
#                                       ))
# 
# t_mc_50000_nmpg_5mu
# ##    user  system elapsed
# ## 167.332   1.796 169.167
# 
# summary(mc_50000_nmpg_5mu)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      7963      1004415       408352     99.03   57548
# ## 2      8905      1010751       120155    130.30   74738
# ## 3      8194      1005465       274661     96.98   58546
# ## 4      9053      1014049       119943    112.23   75379
# ## 5      8982      1011817        95047     99.95   76757
# 
# print(object.size(mc_50000_nmpg_5mu), units = "MB")
# ## 8314.4 Mb

## ----mcf5muk, echo = TRUE, eval = FALSE---------------------------
# t_mc_50000_nmpg_5mu_k <- system.time(
#     mc_50000_nmpg_5mu_k <- oncoSimulPop(5,
#                                         u,
#                                         model = "McFL",
#                                         mu = 5e-7,
#                                         detectionSize = 1e6,
#                                         detectionDrivers = NA,
#                                         detectionProb = NA,
#                                         keepPhylog = TRUE,
#                                         onlyCancer = FALSE,
#                                         keepEvery = 1,
#                                         mutationPropGrowth = FALSE,
#                                         mc.cores = 1
#                                         ))
# 
# t_mc_50000_nmpg_5mu_k
# ##    user  system elapsed
# ## 174.404   5.068 179.481
# 
# summary(mc_50000_nmpg_5mu_k)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1     25294      1001597       102766     123.4   74524
# ## 2     23766      1006679       223010     124.3   71808
# ## 3     21755      1001379       203638     114.8   62609
# ## 4     24889      1012103       161003     119.3   75031
# ## 5     21844      1002927       255388     108.8   64556
# 
# print(object.size(mc_50000_nmpg_5mu_k), units = "MB")
# ## 22645.8 Mb
# 

## ----mc50000_2, echo = TRUE, eval = FALSE-------------------------
# 
# t_mc_50000 <- system.time(
#     mc_50000 <- oncoSimulPop(5,
#                              u,
#                              model = "McFL",
#                              mu = 1e-7,
#                              detectionSize = 1e6,
#                              detectionDrivers = NA,
#                              detectionProb = NA,
#                              keepPhylog = TRUE,
#                              onlyCancer = FALSE,
#                              keepEvery = NA,
#                              mutationPropGrowth = TRUE,
#                              mc.cores = 1
#                              ))
# 
# t_mc_50000
# ##    user  system elapsed
# ## 303.352   2.808 306.223
# 
# summary(mc_50000)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1     13928      1010815       219814     210.9   91255
# ## 2     12243      1003267       214189     178.1   67673
# ## 3     13880      1014131       124354     161.4   88322
# ## 4     14104      1012941        75521     205.7   98583
# ## 5     12428      1005594       232603     167.4   70359
# 
# print(object.size(mc_50000), units = "MB")
# ## 12816.6 Mb
# 

## ----mcf5muk005, echo = TRUE, eval = FALSE------------------------
# t_mc_50000_nmpg_5mu_k <- system.time(
#     mc_50000_nmpg_5mu_k <- oncoSimulPop(2,
#                                         u,
#                                         model = "McFL",
#                                         mu = 5e-7,
#                                         detectionSize = 1e6,
#                                         detectionDrivers = NA,
#                                         detectionProb = NA,
#                                         keepPhylog = TRUE,
#                                         onlyCancer = FALSE,
#                                         keepEvery = 1,
#                                         mutationPropGrowth = FALSE,
#                                         mc.cores = 1
#                                         ))
# t_mc_50000_nmpg_5mu_k
# ##    user  system elapsed
# ## 305.512   5.164 310.711
# 
# summary(mc_50000_nmpg_5mu_k)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1     61737      1003273       104460  295.8731  204214
# ## 2     65072      1000540       133068  296.6243  210231
# 
# print(object.size(mc_50000_nmpg_5mu_k), units = "MB")
# ## 24663.6 Mb
# 

## ----mc50000_1_005, echo = TRUE, eval = FALSE---------------------
# t_mc_50000_nmpg <- system.time(
#     mc_50000_nmpg <- oncoSimulPop(5,
#                                   u,
#                                   model = "McFL",
#                                   mu = 1e-7,
#                                   detectionSize = 1e6,
#                                   detectionDrivers = NA,
#                                   detectionProb = NA,
#                                   keepPhylog = TRUE,
#                                   onlyCancer = FALSE,
#                                   keepEvery = NA,
#                                   mutationPropGrowth = FALSE,
#                                   mc.cores = 1
#                                   ))
# t_mc_50000_nmpg
# ##    user  system elapsed
# ## 111.236   0.596 111.834
# 
# summary(mc_50000_nmpg)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      2646      1000700       217188   734.475  108566
# ## 2      2581      1001626       209873   806.500  107296
# ## 3      2903      1001409       125148   841.700  120859
# ## 4      2310      1000146       473948   906.300   91519
# ## 5      2704      1001290       448409   838.800  103556
# 
# print(object.size(mc_50000_nmpg), units = "MB")
# ## 2638.3 Mb
# 

## ----filog_exp50000_1, echo = TRUE, eval = FALSE------------------
# head(e_50000[[1]]$other$PhylogDF)
# ##   parent child   time
# ## 1         3679 0.8402
# ## 2         4754 1.1815
# ## 3        20617 1.4543
# ## 4        15482 2.3064
# ## 5         4431 3.7130
# ## 6        41915 4.0628
# 
# tail(e_50000[[1]]$other$PhylogDF)
# ##                          parent                            child time
# ## 20672               3679, 20282               3679, 20282, 22359 75.0
# ## 20673        3679, 17922, 22346        3679, 17922, 22346, 35811 75.0
# ## 20674                2142, 3679                2142, 3679, 25838 75.0
# ## 20675        3679, 17922, 19561        3679, 17922, 19561, 43777 75.0
# ## 20676 3679, 15928, 19190, 20282 3679, 15928, 19190, 20282, 49686 75.0
# ## 20677         2142, 3679, 16275         2142, 3679, 16275, 24201 75.0

## ----noplotlconephylog, echo = TRUE, eval = FALSE-----------------
# plotClonePhylog(e_50000[[1]]) ## plot not shown
# 

## ----ex-large-pop-size, eval = FALSE, echo = TRUE-----------------
# ng <- 50
# u <- allFitnessEffects(noIntGenes = c(rep(0.1, ng)))

## ----ex-large-mf, eval = FALSE, echo = TRUE-----------------------
# t_mc_k_50_1e11 <- system.time(
#     mc_k_50_1e11 <- oncoSimulPop(5,
#                                  u,
#                                  model = "McFL",
#                                  mu = 1e-7,
#                                  detectionSize = 1e11,
#                                  initSize = 1e5,
#                                  detectionDrivers = NA,
#                                  detectionProb = NA,
#                                  keepPhylog = TRUE,
#                                  onlyCancer = FALSE,
#                                  mutationPropGrowth = FALSE,
#                                  keepEvery = 1,
#                                  finalTime = 5000,
#                                  mc.cores = 1,
#                                  max.wall.time = 600
#                                  ))
# 
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# 
# t_mc_k_50_1e11
# ## user  system elapsed
# ## 613.612   0.040 613.664
# 
# summary(mc_k_50_1e11)[, c(1:3, 8, 9)]
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      5491 100328847809  44397848771  1019.950  942764
# ## 2      3194 100048090441  34834178374   789.675  888819
# ## 3      5745 100054219162  24412502660   927.950  929231
# ## 4      4017 101641197799  60932177160   750.725  480938
# ## 5      5393 100168156804  41659212367   846.250  898245
# 
# ## print(object.size(mc_k_50_1e11), units = "MB")
# ## 177.8 Mb
# 

## ----ex-large-exp, eval = FALSE, echo = TRUE----------------------
# t_exp_k_50_1e11 <- system.time(
#     exp_k_50_1e11 <- oncoSimulPop(5,
#                                   u,
#                                   model = "Exp",
#                                   mu = 1e-7,
#                                   detectionSize = 1e11,
#                                   initSize = 1e5,
#                                   detectionDrivers = NA,
#                                   detectionProb = NA,
#                                   keepPhylog = TRUE,
#                                   onlyCancer = FALSE,
#                                   mutationPropGrowth = FALSE,
#                                   keepEvery = 1,
#                                   finalTime = 5000,
#                                   mc.cores = 1,
#                                   max.wall.time = 600,
#                                   errorHitWallTime = FALSE,
#                                   errorHitMaxTries = FALSE
#                                   ))
# 
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Hitted wall time. Exiting.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Hitted wall time. Exiting.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Recoverable exception ti set to DBL_MIN. Rerunning.
# ## Hitted wall time. Exiting.
# ## Hitted wall time. Exiting.
# 
# t_exp_k_50_1e11
# ##     user   system  elapsed
# ## 2959.068    0.128 2959.556
# try(summary(exp_k_50_1e11)[, c(1:3, 8, 9)])
# ##   NumClones TotalPopSize LargestClone FinalTime NumIter
# ## 1      6078  65172752616  16529682757  235.7590 1883438
# ## 2      5370 106476643712  24662446729  232.0000 2516675
# ## 3      2711  21911284363  17945303353  224.8608  543698
# ## 4      2838  13241462284   2944300245  216.8091  372298
# ## 5      7289  76166784312  10941729810  240.0217 1999489
# 
# print(object.size(exp_k_50_1e11), units = "MB")
# ## 53.5 Mb
# 

## ----n73----------------------------------------------------------
m4 <- data.frame(G = c("WT", "A", "B", "A, B"), F = c(1, 2, 3, 4))

## ----n74----------------------------------------------------------
fem4 <- allFitnessEffects(genotFitness = m4)

## ----n75----------------------------------------------------------
try(plot(fem4))

## ----n76, fig.width=6.5, fig.height = 6.5-------------------------
plotFitnessLandscape(evalAllGenotypes(fem4))

## ----n78----------------------------------------------------------
evalAllGenotypes(fem4, addwt = TRUE)

## ----n79----------------------------------------------------------
plotFitnessLandscape(evalAllGenotypes(fem4))

## ----n80----------------------------------------------------------
m6 <- cbind(c(1, 1), c(1, 0), c(2, 3))
fem6 <- allFitnessEffects(genotFitness = m6)
evalAllGenotypes(fem6, addwt = TRUE)
## plot(fem6)

## ----n81, fig.width=6.5, fig.height = 6.5-------------------------
plotFitnessLandscape(evalAllGenotypes(fem6))

## ----rj68v3x------------------------------------------------------
r <- data.frame(Genotype = c("WT", "A", "B", "A, B"),
                 Fitness = c("10 * f_",
                             "10 * f_1",
                             "50 * f_2",
                             "200 * (f_1 + f_2) + 50 * f_1_2"))

afe <- allFitnessEffects(genotFitness = r,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel")

plotFitnessLandscape(evalAllGenotypes(afe,
                                      spPopSizes = c(WT = 2500, A = 2000,
                                                     B = 5500, "A, B" = 700)))


## ----j8hhkiu------------------------------------------------------
r <- data.frame(Genotype = c("WT", "A", "B", "A, B"),
                 Fitness = c("10 * f_",
                             "10 * f_A",
                             "50 * f_B",
                             "200 * (f_A + f_B) + 50 * f_A_B"))


## ----mcflparam----------------------------------------------------
sp <- 1e-3
spp <- -sp/(1 + sp)

## ----nx82---------------------------------------------------------

ai1 <- evalAllGenotypes(allFitnessEffects(
    noIntGenes = c(0.05, -.2, .1), frequencyDependentFitness = FALSE), order = FALSE)

## ----nx83---------------------------------------------------------
ai1

## ----nx84---------------------------------------------------------
all(ai1[, "Fitness"]  == c( (1 + .05), (1 - .2), (1 + .1),
       (1 + .05) * (1 - .2),
       (1 + .05) * (1 + .1),
       (1 - .2) * (1 + .1),
       (1 + .05) * (1 - .2) * (1 + .1)))


## ----nx85---------------------------------------------------------
(ai2 <- evalAllGenotypes(allFitnessEffects(
    noIntGenes = c(0.05, -.2, .1)), order = TRUE,
    addwt = TRUE))


## ----nx091, fig.height=4------------------------------------------
data(examplesFitnessEffects)
plot(examplesFitnessEffects[["cbn1"]])

## ----nx092--------------------------------------------------------

cs <-  data.frame(parent = c(rep("Root", 4), "a", "b", "d", "e", "c"),
                 child = c("a", "b", "d", "e", "c", "c", rep("g", 3)),
                 s = 0.1,
                 sh = -0.9,
                 typeDep = "MN")

cbn1 <- allFitnessEffects(cs)


## ----nx093, fig.height=3------------------------------------------
plot(cbn1)

## ----nx094, fig.height=5------------------------------------------
plot(cbn1, "igraph")

## ----nx095, fig.height=5------------------------------------------
library(igraph) ## to make the reingold.tilford layout available
plot(cbn1, "igraph", layout = layout.reingold.tilford)

## ----nx096--------------------------------------------------------
gfs <- evalAllGenotypes(cbn1, order = FALSE, addwt = TRUE)

gfs[1:15, ]

## ----nx097--------------------------------------------------------

c1 <- data.frame(parent = c(rep("Root", 4), "a", "b", "d", "e", "c"),
                 child = c("a", "b", "d", "e", "c", "c", rep("g", 3)),
                 s = c(0.01, 0.02, 0.03, 0.04, 0.1, 0.1, rep(0.2, 3)),
                 sh = c(rep(0, 4), c(-.1, -.2), c(-.05, -.06, -.07)),
                 typeDep = "MN")

try(fc1 <- allFitnessEffects(c1))


## ----nx098--------------------------------------------------------
c1 <- data.frame(parent = c(rep("Root", 4), "a", "b", "d", "e", "c"),
                 child = c("a", "b", "d", "e", "c", "c", rep("g", 3)),
                 s = c(0.01, 0.02, 0.03, 0.04, 0.1, 0.1, rep(0.2, 3)),
                 sh = c(rep(0, 4), c(-.9, -.9), rep(-.95, 3)),
                 typeDep = "MN")

cbn2 <- allFitnessEffects(c1)


## ----nx099--------------------------------------------------------
gcbn2 <- evalAllGenotypes(cbn2, order = FALSE)
gcbn2[1:10, ]

## ----nx0100-------------------------------------------------------
gcbn2o <- evalAllGenotypes(cbn2, order = TRUE, max = 1956)
gcbn2o[1:10, ]

## ----nx0101-------------------------------------------------------
all.equal(
        gcbn2[c(1:21, 22, 28, 41, 44, 56, 63 ) , "Fitness"],
        c(1.01, 1.02, 0.1, 1.03, 1.04, 0.05,
          1.01 * c(1.02, 0.1, 1.03, 1.04, 0.05),
          1.02 * c(0.10, 1.03, 1.04, 0.05),
          0.1 * c(1.03, 1.04, 0.05),
          1.03 * c(1.04, 0.05),
          1.04 * 0.05,
          1.01 * 1.02 * 1.1,
          1.01 * 0.1 * 0.05,
          1.03 * 1.04 * 0.05,
          1.01 * 1.02 * 1.1 * 0.05,
          1.03 * 1.04 * 1.2 * 0.1, ## notice this
          1.01 * 1.02 * 1.03 * 1.04 * 1.1 * 1.2
          ))

## ----nx0102-------------------------------------------------------
gcbn2[56, ]
all.equal(gcbn2[56, "Fitness"], 1.03 * 1.04 * 1.2 * 0.10)

## ----nx0103-------------------------------------------------------

s1 <- data.frame(parent = c(rep("Root", 4), "a", "b", "d", "e", "c"),
                 child = c("a", "b", "d", "e", "c", "c", rep("g", 3)),
                 s = c(0.01, 0.02, 0.03, 0.04, 0.1, 0.1, rep(0.2, 3)),
                 sh = c(rep(0, 4), c(-.9, -.9), rep(-.95, 3)),
                 typeDep = "SM")

smn1 <- allFitnessEffects(s1)


## ----nx0104, fig.height=3-----------------------------------------
plot(smn1)

## ----nx0105-------------------------------------------------------
gsmn1 <- evalAllGenotypes(smn1, order = FALSE)


## ----nx0106-------------------------------------------------------
gcbn2[c(8, 12, 22), ]
gsmn1[c(8, 12, 22), ]

gcbn2[c(20:21, 28), ]
gsmn1[c(20:21, 28), ]

## ----nx0107-------------------------------------------------------

x1 <- data.frame(parent = c(rep("Root", 4), "a", "b", "d", "e", "c"),
                 child = c("a", "b", "d", "e", "c", "c", rep("g", 3)),
                 s = c(0.01, 0.02, 0.03, 0.04, 0.1, 0.1, rep(0.2, 3)),
                 sh = c(rep(0, 4), c(-.9, -.9), rep(-.95, 3)),
                 typeDep = "XMPN")

xor1 <- allFitnessEffects(x1)


## ----nx0108, fig.height=3-----------------------------------------
plot(xor1)

## ----nx0109-------------------------------------------------------

gxor1 <- evalAllGenotypes(xor1, order = FALSE)


## ----nx0110-------------------------------------------------------
gxor1[c(22, 41), ]
c(1.01 * 1.02 * 0.1, 1.03 * 1.04 * 0.05)

## ----nx0111-------------------------------------------------------
gxor1[28, ]
1.01 * 1.1 * 1.2

## ----nx0112-------------------------------------------------------
gxor1[44, ]
1.01 * 1.02 * 0.1 * 1.2

## ----nx0113-------------------------------------------------------

p3 <- data.frame(
    parent = c(rep("Root", 4), "a", "b", "d", "e", "c", "f"),
    child = c("a", "b", "d", "e", "c", "c", "f", "f", "g", "g"),
    s = c(0.01, 0.02, 0.03, 0.04, 0.1, 0.1, 0.2, 0.2, 0.3, 0.3),
    sh = c(rep(0, 4), c(-.9, -.9), c(-.95, -.95), c(-.99, -.99)),
    typeDep = c(rep("--", 4),
                "XMPN", "XMPN", "MN", "MN", "SM", "SM"))
fp3 <- allFitnessEffects(p3)

## ----nx0114, fig.height=3-----------------------------------------
plot(fp3)

## ----nx0115, fig.height=6-----------------------------------------
plot(fp3, "igraph", layout.reingold.tilford)

## ----nx0116-------------------------------------------------------

gfp3 <- evalAllGenotypes(fp3, order = FALSE)


## ----nx0117-------------------------------------------------------
gfp3[c(9, 24, 29, 59, 60, 66, 119, 120, 126, 127), ]

c(1.01 * 1.1, 1.03 * .05, 1.01 * 1.02 * 0.1, 0.1 * 0.05 * 1.3,
  1.03 * 1.04 * 1.2, 1.01 * 1.02 * 0.1 * 0.05,
  0.1 * 1.03 * 1.04 * 1.2 * 1.3,
  1.01 * 1.02 * 0.1 * 1.03 * 1.04 * 1.2,
  1.02 * 1.1 * 1.03 * 1.04 * 1.2 * 1.3,
  1.01 * 1.02 * 1.03 * 1.04 * 0.1 * 1.2 * 1.3)


## ----ny0111-------------------------------------------------------
s <- 0.2
sboth <- (1/(1 + s)) - 1
m0 <- allFitnessEffects(data.frame(
    parent = c("Root", "Root", "a1", "a2"),
    child = c("a1", "a2", "b", "b"),
    s = s,
    sh = -1,
    typeDep = "OR"),
                        epistasis = c("a1:a2" = sboth))
evalAllGenotypes(m0, order = FALSE, addwt = TRUE)

## ----ny01112------------------------------------------------------
s <- 0.2
m1 <- allFitnessEffects(data.frame(
    parent = c("Root", "A"),
    child = c("A", "B"),
    s = s,
    sh = -1,
    typeDep = "OR"),
                        geneToModule = c("Root" = "Root",
                                         "A" = "a1, a2",
                                         "B" = "b1"))
evalAllGenotypes(m1, order = FALSE, addwt = TRUE)

## ----ny0113-------------------------------------------------------
fnme <- allFitnessEffects(epistasis = c("A" = 0.1,
                                        "B" = 0.2),
                          geneToModule = c("A" = "a1, a2",
                                           "B" = "b1"))
evalAllGenotypes(fnme, order = FALSE, addwt = TRUE)

## ----ny0114-------------------------------------------------------
fnme2 <- allFitnessEffects(epistasis = c("A" = 0.1,
                                        "B" = 0.2),
                          geneToModule = c(
                              "Root" = "Root",
                              "A" = "a1, a2",
                              "B" = "b1"))
evalAllGenotypes(fnme, order = FALSE, addwt = TRUE)

## ----ny0115-------------------------------------------------------
p4 <- data.frame(
    parent = c(rep("Root", 4), "A", "B", "D", "E", "C", "F"),
    child = c("A", "B", "D", "E", "C", "C", "F", "F", "G", "G"),
    s = c(0.01, 0.02, 0.03, 0.04, 0.1, 0.1, 0.2, 0.2, 0.3, 0.3),
    sh = c(rep(0, 4), c(-.9, -.9), c(-.95, -.95), c(-.99, -.99)),
    typeDep = c(rep("--", 4),
                "XMPN", "XMPN", "MN", "MN", "SM", "SM"))

fp4m <- allFitnessEffects(
    p4,
    geneToModule = c("Root" = "Root", "A" = "a1",
                     "B" = "b1, b2", "C" = "c1",
                     "D" = "d1, d2", "E" = "e1",
                     "F" = "f1, f2", "G" = "g1"))

## ----ny0116, fig.height=3-----------------------------------------
plot(fp4m)

## ----ny0117, fig.height=3-----------------------------------------
plot(fp4m, expandModules = TRUE)

## ----ny0118, fig.height=6-----------------------------------------
plot(fp4m, "igraph", layout = layout.reingold.tilford,
     expandModules = TRUE)


## ----ny0119-------------------------------------------------------
gfp4 <- evalAllGenotypes(fp4m, order = FALSE, max = 1024)

## ----ny0120-------------------------------------------------------
gfp4[c(12, 20, 21, 40, 41, 46, 50, 55, 64, 92,
       155, 157, 163, 372, 632, 828), ]

c(1.01 * 1.02, 1.02, 1.02 * 1.1, 0.1 * 1.3, 1.03,
  1.03 * 1.04, 1.04 * 0.05, 0.05 * 1.3,
  1.01 * 1.02 * 0.1, 1.02 * 1.1, 0.1 * 0.05 * 1.3,
  1.03 * 0.05, 1.03 * 0.05, 1.03 * 1.04 * 1.2, 1.03 * 1.04 * 1.2,
  1.02 * 1.1 * 1.03 * 1.04 * 1.2 * 1.3)


## ----ny0121-------------------------------------------------------
o3 <- allFitnessEffects(orderEffects = c(
                            "F > D > M" = -0.3,
                            "D > F > M" = 0.4,
                            "D > M > F" = 0.2,
                            "D > M"     = 0.1,
                            "M > D"     = 0.5),
                        geneToModule =
                            c("M" = "m",
                              "F" = "f",
                              "D" = "d") )


(ag <- evalAllGenotypes(o3, addwt = TRUE, order = TRUE))

## ----ny0123-------------------------------------------------------

ofe1 <- allFitnessEffects(
    orderEffects = c("F > D" = -0.3, "D > F" = 0.4),
    geneToModule =
        c("F" = "f1, f2",
          "D" = "d1, d2") )

ag <- evalAllGenotypes(ofe1, order = TRUE)


## ----ny0124-------------------------------------------------------
ag[5:16,]

## ----ny0125-------------------------------------------------------
ag[c(17, 39, 19, 29), ]

## ----ny0126-------------------------------------------------------
ag[c(17, 39, 19, 29), "Fitness"] == c(1.4, 0.7, 1.4, 0.7)

## ----ny0127-------------------------------------------------------
ag[c(43, 44),]
ag[c(43, 44), "Fitness"] == c(1.4, 1.4)

## ----ny0128-------------------------------------------------------
all(ag[41:52, "Fitness"] == 1.4)

## ----ny0129-------------------------------------------------------
all(ag[53:64, "Fitness"] == 0.7)

## ----ny0130-------------------------------------------------------

ofe2 <- allFitnessEffects(
    orderEffects = c("F > D" = -0.3, "D > F" = 0.4),
    geneToModule =
        c("F" = "f1, f2, f3",
          "D" = "d1, d2") )
ag2 <- evalAllGenotypes(ofe2, max = 325, order = TRUE)


## ----ny0131-------------------------------------------------------
all(ag2[grep("^d.*f.*", ag2[, 1]), "Fitness"] == 1.4)
all(ag2[grep("^f.*d.*", ag2[, 1]), "Fitness"] == 0.7)
oe <- c(grep("^f.*d.*", ag2[, 1]), grep("^d.*f.*", ag2[, 1]))
all(ag2[-oe, "Fitness"] == 1)

## ----ny0132-------------------------------------------------------

foi1 <- allFitnessEffects(
    orderEffects = c("D>B" = -0.2, "B > D" = 0.3),
    noIntGenes = c("A" = 0.05, "C" = -.2, "E" = .1))


## ----ny0133-------------------------------------------------------
foi1[c("geneModule", "long.geneNoInt")]

## ----ny0134-------------------------------------------------------
agoi1 <- evalAllGenotypes(foi1,  max = 325, order = TRUE)
head(agoi1)

## ----ny0135-------------------------------------------------------
rn <- 1:nrow(agoi1)
names(rn) <- agoi1[, 1]

agoi1[rn[LETTERS[1:5]], "Fitness"] == c(1.05, 1, 0.8, 1, 1.1)


## ----ny0136-------------------------------------------------------
agoi1[grep("^A > [BD]$", names(rn)), "Fitness"] == 1.05
agoi1[grep("^C > [BD]$", names(rn)), "Fitness"] == 0.8
agoi1[grep("^E > [BD]$", names(rn)), "Fitness"] == 1.1
agoi1[grep("^[BD] > A$", names(rn)), "Fitness"] == 1.05
agoi1[grep("^[BD] > C$", names(rn)), "Fitness"] == 0.8
agoi1[grep("^[BD] > E$", names(rn)), "Fitness"] == 1.1

## ----ny0137-------------------------------------------------------
all.equal(agoi1[230:253, "Fitness"] ,
          rep((1 - 0.2) * 1.05 * 0.8 * 1.1, 24))

## ----ny0138-------------------------------------------------------
sa <- 0.2
sb <- 0.3
sab <- 0.7

e2 <- allFitnessEffects(epistasis =
                            c("A: -B" = sa,
                              "-A:B" = sb,
                              "A : B" = sab))
evalAllGenotypes(e2, order = FALSE, addwt = TRUE)


## ----ny0139-------------------------------------------------------
s2 <- ((1 + sab)/((1 + sa) * (1 + sb))) - 1

e3 <- allFitnessEffects(epistasis =
                            c("A" = sa,
                              "B" = sb,
                              "A : B" = s2))
evalAllGenotypes(e3, order = FALSE, addwt = TRUE)


## ----ny0140-------------------------------------------------------
sa <- 0.1
sb <- 0.15
sc <- 0.2
sab <- 0.3
sbc <- -0.25
sabc <- 0.4

sac <- (1 + sa) * (1 + sc) - 1

E3A <- allFitnessEffects(epistasis =
                            c("A:-B:-C" = sa,
                              "-A:B:-C" = sb,
                              "-A:-B:C" = sc,
                              "A:B:-C" = sab,
                              "-A:B:C" = sbc,
                              "A:-B:C" = sac,
                              "A : B : C" = sabc)
                                                )

evalAllGenotypes(E3A, order = FALSE, addwt = FALSE)


## ----ny0141-------------------------------------------------------

sa <- 0.1
sb <- 0.15
sc <- 0.2
sab <- 0.3
Sab <- ( (1 + sab)/((1 + sa) * (1 + sb))) - 1
Sbc <- ( (1 + sbc)/((1 + sb) * (1 + sc))) - 1
Sabc <- ( (1 + sabc)/
          ( (1 + sa) * (1 + sb) * (1 + sc) *
            (1 + Sab) * (1 + Sbc) ) ) - 1

E3B <- allFitnessEffects(epistasis =
                             c("A" = sa,
                               "B" = sb,
                               "C" = sc,
                               "A:B" = Sab,
                               "B:C" = Sbc,
                               ## "A:C" = sac, ## not needed now
                               "A : B : C" = Sabc)
                                                )
evalAllGenotypes(E3B, order = FALSE, addwt = FALSE)


## ----ny0142-------------------------------------------------------
all(evalAllGenotypes(E3A, order = FALSE, addwt = FALSE) ==
    evalAllGenotypes(E3B, order = FALSE, addwt = FALSE))

## ----ny0143-------------------------------------------------------

sa <- 0.2
sb <- 0.3
sab <- 0.7

em <- allFitnessEffects(epistasis =
                            c("A: -B" = sa,
                              "-A:B" = sb,
                              "A : B" = sab),
                        geneToModule = c("A" = "a1, a2",
                                         "B" = "b1, b2"))
evalAllGenotypes(em, order = FALSE, addwt = TRUE)

## ----ny0144-------------------------------------------------------
s2 <- ((1 + sab)/((1 + sa) * (1 + sb))) - 1

em2 <- allFitnessEffects(epistasis =
                            c("A" = sa,
                              "B" = sb,
                              "A : B" = s2),
                         geneToModule = c("A" = "a1, a2",
                                         "B" = "b1, b2")
                         )
evalAllGenotypes(em2, order = FALSE, addwt = TRUE)


## ----ny0145-------------------------------------------------------

fnme <- allFitnessEffects(epistasis = c("A" = 0.1,
                                        "B" = 0.2),
                          geneToModule = c("A" = "a1, a2",
                                           "B" = "b1, b2, b3"))

evalAllGenotypes(fnme, order = FALSE, addwt = TRUE)


## ----ny0146-------------------------------------------------------
fnme <- allFitnessEffects(epistasis = c("A" = 0.1,
                                        "B" = 0.2,
                                        "A : B" = 0.0),
                          geneToModule = c("A" = "a1, a2",
                                           "B" = "b1, b2, b3"))

evalAllGenotypes(fnme, order = FALSE, addwt = TRUE)


## ----ny0147-------------------------------------------------------
s <- 0.2
sv <- allFitnessEffects(epistasis = c("-A : B" = -1,
                                      "A : -B" = -1,
                                      "A:B" = s))

## ----ny0148-------------------------------------------------------
(asv <- evalAllGenotypes(sv, order = FALSE, addwt = TRUE))

## ----ny01149------------------------------------------------------
evalAllGenotypes(sv, order = TRUE, addwt = TRUE)

## ----ny0150-------------------------------------------------------
sa <- -0.1
sb <- -0.2
sab <- 0.25
sv2 <- allFitnessEffects(epistasis = c("-A : B" = sb,
                             "A : -B" = sa,
                             "A:B" = sab),
                         geneToModule = c(
                             "A" = "a1, a2",
                             "B" = "b"))
evalAllGenotypes(sv2, order = FALSE, addwt = TRUE)

## ----ny0151-------------------------------------------------------
evalAllGenotypes(sv2, order = TRUE, addwt = TRUE)

## ----ny0152-------------------------------------------------------
sa <- 0.1
sb <- 0.2
sab <- -0.8
sm1 <- allFitnessEffects(epistasis = c("-A : B" = sb,
                             "A : -B" = sa,
                             "A:B" = sab))
evalAllGenotypes(sm1, order = FALSE, addwt = TRUE)


## ----ny0153-------------------------------------------------------
evalAllGenotypes(sm1, order = TRUE, addwt = TRUE)

## ----ny0154-------------------------------------------------------
evalAllGenotypes(sv, order = FALSE, addwt = TRUE, model = "Bozic")

## ----ny0155-------------------------------------------------------
s <- 0.2
svB <- allFitnessEffects(epistasis = c("-A : B" = -Inf,
                                      "A : -B" = -Inf,
                                      "A:B" = s))
evalAllGenotypes(svB, order = FALSE, addwt = TRUE, model = "Bozic")

## ----ny0156-------------------------------------------------------

s <- 1
svB1 <- allFitnessEffects(epistasis = c("-A : B" = -Inf,
                                       "A : -B" = -Inf,
                                       "A:B" = s))

evalAllGenotypes(svB1, order = FALSE, addwt = TRUE, model = "Bozic")


s <- 3
svB3 <- allFitnessEffects(epistasis = c("-A : B" = -Inf,
                                       "A : -B" = -Inf,
                                       "A:B" = s))

evalAllGenotypes(svB3, order = FALSE, addwt = TRUE, model = "Bozic")



## ----ny0157-------------------------------------------------------
i1 <- allFitnessEffects(noIntGenes = c(1, 0.5))
evalAllGenotypes(i1, order = FALSE, addwt = TRUE,
                 model = "Bozic")

i1_b <- oncoSimulIndiv(i1, model = "Bozic", onlyCancer = TRUE)


## ----ny0158-------------------------------------------------------
evalAllGenotypes(i1, order = FALSE, addwt = TRUE,
                 model = "Exp")
i1_e <- oncoSimulIndiv(i1, model = "Exp", onlyCancer = TRUE)
summary(i1_e)

## ----ny0159-------------------------------------------------------
p4 <- data.frame(
    parent = c(rep("Root", 4), "A", "B", "D", "E", "C", "F"),
    child = c("A", "B", "D", "E", "C", "C", "F", "F", "G", "G"),
    s = c(0.01, 0.02, 0.03, 0.04, 0.1, 0.1, 0.2, 0.2, 0.3, 0.3),
    sh = c(rep(0, 4), c(-.9, -.9), c(-.95, -.95), c(-.99, -.99)),
    typeDep = c(rep("--", 4),
                "XMPN", "XMPN", "MN", "MN", "SM", "SM"))

oe <- c("C > F" = -0.1, "H > I" = 0.12)
sm <- c("I:J"  = -1)
sv <- c("-K:M" = -.5, "K:-M" = -.5)
epist <- c(sm, sv)

modules <- c("Root" = "Root", "A" = "a1",
             "B" = "b1, b2", "C" = "c1",
             "D" = "d1, d2", "E" = "e1",
             "F" = "f1, f2", "G" = "g1",
             "H" = "h1, h2", "I" = "i1",
             "J" = "j1, j2", "K" = "k1, k2", "M" = "m1")

set.seed(1) ## for reproducibility
noint <- rexp(5, 10)
names(noint) <- paste0("n", 1:5)

fea <- allFitnessEffects(rT = p4, epistasis = epist,
                         orderEffects = oe,
                         noIntGenes = noint,
                         geneToModule = modules)

## ----ny0160, fig.height=5.5---------------------------------------
plot(fea)

## ----ny0161, fig.height=5.5---------------------------------------
plot(fea, "igraph")

## ----ny0162, fig.height=5.5---------------------------------------
plot(fea, expandModules = TRUE)

## ----ny0163, fig.height=6.5---------------------------------------
plot(fea, "igraph", expandModules = TRUE)

## ----nyv0100------------------------------------------------------

evalGenotype("k1 > i1 > h2", fea) ## 0.5
evalGenotype("k1 > h1 > i1", fea) ## 0.5 * 1.12

evalGenotype("k2 > m1 > h1 > i1", fea) ## 1.12

evalGenotype("k2 > m1 > h1 > i1 > c1 > n3 > f2", fea)
## 1.12 * 0.1 * (1 + noint[3]) * 0.05 * 0.9


## ----nyv0101------------------------------------------------------

randomGenotype <- function(fe, ns = NULL) {
    gn <- setdiff(c(fe$geneModule$Gene,
                    fe$long.geneNoInt$Gene), "Root")
    if(is.null(ns)) ns <- sample(length(gn), 1)
    return(paste(sample(gn, ns), collapse = " > "))
}

set.seed(2) ## for reproducibility

evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  k2 > i1 > c1 > n1 > m1
##  Individual s terms are : 0.0755182 -0.9
##  Fitness:  0.107552
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  n2 > h1 > h2
##  Individual s terms are : 0.118164
##  Fitness:  1.11816
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  d2 > k2 > c1 > f2 > n4 > m1 > n3 > f1 > b1 > g1 > n5 > h1 > j2
##  Individual s terms are : 0.0145707 0.0139795 0.0436069 0.02 0.1 0.03 -0.95 0.3 -0.1
##  Fitness:  0.0725829
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  h2 > c1 > f1 > n2 > b2 > a1 > n1 > i1
##  Individual s terms are : 0.0755182 0.118164 0.01 0.02 -0.9 -0.95 -0.1 0.12
##  Fitness:  0.00624418
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  h2 > j1 > m1 > d2 > i1 > b2 > k2 > d1 > b1 > n3 > n1 > g1 > h1 > c1 > k1 > e1 > a1 > f1 > n5 > f2
##  Individual s terms are : 0.0755182 0.0145707 0.0436069 0.01 0.02 -0.9 0.03 0.04 0.2 0.3 -1 -0.1 0.12
##  Fitness:  0
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  n1 > m1 > n3 > i1 > j1 > n5 > k1
##  Individual s terms are : 0.0755182 0.0145707 0.0436069 -1
##  Fitness:  0
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  d2 > n1 > g1 > f1 > f2 > c1 > b1 > d1 > k1 > a1 > b2 > i1 > n4 > h2 > n2
##  Individual s terms are : 0.0755182 0.118164 0.0139795 0.01 0.02 -0.9 0.03 -0.95 0.3 -0.5
##  Fitness:  0.00420528
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  j1 > f1 > j2 > a1 > n4 > c1 > n3 > k1 > d1 > h1
##  Individual s terms are : 0.0145707 0.0139795 0.01 0.1 0.03 -0.95 -0.5
##  Fitness:  0.0294308
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  n5 > f2 > f1 > h2 > n4 > c1 > n3 > b1
##  Individual s terms are : 0.0145707 0.0139795 0.0436069 0.02 0.1 -0.95
##  Fitness:  0.0602298
evalGenotype(randomGenotype(fea), fea, echo = TRUE, verbose = TRUE)
## Genotype:  h1 > d1 > f2
##  Individual s terms are : 0.03 -0.95
##  Fitness:  0.0515



## ----nyv0102------------------------------------------------------

muvar2 <- c("U" = 1e-6, "z" = 5e-5, "e" = 5e-4, "m" = 5e-3,
            "D" = 1e-4)
ni1 <- rep(0, 5)
names(ni1) <- names(muvar2) ## We use the same names, of course
fe1 <- allFitnessEffects(noIntGenes = ni1)
bb <- oncoSimulIndiv(fe1,
                     mu = muvar2, onlyCancer = FALSE,
                     initSize = 1e5,
                     finalTime = 25,
                     seed =NULL)


## ----nyv0103------------------------------------------------------
fe2 <- allFitnessEffects(noIntGenes =
                         c(a1 = 0.1, a2 = 0.2,
                           b1 = 0.01, b2 = 0.3, b3 = 0.2,
                           c1 = 0.3, c2 = -0.2))

fm2 <- allMutatorEffects(epistasis = c("A" = 5,
                                       "B" = 10,
                                       "C" = 3),
                         geneToModule = c("A" = "a1, a2",
                                          "B" = "b1, b2, b3",
                                          "C" = "c1, c2"))

## Show the fitness effect of a specific genotype
evalGenotype("a1, c2", fe2, verbose = TRUE)

## Show the mutator effect of a specific genotype
evalGenotypeMut("a1, c2", fm2, verbose = TRUE)

## Fitness and mutator of a specific genotype
evalGenotypeFitAndMut("a1, c2", fe2, fm2, verbose = TRUE)

## ----rzx033, eval=FALSE-------------------------------------------
# ## Show only all the fitness effects
# evalAllGenotypes(fe2, order = FALSE)
# 
# ## Show only all mutator effects
# evalAllGenotypesMut(fm2)
# 
# ## Show all fitness and mutator
# evalAllGenotypesFitAndMut(fe2, fm2, order = FALSE)

## ----nyv0105------------------------------------------------------

set.seed(1) ## for reproducibility
## 17 genes, 7 with no direct fitness effects
ni <- c(rep(0, 7), runif(10, min = -0.01, max = 0.1))
names(ni) <- c("a1", "a2", "b1", "b2", "b3", "c1", "c2",
               paste0("g", 1:10))

fe3 <- allFitnessEffects(noIntGenes = ni)

fm3 <- allMutatorEffects(epistasis = c("A" = 5,
                                       "B" = 10,
                                       "C" = 3,
                                       "A:C" = 70),
                         geneToModule = c("A" = "a1, a2",
                                          "B" = "b1, b2, b3",
                                          "C" = "c1, c2"))

## ----nyv0106------------------------------------------------------
## These only affect mutation, not fitness
evalGenotypeFitAndMut("a1, a2", fe3, fm3, verbose = TRUE)
evalGenotypeFitAndMut("a1, b3", fe3, fm3, verbose = TRUE)

## These only affect fitness: the mutator multiplier is 1
evalGenotypeFitAndMut("g1", fe3, fm3, verbose = TRUE)
evalGenotypeFitAndMut("g3, g9", fe3, fm3, verbose = TRUE)

## These affect both
evalGenotypeFitAndMut("g3, g9, a2, b3", fe3, fm3, verbose = TRUE)

## ----nyv0107------------------------------------------------------
set.seed(1) ## so that it is easy to reproduce
mue1 <- oncoSimulIndiv(fe3, muEF = fm3,
                       mu = 1e-6,
                       initSize = 1e5,
                       model = "McFL",
                       detectionSize = 5e6,
                       finalTime = 500,
                       onlyCancer = FALSE)

## ----rzx0321, eval=FALSE------------------------------------------
# ## We do not show this in the vignette to avoid cluttering it
# ## with output
# mue1

## ----rzx0111, eval=FALSE------------------------------------------
# 
# set.seed(1) ## for reproducibility
# ## 17 genes, 7 with no direct fitness effects
# ni <- c(rep(0, 7), runif(10, min = -0.01, max = 0.1))
# names(ni) <- c("a1", "a2", "b1", "b2", "b3", "c1", "c2",
#                paste0("g", 1:10))
# 
# ## Next is for nicer figure labeling.
# ## Consider as drivers genes with s >0
# gp <- which(ni > 0)
# 
# fe3 <- allFitnessEffects(noIntGenes = ni,
#                          drvNames = names(ni)[gp])
# 
# 
# set.seed(12)
# mue1 <- oncoSimulIndiv(fe3, muEF = fm3,
#                        mu = 1e-6,
#                        initSize = 1e5,
#                        model = "McFL",
#                        detectionSize = 5e6,
#                        finalTime = 270,
#                        keepPhylog = TRUE,
#                        onlyCancer = FALSE)
# mue1
# ## If you decrease N even further it gets even more cluttered
# op <- par(ask = TRUE)
# plotClonePhylog(mue1, N = 10, timeEvents = TRUE)
# plot(mue1, plotDrivers = TRUE, addtot = TRUE,
#      plotDiversity = TRUE)
# 
# ## The stacked plot is slow; be patient
# ## Most clones have tiny population sizes, and their lines
# ## are piled on top of each other
# plot(mue1, addtot = TRUE,
#      plotDiversity = TRUE, type = "stacked")
# par(op)

## ----nyv0108------------------------------------------------------

d1 <- -0.05 ## single mutant fitness 0.95
d2 <- -0.08 ## double mutant fitness 0.92
d3 <- 0.2   ## triple mutant fitness 1.2
s2 <- ((1 + d2)/(1 + d1)^2) - 1
s3 <- ( (1 + d3)/((1 + d1)^3 * (1 + s2)^3) ) - 1

wb <- allFitnessEffects(
    epistasis = c(
        "A" = d1,
        "B" = d1,
        "C" = d1,
        "A:B" = s2,
        "A:C" = s2,
        "B:C" = s2,
        "A:B:C" = s3))

## ----rzx0112, fig.width=6.5, fig.height=5-------------------------
plotFitnessLandscape(wb, use_ggrepel = TRUE)

## ----rzx0113, fig.width=6.5, fig.height=5-------------------------
(ewb <- evalAllGenotypes(wb, order = FALSE))
plot(ewb, use_ggrepel = TRUE)


## ----wasthis111, fig.width=9.5, fig.height=9.5--------------------
par(cex = 0.7)
pancr <- allFitnessEffects(
    data.frame(parent = c("Root", rep("KRAS", 4),
                   "SMAD4", "CDNK2A",
                   "TP53", "TP53", "MLL3"),
               child = c("KRAS","SMAD4", "CDNK2A",
                   "TP53", "MLL3",
                   rep("PXDN", 3), rep("TGFBR2", 2)),
               s = 0.1,
               sh = -0.9,
               typeDep = "MN"))
plot(evalAllGenotypes(pancr, order = FALSE), use_ggrepel = TRUE)


## ----nyv0109------------------------------------------------------
K <- 4
sp <- 1e-5
sdp <- 0.015
sdplus <- 0.05
sdminus <- 0.1
cnt <- (1 + sdplus)/(1 + sdminus)
prod_cnt <- cnt - 1
bauer <- data.frame(parent = c("Root", rep("D", K)),
                    child = c("D", paste0("s", 1:K)),
                    s = c(prod_cnt, rep(sdp, K)),
                    sh = c(0, rep(sp, K)),
                    typeDep = "MN")
fbauer <- allFitnessEffects(bauer)
(b1 <- evalAllGenotypes(fbauer, order = FALSE, addwt = TRUE))


## ----rzx0114, fig.height=3----------------------------------------
plot(fbauer)

## ----rzx0115, fig.width=6, fig.height=6---------------------------
plot(b1, use_ggrepel = TRUE)

## ----nyv0110------------------------------------------------------
m1 <- expand.grid(D = c(1, 0), s1 = c(1, 0), s2 = c(1, 0),
                  s3 = c(1, 0), s4 = c(1, 0))

fitness_bauer <- function(D, s1, s2, s3, s4,
                          sp = 1e-5, sdp = 0.015, sdplus = 0.05,
                          sdminus = 0.1) {
    if(!D) {
        b <- 0.5 * ( (1 + sp)^(sum(c(s1, s2, s3, s4))))
    } else {
        b <- 0.5 *
            (((1 + sdplus)/(1 + sdminus)  *
              (1 + sdp)^(sum(c(s1, s2, s3, s4)))))
    }
    fitness <- b - (1 - b)
    our_fitness <- 1 + fitness ## prevent negative fitness and
    ## make wt fitness = 1
    return(our_fitness)
}

m1$Fitness <-
    apply(m1, 1, function(x) do.call(fitness_bauer, as.list(x)))

bauer2 <- allFitnessEffects(genotFitness = m1)

## ----nyv0111------------------------------------------------------
evalAllGenotypes(bauer2, order = FALSE, addwt = TRUE)

## ----rzx0116, echo=FALSE, fig.height=4, fig.width=4---------------

df1 <- data.frame(x = c(1, 1.2, 1.4), f = c(1, 1.2, 1.2),
                 names = c("wt", "A", "B"))
plot(df1[, 2] ~ df1[, 1], axes = TRUE, xlab= "",
     ylab = "Fitness", xaxt = "n", yaxt = "n", ylim = c(1, 1.21))
segments(1, 1, 1.2, 1.2)
segments(1, 1, 1.4, 1.2)
text(1, 1, "wt", pos = 4)
text(1.2, 1.2, "A", pos = 2)
text(1.4, 1.2, "B", pos = 2)
## axis(1,  tick = FALSE, labels = FALSE)
## axis(2,  tick = FALSE, labels = FALSE)

## ----nyv0112------------------------------------------------------
s <- 0.1 ## or whatever number
m1a1 <- allFitnessEffects(data.frame(parent = c("Root", "Root"),
                                     child = c("A", "B"),
                                     s = s,
                                     sh = 0,
                                     typeDep = "MN"))
evalAllGenotypes(m1a1, order = FALSE, addwt = TRUE)

## ----nyv0113------------------------------------------------------
s <- 0.1
sab <- 0.3
m1a2 <- allFitnessEffects(epistasis = c("A:-B" = s,
                                        "-A:B" = s,
                                        "A:B" = sab))
evalAllGenotypes(m1a2, order = FALSE, addwt = TRUE)

## ----nyv0114------------------------------------------------------
sab3 <- ((1 + sab)/((1 + s)^2)) - 1
m1a3 <- allFitnessEffects(data.frame(parent = c("Root", "Root"),
                                     child = c("A", "B"),
                                     s = s,
                                     sh = 0,
                                     typeDep = "MN"),
                          epistasis = c("A:B" = sab3))
evalAllGenotypes(m1a3, order = FALSE, addwt = TRUE)

## ----nyv0115------------------------------------------------------
all.equal(evalAllGenotypes(m1a2, order = FALSE, addwt = TRUE),
          evalAllGenotypes(m1a3, order = FALSE, addwt = TRUE))

## ----rzx0117, echo=FALSE, fig.width=4, fig.height=4---------------

df1 <- data.frame(x = c(1, 1.2, 1.2, 1.4), f = c(1, 0.4, 0.3, 1.3),
                 names = c("wt", "A", "B", "AB"))
plot(df1[, 2] ~ df1[, 1], axes = TRUE, xlab= "", ylab = "Fitness",
     xaxt = "n", yaxt = "n", ylim = c(0.29, 1.32))
segments(1, 1, 1.2, 0.4)
segments(1, 1, 1.2, 0.3)
segments(1.2, 0.4, 1.4, 1.3)
segments(1.2, 0.3, 1.4, 1.3)
text(x = df1[, 1], y = df1[, 2], labels = df1[, "names"], pos = c(4, 2, 2, 2))
## text(1, 1, "wt", pos = 4)
## text(1.2, 1.2, "A", pos = 2)
## text(1.4, 1.2, "B", pos = 2)

## ----nyv0116------------------------------------------------------
sa <- -0.6
sb <- -0.7
sab <- 0.3
m1b1 <- allFitnessEffects(epistasis = c("A:-B" = sa,
                                        "-A:B" = sb,
                                        "A:B" = sab))
evalAllGenotypes(m1b1, order = FALSE, addwt = TRUE)

## ----rzx0118, echo=FALSE, fig.width=4, fig.height=4---------------

df1 <- data.frame(x = c(1, 1.2, 1.2, 1.4), f = c(1, 1.2, 0.7, 1.5),
                 names = c("wt", "A", "B", "AB"))
plot(df1[, 2] ~ df1[, 1], axes = TRUE, xlab = "", ylab = "Fitness",
     xaxt = "n", yaxt = "n", ylim = c(0.69, 1.53))
segments(1, 1, 1.2, 1.2)
segments(1, 1, 1.2, 0.7)
segments(1.2, 1.2, 1.4, 1.5)
segments(1.2, 0.7, 1.4, 1.5)
text(x = df1[, 1], y = df1[, 2], labels = df1[, "names"], pos = c(3, 3, 3, 2))
## text(1, 1, "wt", pos = 4)
## text(1.2, 1.2, "A", pos = 2)
## text(1.4, 1.2, "B", pos = 2)


## ----nyv0117------------------------------------------------------
sa <- 0.2
sb <- -0.3
sab <- 0.5
m1c1 <- allFitnessEffects(epistasis = c("A:-B" = sa,
                                        "-A:B" = sb,
                                        "A:B" = sab))
evalAllGenotypes(m1c1, order = FALSE, addwt = TRUE)

## ----rzx0119, echo=FALSE, fig.width=4.5, fig.height=3.5-----------

df1 <- data.frame(x = c(1, 2, 3, 4), f = c(1.1, 1, 0.95, 1.2),
                 names = c("u", "wt", "i", "v"))
plot(df1[, 2] ~ df1[, 1], axes = FALSE, xlab = "", ylab = "")
par(las = 1)
axis(2)
axis(1, at = c(1, 2, 3, 4), labels = df1[, "names"], ylab = "")
box()
arrows(c(2, 2, 3), c(1, 1, 0.95),
       c(1, 3, 4), c(1.1, 0.95, 1.2))
## text(1, 1, "wt", pos = 4)
## text(1.2, 1.2, "A", pos = 2)
## text(1.4, 1.2, "B", pos = 2)

## ----nyv0118------------------------------------------------------
su <- 0.1
si <- -0.05
fvi <- 1.2 ## the fitness of the vi mutant
sv <- (fvi/(1 + si)) - 1
sui <- suv <- -1
od <- allFitnessEffects(
    data.frame(parent = c("Root", "Root", "i"),
               child = c("u", "i", "v"),
               s = c(su, si, sv),
               sh = -1,
               typeDep = "MN"),
    epistasis = c(
        "u:i" = sui,
        "u:v" = suv))

## ----rzx0120, fig.width=3, fig.height=3---------------------------
plot(od)

## ----nyv0119------------------------------------------------------
evalAllGenotypes(od, order = FALSE, addwt = TRUE)

## ----nyv0120------------------------------------------------------
u <- 0.1; i <- -0.05; vi <- (1.2/0.95) - 1; ui <- uv <- -Inf
od2 <- allFitnessEffects(
    epistasis = c("u" = u,  "u:i" = ui,
                  "u:v" = uv, "i" = i,
                  "v:-i" = -Inf, "v:i" = vi))
evalAllGenotypes(od2, addwt = TRUE)


## ----rzx0121, echo=FALSE, fig.width=4, fig.height=3---------------

df1 <- data.frame(x = c(1, 2, 3), f = c(1, 0.95, 1.2),
                 names = c("wt", "1", "2"))
plot(df1[, 2] ~ df1[, 1], axes = FALSE, xlab = "", ylab = "")
par(las = 1)
axis(2)
axis(1, at = c(1, 2, 3), labels = df1[, "names"], ylab = "")
box()
segments(c(1, 2), c(1, 0.95),
       c(2, 3), c(0.95, 1.2))
## text(1, 1, "wt", pos = 4)
## text(1.2, 1.2, "A", pos = 2)
## text(1.4, 1.2, "B", pos = 2)



## ----rzx0122, echo=FALSE, fig.width=4, fig.height=3---------------

df1 <- data.frame(x = c(1, 2, 3, 4), f = c(1, 0.95, 0.92, 1.2),
                 names = c("wt", "1", "2", "3"))
plot(df1[, 2] ~ df1[, 1], axes = FALSE, xlab = "", ylab = "")
par(las = 1)
axis(2)
axis(1, at = c(1, 2, 3, 4), labels = df1[, "names"], ylab = "")
box()
segments(c(1, 2, 3), c(1, 0.95, 0.92),
       c(2, 3, 4), c(0.95, 0.92, 1.2))
## text(1, 1, "wt", pos = 4)
## text(1.2, 1.2, "A", pos = 2)
## text(1.4, 1.2, "B", pos = 2)

## ----nyv0122------------------------------------------------------

d1 <- -0.05 ## single mutant fitness 0.95
d2 <- -0.08 ## double mutant fitness 0.92
d3 <- 0.2   ## triple mutant fitness 1.2

s2 <- ((1 + d2)/(1 + d1)^2) - 1
s3 <- ( (1 + d3)/((1 + d1)^3 * (1 + s2)^3) ) - 1

w <- allFitnessEffects(
    data.frame(parent = c("Root", "Root", "Root"),
               child = c("A", "B", "C"),
               s = d1,
               sh = -1,
               typeDep = "MN"),
    epistasis = c(
        "A:B" = s2,
        "A:C" = s2,
        "B:C" = s2,
        "A:B:C" = s3))

## ----rzx0123, fig.width=4, fig.height=4---------------------------
plot(w)

## ----nyv0123------------------------------------------------------
evalAllGenotypes(w, order = FALSE, addwt = TRUE)

## ----nyv0124------------------------------------------------------
wb <- allFitnessEffects(
    epistasis = c(
        "A" = d1,
        "B" = d1,
        "C" = d1,
        "A:B" = s2,
        "A:C" = s2,
        "B:C" = s2,
        "A:B:C" = s3))

evalAllGenotypes(wb, order = FALSE, addwt = TRUE)

## ----rzx0124, , fig.width=3, fig.height=3-------------------------
plot(wb)

## ----nyv0125------------------------------------------------------
wc <- allFitnessEffects(
    epistasis = c(
        "A:-B:-C" = d1,
        "B:-C:-A" = d1,
        "C:-A:-B" = d1,
        "A:B:-C" = d2,
        "A:C:-B" = d2,
        "B:C:-A" = d2,
        "A:B:C" = d3))
evalAllGenotypes(wc, order = FALSE, addwt = TRUE)

## ----rzx0125, fig.width=4-----------------------------------------

pancr <- allFitnessEffects(
    data.frame(parent = c("Root", rep("KRAS", 4),
                   "SMAD4", "CDNK2A",
                   "TP53", "TP53", "MLL3"),
               child = c("KRAS","SMAD4", "CDNK2A",
                   "TP53", "MLL3",
                   rep("PXDN", 3), rep("TGFBR2", 2)),
               s = 0.1,
               sh = -0.9,
               typeDep = "MN"))

plot(pancr)

## ----rzx0126, fig.height = 4--------------------------------------
rv1 <- allFitnessEffects(data.frame(parent = c("Root", "A", "KRAS"),
                                    child = c("A", "KRAS", "FBXW7"),
                                    s = 0.1,
                                    sh = -0.01,
                                    typeDep = "MN"),
                         geneToModule = c("Root" = "Root",
                             "A" = "EVC2, PIK3CA, TP53",
                             "KRAS" = "KRAS",
                             "FBXW7" = "FBXW7"))

plot(rv1, expandModules = TRUE, autofit = TRUE)


## ----rzx0127, fig.height=6----------------------------------------
rv2 <- allFitnessEffects(
    data.frame(parent = c("Root", "1", "2", "3", "4"),
               child = c("1", "2", "3", "4", "ELF3"),
               s = 0.1,
               sh = -0.01,
               typeDep = "MN"),
    geneToModule = c("Root" = "Root",
                     "1" = "APC, FBXW7",
                     "2" = "ATM, FAM123B, PIK3CA, TP53",
                     "3" = "BRAF, KRAS, NRAS",
                     "4" = "SMAD2, SMAD4, SOX9",
                     "ELF3" = "ELF3"))

plot(rv2, expandModules = TRUE,   autofit = TRUE)

## ----seedprbau003, echo=FALSE-------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## ----prbau003, fig.height=6---------------------------------------

o3init <- allFitnessEffects(orderEffects = c(
                            "M > D > F" = 0.99,
                            "D > M > F" = 0.2,
                            "D > M"     = 0.1,
                            "M > D"     = 0.9),
                        noIntGenes = c("u" = 0.01,
                                       "v" = 0.01,
                                       "w" = 0.001,
                                       "x" = 0.0001,
                                       "y" = -0.0001,
                                       "z" = -0.001),
                        geneToModule =
                            c("M" = "m",
                              "F" = "f",
                              "D" = "d") )

oneI <- oncoSimulIndiv(o3init, model = "McFL",
                       mu = 5e-5, finalTime = 200,
                       detectionDrivers = 3,
                       onlyCancer = FALSE,
                       initSize = 1000,
                       keepPhylog = TRUE,
                       initMutant = c("m > u > d")
                       )
plotClonePhylog(oneI, N = 0)

## ----prbau003bb, fig.height=6-------------------------------------
## Note we also disable the stopping stochastically as a function of size
## to allow the population to grow large and generate may different
## clones.

## For speed, we set a small finalTime and we fix the seed
## for reproducilibity. Beware: since finalTime is short, sometimes
## we do not reach cancer
set.seed(1)
RNGkind("L'Ecuyer-CMRG")

ospI <- oncoSimulPop(2,
                    o3init, model = "Exp",
                    mu = 5e-5, finalTime = 200,
                    detectionDrivers = 3,
                    onlyCancer = TRUE,
                    initSize = 10,
                    keepPhylog = TRUE,
                    initMutant = c("d > m > z"),
                    mc.cores = 2,
                    seed = NULL
                    )

## Show just one example
## op <- par(mar = rep(0, 4), mfrow = c(1, 2))
plotClonePhylog(ospI[[1]])
## plotClonePhylog(ospI[[2]])
## par(op)

set.seed(1)
RNGkind("L'Ecuyer-CMRG")
ossI <- oncoSimulSample(2,
                        o3init, model = "Exp",
                        mu = 5e-5, finalTime = 200,
                        detectionDrivers = 2,
                        onlyCancer = TRUE,
                        initSize = 10,
                        initMutant = c("z > d"),
                        ## check presence of initMutant:
                        thresholdWhole = 1,
                        seed = NULL
                    )

## No phylogeny is kept with oncoSimulSample, but look at the
## OcurringDrivers and the sample
ossI$popSample
ossI$popSummary[, "OccurringDrivers", drop = FALSE]

## ----prbaux002, eval=FALSE----------------------------------------
# gi2 <- rep(0, 5)
# names(gi2) <- letters[1:5]
# oi2 <- allFitnessEffects(noIntGenes = gi2)
# s5 <- oncoSimulPop(200,
#                    oi2,
#                    model = "McFL",
#                    initSize = 1000,
#                    onlyCancer = TRUE,
#                    detectionProb = c(p2 = 0.1,
#                                      n2 = 2000,
#                                      PDBaseline = 1000,
#                                      checkSizePEvery = 2),
#                    detectionSize = NA,
#                    finalTime = NA,
#                    keepEvery = NA,
#                    detectionDrivers = NA)
# s5
# hist(unlist(lapply(s5, function(x) x$FinalTime)))

## ----nyv0126------------------------------------------------------
u <- 0.2; i <- -0.02; vi <- 0.6; ui <- uv <- -Inf
od2 <- allFitnessEffects(
    epistasis = c("u" = u,  "u:i" = ui,
                  "u:v" = uv, "i" = i,
                  "v:-i" = -Inf, "v:i" = vi))

## ----simul-ochs---------------------------------------------------
initS <- 20
## We use only a small number of repetitions for the sake
## of speed. Even fewer in Windows, since we run on a single
## core

if(.Platform$OS.type == "windows") {
    nruns <- 4
} else {
    nruns <- 10
}

od100 <- oncoSimulPop(nruns, od2,
                      fixation = c("u", "v, i"),
                      model = "McFL",
                      mu = 1e-4,
                      detectionDrivers = NA,
                      finalTime = NA,
                      detectionSize = NA,
                      detectionProb = NA,
                      onlyCancer = TRUE,
                      initSize = initS,
                      mc.cores = 2)

## ----ochs-freq-genots---------------------------------------------
sampledGenotypes(samplePop(od100))

## ----sum-simul-ochs-----------------------------------------------
head(summary(od100)[, c(1:3, 8:9)])

## ----fixationG1---------------------------------------------------
## Create a simple fitness landscape
rl1 <- matrix(0, ncol = 6, nrow = 9)
colnames(rl1) <- c(LETTERS[1:5], "Fitness")
rl1[1, 6] <- 1
rl1[cbind((2:4), c(1:3))] <- 1
rl1[2, 6] <- 1.4
rl1[3, 6] <- 1.32
rl1[4, 6] <- 1.32
rl1[5, ] <- c(0, 1, 0, 0, 1, 1.5)
rl1[6, ] <- c(0, 0, 1, 1, 0, 1.54)
rl1[7, ] <- c(1, 0, 1, 1, 0, 1.65)
rl1[8, ] <- c(1, 1, 1, 1, 0, 1.75)
rl1[9, ] <- c(1, 1, 1, 1, 1, 1.85)
class(rl1) <- c("matrix", "genotype_fitness_matrix")
## plot(rl1) ## to see the fitness landscape

## Gene combinations
local_max_g <- c("A", "B, E", "A, B, C, D, E")
## Specify the genotypes
local_max <- paste0("_,", local_max_g)

fr1 <- allFitnessEffects(genotFitness = rl1, drvNames = LETTERS[1:5])
initS <- 2000


######## Stop on gene combinations   #####
r1 <- oncoSimulPop(10,
                       fp = fr1,
                       model = "McFL",
                       initSize = initS,
                       mu = 1e-4,
                       detectionSize = NA,
                       sampleEvery = .03,
                       keepEvery = 1,
                       finalTime = 50000,
                       fixation = local_max_g,
                       detectionDrivers = NA,
                       detectionProb = NA,
                       onlyCancer = TRUE,
                       max.num.tries = 500,
                       max.wall.time = 20,
                       errorHitMaxTries = TRUE,
                       keepPhylog = FALSE,
                       mc.cores = 2)
sp1 <- samplePop(r1, "last", "singleCell")
sgsp1 <- sampledGenotypes(sp1)
## often you will stop on gene combinations that
## are not local maxima in the fitness landscape
sgsp1
sgsp1$Genotype %in% local_max_g

####### Stop on genotypes   ####

r2 <- oncoSimulPop(10,
                       fp = fr1,
                       model = "McFL",
                       initSize = initS,
                       mu = 1e-4,
                       detectionSize = NA,
                       sampleEvery = .03,
                       keepEvery = 1,
                       finalTime = 50000,
                       fixation = local_max,
                       detectionDrivers = NA,
                       detectionProb = NA,
                       onlyCancer = TRUE,
                       max.num.tries = 500,
                       max.wall.time = 20,
                       errorHitMaxTries = TRUE,
                       keepPhylog = FALSE,
                       mc.cores = 2)
## All final genotypes should be local maxima
sp2 <- samplePop(r2, "last", "singleCell")
sgsp2 <- sampledGenotypes(sp2)
sgsp2$Genotype %in% local_max_g




## ----fixationG2---------------------------------------------------
## Create a simple fitness landscape
rl1 <- matrix(0, ncol = 6, nrow = 9)
colnames(rl1) <- c(LETTERS[1:5], "Fitness")
rl1[1, 6] <- 1
rl1[cbind((2:4), c(1:3))] <- 1
rl1[2, 6] <- 1.4
rl1[3, 6] <- 1.32
rl1[4, 6] <- 1.32
rl1[5, ] <- c(0, 1, 0, 0, 1, 1.5)
rl1[6, ] <- c(0, 0, 1, 1, 0, 1.54)
rl1[7, ] <- c(1, 0, 1, 1, 0, 1.65)
rl1[8, ] <- c(1, 1, 1, 1, 0, 1.75)
rl1[9, ] <- c(1, 1, 1, 1, 1, 1.85)
class(rl1) <- c("matrix", "genotype_fitness_matrix")
## plot(rl1) ## to see the fitness landscape

## The local fitness maxima are
## c("A", "B, E", "A, B, C, D, E")

fr1 <- allFitnessEffects(genotFitness = rl1, drvNames = LETTERS[1:5])
initS <- 2000

## Stop on genotypes

r3 <- oncoSimulPop(10,
                  fp = fr1,
                  model = "McFL",
                  initSize = initS,
                  mu = 1e-4,
                  detectionSize = NA,
                  sampleEvery = .03,
                  keepEvery = 1,
                  finalTime = 50000,
                  fixation = c(paste0("_,",
                                   c("A", "B, E", "A, B, C, D, E")),
                               fixation_tolerance = 0.1,
                               min_successive_fixation = 200,
                               fixation_min_size = 3000),
                  detectionDrivers = NA,
                  detectionProb = NA,
                  onlyCancer = TRUE,
                  max.num.tries = 500,
                  max.wall.time = 20,
                  errorHitMaxTries = TRUE,
                  keepPhylog = FALSE,
                  mc.cores = 2)


## ----prbaux001----------------------------------------------------
K <- 5
sd <- 0.1
sdp <- 0.15
sp <- 0.05
bauer <- data.frame(parent = c("Root", rep("p", K)),
                    child = c("p", paste0("s", 1:K)),
                    s = c(sd, rep(sdp, K)),
                    sh = c(0, rep(sp, K)),
                    typeDep = "MN")
fbauer <- allFitnessEffects(bauer, drvNames = "p")
set.seed(1)
## Use fairly large mutation rate
b1 <- oncoSimulIndiv(fbauer, mu = 5e-5, initSize = 1000,
                     finalTime = NA,
                     onlyCancer = TRUE,
                     detectionProb = "default")


## ----baux1,fig.width=6.5, fig.height=10, fig.cap="Three drivers' plots of a simulation of Bauer's model"----
par(mfrow = c(3, 1))
## First, drivers
plot(b1, type = "line", addtot = TRUE)
plot(b1, type = "stacked")
plot(b1, type = "stream")

## ----baux2,fig.width=6.5, fig.height=10, fig.cap="Three genotypes' plots of a simulation of Bauer's model"----
par(mfrow = c(3, 1))
## Next, genotypes
plot(b1, show = "genotypes", type = "line")
plot(b1, show = "genotypes", type = "stacked")
plot(b1, show = "genotypes", type = "stream")

## ----rzx0000, fig.width=6-----------------------------------------

set.seed(678)
nd <- 70
np <- 5000
s <- 0.1
sp <- 1e-3
spp <- -sp/(1 + sp)
mcf1 <- allFitnessEffects(noIntGenes = c(rep(s, nd), rep(spp, np)),
                          drvNames = seq.int(nd))
mcf1s <-  oncoSimulIndiv(mcf1,
                         model = "McFL",
                         mu = 1e-7,
                         detectionProb = "default",
                         detectionSize = NA,
                         detectionDrivers = NA,
                         sampleEvery = 0.025,
                         keepEvery = 8,
                         initSize = 2000,
                         finalTime = 4000,
                         onlyCancer = FALSE)
summary(mcf1s)


## ----mcf1sx1,fig.width=6.5, fig.height=10-------------------------
par(mfrow  = c(2, 1))
## I use thinData to make figures smaller and faster
plot(mcf1s, addtot = TRUE, lwdClone = 0.9, log = "",
     thinData = TRUE, thinData.keep = 0.5)
plot(mcf1s, show = "drivers", type = "stacked",
     thinData = TRUE, thinData.keep = 0.3,
     legend.ncols = 2)

## ----rzx0300, eval=FALSE------------------------------------------
# 
# set.seed(123)
# nd <- 70
# np <- 50000
# s <- 0.1
# sp <- 1e-4 ## as we have many more passengers
# spp <- -sp/(1 + sp)
# mcfL <- allFitnessEffects(noIntGenes = c(rep(s, nd), rep(spp, np)),
#                           drvNames = seq.int(nd))
# mcfLs <-  oncoSimulIndiv(mcfL,
#                          model = "McFL",
#                          mu = 1e-7,
#                          detectionSize = 1e8,
#                          detectionDrivers = 100,
#                          sampleEvery = 0.02,
#                          keepEvery = 2,
#                          initSize = 1000,
#                          finalTime = 2000,
#                          onlyCancer = FALSE)

## ----rzx0301, mcflsx2,fig.width=6---------------------------------
data(mcfLs)
plot(mcfLs, addtot = TRUE, lwdClone = 0.9, log = "",
     thinData = TRUE, thinData.keep = 0.3,
     plotDiversity = TRUE)

## ----nyv0127------------------------------------------------------
summary(mcfLs)
## number of passengers per clone
summary(colSums(mcfLs$Genotypes[-(1:70), ]))

## ----mcflsx3------------------------------------------------------
plot(mcfLs, type = "stacked", thinData = TRUE,
     thinData.keep = 0.1,
     plotDiversity = TRUE,
     xlim = c(0, 1000))

## ----nyv0128------------------------------------------------------
data(examplesFitnessEffects)
names(examplesFitnessEffects)

## ----seedsmmmcfls-------------------------------------------------
set.seed(1)

## ----smmcfls------------------------------------------------------
data(examplesFitnessEffects)
evalAllGenotypes(examplesFitnessEffects$cbn1, order = FALSE)[1:10, ]
sm <-  oncoSimulIndiv(examplesFitnessEffects$cbn1,
                      model = "McFL",
                      mu = 5e-7,
                      detectionSize = 1e8,
                      detectionDrivers = 2,
                      detectionProb = "default",
                      sampleEvery = 0.025,
                      keepEvery = 5,
                      initSize = 2000,
                      onlyCancer = TRUE)
summary(sm)

## ----smbosb1------------------------------------------------------
set.seed(1234)
evalAllGenotypes(examplesFitnessEffects$cbn1, order = FALSE,
                 model = "Bozic")[1:10, ]
sb <-  oncoSimulIndiv(examplesFitnessEffects$cbn1,
                       model = "Bozic",
                       mu = 5e-6,
                      detectionProb = "default",
                       detectionSize = 1e8,
                       detectionDrivers = 4,
                       sampleEvery = 2,
                       initSize = 2000,
                       onlyCancer = TRUE)
summary(sb)

## ----sbx1,fig.width=6.5, fig.height=3.3---------------------------
## Show drivers, line plot
par(cex = 0.75, las = 1)
plot(sb,show = "drivers", type = "line", addtot = TRUE,
     plotDiversity = TRUE)

## ----sbx2,fig.width=6.5, fig.height=3.3---------------------------
## Drivers, stacked
par(cex = 0.75, las = 1)
plot(sb,show = "drivers", type = "stacked", plotDiversity = TRUE)

## ----sbx3,fig.width=6.5, fig.height=3.3---------------------------
## Drivers, stream
par(cex = 0.75, las = 1)
plot(sb,show = "drivers", type = "stream", plotDiversity = TRUE)

## ----sbx4,fig.width=6.5, fig.height=3.3---------------------------
## Genotypes, line plot
par(cex = 0.75, las = 1)
plot(sb,show = "genotypes", type = "line", plotDiversity = TRUE)

## ----sbx5,fig.width=6.5, fig.height=3.3---------------------------
## Genotypes, stacked
par(cex = 0.75, las = 1)
plot(sb,show = "genotypes", type = "stacked", plotDiversity = TRUE)

## ----sbx6,fig.width=6.5, fig.height=3.3---------------------------
## Genotypes, stream
par(cex = 0.75, las = 1)
plot(sb,show = "genotypes", type = "stream", plotDiversity = TRUE)

## ----rzx0302, fig.width=6-----------------------------------------

set.seed(4321)
tmp <-  oncoSimulIndiv(examplesFitnessEffects[["o3"]],
                       model = "McFL",
                       mu = 5e-5,
                       detectionSize = 1e8,
                       detectionDrivers = 3,
                       sampleEvery = 0.025,
                       max.num.tries = 10,
                       keepEvery = 5,
                       initSize = 2000,
                       finalTime = 6000,
                       onlyCancer = FALSE)

## ----tmpmx1,fig.width=6.5, fig.height=4.1-------------------------
par(las = 1, cex = 0.85)
plot(tmp, addtot = TRUE, log = "", plotDiversity = TRUE,
     thinData = TRUE, thinData.keep = 0.2)

## ----tmpmx2,fig.width=6.5, fig.height=4.1-------------------------
par(las = 1, cex = 0.85)
plot(tmp, type = "stacked", plotDiversity = TRUE,
     ylim = c(0, 5500), legend.ncols = 4,
     thinData = TRUE, thinData.keep = 0.2)

## ----nyv0129------------------------------------------------------
evalAllGenotypes(examplesFitnessEffects[["o3"]], addwt = TRUE,
                 order = TRUE)

## ----tmpmx3,fig.width=6.5, fig.height=5.5-------------------------
plot(tmp, show = "genotypes", ylim = c(0, 5500), legend.ncols = 3,
     thinData = TRUE, thinData.keep = 0.5)

## ----nyv0130------------------------------------------------------
set.seed(15)
tmp <-  oncoSimulIndiv(examplesFitnessEffects[["o3"]],
                       model = "McFL",
                       mu = 5e-5,
                       detectionSize = 1e8,
                       detectionDrivers = 3,
                       sampleEvery = 0.025,
                       max.num.tries = 10,
                       keepEvery = 5,
                       initSize = 2000,
                       finalTime = 20000,
                       onlyCancer = FALSE,
                       extraTime = 1500)
tmp

## ----tmpmdx5,fig.width=6.5, fig.height=4--------------------------
par(las = 1, cex = 0.85)
plot(tmp, addtot = TRUE, log = "", plotDiversity = TRUE,
     thinData = TRUE, thinData.keep = 0.5)

## ----tmpmdx6,fig.width=6.5, fig.height=4--------------------------
par(las = 1, cex = 0.85)
plot(tmp, type = "stacked", plotDiversity = TRUE,
     legend.ncols = 4, ylim = c(0, 5200), xlim = c(3400, 5000),
     thinData = TRUE, thinData.keep = 0.5)

## ----tmpmdx7,fig.width=6.5, fig.height=5.3------------------------
## Improve telling apart the most abundant
## genotypes by sorting colors
## differently via breakSortColors
## Modify ncols of legend, so it is legible by not overlapping
## with plot
par(las = 1, cex = 0.85)
plot(tmp, show = "genotypes", breakSortColors = "distave",
     plotDiversity = TRUE, legend.ncols = 4,
     ylim = c(0, 5300), xlim = c(3400, 5000),
     thinData = TRUE, thinData.keep = 0.5)

## ----rzx0303, eval=FALSE------------------------------------------
# ## Convert the data
# lb1 <- OncoSimulWide2Long(b1)
# 
# ## Install the streamgraph package from GitHub and load
# library(devtools)
# devtools::install_github("hrbrmstr/streamgraph")
# library(streamgraph)
# 
# ## Stream plot for Genotypes
# sg_legend(streamgraph(lb1, Genotype, Y, Time, scale = "continuous"),
#               show=TRUE, label="Genotype: ")
# 
# ## Staked area plot and we use the pipe
# streamgraph(lb1, Genotype, Y, Time, scale = "continuous",
#             offset = "zero") %>%
#     sg_legend(show=TRUE, label="Genotype: ")

## ----minitm1------------------------------------------------------
r2 <- rfitness(6)
## Make sure these always viable for interesting stuff
r2[2, 7] <- 1 + runif(1) # A
r2[4, 7] <- 1 + runif(1) # C
r2[8, 7] <- 1 + runif(1) # A, B
o2 <- allFitnessEffects(genotFitness = r2)
ag <- evalAllGenotypes(o2)

out1 <- oncoSimulIndiv(o2, initMutant = c("A", "C"),
                       initSize = c(100, 200),
                       onlyCancer = FALSE,
                       finalTime = 200)



## ----minitm1fdf---------------------------------------------------
gffd0 <- data.frame(
    Genotype = c(
        "A", "A, B",
        "C", "C, D", "C, E"),
    Fitness = c(
        "1.3",
        "1.4",
        "1.4",
        "1.1 + 0.7*((f_A + f_A_B) > 0.3)",
        "1.2 + sqrt(f_A + f_C + f_C_D)"))

afd0 <- allFitnessEffects(genotFitness = gffd0,
                          frequencyDependentFitness = TRUE)

sp <- 1:5
names(sp) <- c("A", "C", "A, B", "C, D", "C, E")
eag0 <- evalAllGenotypes(afd0, spPopSizes = sp)

os0 <- oncoSimulIndiv(afd0,
                      initMutant = c("A", "C"),
                      finalTime = 20, initSize = c(1e4, 1e5),
                      onlyCancer = FALSE, model = "McFLD")

## ----mspeci1------------------------------------------------------

mspec <- data.frame(
    Genotype = c("A",
                 "A, a1", "A, a2", "A, a1, a2",
                 "B",
                 "B, b1", "B, b2", "B, b3",
                 "B, b1, b2", "B, b1, b3", "B, b1, b2, b3"),
    Fitness = 1 + runif(11)
)
fmspec <- allFitnessEffects(genotFitness = mspec)
afmspec <- evalAllGenotypes(fmspec)

## Show only viable ones
afmspec[afmspec$Fitness >= 1, ]

muv <- c(1e-10, rep(1e-5, 2), 1e-10, rep(1e-5, 3))
names(muv) <- c("A", paste0("a", 1:2), "B", paste0("b", 1:3))

out1 <- oncoSimulIndiv(fmspec, initMutant = c("A", "B"),
                       initSize = c(100, 200),
                       mu = muv,
                       onlyCancer = FALSE,
                       finalTime = 200)


## ----mspeci2------------------------------------------------------

mspecF <- data.frame(
    Genotype = c("A",
                 "A, a1", "A, a2", "A, a1, a2",
                 "B",
                 "B, b1", "B, b2", "B, b3",
                 "B, b1, b2", "B, b1, b3", "B, b1, b2, b3"),
    Fitness = c("1 + f_A_a1",
                "1 + f_A_a2",
                "1 + f_A_a1_a2",
                "1 + f_B",
                "1 + f_B_b1",
                "1 + f_B_b2",
                "1 + f_B_b3",
                "1 + f_B_b1_b2",
                "1 + f_B_b1_b3",
                "1 + f_B_b1_b2_b3",
                "1 + f_A")
)
fmspecF <- allFitnessEffects(genotFitness = mspecF,
                             frequencyDependentFitness = TRUE)
## Remeber, spPopSizes correspond to the genotypes
## shown in
fmspecF$full_FDF_spec
## in exactly that order if it is unnamed.

afmspecF <- evalAllGenotypes(fmspecF,
                             spPopSizes = 1:11)

## Alternatively, pass a named vector, which is the recommended approach

spp <- 1:11
names(spp) <- c("A","B",
                "A, a1", "A, a2",
                "B, b1", "B, b2", "B, b3",
                "A, a1, a2",
                "B, b1, b2", "B, b1, b3", "B, b1, b2, b3")

afmspecF <- evalAllGenotypes(fmspecF,
                             spPopSizes = spp)


## Show only viable ones
afmspecF[afmspecF$Fitness >= 1, ]

## Expected values of fitness
exv <- 1 + c(3, 5, 4, 8, 6, 7, 9, 2, 10, 11, 1)/sum(1:11)
stopifnot(isTRUE(all.equal(exv, afmspecF[afmspecF$Fitness >= 1, ]$Fitness)))

muv <- c(1e-10, rep(1e-5, 2), 1e-10, rep(1e-5, 3))
names(muv) <- c("A", paste0("a", 1:2), "B", paste0("b", 1:3))

out1 <- oncoSimulIndiv(fmspecF, initMutant = c("A", "B"),
                       initSize = c(1e4, 1e5),
                       mu = muv,
                       finalTime = 20,
                       model = "McFLD",
                       onlyCancer = FALSE)


## ----pancrpopcreate-----------------------------------------------

pancrPop <- oncoSimulPop(4, pancr,
                         onlyCancer = TRUE,
                         detectionSize = 1e7,
                         keepEvery = 10,
                         mc.cores = 2)

summary(pancrPop)
samplePop(pancrPop)


## ----nyv0131------------------------------------------------------
library(parallel)

if(.Platform$OS.type == "windows") {
    mc.cores <- 1
} else {
    mc.cores <- 2
}

p2 <- mclapply(1:4, function(x) oncoSimulIndiv(pancr,
                                               onlyCancer = TRUE,
                                               detectionSize = 1e7,
                                               keepEvery = 10),
                                               mc.cores = mc.cores)
class(p2) <- "oncosimulpop"
samplePop(p2)

## ----nyv0132------------------------------------------------------
tail(pancrPop[[1]]$pops.by.time)

## ----nyv0133------------------------------------------------------
pancrPopNH <- oncoSimulPop(4, pancr,
                           onlyCancer = TRUE,
                           detectionSize = 1e7,
                           keepEvery = NA,
                           mc.cores = 2)

summary(pancrPopNH)
samplePop(pancrPopNH)

## ----nyv0134------------------------------------------------------
pancrPopNH[[1]]$pops.by.time

## ----nyv0135------------------------------------------------------
pancrSamp <- oncoSimulSample(4, pancr, onlyCancer = TRUE)
pancrSamp$popSamp


## ----nyv0136------------------------------------------------------

set.seed(15)
tmp <-  oncoSimulIndiv(examplesFitnessEffects[["o3"]],
                       model = "McFL",
                       mu = 5e-5,
                       detectionSize = 1e8,
                       detectionDrivers = 3,
                       sampleEvery = 0.025,
                       max.num.tries = 10,
                       keepEvery = 5,
                       initSize = 2000,
                       finalTime = 20000,
                       onlyCancer = FALSE,
                       extraTime = 1500,
                       keepPhylog = TRUE)
tmp

## ----nyv0137------------------------------------------------------
plotClonePhylog(tmp, N = 0)

## ----nyv0138------------------------------------------------------
plotClonePhylog(tmp, N = 1)

## ----pcpkeepx1----------------------------------------------------
plotClonePhylog(tmp, N = 1, keepEvents = TRUE)

## ----nyv0139------------------------------------------------------
plotClonePhylog(tmp, N = 1, timeEvents = TRUE)

## ----rzx0304, fig.keep="none"-------------------------------------
get.adjacency(plotClonePhylog(tmp, N = 1, returnGraph = TRUE))


## ----nyv0140------------------------------------------------------

set.seed(456)
mcf1s <-  oncoSimulIndiv(mcf1,
                         model = "McFL",
                         mu = 1e-7,
                         detectionSize = 1e8,
                         detectionDrivers = 100,
                         sampleEvery = 0.025,
                         keepEvery = 2,
                         initSize = 2000,
                         finalTime = 1000,
                         onlyCancer = FALSE,
                         keepPhylog = TRUE)


## ----nyv0141------------------------------------------------------
plotClonePhylog(mcf1s, N = 1)

## ----nyv0142------------------------------------------------------
par(cex = 0.7)
plotClonePhylog(mcf1s, N = 1, timeEvents = TRUE)

## ----nyv0143------------------------------------------------------
par(cex = 0.7)
plotClonePhylog(mcf1s, N = 1, t = c(800, 1000))

## ----nyv0144------------------------------------------------------
par(cex = 0.7)
plotClonePhylog(mcf1s, N = 1, t = c(900, 1000), timeEvents = TRUE)

## ----fig.keep="none"----------------------------------------------
g1 <- plotClonePhylog(mcf1s, N = 1, t = c(900, 1000),
                      returnGraph = TRUE)

## ----nyv0145------------------------------------------------------
plot(g1)

## ----rzx0305, eval=FALSE------------------------------------------
# op <- par(ask = TRUE)
# while(TRUE) {
#     tmp <- oncoSimulIndiv(smn1, model = "McFL",
#                           mu = 5e-5, finalTime = 500,
#                           detectionDrivers = 3,
#                           onlyCancer = FALSE,
#                           initSize = 1000, keepPhylog = TRUE)
#     plotClonePhylog(tmp, N = 0)
# }
# par(op)

## ----nyv0146------------------------------------------------------

oi <- allFitnessEffects(orderEffects =
               c("F > D" = -0.3, "D > F" = 0.4),
               noIntGenes = rexp(5, 10),
                          geneToModule =
                              c("F" = "f1, f2, f3",
                                "D" = "d1, d2") )
oiI1 <- oncoSimulIndiv(oi, model = "Exp", onlyCancer = TRUE)
oiP1 <- oncoSimulPop(4, oi,
                     keepEvery = 10,
                     mc.cores = 2,
                     keepPhylog = TRUE, onlyCancer = TRUE)


## ----rzx0306, fig.height=9----------------------------------------

op <- par(mar = rep(0, 4), mfrow = c(2, 1))
plotClonePhylog(oiP1[[1]])
plotClonePhylog(oiP1[[2]])
par(op)


## ----nyv0147------------------------------------------------------
## A small example
rfitness(3)

## A 5-gene example, where the reference genotype is the
## one with all positions mutated, similar to Greene and Crona,
## 2014.  We will plot the landscape and use it for simulations
## We downplay the random component with a sd = 0.5

r1 <- rfitness(5, reference = rep(1, 5), sd = 0.6)
plot(r1)
oncoSimulIndiv(allFitnessEffects(genotFitness = r1),
               onlyCancer = TRUE)

## ----nkex1--------------------------------------------------------
rnk <- rfitness(5, K = 3, model = "NK")
plot(rnk)
oncoSimulIndiv(allFitnessEffects(genotFitness = rnk),
               onlyCancer = TRUE)

## ----addex1-------------------------------------------------------
radd <- rfitness(4, model = "Additive", mu = 0, sd = 0.5)
plot(radd)

## ----eggex1-------------------------------------------------------
regg <- rfitness(4, model = "Eggbox", e = 1, E = 0.5)
plot(regg)

## ----isingex1-----------------------------------------------------
ris <- rfitness(g = 4, model = "Ising", i = 0.002, I = 0.45)
plot(ris)

## ----fullex1------------------------------------------------------
rnk <- rfitness(4, model = "Full", i = 0.5, I = 0.1,
                e = 2, s = 0.3, S = 0.08)
plot(rnk)

## ----magstats1----------------------------------------------------
rnk1 <- rfitness(6, K = 1, model = "NK")
Magellan_stats(rnk1)

rnk2 <- rfitness(6, K = 4, model = "NK")
Magellan_stats(rnk2)

## ----fdf1---------------------------------------------------------
## Define fitness of the different genotypes
gffd <- data.frame(
    Genotype = c("WT", "A", "B", "C", "A, B"),
    Fitness = c("1 + 1.5 * f_A_B",
                "1.3 + 1.5 * f_A_B",
                "1.4",
                "1.1 + 0.7*((f_A + f_B) > 0.3) + f_A_B",
                "1.2 + sqrt(f_1 + f_C + f_B) - 0.3 * (f_A_B > 0.5)"))


## ----fdf1named----------------------------------------------------
## Define fitness of the different genotypes
gffdn <- data.frame(
    Genotype = c("WT", "A", "B", "C", "A, B"),
    Fitness = c("1 + 1.5 * f_1_2",
                "1.3 + 1.5 * f_1_2",
                "1.4",
                "1.1 + 0.7*((f_1 + f_2) > 0.3) + f_1_2",
                "1.2 + sqrt(f_1 + f_3 + f_2) - 0.3 * (f_1_2 > 0.5)"),
    stringsAsFactors = FALSE)

## ----fdf1b--------------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness = gffd,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel"),
                 spPopSizes = c(WT = 100, A = 20, B = 20, C = 30, "A, B" = 0))

## Notice the warning
evalAllGenotypes(allFitnessEffects(genotFitness = gffd,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel"),
                 spPopSizes = c(100, 30, 40, 0, 10))

evalAllGenotypes(allFitnessEffects(genotFitness = gffd,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel"),
                 spPopSizes = c(100, 30, 40, 0, 100))


## ----fdf1bnamed---------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness = gffdn,
                         frequencyDependentFitness = TRUE),
                 spPopSizes = c(100, 20, 20, 30, 0))

evalAllGenotypes(allFitnessEffects(genotFitness = gffdn,
                         frequencyDependentFitness = TRUE),
                 spPopSizes = c(100, 30, 40, 0, 10))

evalAllGenotypes(allFitnessEffects(genotFitness = gffdn,
                         frequencyDependentFitness = TRUE),
                 spPopSizes = c(100, 30, 40, 0, 100))


## ----fdf1c--------------------------------------------------------
afd <- allFitnessEffects(genotFitness = gffd,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel")

set.seed(1) ## for reproducibility
sfd <- oncoSimulIndiv(afd,
                     model = "McFL",
                     onlyCancer = FALSE,
                     finalTime = 55, ## short, for speed
                     mu = 1e-4,
                     initSize = 5000,
                     keepPhylog = FALSE,
                     seed = NULL,
                     errorHitMaxTries = FALSE,
                     errorHitWallTime = FALSE)
plot(sfd, show = "genotypes")

## ----hurlbutpay, eval=TRUE,echo=FALSE, fig.cap="Payoff matrix from Table 2 of Hurlbut et al., 2018, 'Game Theoretical Model of Cancer Dynamics withFour Cell Phenotypes', *Games*, 9, 61; doi:10.3390/g9030061."----
knitr::include_graphics("hurlbut.png")

## ----hurlbutfit1--------------------------------------------------


create_fe <- function(a, b, c, d, e, f, g,
                        gt = c("WT", "A", "P", "C")) {
  data.frame(Genotype = gt,
             Fitness = c(
                 paste0("1 + ",
                       d, " * f_A ",
                       "- ", c, " * f_C"),
                 paste0("1 - ", a,
				     " + ", d, " + ",
                       f, " * f_A ",
                      "- ", c, " * f_C"),
                 paste0("1 + ", g, " + ",
                       d, " * f_A ",
                       "- ", c, " * (1 + ",
                       g, ") * f_C"),
                 paste0("1 - ", b, " + ",
                       e, " * f_ + ",
                       "(", d, " + ",
					   e, ") * f_A + ",
                       e , " * f_P")))
}

## ----hbf1check----------------------------------------------------
create_fe("a", "b", "c", "d", "e", "f", "g")

## ----hurlbutfit2--------------------------------------------------
## Different assumption about origins from mutation:
## WT -> P; P -> A,P; P -> C,P

create_fe2 <- function(a, b, c, d, e, f, g,
                        gt = c("WT", "A", "P", "C", "A, P", "A, C",
                                "C, P")) {
  data.frame(Genotype = gt,
             Fitness = c(
                 paste0("1 + ",
                       d, " * f_A_P ",
                       "- ", c, " * f_P_C"),
                 "0",
                 paste0("1 + ", g, " + ",
                       d, " * f_A_P ",
                       "- ", c, " * (1 + ",
                       g, ") * f_P_C"),
                 "0",
                 paste0("1 - ", a, " + ",
				 d, " + ",
                       f, " * f_A_P ",
                       "- ", c, " * f_P_C"),
                 "0",
                 paste0("1 - ", b, " + ",
                       e, " * f_ + ",
                       "(", d, " + ",
					   e, ") * f_A_P + ",
                       e , " * f_P")),
             stringsAsFactors = FALSE)
}

## And check:
create_fe2("a", "b", "c", "d", "e", "f", "g")

## ----hurl3a, message=FALSE----------------------------------------
## Figure 3a
afe_3_a <- allFitnessEffects(
		        genotFitness =
                       create_fe(0.02, 0.04, 0.08, 0.06,
                                 0.15, 0.1, 0.06),
                frequencyDependentFitness = TRUE)


## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below

data(s_3_a)
if (FALSE) {
set.seed(2)
s_3_a <- oncoSimulIndiv(afe_3_a,
                     model = "McFL",
                     onlyCancer = FALSE,
                     finalTime = 160,
                     mu = 1e-4,
                     initSize = 5000,
                     keepPhylog = FALSE,
                     seed = NULL,
                     errorHitMaxTries = FALSE,
                     errorHitWallTime = FALSE,
                     keepEvery = 1)
}
plot(s_3_a, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue"))

## ----hurl3b, message=FALSE----------------------------------------
## Figure 3b
afe_3_b <- allFitnessEffects(
                genotFitness =
                       create_fe(0.02, 0.04, 0.08, 0.1,
                                 0.15, 0.1, 0.05),
                frequencyDependentFitness = TRUE)

## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below
data(s_3_b)

if (FALSE) {
set.seed(2)
## Use a short finalTime, for speed of vignette execution
s_3_b <- oncoSimulIndiv(afe_3_b,
                     model = "McFL",
                     onlyCancer = FALSE,
                     finalTime = 100,
                     mu = 1e-4,
                     initSize = 5000,
                     keepPhylog = FALSE,
                     seed = NULL,
                     errorHitMaxTries = FALSE,
                     errorHitWallTime = FALSE,
                     keepEvery = 1)
}
plot(s_3_b, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue"))
## we are using keepEvery. O.w. we could have used
## thinData = TRUE for faster plotting

## ----hurl3b2------------------------------------------------------
## Figure 3b. Now with WT -> P; P -> A,P; P -> C,P
## For speed, we set finalTime = 100
afe_3_b_2 <- allFitnessEffects(
                  genotFitness =
                      create_fe2(0.02, 0.04, 0.08, 0.1,
                                 0.15, 0.1, 0.05),
                  frequencyDependentFitness = TRUE,
                  frequencyType = "rel")
set.seed(2)
s_3_b_2 <- oncoSimulIndiv(afe_3_b_2,
                   model = "McFL",
                   onlyCancer = FALSE,
                   finalTime = 100,
                   mu = 1e-4,
                   initSize = 5000,
                   keepPhylog = FALSE,
                   seed = NULL,
                   errorHitMaxTries = FALSE,
                   errorHitWallTime = FALSE,
				   keepEvery = 1)
plot(s_3_b_2, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue"))


## ----fdf2, message=FALSE------------------------------------------
gffd3 <- data.frame(Genotype = c("WT", "A", "B"),
                   Fitness = c("1",
                               "1 + 0.2 * (n_B > 10)",
                               ".9 + 0.4 * (n_A > 10)"
                               ))
afd3 <- allFitnessEffects(genotFitness = gffd3,
                         frequencyDependentFitness = TRUE)

## ----fdf2b, message=FALSE-----------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness = gffd3,
                         frequencyDependentFitness = TRUE),
                 spPopSizes = c(WT = 100, A = 1, B = 11))

evalAllGenotypes(allFitnessEffects(genotFitness = gffd3,
                         frequencyDependentFitness = TRUE),
                 spPopSizes = c(WT = 100, A = 11, B = 1))

## ----fdf2c--------------------------------------------------------
set.seed(1)
sfd3 <- oncoSimulIndiv(afd3,
                       model = "McFLD",
                       onlyCancer = FALSE,
                       finalTime = 200,
                       mu = 1e-4,
                       initSize = 5000,
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE)

## ----echo=FALSE---------------------------------------------------
op <- par(mfrow = c(1, 2))

## -----------------------------------------------------------------
plot(sfd3, show = "genotypes", type = "line")
plot(sfd3, show = "genotypes")
sfd3

## ----echo=FALSE---------------------------------------------------
par(op)


## ----fdf2d--------------------------------------------------------
set.seed(1)
sfd4 <- oncoSimulIndiv(afd3,
                       model = "McFL",
                       onlyCancer = FALSE,
                       finalTime = 145,
                       mu = 1e-4,
                       initSize = 5000,
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE)

## ----rzx0307, echo=FALSE------------------------------------------
op <- par(mfrow = c(1, 2))

## ----polotfdfv6---------------------------------------------------
plot(sfd4, show = "genotypes", type = "line")
plot(sfd4, show = "genotypes")
sfd4

## ----rzx0308, echo=FALSE------------------------------------------
par(op)

## ----fdfpopfinal--------------------------------------------------
## Check final pop size corresponds to birth = death
K <- 5000/(exp(1) - 1)
K
log1p(4290/K)

## ----lotka1-------------------------------------------------------
G_fe_LV <- function(r1, r2, K1, K2, a_12, a_21, awt = 1e-4,
                                 gt = c("WT", "S1", "S2")) {
    data.frame(Genotype = gt,
               Fitness = c(
                  paste0("max(0.1, 1 - ", awt, " * (n_2 + n_1))"),
                  paste0("1 + ", r1,
                         " * ( 1 - (n_1 + ", a_12, " * n_2)/", K1,
                         ")"),
                  paste0("1 + ", r2,
                         " * ( 1 - (n_2 + ", a_21, " * n_1)/", K2,
                         ")")
                  ))
}

## Show expressions for birth rates
G_fe_LV("r1", "r2", "K1", "K2", "a_12", "a_21", "awt")


## ----rzx0309, echo = FALSE----------------------------------------
set.seed(1)

## ----complv1, message=FALSE---------------------------------------
fe_competition <-
    allFitnessEffects(
        genotFitness =
            G_fe_LV(1.5, 1.4, 10000, 4000, 0.6, 0.2,
                  gt = c("WT","S1", "S2")),
        frequencyDependentFitness = TRUE,
        frequencyType = "abs")

competition <- oncoSimulIndiv(fe_competition,
                            model = "Exp",
                            onlyCancer = FALSE,
                            finalTime = 100,
                            mu = 1e-4,
                            initSize = 40000,
                            keepPhylog = FALSE,
                            seed = NULL,
                            errorHitMaxTries = FALSE,
                            errorHitWallTime = FALSE)

## ----pp1wt--------------------------------------------------------
plot(competition, show = "genotypes")

## ----rzx0310, echo=FALSE------------------------------------------
op <- par(mfrow = c(1, 2))

## ----pp1nowt------------------------------------------------------
plot(competition, show = "genotypes",
     xlim = c(80, 100))
plot(competition, show = "genotypes", type = "line",
     xlim = c(80, 100), ylim = c(1500, 12000))

## ----rzx0311, echo=FALSE------------------------------------------
par(op)

## ----lotka1multi--------------------------------------------------
G_fe_LVm <- function(r1, r2, K1, K2, a_12, a_21, awt = 1e-4,
                                 gt = c("S1", "S2")) {
    data.frame(Genotype = gt,
               Fitness = c(
                  paste0("1 + ", r1,
                         " * ( 1 - (n_1 + ", a_12, " * n_2)/", K1,
                         ")"),
                  paste0("1 + ", r2,
                         " * ( 1 - (n_2 + ", a_21, " * n_1)/", K2,
                         ")")
                  ))
}

## Show expressions for birth rates
G_fe_LVm("r1", "r2", "K1", "K2", "a_12", "a_21", "awt")


## ----rzx0312, echo = FALSE----------------------------------------
set.seed(1)

## ----complv1multi, message=FALSE----------------------------------
fe_competitionm <-
    allFitnessEffects(
        genotFitness =
            G_fe_LVm(1.5, 1.4, 10000, 4000, 0.6, 0.2,
                  gt = c("S1", "S2")),
        frequencyDependentFitness = TRUE)

fe_competitionm$full_FDF_spec

competitionm <- oncoSimulIndiv(fe_competitionm,
                              model = "Exp",
                              initMutant = c("S1", "S2"),
                              initSize = c(5000, 2000),
                              onlyCancer = FALSE,
                              finalTime = 100,
                              mu = 1e-4,
                              keepPhylog = FALSE,
                              seed = NULL,
                              errorHitMaxTries = FALSE,
                              errorHitWallTime = FALSE)

## ----pp1wtmulti---------------------------------------------------
plot(competitionm, show = "genotypes")

## ----ppreydefvm2--------------------------------------------------
G_fe_LVm2 <- function(r1, r2, K1, K2, a_12, a_21, awt = 1e-4,
                                 gt = c("S1", "S2")) {
    data.frame(Genotype = gt,
               Fitness = c(
                   paste0("1 + ", r1,
                         " * ( 1 - (n_", gt[1], " + ", a_12, " * n_", gt[2], ")/", K1,
                         ")"),
                  paste0("1 + ", r2,
                         " * ( 1 - (n_", gt[2], " + ", a_21, " * n_", gt[1], ")/", K2,
                         ")")
                  ))
}


## But notice that, because of ordering, "prey" ends up being n_2
## but that is not a problem.

fe_pred_preym2 <-
    allFitnessEffects(
        genotFitness =
            G_fe_LVm2(1.5, 1.4, 10000, 4000, 1.1, -0.5, awt = 1,
                  gt = c("prey", "Predator")),
        frequencyDependentFitness = TRUE)
fe_pred_preym2$full_FDF_spec

## Change order and note how these are, of course, equivalent

fe_pred_preym3 <-
    allFitnessEffects(
        genotFitness =
            G_fe_LVm2(1.4, 1.5, 4000, 10000, -0.5, 1.1, awt = 1,
                  gt = c("Predator", "prey")),
        frequencyDependentFitness = TRUE)
fe_pred_preym3$full_FDF_spec

evalAllGenotypes(fe_pred_preym2, spPopSizes = c(1000, 300))
evalAllGenotypes(fe_pred_preym3, spPopSizes = c(300, 1000))

## ----rzx0313, echo=FALSE------------------------------------------
set.seed(1)

## ----pprey3-------------------------------------------------------
s_pred_preym2 <- oncoSimulIndiv(fe_pred_preym2,
                                model = "Exp",
                                initMutant = c("prey", "Predator"),
                                initSize = c(1000, 1000),
                                onlyCancer = FALSE,
                                finalTime = 200,
                                mu = 1e-3,
                                keepPhylog = FALSE,
                                seed = NULL,
                                errorHitMaxTries = FALSE,
                                errorHitWallTime = FALSE)

## ----prepreylv1237------------------------------------------------
plot(s_pred_preym2, show = "genotypes")

## ----prepreylv1238------------------------------------------------
evalAllGenotypes(fe_pred_preym2, spPopSizes = c(0, 300))

evalAllGenotypes(allFitnessEffects(
    genotFitness =
        G_fe_LVm2(1.5, 1.4, 100, 40,
                  0.6, -0.5, awt = 0.1,
                  gt = c("prey", "Predator")),
    frequencyDependentFitness = TRUE),
    spPopSizes = c(0, 40))


## ----predprey2a---------------------------------------------------
C_fe_pred_prey2 <- function(r, a, c, e, d,
                           gt = c("s1", "s2")) {
    data.frame(Genotype = gt,
               Fitness = c(
                   paste0("1 + ", r, " - ", a,
                          " * ", c, " * n_2"),
                   paste0("1 + ", e, " * ", a,
                          " * ", c, " * n_1 - ", d)
               ))
}

C_fe_pred_prey2("r", "a", "c", "e", "d")


## ----echo=FALSE---------------------------------------------------
set.seed(2)

## ----predprey2b---------------------------------------------------
fe_pred_prey2 <-
    allFitnessEffects(
        genotFitness =
            C_fe_pred_prey2(r = .7, a = 1, c = 0.005,
                            e = 0.02, d = 0.4,
                            gt = c("Fly", "Lizard")),
        frequencyDependentFitness = TRUE)


fe_pred_prey2$full_FDF_spec

## You want to make sure you start the simulation from
## a viable condition

evalAllGenotypes(fe_pred_prey2,
                 spPopSizes = c(5000, 100))

set.seed(2)
pred_prey2 <- oncoSimulIndiv(fe_pred_prey2,
                             model = "Exp",
                             initMutant = c("Fly", "Lizard"),
                             initSize = c(500, 100),
                             sampleEvery = 0.1,
                             mu = 1e-3,
                             onlyCancer = FALSE,
                             finalTime = 100,
                             keepPhylog = FALSE,
                             seed = NULL,
                             errorHitMaxTries = FALSE,
                             errorHitWallTime = FALSE)
op <- par(mfrow = c(1, 2))
## Nicer colors
plot(pred_prey2, show = "genotypes")
## But this shows better what is going on
plot(pred_prey2, show = "genotypes", type = "line")
par(op)


## ----commens, eval=FALSE------------------------------------------
# fe_commens <-
#     allFitnessEffects(
#         genotFitness =
#             G_fe_LV(1.2, 1.3, 5000, 20000,
#                                  0, -0.2,
#                                  gt = c("WT","A", "Commensal")),
#         frequencyDependentFitness = TRUE,
#         frequencyType = "abs")
# 
# commens <- oncoSimulIndiv(fe_commens,
#                             model = "Exp",
#                             onlyCancer = FALSE,
#                             finalTime = 100,
#                             mu = 1e-4,
#                             initSize = 40000,
#                           keepPhylog = FALSE,
#                           seed = NULL,
#                             errorHitMaxTries = FALSE,
#                             errorHitWallTime = FALSE)
# 
# plot(commens, show = "genotypes")
# 
# plot(commens, show = "genotypes",
#      xlim = c(80, 100))
# 
# plot(commens, show = "genotypes", type = "line",
#      xlim = c(80, 100), ylim = c(2000, 22000))
# 

## ----fdfar, message=FALSE-----------------------------------------
rar <- data.frame(Genotype = c("WT", "A", "B", "C"),
                 Fitness = c("1",
                             "1.1 + .3*f_2",
                             "1.2 + .4*f_1",
                             "1.0 + .5 * (f_1 + f_2)"))
afear <- allFitnessEffects(genotFitness = rar,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel")

evalAllGenotypes(afear, spPopSizes = c(100, 200, 300, 400))


rar2 <- data.frame(Genotype = c("WT", "A", "B", "C"),
                 Fitness = c("1",
                             "1.1 + .3*(n_2/N)",
                             "1.2 + .4*(n_1/N)",
                             "1.0 + .5 * ((n_1 + n_2)/N)"))
afear2 <- allFitnessEffects(genotFitness = rar2,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "abs")

evalAllGenotypes(afear2, spPopSizes = c(100, 200, 300, 400))

## ----relarres, message=FALSE--------------------------------------
set.seed(1)
tmp1 <- oncoSimulIndiv(afear,
                       model = "McFL",
                       onlyCancer = FALSE,
                       finalTime = 30,
                       mu = 1e-4,
                       initSize = 5000,
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE)

set.seed(1)
tmp2 <- oncoSimulIndiv(afear2,
                       model = "McFL",
                       onlyCancer = FALSE,
                       finalTime = 30,
                       mu = 1e-4,
                       initSize = 5000,
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE)
stopifnot(identical(print(tmp1), print(tmp2)))

## ----relar3a, message=FALSE---------------------------------------
rar3 <- data.frame(Genotype = c("WT", "A", "B", "C"),
                 Fitness = c("1",
                             "1.1 + .3*(n_2/N)",
                             "1.2 + .4*(n_1/N)",
                             "1.0 + .5 * ( n_1 > 20)"))
afear3 <- allFitnessEffects(genotFitness = rar3,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "abs")

evalAllGenotypes(afear3, spPopSizes = c(100, 200, 300, 400))


set.seed(1)
tmp3 <- oncoSimulIndiv(afear3,
                       model = "McFL",
                       onlyCancer = FALSE,
                       finalTime = 60,
                       mu = 1e-4,
                       initSize = 5000,
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE)
plot(tmp3, show = "genotypes")

## ----fdfmutex-----------------------------------------------------
## Relative
r1fd <- data.frame(Genotype = c("WT", "A", "B", "A, B"),
                 Fitness = c("1",
                             "1.4 + 1*(f_2)",
                             "1.4 + 1*(f_1)",
                             "1.6 + f_1 + f_2"))
afe4 <- allFitnessEffects(genotFitness = r1fd,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel")

mtfd <- allMutatorEffects(epistasis = c("A" = 0.1,
                                        "B" = 10))

## ----fdfmutex1----------------------------------------------------
set.seed(1)
s1fd <- oncoSimulIndiv(afe4,
                     model = "McFL",
                     onlyCancer = FALSE,
                     finalTime = 40,
                     mu = 1e-4,
                     initSize = 5000,
                     keepPhylog = TRUE,
                     seed = NULL,
                     errorHitMaxTries = FALSE,
                     errorHitWallTime = FALSE)
plot(s1fd, show = "genotypes")

## ----fdfmutex2----------------------------------------------------
set.seed(1)
s2fd <- oncoSimulIndiv(afe4,
                     muEF = mtfd,
                     model = "McFL",
                     onlyCancer = FALSE,
                     finalTime = 40,
                     mu = 1e-4,
                     initSize = 5000,
                     keepPhylog = TRUE,
                     seed = NULL,
                     errorHitMaxTries = FALSE,
                     errorHitWallTime = FALSE)

## In the Mac ARM64 architecture, the above
## run leads to an exception, which is really odd.
## While that is debugged, use try to prevent
## failure of the plot to abort vignette building.

try(plot(s2fd, show = "genotypes"))

## ----echo=FALSE---------------------------------------------------
op <- par(mfrow = c(1, 2))

## ----figmutfdf----------------------------------------------------
plotClonePhylog(s1fd, keepEvents = TRUE)
plotClonePhylog(s2fd, keepEvents = TRUE)

## ----echo=FALSE---------------------------------------------------
par(op)

## ----exmutfdf2, eval=FALSE----------------------------------------
# 
# ## Absolute
# r5 <- data.frame(Genotype = c("WT", "A", "B", "A, B"),
#                  Fitness = c("1",
#                              "1.25 - .0025*(n_2)",
#                              "1.25 - .0025*(n_1)",
#                              "1.4"),
#                  stringsAsFactors = FALSE)
# 
# afe5 <- allFitnessEffects(genotFitness = r5,
#                          frequencyDependentFitness = TRUE,
#                          frequencyType = "abs")
# set.seed(8)
# s5 <- oncoSimulIndiv(afe5,
#                      model = "McFL",
#                      onlyCancer = FALSE,
#                      finalTime = 100,
#                      mu = 1e-4,
#                      initSize = 5000,
#                      keepPhylog = TRUE,
#                      seed = NULL,
#                      errorHitMaxTries = FALSE,
#                      errorHitWallTime = FALSE)
# plot(s5, show = "genotypes")
# plot(s5, show = "genotypes", log = "y", type = "line")
# 
# mt <- allMutatorEffects(epistasis = c("A" = 0.1,
#                                       "B" = 10))
# set.seed(8)
# s6 <- oncoSimulIndiv(afe5,
#                      muEF = mt,
#                      model = "McFL",
#                      onlyCancer = FALSE,
#                      finalTime = 100,
#                      mu = 1e-4,
#                      initSize = 5000,
#                      keepPhylog = TRUE,
#                      seed = NULL,
#                      errorHitMaxTries = FALSE,
#                      errorHitWallTime = FALSE)
# plot(s6, show = "genotypes")
# plot(s6, show = "genotypes", log = "y", type = "line")
# 
# plotClonePhylog(s5, keepEvents = TRUE)
# plotClonePhylog(s6, keepEvents = TRUE)
# 

## ----noworkeval---------------------------------------------------

evalAllGenotypes(allFitnessEffects(genotFitness = r1fd,
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(10, 20, 30, 40))


evalAllGenotypesFitAndMut(allFitnessEffects(genotFitness = r1fd,
                                   frequencyDependentFitness = TRUE,
                                            frequencyType = "rel"),
                          mtfd,
                          spPopSizes = c(10, 20, 30, 40))

## ----rps1,  message=F---------------------------------------------
crs <- function (a, b, c){
  data.frame(Genotype = c("WT", "C", "R"),
             Fitness = c(paste0("1 + ", a, " * f_R - ", b, " * f_C"),
                         paste0("1 + ", b, " * f_ - ", c, " * f_R"),
                         paste0("1 + ", c, " * f_C - ", a, " * f_")
             ))
}

## ----rps2, message=F----------------------------------------------
crs("a", "b", "c")

## ----sps3b, message=F---------------------------------------------
afcrs1 <- allFitnessEffects(genotFitness = crs(1, 1, 1),
                           frequencyDependentFitness = TRUE,
                           frequencyType = "rel")

resultscrs1 <- oncoSimulIndiv(afcrs1,
                             model = "McFL",
                             onlyCancer = FALSE,
                             finalTime = 100,
                             mu = 1e-2,
                             initSize = 4000,
                             keepPhylog = FALSE,
                             seed = NULL,
                             errorHitMaxTries = FALSE,
                             errorHitWallTime = FALSE)
op <- par(mfrow = c(1, 2))
plot(resultscrs1, show = "genotypes", type = "line", cex.lab=1.1,
     las = 1)
plot(resultscrs1, show = "genotypes", type = "stacked")
par(op)

## ----rps4, message=F----------------------------------------------
afcrs2 <- allFitnessEffects(genotFitness = crs(10, 1, 1),
                           frequencyDependentFitness = TRUE,
                           frequencyType = "rel")



## ----rps4b, eval=FALSE--------------------------------------------
# resultscrs2 <- oncoSimulPop(10,
#                            afcrs2,
#                              model = "McFL",
#                              onlyCancer = FALSE,
#                              finalTime = 100,
#                              mu = 1e-2,
#                              initSize = 4000,
#                              keepPhylog = FALSE,
#                              seed = NULL,
#                              errorHitMaxTries = FALSE,
#                              errorHitWallTime = FALSE)

## ----rps5, message=F----------------------------------------------
set.seed(1)

resultscrs2a <- oncoSimulIndiv(afcrs2,
                             model = "McFL",
                             onlyCancer = FALSE,
                             finalTime = 100,
                             mu = 1e-2,
                             initSize = 4000,
                             keepPhylog = FALSE,
                             seed = NULL,
                             errorHitMaxTries = FALSE,
                             errorHitWallTime = FALSE)

plot(resultscrs2a, show = "genotypes", type = "line")

## ----rps6, message=F----------------------------------------------
set.seed(3)

resultscrs2b <- oncoSimulIndiv(afcrs2,
                             model = "McFL",
                             onlyCancer = FALSE,
                             finalTime = 60,
                             mu = 1e-2,
                             initSize = 4000,
                             keepPhylog = FALSE,
                             seed = NULL,
                             errorHitMaxTries = FALSE,
                             errorHitWallTime = FALSE)

plot(resultscrs2b, show = "genotypes", type = "line", cex.lab=1.1,
     las = 1)

## ----rps7, message=F----------------------------------------------
afcrs3 <- allFitnessEffects(genotFitness = crs(1, 5, 5),
                           frequencyDependentFitness = TRUE,
                           frequencyType = "rel")

resultscrs3 <- oncoSimulIndiv(afcrs3,
                             model = "McFL",
                             onlyCancer = FALSE,
                             finalTime = 60,
                             mu = 1e-2,
                             initSize = 4000,
                             keepPhylog = FALSE,
                             seed = NULL,
                             errorHitMaxTries = FALSE,
                             errorHitWallTime = FALSE)

plot(resultscrs3, show = "genotypes", type = "line", cex.lab=1.1,
     las = 1)

## ----hkdv, message=F----------------------------------------------
## Stablish Genotype-Fitnees mapping. D = Dove, H = Hawk

## With newer OncoSimulR functionality, using WT to start the simulation
## would no longer be needed.
H_D_fitness <- function(c, v,
                    gt = c("WT", "H", "D")) {
  data.frame(Genotype = gt,
             Fitness = c(
               paste0("1"),
               paste0("1 + f_H *", (v-c)/2, "+ f_D *", v),
               paste0("1 + f_D *", v/2)))
}

## Fitness Effects specification
HD_competition <-allFitnessEffects(
  genotFitness = H_D_fitness(10, 2,
                         gt = c("WT", "H", "D")),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel")

## Plot fitness landscape of genotype "H, D" evaluation
data.frame("Doves_fitness" = evalGenotype(genotype = "D",
                                          fitnessEffects = HD_competition,
                                          spPopSizes = c(5000, 5000, 5000)),
           "Hawks_fitness" = evalGenotype(genotype = "H",
                                          fitnessEffects = HD_competition,
                                          spPopSizes = c(5000, 5000, 5000))
           )

## ----hkdv2, message=F---------------------------------------------
## Simulated trajectories
## run only a few for the sake of speed
simulation <- oncoSimulPop(2,
                           mc.cores = 2,
                           HD_competition,
                           model = "McFL", # There is no collapse
                           onlyCancer = FALSE,
                           finalTime = 50,
                           mu = 1e-2, # Quick emergence of D and H
                           initSize = 4000,
                           keepPhylog = FALSE,
                           seed = NULL,
                           errorHitMaxTries = FALSE,
                           errorHitWallTime = FALSE)



## Plot first trajectory as an example
plot(simulation[[1]], show = "genotypes", type = "line",
    xlim = c(40, 50),
     lwdClone = 2, ylab = "Number of individuals",
     main = "Hawk and Dove trajectory",
     col = c("#a37acc", "#f8776d", "#7daf00"),
     font.main=2, font.lab=2,
     cex.main=1.4, cex.lab=1.1,
     las = 1)


## ----hkdvx45------------------------------------------------------
## Recover the final result from first simulation
result <- tail(simulation[[1]][[1]], 1)

## Get the number of organisms from each species
n_WT <- result[2]
n_D <- result[3]
n_H <- result[4]
total <- n_WT + n_D + n_H

## Dove percentage
data.frame("Doves" = round(n_D/total, 2)*100,
           "Hawks" = round(n_H/total, 2)*100  )

## ----glvop1, message=FALSE----------------------------------------

# Definition of the function for creating the corresponding dataframe.
avc <- function (a, v, c) {
  data.frame(Genotype = c("WT", "GLY", "VOP", "DEF"),
             Fitness = c("1",
                         paste0("1 + ",a," * (f_GLY + 1)"),
                         paste0("1 + ",a," * f_GLY + ",v," * (f_VOP + 1) - ",c),
                         paste0("1 + ",a," * f_GLY + ",v," * f_VOP")
                         ))
                          }

# Specification of the different effects on fitness.
afavc <- allFitnessEffects(genotFitness = avc(2.5, 2, 1),
                           frequencyDependentFitness = TRUE,
                           frequencyType = "rel")

## For real, you would probably want to run
## this multiple times with oncoSimulPop
simulation <- oncoSimulIndiv(afavc,
                           model = "McFL",
                           onlyCancer = FALSE,
                           finalTime = 15,
                           mu = 1e-3,
                           initSize = 4000,
                           keepPhylog = FALSE,
                           seed = NULL,
                           errorHitMaxTries = FALSE,
                           errorHitWallTime = FALSE)


## ----glvop2, message=FALSE----------------------------------------

# Representation of the plot of one simulation as an example (the others are
# highly similar).
plot(simulation, show = "genotypes", type = "line",
     ylab = "Number of individuals", main = "Fully glycolytic tumours",
     font.main=2, font.lab=2, cex.main=1.4, cex.lab=1.1, las = 1)


## ----glvop3, message=FALSE----------------------------------------

# Definition of the function for creating the corresponding dataframe.
avc <- function (a, v, c) {
  data.frame(Genotype = c("WT", "GLY", "VOP", "DEF"),
             Fitness = c("1",
                         paste0("1 + ",a," * (f_GLY + 1)"),
                         paste0("1 + ",a," * f_GLY + ",v, " * (f_VOP + 1) - ",c),
                         paste0("1 + ",a," * f_GLY + ",v, " * f_VOP")
                         ))
                          }

# Specification of the different effects on fitness.
afavc <- allFitnessEffects(genotFitness = avc(2.5, 7, 1),
                           frequencyDependentFitness = TRUE,
                           frequencyType = "rel")

simulation <- oncoSimulIndiv(afavc,
                           model = "McFL",
                           onlyCancer = FALSE,
                           finalTime = 15,
                           mu = 1e-4,
                           initSize = 4000,
                           keepPhylog = FALSE,
                           seed = NULL,
                           errorHitMaxTries = FALSE,
                           errorHitWallTime = FALSE)


## ----glvop4, message=FALSE----------------------------------------
## We get a huge number of VOP very quickly
## (too quickly?)
plot(simulation, show = "genotypes", type = "line",
     ylab = "Number of individuals", main = "Fully angiogenic tumours",
     font.main=2, font.lab=2, cex.main=1.4, cex.lab=1.1, las = 1)


## ----glvop5, message=FALSE----------------------------------------

# Definition of the function for creating the corresponding dataframe.
avc <- function (a, v, c) {
  data.frame(Genotype = c("WT", "GLY", "VOP", "DEF"),
             Fitness = c("1",
                         paste0("1 + ",a," * (f_GLY + 1)"),
                         paste0("1 + ",a," * f_GLY + ",v," * (f_VOP + 1) - ",c),
                         paste0("1 + ",a," * f_GLY + ",v," * f_VOP")
                         ))
                          }

# Specification of the different effects on fitness.
afavc <- allFitnessEffects(genotFitness = avc(7.5, 2, 1),
                           frequencyDependentFitness = TRUE,
                           frequencyType = "rel")

# Launching of the simulation (20 times).
simulation <- oncoSimulIndiv(afavc,
                           model = "McFL",
                           onlyCancer = FALSE,
                           finalTime = 25,
                           mu = 1e-4,
                           initSize = 4000,
                           keepPhylog = FALSE,
                           seed = NULL,
                           errorHitMaxTries = FALSE,
                           errorHitWallTime = FALSE)


## ----glvop6, message=FALSE----------------------------------------

# Representation of the plot of one simulation as an example (the others are
# highly similar).
plot(simulation, show = "genotypes", type = "line",
     ylab = "Number of individuals", main = "Heterogeneous tumours",
     font.main=2, font.lab=2, cex.main=1.4, cex.lab=1.1, las = 1)


## ----example5_fitness, message=FALSE------------------------------
fitness_rel <- function(a, b, r, g, gt = c("WT", "S", "I", "D")) {
    data.frame(
      Genotype = gt,
      Fitness = c("1",
                  paste0("1 + ", a, " * f_D"),
                  paste0("1 + 1 - ", g),
                  paste0("1 + (1 - f_I - f_D) * (1 - ", b, " + ",
                         a, ") + f_I * (1 - ", b, " + ", r,
                         ") + f_D * (1 - 2 * ", b, ") + 1 - ", b,
                         " + ", a, " + f_I * (", r, " - ",
                         a, ") - f_D * (", b, " + ", a, ")"))
                  )
}

## ----example5scen1, message=FALSE---------------------------------
scen1 <- allFitnessEffects(genotFitness = fitness_rel(a = 0.5, b = 0.7,
                                                     r = 0.1, g = 0.8),
                          frequencyDependentFitness = TRUE,
                          frequencyType = "rel")

set.seed(1)
simulScen1 <- oncoSimulIndiv(scen1,
                              model = "McFL",
                              onlyCancer = FALSE,
                              finalTime = 70,
                              mu = 1e-4,
                              initSize = 5000,
                              keepPhylog = FALSE,
                              seed = NULL,
                              errorHitMaxTries = FALSE,
                              errorHitWallTime = FALSE)
op <- par(mfrow = c(1, 2))
plot(simulScen1, show = "genotypes", type = "line",
     main = "First scenario",
     cex.main = 1.4, cex.lab = 1.1,
     las = 1)
plot(simulScen1, show = "genotypes",
     main = "First scenario",
     cex.main = 1.4, cex.lab = 1.1,
     las = 1)
par(op)

## ----example5scen2, message=FALSE---------------------------------
scen2 <- allFitnessEffects(genotFitness = fitness_rel(a = 0.3, b = 0.7,
                                                     r = 0.1, g = 0.7),
                          frequencyDependentFitness = TRUE,
                          frequencyType = "rel")

set.seed(1)

simulScen2 <- oncoSimulIndiv(scen2,
                              model = "McFL",
                              onlyCancer = FALSE,
                              finalTime = 70,
                              mu = 1e-4,
                              initSize = 4000,
                              keepPhylog = FALSE,
                              seed = NULL,
                              errorHitMaxTries = FALSE,
                              errorHitWallTime = FALSE)
op <- par(mfrow = c(1, 2))
plot(simulScen2, show = "genotypes", type = "line",
     main = "Second scenario",
     cex.main = 1.4, cex.lab = 1.1,
     las = 1)
plot(simulScen2, show = "genotypes",
     main = "Second scenario",
     cex.main = 1.4, cex.lab = 1.1,
     las = 1)
par(op)

## ----example5scen3, message=FALSE---------------------------------
scen3 <- allFitnessEffects(genotFitness = fitness_rel(a = 0.2, b = 0.3,
                                                     r = 0.1, g = 0.3),
                          frequencyDependentFitness = TRUE,
                          frequencyType = "rel")

set.seed(1)
simulScen3 <- oncoSimulIndiv(scen3,
                              model = "McFL",
                              onlyCancer = FALSE,
                              finalTime = 50,
                              mu = 1e-4,
                              initSize = 4000,
                             keepPhylog = FALSE,
                             seed = NULL,
                              errorHitMaxTries = FALSE,
                              errorHitWallTime = FALSE)
op <- par(mfrow = c(1, 2))
plot(simulScen3, show = "genotypes", type = "line",
     main = "Third scenario",
     cex.main = 1.4, cex.lab = 1.1,
     las = 1)
plot(simulScen3, show = "genotypes",
     main = "Third scenario",
     cex.main = 1.4, cex.lab = 1.1,
     las = 1)
par(op)

## ----example5scen4, message=FALSE---------------------------------
scen4 <- allFitnessEffects(genotFitness = fitness_rel(a = 0.2, b = 0.4,
                                                     r = 0.1, g = 0.3),
                          frequencyDependentFitness = TRUE,
                          frequencyType = "rel")

## Set a different seed to show the results better since
## with set.seed(1) the progression of I cells was not shown
set.seed(2)

simulScen4 <- oncoSimulIndiv(scen4,
                              model = "McFL",
                              onlyCancer = FALSE,
                              finalTime = 40,
                              mu = 1e-4,
                              initSize = 4000,
                             keepPhylog = FALSE,
                             seed = NULL,
                              errorHitMaxTries = FALSE,
                              errorHitWallTime = FALSE)
op <- par(mfrow = c(1, 2))
plot(simulScen4, show = "genotypes", type = "line",
     main = "Fourth scenario",
     cex.main = 1.4, cex.lab = 1.1,
     las = 1)
plot(simulScen4, show = "genotypes",
     main = "Fourth scenario",
     cex.main = 1.4, cex.lab = 1.1,
     las = 1)
par(op)

## ----smyeloma, eval=TRUE,echo=FALSE, fig.cap="Multiplication factor in myeloma interaction. Table 1 in Sartakhti et al., 2016, 'Evolutionary Dynamics of Tumor-Stroma Interactions in Multiple Myeloma' https://doi.org/10.1371/journal.pone.0168856 ."----
knitr::include_graphics("Myeloma_interaction.png")

## ----smyelo56j----------------------------------------------------
f_cells <- function(c1, c2, c3, r11, r12, r13,
                    r21, r22, r23, r31, r32, r33, M, awt = 1e-4,
                                 gt = c("WT", "OC", "OB", "MM")) {
    data.frame(Genotype = gt,
               Fitness = c(
                  paste0("max(0.1, 1 - ", awt, " * (f_OC + f_OB+f_MM)*N)"),
                  paste0("1", "+(((f_OC * (", M, "-1)+1)*", c1, ")/", M, ")*",r11,
                          "+((((1-f_MM) * (", M, "-1)-f_OC*(", M, "-1)-1)*", c2, ")/", M, ")*", r12,
                          "+(((", M, "-(1-f_MM)*(", M, "-1))*", c3, ")/", M, ")*", r13,
                          "-", c1
                          ),
                  paste0("1", "+(((f_OB*(", M, "-1)+1)*", c2, ")/", M, ")*", r22,
                          "+((((1-f_OC)*(", M, "-1)-f_OB*(", M, "-1)-1)*", c3, ")/", M, ")*", r23,
                          "+(((", M, "-(1-f_OC)*(", M, "-1))*", c1, ")/", M, ")*", r21,
                          "-", c2
                          ),
                  paste0("1", "+(((f_MM*(", M, "-1)+1)*", c3, ")/", M, ")*", r33,
                          "+((((1-f_OB)*(", M, "-1)-f_MM*(", M, "-1)-1)*", c1, ")/", M, ")*", r31,
                          "+(((", M, "-(1-f_OB)*(", M, "-1))*", c2, ")/", M, ")*", r32,
                          "-", c3
                          )
                  )
               ,stringsAsFactors = FALSE
               )
}


## ----smyelo3v57---------------------------------------------------
N <- 40000
M <- 10
c1 <- 1
c2 <- 1.2
c3 <- 1.4
r11 <- 0
r12 <- 1
r13 <- 2.5
r21 <- 1
r22 <- 0
r23 <- -0.3
r31 <- 2.5
r32 <- 0
r33 <- 0

fe_cells <-
    allFitnessEffects(
        genotFitness =
            f_cells(c1, c2, c3, r11, r12, r13,
                    r21, r22, r23, r31, r32, r33, M,
                    gt = c("WT", "OC", "OB", "MM")),
        frequencyDependentFitness = TRUE,
        frequencyType = "rel")

## Simulated trajectories

## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below
data(smyelo3v57)

if (FALSE) {
set.seed(2)
smyelo3v57 <- oncoSimulIndiv(fe_cells,
                           model = "McFL",
                           onlyCancer = FALSE,
                           finalTime = 20,
                           mu = c("OC"=1e-1, "OB"=1e-1, "MM"=1e-4),
                           initSize = N,
                           keepPhylog = FALSE,
                           seed = NULL,
                           errorHitMaxTries = FALSE,
                           errorHitWallTime = FALSE,
						   keepEvery = 0.1)
}
## Plot trajectories
plot(smyelo3v57, show = "genotypes")



## ----smyeloc1v23--------------------------------------------------
N <- 40000
M <- 10
c1 <- 1
c2 <- 1
c3 <- 1
r11 <- 0
r12 <- 1
r13 <- 0.5
r21 <- 1
r22 <- 0
r23 <- -0.3
r31 <- 0.5
r32 <- 0
r33 <- 0

fe_cells <-
    allFitnessEffects(
        genotFitness =
            f_cells(c1, c2, c3, r11, r12, r13,
                    r21, r22, r23, r31, r32, r33, M,
                    gt = c("WT", "OC", "OB", "MM")),
        frequencyDependentFitness = TRUE,
        frequencyType = "rel")

## Simulated trajectories
set.seed(1)
simulation <- oncoSimulIndiv(fe_cells,
                           model = "McFL",
                           onlyCancer = FALSE,
                           finalTime = 15, ## 25
                           mu = c("OC"=1e-1, "OB"=1e-1, "MM"=1e-4),
                           initSize = N,
                           keepPhylog = FALSE,
                           seed = NULL,
                           errorHitMaxTries = FALSE,
                           errorHitWallTime = FALSE)

#Plot trajectorie
plot(simulation, show = "genotypes", thinData = TRUE)


## ----parka , message=FALSE----------------------------------------
park1<- data.frame(Genotype = c("WT", "A", "B", "A,B"),
                 Fitness = c("1",
			     "1 + 3*(f_1 + f_2 + f_1_2)",
                 "1 + 2*(f_1 + f_2 + f_1_2)", ## We establish
                 ## the fitness of B smaller than the one of A because
                 ## it is an indirect cause of the disease and not a direct one.
                 "1.5 + 4.5*(f_1 + f_2 + f_1_2)")) ## The baseline
                  ## of the fitness is higher in the
                  ## AB population (their growth is favored).

parkgen1<- allFitnessEffects(genotFitness = park1,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel")

## ----parkb--------------------------------------------------------
set.seed(1)
fpark1 <- oncoSimulIndiv(parkgen1,
                     model = "McFL",
                     onlyCancer = FALSE,
                     finalTime = 100,
                     mu = 1e-4,
                     initSize = 5000,
                     keepPhylog = TRUE,
                     seed = NULL,
                     errorHitMaxTries = FALSE,
                     errorHitWallTime = FALSE)



## ----parkplot1, message=FALSE-------------------------------------
plot(fpark1, show = "genotypes",  type = "line",
     col = c("black", "green", "red", "blue"))

## ----parkplot2, message=FALSE-------------------------------------
plotClonePhylog(fpark1, N = 0, keepEvents=TRUE, timeEvents=TRUE)

## ----wuAMicrobesfit1----------------------------------------------
create_fe <- function(bG, cG, iPA, cI, cS, bPA, ab,
                      gt = c("WT", "CT", "PA")) {
  data.frame(Genotype = gt,
             Fitness = c(
               paste0("1 + ", bG, " * (f_ + f_CT) - ", cS,
                      " * (f_ +  f_CT + f_PA) - ", cI, "(f_PA > 0.2) - ", cG,
                      " - ", ab),
               paste0("1 + ", bG, " * (f_ + f_CT) - ", cS,
                      " * (f_ +  f_CT + f_PA) - ", cG),
               paste0("1 +", bPA, " - ", cS, " * (f_ +  f_CT + f_PA) - ", iPA,
                      " *(f_(f_PA > 0.2))")),
             stringsAsFactors = FALSE)
}


## ----wuAMicrobescheck---------------------------------------------
create_fe("bG", "cG", "iPA", "cI", "cS", "bPA", "ab")

## ----wuAMicrobes2a------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(7, 1, 9, 0.5, 2, 5, 0),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(1000, 1000, 1000))


## ----wuAMicrobes2b------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(7, 1, 9, 0.5, 2, 5, 2),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(1000, 1000, 1000))


## ----wuAMicrobes2c------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(7, 1, 9, 0.5, 2, 5, 2),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(0, 0, 1000))


## ----wuAMicrobes2d------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(7, 1, 9, 0.5, 2, 5, 2),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(100, 0, 1000))


## ----wuAMicrobes2e------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(7, 1, 9, 0.5, 2, 5, 5),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(1000, 0, 0))


## ----wuAMicrobes2f------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
				   create_fe(7, 1, 9, 0.5, 2, 5, 5),
				   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(1000, 0, 1000))


## ----woAntib1, eval = FALSE---------------------------------------
# woAntib <- allFitnessEffects(
#   genotFitness = create_fe(7, 1, 9, 0.5, 2, 5, 0),
#   frequencyDependentFitness = TRUE,
#   frequencyType = "rel")
# 
# ## We do not run this for speed but load it below
# set.seed(2)
# woAntibS <- oncoSimulIndiv(woAntib,
#                         model = "McFL",
#                         onlyCancer = FALSE,
#                         finalTime = 2000,
#                         mu = 1e-4,
#                         initSize = 1000,
#                         keepPhylog = FALSE,
#                         seed = NULL,
#                         errorHitMaxTries = FALSE,
#                         errorHitWallTime = FALSE,
#                         keepEvery = 2 ## store a smaller object
#                         )
# 

## ----woAntib1data-------------------------------------------------
## Load stored results
data(woAntibS)

## ----woAntib2-----------------------------------------------------

plot(woAntibS, show = "genotypes", type = "line",
     col = c("black", "green", "red"))


## ----wiAntib1-----------------------------------------------------
wiAntib <- allFitnessEffects(
  genotFitness = create_fe(7, 1, 9, 0.5, 2, 5, 2),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel")


set.seed(2)
wiAntibS <- oncoSimulIndiv(wiAntib,
                        model = "McFL",
                        onlyCancer = FALSE,
                        finalTime = 100,
                        mu = 1e-4,
                        initSize = 1000,
                        keepPhylog = FALSE,
                        seed = NULL,
                        errorHitMaxTries = FALSE,
                        errorHitWallTime = FALSE)

plot(wiAntibS, show = "genotypes", type = "line",
     col = c("black", "green", "red"))


## ----breastCfit1--------------------------------------------------
create_fe <- function(cG, bG, cS, cMMph, cMMTC, bR, cD,
                      gt = c("WT", "Mph", "BTC", "MTC")) {
  data.frame(Genotype = gt,
             Fitness = c(
               paste0("1 + ", bG, "*(f_ + f_Mph) - ", cG, " - ", cS, "*(f_ + f_BTC)"),
               paste0("1 + ", bG, "*(f_ + f_Mph) - ", cG, " - ", cMMph),
               paste0("1 + ", bR, " + ", bG, "*(f_ + f_Mph) - ", cS, "* (f_ + f_BTC) -",
                      cD , " * f_Mph"),
               paste0("1 + ", bR, " + ", bG, " *(f_ + f_Mph) -", cMMTC, " - ",
                      cD , " * f_Mph")
               ),
             stringsAsFactors = FALSE)
}


## ----breastCcheck-------------------------------------------------
create_fe("cG", "bG","cS", "cMMph", "cMMTC", "bR", "cD")

## ----breastC2a----------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(2, 5, 1, 0.8, 1, 1, 9),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(WT = 1000, Mph = 0, BTC = 0, MTC = 0))


## ----breastC2b----------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(2, 5, 1, 0.8, 1, 1, 9),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(WT = 1000, Mph = 1000, BTC = 0, MTC = 0))


## ----breastC2c----------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(2, 5, 1, 0.8, 1, 1, 9),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(WT = 1000, Mph = 1000, BTC = 100, MTC = 100))


## ----cancercontrol1-----------------------------------------------
afe_3_a <- allFitnessEffects(
  genotFitness =
    create_fe(0.5, 4, 1, 0.2, 1, 0.5, 4),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel")

set.seed(2)

s_3_a <- oncoSimulIndiv(afe_3_a,
                        model = "McFL",
                        onlyCancer = FALSE,
                        finalTime = 50,
                        mu = 1e-4,
                        initSize = 10000,
                        keepPhylog = FALSE,
                        seed = NULL,
                        errorHitMaxTries = FALSE,
                        errorHitWallTime = FALSE)

plot(s_3_a, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue", "yellow"))


## ----cancerNM1----------------------------------------------------
afe_3_a <- allFitnessEffects(
  genotFitness =
    create_fe(1, 4, 0.5, 1, 1.5, 1, 4),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel")

set.seed(2)

s_3_a <- oncoSimulIndiv(afe_3_a,
                        model = "McFL",
                        onlyCancer = FALSE,
                        finalTime = 50,
                        mu = 1e-4,
                        initSize = 10000,
                        keepPhylog = FALSE,
                        seed = NULL,
                        errorHitMaxTries = FALSE,
                        errorHitWallTime = FALSE)


plot(s_3_a, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue", "yellow"))


## ----cancerM1-----------------------------------------------------

afe_3_a <- allFitnessEffects(
  genotFitness =
    create_fe(0.5, 4, 2, 0.5, 0.5, 1, 4),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel")

set.seed(2)

s_3_a <- oncoSimulIndiv(afe_3_a,
                        model = "McFL",
                        onlyCancer = FALSE,
                        finalTime = 50,
                        mu = 1e-4,
                        initSize = 10000,
                        keepPhylog = FALSE,
                        seed = NULL,
                        errorHitMaxTries = FALSE,
                        errorHitWallTime = FALSE)


plot(s_3_a, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue", "yellow"))



## ----breastCQfit1-------------------------------------------------
create_fe <- function(cG, bG, cS, cMMph, cMMTC, bR, cD, Q,
                      gt = c("WT", "BTC", "R", "MTC", "Mph", "BTC,R", "MTC,R")) {
  data.frame(Genotype = gt,
             Fitness = c(

               paste0("1 + ", bG, "(f_ + f_R + f_Mph) - ", cG, " - ", cS, "(f_ + f_BTC + f_R + f_BTC_R) -",
                      "0.01*", Q),
               paste0("1 + ", bR, " + ", bG, "(f_ + f_R + f_Mph) - ", cS, " (f_ + f_BTC + f_R + f_BTC_R) -",
                      cD , " * f_Mph -", Q),
               paste0("1 + ", bG, "(f_ + f_R + f_Mph) - ", cG, " - ", cS, "(f_ + f_BTC + f_R + f_BTC_R)"),
               paste0("1 + ", bR, " + ", bG, " *(f_ + f_R + f_Mph) -", cMMTC, " - ",
                      cD , " * f_Mph -", Q),
               paste0("1 + ", bG, "(f_ + f_R + f_Mph) - ", cG, " - ", cMMph, "- 0.01*",Q),
               paste0("1 + ", bR, " + ", bG, "(f_ + f_R + f_Mph) - ", cS, " (f_ + f_BTC + f_R + f_BTC_R) -",
                      cD , " * f_Mph"),
               paste0("1 + ", bR, " + ", bG, " *(f_ + f_R + f_Mph) -", cMMTC, " - ",
                      cD , " * f_Mph")
             ),
             stringsAsFactors = FALSE)
}


## ----breastCQcheck------------------------------------------------
create_fe("cG", "bG","cS", "cMMph", "cMMTC", "bR", "cD", "Q")

## ----breastCQ2a---------------------------------------------------
evalAllGenotypes(allFitnessEffects(genotFitness =
                                   create_fe(2,5,1,0.8,1,1,9,5),
                                   frequencyDependentFitness = TRUE,
                                   frequencyType = "rel"),
                 spPopSizes = c(WT = 1000, BTC = 100, R = 0,
                                MTC = 100, Mph = 1000,
                                "BTC, R" = 0, "MTC, R" = 0))


## ----cancerwoQ1---------------------------------------------------

afe_3_a <- allFitnessEffects(
  genotFitness =
    create_fe(2, 5, 1, 0.8, 1, 1, 9, 0),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel")

#Set mutation rates
muvar2 <- c("Mph" = 1e-2, "BTC" = 1e-3, "MTC"=1e-3, "R" = 1e-7)

set.seed(2)
s_3_a <- oncoSimulIndiv(afe_3_a,
                        model = "McFL",
                        onlyCancer = FALSE,
                        finalTime = 20,
                        mu = muvar2,
                        initSize = 10000,
                        keepPhylog = FALSE,
                        seed = NULL,
                        errorHitMaxTries = FALSE,
                        errorHitWallTime = FALSE)


plot(s_3_a, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue", "pink", "orange", "brown"))


## ----cancerwQlRm1-------------------------------------------------

afe_3_a <- allFitnessEffects(
  genotFitness =
    create_fe(2, 5, 1, 0.8, 1, 1, 9, 2),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel")

muvar2 <- c("Mph" = 1e-2, "BTC" = 1e-3, "MTC"=1e-3, "R" = 1e-7)

set.seed(2)

s_3_a <- oncoSimulIndiv(afe_3_a,
                        model = "McFL",
                        onlyCancer = FALSE,
                        finalTime = 20,
                        mu = muvar2,
                        initSize = 10000,
                        keepPhylog = FALSE,
                        seed = NULL,
                        errorHitMaxTries = FALSE,
                        errorHitWallTime = FALSE)


plot(s_3_a, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue", "pink", "orange", "brown"))


## ----cancerwQHRm1-------------------------------------------------

afe_3_a <- allFitnessEffects(
  genotFitness =
    create_fe(2, 5, 1, 0.8, 1, 1, 9, 2),
  frequencyDependentFitness = TRUE,
  frequencyType = "rel")

muvar2 <- c("Mph" = 1e-2, "BTC" = 1e-3, "MTC"=1e-3, "R" = 1e-5)

set.seed(2)

s_3_a <- oncoSimulIndiv(afe_3_a,
                        model = "McFL",
                        onlyCancer = FALSE,
                        finalTime = 20, ## short for speed; increase for "real"
                        mu = muvar2,
                        initSize = 10000,
                        keepPhylog = FALSE,
                        seed = NULL,
                        errorHitMaxTries = FALSE,
                        errorHitWallTime = FALSE)


plot(s_3_a, show = "genotypes", type = "line",
     col = c("black", "green", "red", "blue", "pink", "orange", "brown"))


## ----exampleBirthNom----------------------------------------------

m4 <- data.frame(Genotype = c("WT", "A", "B", "A, B"), Birth = c(1, 2, 3, 4))

fem4 <- allFitnessEffects(genotFitness = m4, frequencyDependentBirth = FALSE)

evalAllGenotypes(fem4)


## ----exampleDeath-------------------------------------------------
m4 <- data.frame(Genotype = c("WT", "A", "B", "A, B"),
                 Birth = c(1, 2, 3, 4),
                 Death = c(1, 2, 3, 4))

fem4 <- allFitnessEffects(genotFitness = m4,
                          frequencyDependentBirth = FALSE,
                          frequencyDependentDeath = FALSE,
                          deathSpec = TRUE)

evalAllGenotypes(fem4)


## ----exampleSimulDeath--------------------------------------------
G_fe_LVm <- function(r1, r2, K1, K2, a_12, a_21, gt = c("S1", "S2")) {
    data.frame(Genotype = gt,
               Birth = c(paste0(r1, "-", r1, "*(", a_12, "*n_", gt[2], ")/", K1), r2),
               Death = c(paste0(r1, "*(n_", gt[1], ")/", K1),
                         paste0(r2, "*(n_", gt[2], "+", a_21, "*n_", gt[1], ")/", K2)))
}
fe_pred_prey <- allFitnessEffects(
		genotFitness = G_fe_LVm(1.4, 1.5, 4000, 10000, -0.5, 1.1, gt = c("Predator", "Prey")),
		frequencyDependentBirth = TRUE,
		frequencyDependentDeath = TRUE,
		deathSpec = TRUE)

s_pred_preym <- oncoSimulIndiv(fe_pred_prey, model = "Arb",
                                initMutant = c("Predator", "Prey"),
                                initSize = c(1000, 1000),
                                onlyCancer = FALSE,
                                finalTime = 75, mu = 1e-3,
                               keepPhylog = FALSE, seed = NULL,
                               errorHitMaxTries = FALSE,
                                errorHitWallTime = FALSE,
								keepEvery = 1)

plot(s_pred_preym, show="genotypes", type="line", log = "")


## ----exampleConst-------------------------------------------------
H_D_fitness <- function(c, v, gt = c("H", "D")) {
                  data.frame(Genotype = gt,
                             Birth = c(
                    			    paste0("max(1e-5, f_H *", (v-c)/2, "+ f_D *", v, ")"),
                              paste0("f_D *", v/2)))
}

HD_eq <- allFitnessEffects(
	             genotFitness = H_D_fitness(10, 4, gt = c("H", "D")),
	             frequencyDependentBirth = TRUE,
	              frequencyType = "rel")

osi_eq <- oncoSimulIndiv(HD_eq, model = "Const",
                           onlyCancer = FALSE, finalTime = 50,
                           mu = 1e-6, initSize = c(2000, 2000),
                         initMutant = c("H", "D"), keepPhylog = FALSE,
                         seed = NULL, errorHitMaxTries = FALSE,
                           errorHitWallTime = FALSE)
osi_eq

## This try should not be necessary, except
## the code above seems to produce an empty object
## in the BioC kjohnson3 (maOS 13.6.5, arm64) machine.
## See below, "Help debugging"
try(plot(osi_eq, show="genotypes", ylim=c(1, 5000)))

## ----interventionListExample--------------------------------------
interventions <- list(
    list(ID           = "i2",
        Trigger       = "(N > 1e6) & (T > 100)",
        WhatHappens   = "N = 0.001 * N",
        Repetitions   = 7,
        Periodicity    = Inf
    ),
    list(ID           = "i1",
        Trigger       = "(T > 10)",
        WhatHappens   = "N = 0.3 * N",
        Periodicity   = 10,
        Repetitions   = 0
    ),
    list(ID           = "i3",
        Trigger       = "(T > 1) & (T < 200)",
        WhatHappens   = "n_A = n_A * 0,3 / n_C",
        Repetitions   = Inf,
        Periodicity    = 10
    ),
    list(ID           = "i5",
        Trigger       = "(N > 1e8) & (T> 1.2)",
        WhatHappens   = "n_A_B = n_B * 0,3 / n_SRL",
        Repetitions   = 0,
        Periodicity    = Inf
    )
)


## ----interventionEscenario1Example--------------------------------
fa1 <- data.frame(Genotype = c("WT", "A", "B"),
                    Fitness = c("n_*0",
                                "1.5",
                                "1"))

afd3 <- allFitnessEffects(genotFitness = fa1,
                          frequencyDependentFitness = TRUE,
                          frequencyType = "abs")

## ----interventionsCreateInterventionExample-----------------------
interventions <- createInterventions(interventions, afd3)

## ----interventionsOncoSimulIndivExample, eval=FALSE---------------
# ep2 <- oncoSimulIndiv(
#     afd3,
#     model = "Exp",
#     mu = 1e-4,
#     sampleEvery = 0.001,
#     initSize = c(20000, 20000),
#     initMutant = c("A", "B"),
#     finalTime = 5.2,
#     onlyCancer = FALSE,
#     interventions = interventions
# )

## ----interventionsSimpleExampleNoInts-----------------------------
df3x <- data.frame(Genotype = c("WT", "B", "A", "B, A", "C, A"),
                       Fitness = c("0*n_",
                                    "1.5",
                                    "1.002",
                                    "1.003",
                                    "1.004"))

afd3 <- allFitnessEffects(genotFitness = df3x,
                          frequencyDependentFitness = TRUE,
                          frequencyType = "abs")

ex1 <- oncoSimulIndiv(
                    afd3,
                    model = "McFLD",
                    mu = 1e-4,
                    sampleEvery = 0.01,
                    initSize = c(20000, 20000),
                    initMutant = c("A", "B"),
                    finalTime = 10,
                    onlyCancer = FALSE
                    )

plot(ex1, show="genotypes", type = "line")

## ----create_interventionsSimpleExample----------------------------
interventions <- list(
    list(ID           = "intOverB",
        Trigger       = "(T >= 5)",
        WhatHappens   = "n_B = n_B * 0.88",
        Repetitions   = Inf,
        Periodicity   = 0.07
    ))

interventions <- createInterventions(interventions, afd3)

## ----interventionsSimpleExampleWithInts---------------------------

ex1_with_ints <- oncoSimulIndiv(
                    afd3,
                    model = "McFLD",
                    mu = 1e-4,
                    sampleEvery = 0.01,
                    initSize = c(20000, 20000),
                    initMutant = c("A", "B"),
                    finalTime = 10,
                    onlyCancer = FALSE,
                    interventions = interventions)

## This try should not be necessary, except
## the code above seems to produce an empty object
## in the BioC kjohnson3 (maOS 13.6.5, arm64) machine.
## See below, "Help debugging"
try(plot(ex1_with_ints, show="genotypes", type = "line"))

## ----intex2-------------------------------------------------------
gffd3 <- data.frame(Genotype = c("WT", "A", "B"),
                    Fitness = c("1",
                    "1 + 0.25 * (n_B > 0)",
                    ".9 + 0.4 * (n_A > 0)"
                    ))
afd3 <- allFitnessEffects(genotFitness = gffd3,
                            frequencyDependentFitness = TRUE,
                            frequencyType = "abs")


## ----intex2load---------------------------------------------------
## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below
data(osi)

if (FALSE) {
osi <- oncoSimulIndiv( afd3,
                        model = "McFLD",
                        onlyCancer = FALSE,
                        finalTime = 200,
                        mu = 1e-4,
                        initSize = 5000,
                        sampleEvery = 0.001,
						keepEvery = 1)
}


## ----plotintex2---------------------------------------------------
plot(osi, show = "genotypes", type = "line")

## ----intforintex2-------------------------------------------------
intervention_tot_pop = list(
        list(
            ID            = "intOverTotPop",
            Trigger       = "T > 40",
            WhatHappens   = "N = N * 0.2",
            Repetitions   = 2,
            Periodicity   = 20
        )
    )

    intervention_tot_pop <- createInterventions(intervention_tot_pop, afd3)

## ----simulationwithinterventionsintex2----------------------------
## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below
data(osi_with_ints)

if(FALSE) {
osi_with_ints <- oncoSimulIndiv( afd3,
                        model = "McFLD",
                        onlyCancer = FALSE,
                        finalTime = 200,
                        mu = 1e-4,
                        initSize = 5000,
                        sampleEvery = 0.001,
                        interventions = intervention_tot_pop)
}

plot(osi_with_ints, show = "genotypes", type = "line")

## ----popsbytimeintex2---------------------------------------------
osi_with_ints$pops.by.time[39:42, ]

## ----popsbytimeintex2_proof---------------------------------------
pre_int_tot_pop = osi_with_ints$PerSampleStats[40, 1]
post_int_tot_pop = osi_with_ints$PerSampleStats[41, 1]

## If you did not remember about PerSampleStats
## you could add all except the first column of pops.by.time
## to get the total population sizes.
percentage_eliminated = (post_int_tot_pop/pre_int_tot_pop)*100

paste0("The percentage of population has decreased by ", percentage_eliminated, "%")

## ----idif1, eval = FALSE------------------------------------------
# 
# N = 0.2 * N
# 

## ----idif2, eval = FALSE------------------------------------------
# 
# n_A = 0.2 * n_A
# 

## ----rpswithnoints------------------------------------------------
crs <- function (a, b, c){
        data.frame(Genotype = c("WT", "C", "R"),
        Fitness = c(paste0("1 + ", a, " * n_R/N - ", b, " * n_C/N"),
        paste0("1 + ", b, " * n_/N - ", c, " * n_R/N"),
        paste0("1 + ", c, " * n_C/N - ", a, " * n_/N")
        ))
    }

afcrs1 <- allFitnessEffects(genotFitness = crs(1, 1, 1),
frequencyDependentFitness = TRUE,
frequencyType = "abs")

resultscrs1_noints <- oncoSimulIndiv(afcrs1,
                            model = "McFL",
                            finalTime = 25,
                            mu = 1e-2,
                            initSize = 4000,
                            onlyCancer = FALSE,
                            keepPhylog = FALSE,
                            seed = NULL)

plot(resultscrs1_noints, show="genotypes", type = "line")


## ----interventionforrps-------------------------------------------
int_over_C <- list(
    list(
        ID = "Bothering R strain, by reducing C",
        Trigger = "n_C >= 500",
        WhatHappens = "n_C = n_C * 0.1",
        Periodicity = 3,
        Repetitions = Inf
    )
    )

final_int_over_C <-
    createInterventions(interventions = int_over_C,
                        genotFitness = afcrs1)

## ----rpswithints--------------------------------------------------
resultscrs1_noints <- oncoSimulIndiv(afcrs1,
                            model = "McFL",
                            finalTime = 25,
                            mu = 1e-2,
                            initSize = 4000,
                            onlyCancer = FALSE,
                            keepPhylog = FALSE,
                            seed = NULL,
                            interventions = final_int_over_C)

plot(resultscrs1_noints, show="genotypes", type = "line")


## ----userVarsListExample------------------------------------------
userVars <- list(
    list(Name           = "user_var1",
        Value       = 0
    ),
    list(Name           = "user_var2",
        Value       = 3
    ),
    list(Name           = "user_var3",
        Value       = 2.5
    )
)


## ----ruleListExample----------------------------------------------
rules <- list(
        list(ID = "rule_1",
            Condition = "T > 20",
            Action = "user_var_1 = 1"
        ),list(ID = "rule_2",
            Condition = "T > 30",
            Action = "user_var_2 = 2; user_var3 = 2*N"
        ),list(ID = "rule_3",
            Condition = "T > 40",
            Action = "user_var_3 = 3;user_var_2 = n_A*n_B"
        )
    )


## ----userVarsEscenario1Example------------------------------------
dfuv <- data.frame(Genotype = c("WT", "A", "B"),
                    Fitness = c("1",
                    "1 + 0.2 * (n_B > 0)",
                    ".9 + 0.4 * (n_A > 0)"
                    ))
afuv <- allFitnessEffects(genotFitness = dfuv,
                        frequencyDependentFitness = TRUE,
                        frequencyType = "abs")

## ----userVarsCreateUserVarsAndRulesExample------------------------
userVars <- createUserVars(userVars)
rules <- createRules(rules, afuv)

## ----userVarsOncoSimulIndivExample, eval=FALSE--------------------
# 
# uvex <- oncoSimulIndiv(
#     afuv,
#     model = "McFLD",
#     mu = 1e-4,
#     sampleEvery = 0.001,
#     initSize = c(20000, 20000),
#     initMutant = c("A", "B"),
#     finalTime = 5.2,
#     onlyCancer = FALSE,
#     userVars = userVars,
#     rules = rules
# )
# 

## ----userVarsBasicExample-----------------------------------------
dfuv2 <- data.frame(Genotype = c("WT", "B", "A", "B, A", "C, A"),
                       Fitness = c("0*n_",
                                    "1.5",
                                    "1.002",
                                    "1.003",
                                    "1.004"))

afuv2 <- allFitnessEffects(genotFitness = dfuv2,
                          frequencyDependentFitness = TRUE,
                          frequencyType = "abs")

userVars <- list(
    list(Name           = "genAProp",
        Value       = 0.5
    ),
	list(Name           = "genBProp",
        Value       = 0.5
    ),
	list(Name           = "genABProp",
        Value       = 0.0
    ),
	list(Name           = "genACProp",
        Value       = 0.0
    )
)

userVars <- createUserVars(userVars)

rules <- list(
        list(ID = "rule_1",
            Condition = "TRUE",
            Action = "genBProp = n_B/N"
        ),
		list(ID = "rule_2",
            Condition = "TRUE",
            Action = "genAProp = n_A/N"
        ),
		list(ID = "rule_3",
            Condition = "TRUE",
            Action = "genABProp = n_A_B/N"
        ),
		list(ID = "rule_4",
            Condition = "TRUE",
            Action = "genACProp = n_A_C/N"
        )
    )

rules <- createRules(rules, afuv2)

## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below
data(uvex2)

if(FALSE) {
set.seed(1)
uvex2 <- oncoSimulIndiv(
                    afuv2,
                    model = "McFLD",
                    mu = 1e-4,
                    sampleEvery = 0.01,
                    initSize = c(20000, 20000),
                    initMutant = c("A", "B"),
                    finalTime = 10,
                    onlyCancer = FALSE,
                    userVars = userVars,
                    rules = rules,
                    keepEvery = 0.1
                    )
}

plot(
    unlist(uvex2$other$userVarValues) [c(FALSE, FALSE, FALSE, FALSE, TRUE)],
    unlist(uvex2$other$userVarValues) [c(TRUE, FALSE, FALSE, FALSE, FALSE)],
    xlab="Time", ylab="Proportion", ylim=c(0,1), type="l", col="purple")

lines(
    unlist(uvex2$other$userVarValues) [c(FALSE, FALSE, FALSE, FALSE, TRUE)],
    unlist(uvex2$other$userVarValues) [c(FALSE, TRUE, FALSE, FALSE, FALSE)], type="l", col="#E6AB02")

lines(
    unlist(uvex2$other$userVarValues) [c(FALSE, FALSE, FALSE, FALSE, TRUE)],
    unlist(uvex2$other$userVarValues) [c(FALSE, FALSE, TRUE, FALSE, FALSE)], type="l", col="#1B9E77")

lines(
    unlist(uvex2$other$userVarValues) [c(FALSE, FALSE, FALSE, FALSE, TRUE)],
    unlist(uvex2$other$userVarValues) [c(FALSE, FALSE, FALSE, TRUE, FALSE)], type="l", col="#666666")

legend(0,1,
       legend=c("genABProp", "genACProp", "genAProp", "genBProp"), col=c("purple", "#E6AB02", "#1B9E77", "#666666"), lty= 1:2)

## ----userVarsBasicExample2----------------------------------------
dfuv3 <- data.frame(Genotype = c("WT", "A", "B"),
                   Fitness = c("1",
                               "1 + 0.2 * (n_B > 10)",
                               ".9 + 0.4 * (n_A > 10)"
                               ))
afuv3 <- allFitnessEffects(genotFitness = dfuv3,
                         frequencyDependentFitness = TRUE)

userVars <- list(
    list(Name           = "genWTRateDiff",
        Value       = 0.5
    ),list(Name           = "genARateDiff",
        Value       = 0.5
    ),list(Name           = "genBRateDiff",
        Value       = 0.0
    )
)

userVars <- createUserVars(userVars)

rules <- list(
        list(ID = "rule_1",
            Condition = "TRUE",
            Action = "genWTRateDiff = b_-d_"
        ),list(ID = "rule_2",
            Condition = "TRUE",
            Action = "genARateDiff = b_1-d_1"
        ),list(ID = "rule_3",
            Condition = "TRUE",
            Action = "genBRateDiff = b_2-d_2"
        )
    )

rules <- createRules(rules, afuv3)


## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below

data(uvex3)

if(FALSE) {
set.seed(1)

uvex3 <- oncoSimulIndiv(afuv3,
                       model = "McFLD",
                       onlyCancer = FALSE,
                       finalTime = 105,
                       mu = 1e-4,
                       initSize = 5000,
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE,
                       userVars = userVars,
                       rules = rules,
                       keepEvery = 1)
}

plot(uvex3, show = "genotypes", type = "line")

## ----userVarsBasicExamplePlotVars---------------------------------
plot(
    unlist(uvex3$other$userVarValues) [c(FALSE, FALSE, FALSE, TRUE)],
    unlist(uvex3$other$userVarValues) [c(FALSE, FALSE, TRUE, FALSE)], xlab="Time", ylab="Rate Diff",
    xlim=c(0, 105),
    ylim=c(-0.75,0.75), type="l", col="#1B9E77")

lines(
    unlist(uvex3$other$userVarValues) [c(FALSE, FALSE, FALSE, TRUE)],
    unlist(uvex3$other$userVarValues) [c(TRUE, FALSE, FALSE, FALSE)], type="l", col="#A6761D")

lines(
    unlist(uvex3$other$userVarValues) [c(FALSE, FALSE, FALSE, TRUE)],
    unlist(uvex3$other$userVarValues) [c(FALSE, TRUE, FALSE, FALSE)], type="l", col="#666666")

legend(0, 0.75,
       legend=c("genWTRateDiff", "genARateDiff", "genBRateDiff"), col=c("#1B9E77", "#A6761D", "#666666"), lty= 1:2)

## ----adaptiveTherapy1---------------------------------------------

dfat <- data.frame(Genotype = c("WT", "B", "A", "B, A", "C, A"),
                       Fitness = c("0*n_",
                                    "1.5",
                                    "1.002",
                                    "1.003",
                                    "1.004"))

adat <- allFitnessEffects(genotFitness = dfat,
                          frequencyDependentFitness = TRUE,
                          frequencyType = "abs")

userVars <- list(
    list(Name           = "user_var1",
        Value       = 0
    )
)

userVars <- createUserVars(userVars)

rules <- list(
        list(ID = "rule_1",
            Condition = "n_B > n_A",
            Action = "user_var1 = n_A-n_B"
        ),list(ID = "rule_2",
            Condition = "n_B > n_A",
            Action = "user_var1 = n_B-n_A"
        )
    )

rules <- createRules(rules, adat)


## ----AdaptiveTherapy2---------------------------------------------
interventions <- list(
    list(ID           = "i1",
        Trigger       = "N > 1000",
        WhatHappens   = "N = user_var1*0.8",
        Periodicity   = 1,
        Repetitions   = 5
    )
)

interventions <- createInterventions(interventions, adat)


## ----AdaptiveTherapy3---------------------------------------------
atex <- oncoSimulIndiv(
                    adat,
                    model = "McFLD",
                    mu = 1e-4,
                    sampleEvery = 0.01,
                    initSize = c(20000, 20000),
                    initMutant = c("A", "B"),
                    finalTime = 10,
                    onlyCancer = FALSE,
                    userVars = userVars,
                    rules = rules,
                    interventions = interventions)

## This try should not be necessary, except
## the code above seems to produce an empty object
## in the BioC kjohnson3 (maOS 13.6.5, arm64) machine.
## See below, "Help debugging"

try(plot(atex, show = "genotypes", type = "line"))

## ----adaptiveTherapyComplexExample--------------------------------
dfat3 <- data.frame(Genotype = c("WT", "A", "B"),
                   Fitness = c("1",
                               "0.8 + 0.2 * (n_B > 10) + 0.1 (n_A > 10)",
                               "0.8 + 0.25 * (n_B > 10)"
                               ))
afat3 <- allFitnessEffects(genotFitness = dfat3,
                         frequencyDependentFitness = TRUE)


userVars <- list(
    list(Name           = "lastMeasuredA",
        Value       = 0
    ),
	list(Name           = "lastMeasuredB",
        Value       = 0
    ),
	list(Name           = "previousA",
        Value       = 0
    ),
	list(Name           = "previousB",
        Value       = 0
    ),
	list(Name           = "lastTime",
        Value       = 0
    ),
	list(Name           = "measure",
        Value       = 0
    ),
	list(Name           = "treatment",
        Value       = 0
    )
)

userVars <- createUserVars(userVars)

rules <- list(
       list(ID = "rule_1",
            Condition = "T - lastTime < 10",
            Action = "measure = 0"
        ),
		list(ID = "rule_2",
            Condition = "T - lastTime >= 10",
            Action = "measure = 1;lastTime = T"
        ),
		list(ID = "rule_3",
            Condition = "measure == 1",
            Action = "previousA = lastMeasuredA;previousB = lastMeasuredB;lastMeasuredA = n_A;lastMeasuredB = n_B"
        ),
		list(ID = "rule_4",
            Condition = "TRUE",
            Action = "treatment = 0"
        ),
		list(ID = "rule_5",
            Condition = "lastMeasuredA + lastMeasuredB > 100",
            Action = "treatment = 1"
        ),
		list(ID = "rule_6",
            Condition = "lastMeasuredA - PreviousA > 500",
            Action = "treatment = 2"
        ),
		list(ID = "rule_7",
            Condition = "lastMeasuredB - PreviousB > 500",
            Action = "treatment = 3"
        ),
		list(ID = "rule_8",
            Condition = "lastMeasuredA - PreviousA > 500 and lastMeasuredB - PreviousB > 500",
            Action = "treatment = 4"
        )
    )

rules <- createRules(rules, afat3)


interventions <- list(
    list(ID           = "basicTreatment",
        Trigger       = "treatment == 1",
        WhatHappens   = "N = 0.8*N",
        Periodicity   = 10,
        Repetitions   = Inf
    ),
	list(ID           = "treatmentOverA",
        Trigger       = "treatment == 2 or treatment == 4",
        WhatHappens   = "n_B = n_B*0.3",
        Periodicity   = 20,
        Repetitions   = Inf
    ),
	list(ID           = "treatmentOverB",
        Trigger       = "treatment == 3 or treatment == 4",
        WhatHappens   = "n_B = n_B*0.3",
        Periodicity   = 20,
        Repetitions   = Inf
    ),
	list(ID           = "intervention",
        Trigger       = "lastMeasuredA+lastMeasuredB > 5000",
        WhatHappens   = "N = 0.1*N",
        Periodicity   = 70,
        Repetitions   = Inf
    )
)

interventions <- createInterventions(interventions, afat3)


## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below

data(atex2b)

if (FALSE) {

set.seed(1) ## for reproducibility
atex2b <- oncoSimulIndiv(afat3,
                         model = "McFLD",
                       onlyCancer = FALSE,
                       finalTime = 200,
                       mu = 1e-4,
                       initSize = 5000,
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE,
                       userVars = userVars,
                       rules = rules,
                       interventions = interventions,
					   keepEvery = 1)
}

plot(atex2b, show = "genotypes", type = "line")

## ----HansenExample1-----------------------------------------------
dfat4 <- data.frame(Genotype = c("WT", "A", "B"),
                   Fitness = c("n_/n_",
                               "1.005",
                               "1.1"
                               ))
afat4 <- allFitnessEffects(genotFitness = dfat4,
                         frequencyDependentFitness = TRUE)

## ----HansenExample2-----------------------------------------------
interventions <- list(
    list(ID           = "i1",
        Trigger       = "T > 10",
        WhatHappens   = "n_B = n_B*0.8",
        Periodicity   = 1,
        Repetitions   = Inf
    )
)

interventions <- createInterventions(interventions, afat4)

## ----HansenExample3-----------------------------------------------
## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below

data(atex4)

if(FALSE) {
set.seed(1) ## for reproducibility
atex4 <- oncoSimulIndiv(afat4,
                       model = "McFLD",
                       onlyCancer = FALSE,
                       finalTime = 2000,
                       mu = 1e-4,
                       initSize = c(10000, 50, 1000),
                       initMutant = c("WT", "A", "B"),
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE,
                       interventions = interventions,
                       keepEvery = 1)
}

plot(atex4, show = "genotypes", type = "line")

## ----HansenExampleAT1---------------------------------------------
dfat5 <- data.frame(Genotype = c("WT", "A", "B"),
                   Fitness = c("n_/n_",
                               "1.005",
                               "1.1"
                               ))
afat5 <- allFitnessEffects(genotFitness = dfat5,
                         frequencyDependentFitness = TRUE)

## ----HansenExampleAT2---------------------------------------------
userVars <- list(
    list(Name           = "measure",
        Value       = 0
    ),list(Name           = "lastTime",
        Value       = 0
    ),list(Name           = "treatment",
        Value       = 0
    ),list(Name           = "totalPopMeasured",
        Value       = 0
    )
)

userVars <- createUserVars(userVars)

rules <- list(
        list(ID = "rule_1",
            Condition = "T - lastTime < 10",
            Action = "measure = 0"
        ),list(ID = "rule_2",
            Condition = "T - lastTime >= 10",
            Action = "measure = 1;lastTime = T"
        ),list(ID = "rule_3",
            Condition = "measure == 1",
            Action = "totalPopMeasured = n_A + n_B"
        ),list(ID = "rule_4",
            Condition = "totalPopMeasured < 2000",
            Action = "treatment = 0"
        ),list(ID = "rule_5",
            Condition = "totalPopMeasured >= 2000",
            Action = "treatment = 1"
        )
    )

rules <- createRules(rules, afat5)

## ----HansenExampleAT3---------------------------------------------
interventions <- list(
    list(ID           = "i1",
        Trigger       = "treatment == 1",
        WhatHappens   = "n_B = n_B*0.8",
        Periodicity   = 1,
        Repetitions   = Inf
    )
)

interventions <- createInterventions(interventions, afat5)

## ----HansenExampleAT4---------------------------------------------
## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below

data(atex5)

if(FALSE) {
set.seed(1) ## for reproducibility
atex5 <- oncoSimulIndiv(afat5,
                       model = "McFLD",
                       onlyCancer = FALSE,
                       finalTime = 1500,
                       mu = 1e-4,
                       initSize = c(10000, 50, 1000),
                       initMutant = c("WT", "A", "B"),
                       keepPhylog = FALSE,
                       seed = NULL,
                       errorHitMaxTries = FALSE,
                       errorHitWallTime = FALSE,
                       userVars = userVars,
                       rules = rules,
                       interventions = interventions)
}

plot(atex5, show = "genotypes", type = "line")

## ----WTinIntervention---------------------------------------------
dfwtx <- data.frame(Genotype = c("WT", "B", "A"),
                    Fitness = c("4",
                                "3.7",
                                "3.8 + 0 * n_"))
afdwtx <- allFitnessEffects(genotFitness = dfwtx,
                            frequencyDependentFitness = TRUE,
                            frequencyType = "abs")
## Warning in allFitnessEffects(genotFitness = dfwtx,
## frequencyDependentFitness = TRUE, : v2 functionality detected.
## Adapting to v3 functionality.
## All single-gene genotypes as input to to_genotFitness_std

interventionsWT <- list(
    list(ID           = "intWT",
         Trigger       = "n_ >= 400 ",
         WhatHappens   = "n_ = 100",
         Repetitions   = Inf,
         Periodicity   = 0.07
         ))

interventionsWT <- createInterventions(interventionsWT, afdwtx)
## [1] "Checking intervention: intWT"

ex1_with_ints <- oncoSimulIndiv(
    afdwtx,
    model = "McFLD",
    mu = 1e-4,
    sampleEvery = 0.01,
    initMutant = c("WT", "A", "B"),
    initSize = c(100, 10, 20),
    finalTime = 20,
    onlyCancer = FALSE,
    interventions = interventionsWT)
## Using old version of fitnessEffects. Transforming fitnessEffects
##             to last version.
## Using old version of fitnessEffects. Transforming fitnessEffects
##             to last version.

plot(ex1_with_ints, show="genotypes", type = "stacked")

plot(ex1_with_ints, show="genotypes", type = "stacked",
     xlim = c(0, 10), ylim = c(0, 400))

## ----timefdf1-----------------------------------------------------
## Fitness definition
fl <- data.frame(
  Genotype = c("WT", "A", "B"),
  Fitness = c("1",                       #WT
              "if (T>50) 1.5; else 0;",  #A
              "0*f_") ,                  #B
  stringsAsFactors = FALSE
)

fe <- allFitnessEffects(genotFitness = fl,
                        frequencyDependentFitness = TRUE,
                        frequencyType = "rel")

## Evaluate the fitness before and after the specified currentTime
evalAllGenotypes(fe, spPopSizes = c(100, 100, 100))
evalAllGenotypes(fe, spPopSizes = c(100, 100, 100), currentTime = 80)

## Simulation
sim <- oncoSimulIndiv(fe,
                      model = "McFL",
                      onlyCancer = FALSE,
                      finalTime = 100,
                      mu = 0.01,
                      initSize = 5000,
                      keepPhylog = FALSE,
                      seed = NULL,
                      errorHitMaxTries = FALSE,
                      errorHitWallTime = FALSE)

## Plot the results
plot(sim, show = "genotypes")


## ----adapChemo1---------------------------------------------------
a <- 1;     b <- 0.5;  c <- 0.5    ## a b c
d <- 1;     e <- 1.25; f <- 0.7    ## d e f
g <- 0.975; h <- -0.5; i <- 0.75   ## g h i

payoff_m <- matrix(c(a,b,c,d,e,f,g,h,i), ncol=3, byrow=TRUE)
colnames(payoff_m) <- c("Healthy", "Chemo-sensitive", "Chemo-resistant")
rownames(payoff_m) <- c("Healthy", "Chemo-sensitive", "Chemo-resistant")
print(payoff_m <- as.table(payoff_m))


## ----adapChemo2---------------------------------------------------
print( df <- data.frame(
  CellType = c("H", "S", "R"),
  Fitness = c("F(H) = ax(H) + bx(S) + cx(R)",    #Healthy
              "F(S) = dx(H) + ex(S) + fx(R)",    #Sensitive
              "F(R) = gx(H) + hx(S) + ix(R)")),  #Resistant
  row.names = FALSE )

## ----scenChemo1---------------------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")


## Coefficients
# Healthy  Sensitive  Resistant
a=3;       b=1.5;     c=1.5     # Healthy
d=4;       e=5;       f=2.8     # Sensitive
g=3.9;     h=-2;      i=2.2     # Resistant


# Here we divide coefficients to reduce the amount of cells obtained in the simulation.
# We have divided a, b and c by 3, and d, e and i by 4.

# Healthy     Sensitive   Resistant
a <- 1;       b <- 0.5;   c <- 0.5    # Healthy
d <- 1;       e <- 1.25;  f <- 0.7    # Sensitive
g <- 0.975;   h <- -0.5;  i <- 0.75   # Resistant


## Fitness definition
players <- data.frame(Genotype = c("WT","S","R","S,R"),
                      Fitness = c(paste0(a, "*f_+", b, "*f_S+", c, "*f_S_R"), #WT
                                  paste0(d,"*f_+",e,"*f_S+",f,"*f_S_R"),      #S
                                  "0",                                        #R
                                  paste0(g,"*f_+",h,"*f_S+",i,"*f_S_R")),     #S,R
                      stringsAsFactors = FALSE)


game <- allFitnessEffects(genotFitness = players,
                          frequencyDependentFitness = TRUE,
                          frequencyType = "rel")

## Plot the first scenario
eag <- evalAllGenotypes(game, spPopSizes = c(10,1,0,10))[c(1, 3, 4),]

## This try should not be necessary, except
## the code above seems to produce an empty object
## in the BioC kjohnson3 (maOS 13.6.5, arm64) machine.
## See below, "Help debugging"
try(plot(eag))

## Simulation
gamesimul <- oncoSimulIndiv(game,
                            model = "McFL",
                            onlyCancer = FALSE,
                            finalTime = 40,
                            mu = 0.01,
                            initSize = 5000,
                            keepPhylog = FALSE,
                            seed = NULL)

## This try should not be necessary, except
## the code above seems to produce an empty object
## in the BioC kjohnson3 (maOS 13.6.5, arm64) machine.
## See below, "Help debugging"
## Plot 2
try(plot(gamesimul, show = "genotypes", type = "line",
     col = c("black", "green", "red"), ylim = c(20, 50000)))

try(plot(gamesimul, show = "genotypes"))

## ----fixedChemo1--------------------------------------------------
# Effect of drug on fitness sensible tumor cells
drug_eff <- 0.01

wt_fitness <- paste0(a, "*f_+", b, "*f_S+", c, "*f_S_R")
sens_fitness <- paste0(d, "*f_+", e, "*f_S+", f, "*f_S_R")
res_fitness <- paste0(g, "*f_+", h, "*f_S+", i, "*f_S_R")

players_1 <- data.frame(Genotype = c("WT", "S", "R", "S, R"),
                        Fitness = c(wt_fitness,                                               #WT
                                    paste0("if (T>50) ", drug_eff, "*(",sens_fitness, ")",";
                                           else ", sens_fitness, ";"),                        #S
                                    "0",                                                      #R
                                    res_fitness),                                             #S,R
                        stringsAsFactors = FALSE)

period_1 <- allFitnessEffects(genotFitness = players_1,
                              frequencyDependentFitness = TRUE,
                              frequencyType = "rel")


## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below

data(simul_period_1)

if (FALSE) {
set.seed(2)

final_time <- 170 ## for speed
simul_period_1 <- oncoSimulIndiv(period_1,
                                 model = "McFL",
                                 onlyCancer = FALSE,
                                 finalTime = final_time,
                                 mu = 0.01,
                                 initSize = 5000,
                                 keepPhylog = FALSE,
                                 seed = NULL)
}
# ylim has been adapted to number of cells
plot(simul_period_1, show = "genotypes", type = "line",
     col = c("black", "green", "red"), ylim = c(20, 300000),
     thinData = TRUE)

## plot(simul_period_1, show = "genotypes", ylim = c(20, 12000))

## ----switchChemo1-------------------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

# Healthy     Sensitive   Resistant
a <- 1;       b <- 0.5;   c <- 0.5    # Healthy
d <- 1;       e <- 1.25;  f <- 0.7    # Sensitive
g <- 0.975;   h <- -0.5;  i <- 0.75   # Resistant

wt_fitness   <- paste0(a, "*f_+", b, "*f_S+", c, "*f_S_R")
sens_fitness <- paste0(d, "*f_+", e, "*f_S+", f, "*f_S_R")
res_fitness  <- paste0(g, "*f_+", h, "*f_S+", i, "*f_S_R")

fitness_df <-data.frame(Genotype = c("WT", "S", "R", "S, R"),
                        Fitness = c(wt_fitness,                                              #WT
                                    paste0("if (T>50) (sin(T+2)/10) * (", sens_fitness,")",
                                           "; else ", sens_fitness, ";"),                    #S
                                    "0",                                                     #R
                                    res_fitness),                                            #S,R
                        stringsAsFactors = FALSE)

afe <- allFitnessEffects(genotFitness = fitness_df,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel")

switching_sim  <- oncoSimulIndiv(afe,
                               model = "McFL",
                               onlyCancer = FALSE,
                               finalTime = 100,
                               mu = 0.01,
                               initSize = 5000,
                               keepPhylog = FALSE,
                               seed = NULL)

plot(switching_sim, show = "genotypes", type = "line",
   col = c("black", "green", "red"), ylim = c(20, 200000))

## plot(switching_sim, show = "genotypes", ylim = c(20, 1000))


## ----gfChemo1-----------------------------------------------------
# WT      Cooperators Defectors Overproducers
a <- 1;   b <- 0.5;   c <- 0.5; m <- 0.75      ## a b c m
d <- 1;   e <- 1.25;  f <- 0.7; o <- 0.185     ## d e f o
g <- 1;   h <- 1.5;   i <- 0.5; p <- 2.5       ## g h i p
j <- 0.8; k <- 1;     l <- 0.5; q <- 1.5       ## j k l q

payoff_m <- matrix(c(a,b,c,m,d,e,f,o,g,h,i,p,j,k,l,q), ncol=4, byrow=TRUE)
colnames(payoff_m) <- c("WT", "Cooperators", "Defectors", "Overproducers")
rownames(payoff_m) <- c("WT", "Cooperators", "Defectors", "Overproducers")
print(payoff_m <- as.table(payoff_m))


## ----gfChemo2-----------------------------------------------------
print( df <- data.frame(
  CellType = c("WT", "C", "D", "P"),
  Fitness = c("F(WT) = ax(WT) + bx(C) + cx(D) + mx(P)",
              "F(C) = dx(WT) + ex(C) + fx(D) + ox(P)",
              "F(D) = gx(WT) + hx(C) + ix(D) + px(P)",
              "F(P) = jx(WT) + kc(C) + lx(D) + qx(P)")),
  row.names = FALSE )

## ----scenGF1------------------------------------------------------
set.seed(2)
RNGkind("L'Ecuyer-CMRG")

## Coefficients
## New coefficients for the interaction with overproducing sensitive:

# WT      COOPERATOR  DEFECTOR    OVERPRODUCER
a <- 1;   b <- 0.5;   c <- 0.5;   m <- 0.75   # WT
wt_fitness <- paste0(a, "*f_+", b, "*f_C+", c, "*f_C_D+", m, "*f_C_P")

d <- 1;   e <- 1.25;  f <- 0.7;   o <- 1.875  # Cooperator
coop_fitness <- paste0(d, "*f_+", e, "*f_C+", f, "*f_C_D+", o, "*f_C_P")

g <- 1;   h <- 1.5;   i <- 0.5;   p <- 2.5    # Defector
def_fitness <- paste0(g, "*f_+", h, "*f_C+", i, "*f_C_D+", p, "*f_C_P")

j <- 0.8; k <- 1;     l <- 0.5;   q <- 1.5    # Cooperator overproducing
over_fitness <- paste0(j, "*f_+", k, "*f_C+", l, "*f_C_D+", q, "*f_C_P")


## No-chemotherapy
## Fitness definition
coop_no <- data.frame(Genotype = c("WT", "C", "D", "P", "C,D", "C,P", "D,P", "C,D,P"),
                      Fitness = c(
                        wt_fitness, #WT
                        coop_fitness, #S
                        "0", #D
                        "0", #P
                        def_fitness, #S,D
                        over_fitness, #S,P
                        "0", #D,P
                        "0"  #C,D,P
                        ),
                        stringsAsFactors = FALSE)

game_no <- allFitnessEffects(genotFitness = coop_no,
                          frequencyDependentFitness = TRUE,
                          frequencyType = "rel")


## First plot
eag <- evalAllGenotypes(game_no,
                        spPopSizes = c(WT = 10, C = 10, D = 0, P = 0,
                                       "C, D" = 10, "C, P" = 1,
                                       "D, P" = 0, "C, D, P" = 0))[c(1, 2, 5, 6),]
plot(eag)

## Simulation
gamesimul_no <- oncoSimulIndiv(game_no,
                            model = "McFL",
                            onlyCancer = FALSE,
                            finalTime = 35,
                            mu = 0.01,
                            initSize = 5000,
                            keepPhylog = FALSE,
                            seed = NULL)

## Second plot
plot(gamesimul_no, show = "genotypes", type = "line",
     col = c("blue", "red", "green", "purple"), ylim = c(20, 50000),
     thinData = TRUE)

# Third plot
## plot(gamesimul_no, show = "genotypes")

## ----scenGFChemo1-------------------------------------------------
## Chemotherapy - GF Impairing

# Effect of drug on GF availability
# This term is multiplied by the fitness, and reduces the GF available
drug_eff <- 0.25

coop_fix <- data.frame(Genotype = c("WT", "C", "D", "P", "C,D", "C,P", "D,P", "C,D,P"),
                      Fitness = c(
                        wt_fitness,                                                   #WT
                        paste0("if (T>50) ", drug_eff, "* 1.2 *(", coop_fitness, ")",
                               "; else ", coop_fitness, ";"),                         #C
                        "0",                                                          #D
                        "0",                                                          #P
                        paste0("if (T>50) ", drug_eff, "*(", def_fitness, ")",
                               "; else ", def_fitness, ";"),                          #C,D
                        paste0("if (T>50) ", drug_eff, "* 1.5 * (", over_fitness, ")",
                               "; else ", over_fitness, ";"),                         #C,P **
                        "0",                                                          #D,P
                        "0"                                                           #C,D,P
                      ),
                      stringsAsFactors = FALSE)

## ** The drug effect is 1.5 times the original because of the overproduction of GF and the
##    full availability of this molecule inside the producing subclone.

period_fix <- allFitnessEffects(genotFitness = coop_fix,
                              frequencyDependentFitness = TRUE,
                              frequencyType = "rel")

set.seed(2)
final_time <- 30 ## you'd want this longer; short for speed of vignette
simul_period_fix <- oncoSimulIndiv(period_fix,
                                 model = "McFL",
                                 onlyCancer = FALSE,
                                 finalTime = final_time,
                                 mu = 0.01,
                                 initSize = 5000,
                                 keepPhylog = FALSE,
                                 seed = NULL)

# First plot
plot(simul_period_fix, show = "genotypes", type = "line",
     col = c("blue", "red", "green", "purple"), ylim = c(20, 50000),
     thinData = TRUE)

# Second plot
## plot(simul_period_fix, show = "genotypes", ylim = c(20, 8000))

## ----exTimeInc----------------------------------------------------
dfT1 <- data.frame(Genotype = c("WT", "A", "B"),
                 Fitness = c("1",
                             "if (T>50) 1 + 2.35*f_; else 0.50;",
                             "if (T>200) 1 + 0.45*(f_ + f_1); else 0.50;"),
                 stringsAsFactors = FALSE)

afeT1 <- allFitnessEffects(genotFitness = dfT1,
                         frequencyDependentFitness = TRUE,
                         frequencyType = "rel")

set.seed(1)
simT1 <- oncoSimulIndiv(afeT1,
                      model = "Exp",
                      mu = 1e-5,
                      initSize = 1000,
                      finalTime = 500,
                      onlyCancer = FALSE,
                      seed = NULL)

plot(simT1, show = "genotypes", type = "line")

## ----exTimeInc1---------------------------------------------------
evalAllGenotypes(afeT1, spPopSizes = c(10,10,10), currentTime = 49)[c(2,3), ]
evalAllGenotypes(afeT1, spPopSizes = c(10,10,10), currentTime = 51)[c(2,3), ]
evalAllGenotypes(afeT1, spPopSizes = c(10,10,10), currentTime = 201)[c(2,3), ]

## ----exTimeDec----------------------------------------------------
dfT2 <- data.frame(Genotype = c("WT", "A", "B"),
                     Fitness = c(
                       "1",
                       "if (T>0 and T<50) 0; else if (T>100 and T<150) 0.05; else 1.2 + 0.35*f_;",
                       "0.8 + 0.45*(f_)"
                     ),
                     stringsAsFactors = FALSE)

afeT2 <- allFitnessEffects(genotFitness = dfT2,
                             frequencyDependentFitness = TRUE,
                             frequencyType = "rel")


## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below

data(simT2)

if (FALSE) {
set.seed(1)
simT2 <- oncoSimulIndiv(afeT2,
                        model = "McFL",
                        mu = 1e-5,
                        initSize = 10000,
                        finalTime = 225,
                        onlyCancer = FALSE,
                        seed = NULL,
						keepEvery = 1)
}
## Had we not used keepEvery, we'd probably have used
## plot(simT2, show = "genotypes", thinData = TRUE)
plot(simT2, show = "genotypes")


## ----examplesTDec1------------------------------------------------
evalAllGenotypes(afeT2, spPopSizes = c(100,10,10), currentTime = 49)[c(2,3), ]
evalAllGenotypes(afeT2, spPopSizes = c(100,10,10), currentTime = 51)[c(2,3), ]
evalAllGenotypes(afeT2, spPopSizes = c(100,10,10), currentTime = 101)[c(2,3), ]
evalAllGenotypes(afeT2, spPopSizes = c(100,10,10), currentTime = 201)[c(2,3), ]

## ----examplesTCol-------------------------------------------------
dfT3 <- data.frame(Genotype = c("WT", "A", "B"),
                 Fitness = c(
                   "1",
                   "1 + 0.2 * (n_2 > 10)",
                   "if (T>50 and T<80) 0.80; else 0.9 + 0.4 * (n_1 > 10)"),
                 stringsAsFactors = FALSE)

afeT3 <- allFitnessEffects(genotFitness = dfT3,
                           frequencyDependentFitness = TRUE,
                           frequencyType = "abs")


## For speed creating the vignette, we load
## precomputed simulation data. Otherwise, run code below

data(simT3)

if (FALSE) {
set.seed(2)
simT3 <- oncoSimulIndiv(afeT3,
                      model = "McFLD",
                      mu = 1e-4,
                      initSize = 5000,
                      finalTime = 500,
                      onlyCancer = FALSE,
                      seed = NULL,
                      errorHitWallTime = FALSE,
                      errorHitMaxTries = FALSE,
					  keepEvery = 1)
}

plot(simT3, show = "genotypes", type = "line")

## ----examplesTCol1------------------------------------------------
evalAllGenotypes(afeT3, spPopSizes = c(10,10,10), currentTime = 30)[c(2,3), ]
evalAllGenotypes(afeT3, spPopSizes = c(11,11,11), currentTime = 79)[c(2,3), ]
evalAllGenotypes(afeT3, spPopSizes = c(11,11,11), currentTime = 81)[c(2,3), ]

## ----lod_pom_ex---------------------------------------------------
pancr <- allFitnessEffects(
    data.frame(parent = c("Root", rep("KRAS", 4), "SMAD4", "CDNK2A",
                          "TP53", "TP53", "MLL3"),
               child = c("KRAS","SMAD4", "CDNK2A",
                         "TP53", "MLL3",
                         rep("PXDN", 3), rep("TGFBR2", 2)),
               s = 0.05, sh = -0.3, typeDep = "MN"))

pancr16 <- oncoSimulPop(16, pancr,
                        model = "Exp",                          onlyCancer = TRUE,
                        mc.cores = 2)

## Look a the first POM
str(POM(pancr16)[1:3])

LOD(pancr16)[1:2]

## The diversity of LOD (lod_single) and POM might or might not
## be identical
diversityPOM(POM(pancr16))
diversityLOD(LOD(pancr16))

## Show the genotypes and their diversity (which might, or might
## not, differ from the diversity of LOD and POM)
sampledGenotypes(samplePop(pancr16))


## ----nyv0150------------------------------------------------------
## No seed fixed, so reruns will give different DAGs.
(a1 <- simOGraph(10))
library(graph) ## for simple plotting
plot(as(a1, "graphNEL"))

## ----simographindirect, eval=FALSE,echo=TRUE----------------------
# g2 <- simOGraph(4, out = "rT", removeDirectIndirect = FALSE)
# 
# fe_from_d <- allFitnessEffects(g2)
# fitness_d <- evalAllGenotypes(fe_from_d)
# 
# fe_from_t <- allFitnessEffects(genotFitness =
#                           OncoSimulR:::allGenotypes_to_matrix(fitness_d))
# 
# ## Compare
# fitness_d
# (fitness_t <- evalAllGenotypes(fe_from_t))
# 
# identical(fitness_d, fitness_t)
# 
# 
# ## ... but to be safe use fe_from_t as the fitnessEffects object for simulations
# 

## ----nyv0161------------------------------------------------------
## This code will only be evaluated under Windows
if(.Platform$OS.type == "windows")
    try(pancrError <- oncoSimulPop(10, pancr,
                                   initSize = 1e-5,
                                   onlyCancer = TRUE,
                                   detectionSize = 1e7,
                                   keepEvery = 10,
                               mc.cores = 2))

## ----nyv0162------------------------------------------------------
## Do not run under Windows
if(.Platform$OS.type != "windows")
    pancrError <- oncoSimulPop(10, pancr,
                               initSize = 1e-5,
                               onlyCancer = TRUE,
                               detectionSize = 1e7,
                               keepEvery = 10,
                               mc.cores = 2)

## ----rzx0316, eval=FALSE------------------------------------------
# pancrError[[1]]

## ----rzx0317, eval=FALSE------------------------------------------
# pancrError[[1]][1]

## ----ex-tomlin1exc------------------------------------------------
sd <- 0.1 ## fitness effect of drivers
sm <- 0 ## fitness effect of mutator
nd <- 20 ## number of drivers
nm <- 5  ## number of mutators
mut <- 50 ## mutator effect  THIS IS THE DIFFERENCE

fitnessGenesVector <- c(rep(sd, nd), rep(sm, nm))
names(fitnessGenesVector) <- 1:(nd + nm)
mutatorGenesVector <- rep(mut, nm)
names(mutatorGenesVector) <- (nd + 1):(nd + nm)

ft <- allFitnessEffects(noIntGenes = fitnessGenesVector,
                        drvNames = 1:nd)
mt <- allMutatorEffects(noIntGenes = mutatorGenesVector)


## ----ex-tomlinexc2------------------------------------------------
ddr <- 4
set.seed(2)
RNGkind("L'Ecuyer-CMRG")
st <- oncoSimulPop(4, ft, muEF = mt,
                   detectionDrivers = ddr,
                   finalTime = NA,
                   detectionSize = NA,
                   detectionProb = NA,
                   onlyCancer = TRUE,
                   keepEvery = NA,
                   mc.cores = 2, ## adapt to your hardware
                   seed = NULL) ## for reproducibility
## set.seed(NULL) ## return things to their "usual state"


## ----nyv01880-----------------------------------------------------
sessionInfo()

## ----last, echo=FALSE---------------------------------------------
paste(difftime(Sys.time(), time0, units = "mins"), "minutes")

## ----timeit-------------------------------------------------------
## The 15 most time consuming chunks
sort(unlist(all_times), decreasing = TRUE)[1:15]

## ----sumtimeit----------------------------------------------------
paste("Sum times of chunks = ", sum(unlist(all_times))/60, " minutes")

## ----fundinglogo, eval=TRUE,echo=FALSE----------------------------
knitr::include_graphics("logo-micin-aei-uefeder.png", dpi = 150)

## ----fundinglogo2, eval=TRUE,echo=FALSE---------------------------
knitr::include_graphics("logo-micin-aei.png", dpi = 420)

## ----rzx0323, echo=FALSE, eval=TRUE-------------------------------
## reinitialize the seed
set.seed(NULL)

