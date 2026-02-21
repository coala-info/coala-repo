# Code example from 'pcair' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, message = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# geno <- MatrixGenotypeReader(genotype = genotype, snpID = snpID,
#                              chromosome = chromosome, position = position,
#                              scanID = scanID)
# genoData <- GenotypeData(geno)

## ----eval=FALSE---------------------------------------------------------------
# geno <- GdsGenotypeReader(filename = "genotype.gds")
# genoData <- GenotypeData(geno)

## ----eval=FALSE---------------------------------------------------------------
# snpgdsBED2GDS(bed.fn = "genotype.bed",
#               bim.fn = "genotype.bim",
#               fam.fn = "genotype.fam",
#               out.gdsfn = "genotype.gds")

## -----------------------------------------------------------------------------
gdsfile <- system.file("extdata", "HapMap_ASW_MXL_geno.gds", package="GENESIS")

## ----seed, include=FALSE------------------------------------------------------
# set seed for LD pruning
set.seed(100)

## -----------------------------------------------------------------------------
library(SNPRelate)
# read in GDS data
gds <- snpgdsOpen(gdsfile)
snpset <- snpgdsLDpruning(gds, method="corr", slide.max.bp=10e6, 
                          ld.threshold=sqrt(0.1), verbose=FALSE)
pruned <- unlist(snpset, use.names=FALSE)
length(pruned)
head(pruned)
snpgdsClose(gds)

## -----------------------------------------------------------------------------
# create matrix of KING estimates
library(GENESIS)
KINGmat <- kingToMatrix(
    c(system.file("extdata", "MXL_ASW.kin0", package="GENESIS"),
      system.file("extdata", "MXL_ASW.kin", package="GENESIS")),
      estimator = "Kinship")
KINGmat[1:5,1:5]

## -----------------------------------------------------------------------------
library(GWASTools)
HapMap_geno <- GdsGenotypeReader(filename = gdsfile)
# create a GenotypeData class object
HapMap_genoData <- GenotypeData(HapMap_geno)
HapMap_genoData

## -----------------------------------------------------------------------------
# run PC-AiR on pruned SNPs
mypcair <- pcair(HapMap_genoData, kinobj = KINGmat, divobj = KINGmat,
                 snp.include = pruned)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# #kinobj and divobj are now required arguments
# # As PCA is an unsupervised method, it is often difficult to identify what population structure each of the top PCs represents.  In order to provide some understanding of the inferred structure, it is sometimes recommended to include reference population samples of known ancestry in the analysis.  If the data set contains such reference population samples, we may want to use only those individuals as the "unrelated subset" for performing the PCA and predict values for all other sample individuals.  This can be accomplished by setting the input `unrel.set` equal to a vector, `IDs`, of the individual IDs for the reference population samples.
# mypcair <- pcair(HapMap_genoData, unrel.set = IDs)

## ----eval=FALSE---------------------------------------------------------------
# mypcair <- pcair(HapMap_genoData, kinobj = KINGmat, divobj = KINGmat,
#                  snp.include = pruned, unrel.set = IDs)

## -----------------------------------------------------------------------------
part <- pcairPartition(kinobj = KINGmat, divobj = KINGmat)

## -----------------------------------------------------------------------------
head(part$unrels); head(part$rels)

## -----------------------------------------------------------------------------
summary(mypcair)

## ----fig.show='hold', fig.small=TRUE------------------------------------------
# plot top 2 PCs
plot(mypcair)
# plot PCs 3 and 4
plot(mypcair, vx = 3, vy = 4)

## -----------------------------------------------------------------------------
# run PC-Relate
HapMap_genoData <- GenotypeBlockIterator(HapMap_genoData, snpInclude=pruned)
mypcrelate <- pcrelate(HapMap_genoData, pcs = mypcair$vectors[,1:2], 
                       training.set = mypcair$unrels,
			 	       BPPARAM = BiocParallel::SerialParam())

## -----------------------------------------------------------------------------
plot(mypcrelate$kinBtwn$k0, mypcrelate$kinBtwn$kin, xlab="k0", ylab="kinship")

## -----------------------------------------------------------------------------
iids <- as.character(getScanID(HapMap_genoData))
pcrelateToMatrix(mypcrelate, sample.include = iids[1:5], thresh = 2^(-11/2), scaleKin = 2)

## ----echo=FALSE---------------------------------------------------------------
close(HapMap_genoData)

