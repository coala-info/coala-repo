# Code example from 'Building-Time-Trees-Vignette' vignette. See references/ for full tutorial.

## ----prepare-data, eval=FALSE-------------------------------------------------
# library(dowser)
# library(dplyr)
# library(ggtree)
# 
# # load example AIRR tsv data
# data(ExampleAirrTyCHE)
# 
# # set up time/date trait
# ExampleAirrTyCHE$sample_time <- as.numeric(ExampleAirrTyCHE$sample_time)
# 
# # trait value of interest
# trait="location"
# 
# clones <- formatClones(
#   ExampleAirrTyCHE,
#   traits = c(trait, "sample_time"),
#   germ   = "germline_alignment"
# )
# 
# # Column shows which location the B cell was obtained from
# print(table(ExampleAirrTyCHE[[trait]]))

## ----print-table, echo=FALSE, warning=FALSE, message=FALSE--------------------
library(dowser)
data(ExampleAirrTyCHE)
trait="location"

print(table(ExampleAirrTyCHE[[trait]]))

## ----estimate-gc-clock-rate, eval=FALSE---------------------------------------
# gc_cells = filter(ExampleAirrTyCHE, location=="germinal_center")
# gcf = formatClones(gc_cells, traits=c("location","sample_time"),
# 	germ="germline_alignment")
# 
# 
# gctrees = getTrees(gcf, build="pml", sub_model="HKY")
# 
# plotTrees(gctrees)[[1]] + geom_tippoint(aes(color=sample_time))

## ----eval=FALSE---------------------------------------------------------------
# # edit to your BEAST installation path
# beast <- "/Applications/BEAST 2.7.7/bin/"
# 
# # estimate clock rate of GC B cells
# # if you don't care about convergence, reduce mcmc_length
# # ensure you are providing the correct path to the template file downloaded earlier (see Requirements)
# gctree = getTimeTreesIterate(gcf,
# 	beast=beast,
# 	template="StrictClock_Standard_EmpFreq.xml",
# 	dir="temp",
# 	id="gc_strict",
# 	time="sample_time",
# 	mcmc_length=1e6,
# 	iterations=10,
# 	nproc=2,
# 	CLOCK_RATE_INIT=0.001,
# 	KAPPA_PRIOR_M=0.67,
# 	KAPPA_PRIOR_S=0.2,
# 	ignore=c("freqParameter"))
# 
# 
# gcrate_tree = mean(sapply(gctree$parameters, function(x)filter(x,item=="geneticClockRate")$mean))
# print(gcrate_tree)

## ----echo=FALSE---------------------------------------------------------------
print(0.000363)

## ----eval=FALSE---------------------------------------------------------------
# gcrate_slope = mean(correlationTest(gctrees, time="sample_time")$slope)
# print(gcrate_slope)

## ----echo=FALSE---------------------------------------------------------------
print(0.0003686277)

## ----eval=FALSE---------------------------------------------------------------
# mixed_trees <- getTimeTreesIterate(
#   clones,
#   beast    = beast,
#   template = "TraitLinkedExpectedOccupancy_EstTraitClockRates_EmpFreq.xml",
#   trait    = trait,
#   time     = "sample_time",
#   dir      = "temp",
#   id       = "tyche_eo_est",
#   log_every = "auto",
#   nproc     = 2,
#   KAPPA_PRIOR_M = 0.67,
#   KAPPA_PRIOR_S = 0.2,
#   TRAIT_RATE_MEAN_1 = gcrate_tree,
#   TRAIT_RATE_MEAN_2 = 0.000001,
#   TRAIT_RATE_SIGMA_1 = gcrate_tree * 0.01,
#   TRAIT_RATE_SIGMA_2 = 0.001,
#   RATE_INDICATORS = "1 0",
#   TRANSITION_RATE_ALPHA_1 = 0.1,
#   TRANSITION_RATE_ALPHA_2 = 1.0,
#   TRANSITION_RATE_BETA_1  = 0.1,
#   TRANSITION_RATE_BETA_2  = 1.0,
#   log_target   = 2000,
#   mcmc_length  = 1e6,
#   ignore       = c("freqParameter"),
#   iterations   = 20
# )

## ----plot-mixed-trees-result, eval=FALSE--------------------------------------
# plotTrees(mixed_trees, scale=10)[[1]] + geom_point(aes(fill=location), pch=21, size=3)

## ----tree-height-parameter, eval=FALSE----------------------------------------
# print(mixed_trees$parameters[[2]] %>% filter(item=="TreeHeight"))

## ----echo=FALSE---------------------------------------------------------------
tree_height_param <- "        item     mean   stderr   stddev   median X95.HPDlo X95.HPDup      ACT      ESS geometric.mean
1 TreeHeight 236.0621 1.595335 19.36631 234.2536  201.9269  275.1676 122150.1 147.3636       235.2881"
cat(tree_height_param)

## ----logged-parameters, eval=FALSE--------------------------------------------
# print(mixed_trees$parameters[[2]]$item)

## ----echo=FALSE---------------------------------------------------------------
logged_items <- c("posterior", "likelihood","prior", 
                  "treeLikelihood.tyche_eo_est_2", "TreeHeight", 
                  "rateIndicator.type.1", "rateIndicator.type.2", 
                  "relativeGeoRates.type.1", "relativeGeoRates.type.2",
                  "typeSwitchClockRate", "kappa.tyche_eo_est_2",
                  "BayesianSkyline", "bPopSizes.1", "bPopSizes.2", "bPopSizes.3",
                  "bPopSizes.4", "bPopSizes.5", "bGroupSizes.1",
                  "bGroupSizes.2", "bGroupSizes.3", "bGroupSizes.4",
                  "bGroupSizes.5", "freqParameter.tyche_eo_est_2.1",
                  "freqParameter.tyche_eo_est_2.2",
                  "freqParameter.tyche_eo_est_2.3", 
                  "freqParameter.tyche_eo_est_2.4", "traitfrequencies.type.1",
                  "traitfrequencies.type.2", "typeLinkedRates.1", "typeLinkedRates.2")
print(logged_items)

## ----read-beast-output, eval=FALSE--------------------------------------------
# mixed_trees <- readBEAST(clones, dir="temp", id="tyche_eo_est", beast=beast, trait=trait)

