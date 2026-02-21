# Code example from 'SAIGEgds' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------------------------------------
options(width=110)

## ----message=FALSE------------------------------------------------------------------------------------------
library(SeqArray)
library(SAIGEgds)

# the genotype file in SeqArray GDS format (1000 Genomes Phase1, chromosome 22)
(geno_fn <- seqExampleFileName("KG_Phase1"))

## -----------------------------------------------------------------------------------------------------------
# open a SeqArray file in the package (1000 Genomes Phase1, chromosome 22)
gds <- seqOpen(geno_fn)

## -----------------------------------------------------------------------------------------------------------
library(SNPRelate)

set.seed(1000)
snpset <- snpgdsLDpruning(gds)
str(snpset)

snpset.id <- unlist(snpset, use.names=FALSE)  # get the variant IDs of a LD-pruned set
head(snpset.id)

## -----------------------------------------------------------------------------------------------------------
grm_fn <- "grm_geno.gds"
seqSetFilter(gds, variant.id=snpset.id)

# export to a GDS genotype file without annotation data
seqExport(gds, grm_fn, info.var=character(), fmt.var=character(), samp.var=character())

## -----------------------------------------------------------------------------------------------------------
# close the file
seqClose(gds)

## -----------------------------------------------------------------------------------------------------------
set.seed(1000)
sampid <- seqGetData(grm_fn, "sample.id")  # sample IDs in the genotype file

pheno <- data.frame(
    sample.id = sampid,
    y  = sample(c(0, 1), length(sampid), replace=TRUE, prob=c(0.95, 0.05)),
    x1 = rnorm(length(sampid)),
    x2 = rnorm(length(sampid)),
    stringsAsFactors = FALSE)
head(pheno)

grm_fn

## ----echo=FALSE---------------------------------------------------------------------------------------------
glmm <- readRDS(system.file("extdata", "v_glmm.rds", package="SAIGEgds"))

## -----------------------------------------------------------------------------------------------------------
# genetic variants stored in the file geno_fn
geno_fn
# calculate, using 2 processes
assoc <- seqAssocGLMM_SPA(geno_fn, glmm, mac=10, parallel=2)

head(assoc)

# filtering based on p-value
assoc[assoc$pval < 5e-4, ]

## -----------------------------------------------------------------------------------------------------------
# save to 'assoc.gds'
seqAssocGLMM_SPA(geno_fn, glmm, mac=10, parallel=2, res.savefn="assoc.gds")

## -----------------------------------------------------------------------------------------------------------
# open the GDS file
(f <- openfn.gds("assoc.gds"))
# get p-values
pval <- read.gdsn(index.gdsn(f, "pval"))
summary(pval)
closefn.gds(f)

## -----------------------------------------------------------------------------------------------------------
res <- seqSAIGE_LoadPval("assoc.gds")
head(res)

## ----fig.width=6, fig.height=3, fig.align='center'----------------------------------------------------------
library(ggmanh)

g <- manhattan_plot(assoc, pval.colname="pval", chr.colname="chr",
    pos.colname="pos", x.label="Chromosome 22")
g

## ----fig.width=3, fig.height=3, fig.align='center'----------------------------------------------------------
# QQ plot
qqunif(assoc$pval)

## -----------------------------------------------------------------------------------------------------------
sessionInfo()

## ----echo=FALSE---------------------------------------------------------------------------------------------
unlink(c("grm_geno.gds", "assoc.gds"), force=TRUE)

