# Code example from 'Resolve-Light-Chains-Vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE, warning=FALSE, message=FALSE---------------------------------
# library(dowser)
# library(ggtree)
# # load example tsv data
# data("ExampleMixedDb")
# 
# # find the clone subgroups
# ExampleMixedDb <- resolveLightChains(ExampleMixedDb)
# print(ExampleMixedDb$clone_subgroup)

## ----eval=FALSE, warning=FALSE, message=FALSE---------------------------------
# # run createGermlines -- this will create new germline for each locus in each subgroup
# # the directory for the references matches the location on docker
# references <- readIMGT("/usr/local/share/germlines/imgt/human/vdj")
# ExampleMixedDb <- createGermlines(ExampleMixedDb, references = references, clone = "clone_subgroup_id", nproc = 1)

## ----eval=FALSE, warning=FALSE, message=FALSE---------------------------------
# clones <- formatClones(ExampleMixedDb, chain="HL", nproc=1, collapse = FALSE,
#                        split_light = TRUE, minseq = 3)
# print(clones)

## ----eval=FALSE, warning=FALSE, message=FALSE---------------------------------
# # Building maximum likelihood trees with multiple partitions using IgPhyML
# # Only the newest version of IgPhyML supports this option
# # exec here is set to IgPhyML position in the Docker image.
# clones <- getTrees(clones, build="igphyml", nproc=1, partition="hl",
#                    exec="/usr/local/share/igphyml/src/igphyml")

## ----eval=FALSE, warning=FALSE, message=FALSE---------------------------------
# plotTrees(clones)[[1]]+geom_tiplab()+xlim(0,0.35)

## ----eval=TRUE, warning=FALSE, message=FALSE, echo=FALSE----------------------
library(dowser)
library(ggtree)
# Load data instead of running IgPhyML
data(ExampleMixedClones)

ExampleMixedClones$trees <- ExampleMixedClones$igphyml_partitioned_trees

plotTrees(ExampleMixedClones)[[1]] + geom_tiplab() +xlim(0,0.35)

## ----eval=FALSE, warning=FALSE, message=FALSE---------------------------------
# 
# # exec is set to RAxML position in the Docker image.
# clones = getTrees(clones, build="raxml",
#     exec="/usr/local/bin/raxml-ng", nproc=1, partition="scaled")

## ----eval=FALSE, warning=FALSE, message=FALSE---------------------------------
# plotTrees(clones)[[1]]+geom_tiplab()+xlim(0, 0.12)

## ----eval=TRUE, warning=FALSE, message=FALSE, echo=FALSE----------------------
data(ExampleMixedClones)
# change the tree names
ExampleMixedClones$trees <- ExampleMixedClones$raxml_partitioned_trees
plotTrees(ExampleMixedClones)[[1]] + geom_tiplab() + xlim(0, 0.12)

