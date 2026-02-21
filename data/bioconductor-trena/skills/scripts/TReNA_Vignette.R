# Code example from 'TReNA_Vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----message = FALSE, warning = FALSE------------------------------------
library(trena)

## ------------------------------------------------------------------------
load(system.file(package="trena", "extdata/ampAD.154genes.mef2cTFs.278samples.RData"))

## ----echo=FALSE, fig.width = 6-------------------------------------------
hist(mtx.sub, main = "Expression Matrix Data")

## ----message = FALSE-----------------------------------------------------
mtx.asinh <- asinh(mtx.sub)

## ----echo=FALSE, fig.width = 6-------------------------------------------
hist(mtx.asinh, main = "VOOM-Transformed Expression Matrix Data")

## ------------------------------------------------------------------------
variance.filter <- VarianceFilter(mtx.assay = mtx.asinh, targetGene = "MEF2C", varSize = 0.5)
tf.list <- getCandidates(variance.filter)
str(tf.list)

## ------------------------------------------------------------------------

# Sp
db.address <- system.file(package="trena", "extdata")
genome.db.uri <- paste("sqlite:/",db.address,"mef2c.neighborhood.hg38.gtfAnnotation.db", sep = "/")
project.db.uri <- paste("sqlite:/",db.address,"mef2c.neigborhood.hg38.footprints.db", sep = "/")

# Create the specs for the MEF2C gene region
tss <- 88904257
start <- tss - 1000
end <- tss + 1000
chrom <- "chr5"
gene.regions <- data.frame(chrom=chrom,
                           start=start,
                           end=end,
                           stringsAsFactors = FALSE)

# Create a filter using the geneCenteredSpec option
footprint.filter <- FootprintFilter(genomeDB = genome.db.uri, footprintDB = project.db.uri,
regions = gene.regions)

# Run the getCandidates method
tbl <- getCandidates(footprint.filter)[[1]]
str(tbl)

## ----message = FALSE, warning= FALSE-------------------------------------
library(MotifDb)

tbl.tfs <- associateTranscriptionFactors(MotifDb, tbl, source="MotifDb", expand.rows=TRUE)
str(tbl.tfs)


## ------------------------------------------------------------------------
lasso.solver <- LassoSolver(mtx.assay = mtx.asinh,
                            targetGene = "MEF2C",
                            candidateRegulators = tbl.tfs$geneSymbol
                            )

## ------------------------------------------------------------------------
set.seed(10)
tbl <- run(lasso.solver)
str(tbl)

## ------------------------------------------------------------------------
set.seed(10)
lasso.solver.keep <- LassoSolver(mtx.assay = mtx.asinh,
                                 targetGene = "MEF2C",
                                 candidateRegulators = tbl.tfs$geneSymbol,
                                 keep.metrics = TRUE
                                 )
tbl.keep <- run(lasso.solver.keep)
str(tbl.keep)

## ------------------------------------------------------------------------
lasso.solver.lenient  <- LassoSolver(mtx.assay = mtx.asinh,
                                     targetGene = "MEF2C",
                                     candidateRegulators = tbl.tfs$geneSymbol,
                                     lambda = 0.05
                                     )
tbl.lenient <- run(lasso.solver.lenient)
str(tbl.lenient)

## ------------------------------------------------------------------------
ensemble.solver <- EnsembleSolver(mtx.assay = mtx.asinh, 
                                  targetGene = "MEF2C",
                                  candidateRegulators = tbl.tfs$geneSymbol)
tbl.out <- run(ensemble.solver)
tbl.out

## ------------------------------------------------------------------------
ensemble.full <- EnsembleSolver(mtx.assay = mtx.asinh,
                                targetGene = "MEF2C",
                                candidateRegulators = tbl.tfs$geneSymbol,
                                solverNames = c("lasso","pearson","randomforest","ridge"),
                                geneCutoff = 1
                                )
tbl.full <- run(ensemble.full)
str(tbl.full)

