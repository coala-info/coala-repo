# Code example from 'methcp' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache = FALSE)

## ---- message=FALSE-----------------------------------------------------------
library(bsseq)
library(MethCP)

## ----readData-----------------------------------------------------------------
# The dataset is consist of 6 samples. 3 samples are H2A.Z mutant 
# plants, and 3 samples are controls.
sample_names <- c(
    paste0("control", seq_len(3)), 
    paste0("treatment", seq_len(3))
)

# Get the vector of file path and names 
raw_files <- system.file(
    "extdata", paste0(sample_names, ".txt"), package = "MethCP")

# load the data
bs_object <- createBsseqObject(
    files = raw_files, sample_names = sample_names, 
    chr_col = 'Chr', pos_col = 'Pos', m_col = "M", cov_col = 'Cov')

## ----showBSobject-------------------------------------------------------------
bs_object

## -----------------------------------------------------------------------------
dt <- read.table(
            raw_files[1], stringsAsFactors = FALSE, header = TRUE)
head(dt)

## ----calcStat-----------------------------------------------------------------
# the sample names of the two groups to compare. They should be subsets of the 
# sample names provided when creating the `bsseq` objects.
group1 <- paste0("control", seq_len(3))
group2 <- paste0("treatment", seq_len(3))

# Below we calculate the per-cytosine statistics using two different 
# test `DSS` and `methylKit`. The users may pick one of the two for their
#  application.
obj_DSS <- calcLociStat(bs_object, group1, group2, test = "DSS")
obj_methylKit <- calcLociStat(
    bs_object, group1, group2, test = "methylKit")

## ----obj_DSS------------------------------------------------------------------
obj_DSS

## ----obj_methylKit------------------------------------------------------------
obj_methylKit

## ----createmethcp-------------------------------------------------------------
data <- data.frame(
    chr = rep("Chr01", 5),
    pos = c(2, 5, 9, 10, 18),
    effect.size = c(1,-1, NA, 9, Inf),
    pvals = c(0, 0.1, 0.9, NA, 0.02))
obj <- MethCPFromStat(
    data, test.name="myTest",
    pvals.field = "pvals",
    effect.size.field="effect.size",
    seqnames.field="chr",
    pos.field="pos"
)

## -----------------------------------------------------------------------------
obj

## ----segmentation-------------------------------------------------------------
obj_DSS <- segmentMethCP(
    obj_DSS, bs_object, region.test = "weighted-coverage")

obj_methylKit <- segmentMethCP(
    obj_methylKit, bs_object, region.test = "fisher")

## -----------------------------------------------------------------------------
obj_DSS

## -----------------------------------------------------------------------------
obj_methylKit

## -----------------------------------------------------------------------------
region_DSS <- getSigRegion(obj_DSS)
head(region_DSS)

## -----------------------------------------------------------------------------
region_methylKit <- getSigRegion(obj_methylKit)
head(region_methylKit)

## -----------------------------------------------------------------------------
meta_file <- system.file(
    "extdata", "meta_data.txt", package = "MethCP")
meta <- read.table(meta_file, sep = "\t", header = TRUE)

head(meta)

## -----------------------------------------------------------------------------
# Get the vector of file path and names 
raw_files <- system.file(
    "extdata", paste0(meta$SampleName, ".tsv"), package = "MethCP")

# read files
bs_object <- createBsseqObject(
    files = raw_files, sample_names = meta$SampleName, 
    chr_col = 1, pos_col = 2, m_col = 4, cov_col = 5, header = TRUE)

## -----------------------------------------------------------------------------
groups <- split(seq_len(nrow(meta)), meta$Condition)
coverages <- as.data.frame(getCoverage(bs_object, type = "Cov"))
filter <- rowSums(coverages[, meta$SampleName[groups[[1]]]] != 0) >= 3 &
    rowSums(coverages[, meta$SampleName[groups[[2]]]] != 0) >= 3
bs_object <- bs_object[filter, ]

## -----------------------------------------------------------------------------
obj <- calcLociStatTimeCourse(bs_object, meta)

## -----------------------------------------------------------------------------
obj

## -----------------------------------------------------------------------------
obj <- segmentMethCP(obj, bs_object, region.test = "stouffer")

## -----------------------------------------------------------------------------
regions <- getSigRegion(obj)

## -----------------------------------------------------------------------------
head(regions)

## -----------------------------------------------------------------------------
sessionInfo() 

