# Code example from 'phylocompcodeR' vignette. See references/ for full tutorial.

## ----include = FALSE---------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(width = 55)

## ----setup-------------------------------------------
library(compcodeR)

## ----tree, eval = TRUE-------------------------------
library(ape)
tree <- system.file("extdata", "Stern2018.tree", package = "compcodeR")
tree <- read.tree(tree)

## ----cond, eval = TRUE-------------------------------
# link each sample to a species
id_species <- factor(sub("_.*", "", tree$tip.label))
names(id_species) <- tree$tip.label
# Assign a condition to each species
species_names <- unique(id_species)
species_names[c(length(species_names)-1, length(species_names))] <- species_names[c(length(species_names), length(species_names)-1)]
cond_species <- rep(c(1, 2), length(species_names) / 2)
names(cond_species) <- species_names
# map them on the tree
id_cond <- id_species
id_cond <- cond_species[as.vector(id_cond)]
id_cond <- as.factor(id_cond)
names(id_cond) <- tree$tip.label

## ----eval = TRUE, echo = TRUE, fig.cap = "Phylogenetic tree with $14$ species and $34$ samples, with two conditions", fig.height = 8, fig.align='center'----
plot(tree, label.offset = 0.01)
tiplabels(pch = 19, col = c("#D55E00", "#009E73")[id_cond])

## ----eval = FALSE------------------------------------
# set.seed(12890926)
# alt_BM <- generateSyntheticData(dataset = "alt_BM",
#                                 n.vars = 2000, samples.per.cond = 17,
#                                 n.diffexp = 200, repl.id = 1,
#                                 seqdepth = 1e7, effect.size = 3,
#                                 fraction.upregulated = 0.5,
#                                 output.file = "alt_BM_repl1.rds",
#                                 ## Phylogenetic parameters
#                                 tree = tree,                      ## Phylogenetic tree
#                                 id.species = id_species,          ## Species structure of samples
#                                 id.condition = id_cond,           ## Condition design
#                                 model.process = "BM",             ## The latent trait follows a BM
#                                 prop.var.tree = 0.9,              ## Tree accounts for 90% of the variance
#                                 lengths.relmeans = "auto",        ## OG length mean and dispersion
#                                 lengths.dispersions = "auto")     ## are taken from an empirical exemple

## ----reportsimulated, eval = FALSE-------------------
# summarizeSyntheticDataSet(data.set = "alt_BM_repl1.rds",
#                           output.filename = "alt_BM_repl1_datacheck.html")

## ----echo = FALSE, fig.cap = "Example figures from the summarization report generated for a simulated data set. The top panel shows an MA plot, with the genes colored by the true differential expression status. The bottom panel shows the same plot, but using TPM-normalized estimated expression levels.", fig.show='hold',fig.align='center'----
knitr::include_graphics(
  c("phylocompcodeR_check_figure/maplot-trueDEstatus-1.png",
    "phylocompcodeR_check_figure/maplot-trueDEstatus-logTPM-1.png")
  )

## ----echo = FALSE, fig.cap = "Example figures from the summarization report generated for a simulated data set. The tips colored by true differential expression status. Only the first 400 genes are represented. The first block of 200 genes are differencially expressed between condition 1 and 2. The second block of 200 genes are not differencially expressed.", fig.show='hold',fig.align='center'----
knitr::include_graphics(
  c("phylocompcodeR_check_figure/maplot-phyloHeatmap-1.png")
  )

## ----rundiffexp1, eval = FALSE-----------------------
# runDiffExp(data.file = "alt_BM_repl1.rds",
#            result.extent = "DESeq2", Rmdfunction = "DESeq2.createRmd",
#            output.directory = ".",
#            fit.type = "parametric", test = "Wald")
# runDiffExp(data.file = "alt_BM_repl1.rds",
#            result.extent = "lengthNorm.limma", Rmdfunction = "lengthNorm.limma.createRmd",
#            output.directory = ".",
#            norm.method = "TMM",
#            length.normalization = "TPM",
#            data.transformation = "log2",
#            trend = FALSE, block.factor = "id.species")
# runDiffExp(data.file = "alt_BM_repl1.rds",
#            result.extent = "phylolm", Rmdfunction = "phylolm.createRmd",
#            output.directory = ".",
#            norm.method = "TMM",
#            model = "BM", measurement_error = TRUE,
#            extra.design.covariates = NULL,
#            length.normalization = "TPM",
#            data.transformation = "log2")

## ----listcreatermd-----------------------------------
listcreateRmd()

## ----create-compData, eval=TRUE----------------------
## Phylogentic tree with replicates
tree <- read.tree(text = "(((A1:0,A2:0,A3:0):1,B1:1):1,((C1:0,C2:0):1.5,(D1:0,D2:0):1.5):0.5);")
## Sample annotations
sample.annotations <- data.frame(
  condition = c(1, 1, 1, 1, 2, 2, 2, 2),                 # Condition of each sample
  id.species = c("A", "A", "A", "B", "C", "C", "D", "D") # Species of each sample
  )
## Count Matrix
count.matrix <- round(matrix(1000*runif(8000), 1000))
## Length Matrix
length.matrix <- round(matrix(1000*runif(8000), 1000))
## Names must match
colnames(count.matrix) <- colnames(length.matrix) <- rownames(sample.annotations) <- tree$tip.label
## Extra infos
info.parameters <- list(dataset = "mydata", uID = "123456")
## Creation of the object
cpd <- phyloCompData(count.matrix = count.matrix,
                     sample.annotations = sample.annotations,
                     info.parameters = info.parameters,
                     tree = tree,
                     length.matrix = length.matrix)
## Check
check_phyloCompData(cpd)

## ----session-info------------------------------------
sessionInfo()

