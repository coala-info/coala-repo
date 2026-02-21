# Code example from 'Usage' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ZygosityPredictor")

## -----------------------------------------------------------------------------
library(ZygosityPredictor)
library(dplyr)
library(stringr)
library(GenomicRanges)

# file to sequence alignment 
FILE_BAM <- system.file("extdata", "ZP_example.bam", 
                        package = "ZygosityPredictor")
VCF <- system.file("extdata", "ZP_example_chr7.vcf.gz", 
                        package = "ZygosityPredictor")
# meta information of the sample
PURITY <- 0.98
PLOIDY <- 1.57
SEX <- "female"
# variants
data("GR_SCNA")
data("GR_GERM_SMALL_VARS")
data("GR_SOM_SMALL_VARS")
# used gene model
data("GR_GENE_MODEL")
data("GR_HAPLOBLOCKS")


## -----------------------------------------------------------------------------
## as an example we take the first variant of our prepared input data and 
## extract the required information from different input data layer
## the allele frequency and the chromosome can be taken from the GRanges object

AF = elementMetadata(GR_GERM_SMALL_VARS[1])[["af"]]
CHR = seqnames(GR_GERM_SMALL_VARS[1]) %>%
  as.character()

## the total copy number (tcn) can be extracted from the CNV object by selecting
## the CNV from the position of the variant

TCN = elementMetadata(
  subsetByOverlaps(GR_SCNA, GR_GERM_SMALL_VARS[1])
  )[["tcn"]]

## purity and sex can be taken from the global variables of the sample
## with this function call the affected copies are calculated for the variant
aff_germ_copies(af=AF,
                tcn=TCN,
                purity=PURITY,
                chr=CHR,
                sex=SEX)

## -----------------------------------------------------------------------------
## the function for somatic variants works the same way as the germline function

AF = elementMetadata(GR_SOM_SMALL_VARS[1])[["af"]]
CHR = seqnames(GR_SOM_SMALL_VARS[1]) %>%
  as.character()
TCN = elementMetadata(
  subsetByOverlaps(GR_SCNA, GR_SOM_SMALL_VARS[1])
  )[["tcn"]]

aff_som_copies(af=AF,
               chr=CHR,
               tcn=TCN,
               purity=PURITY,
               sex=SEX)

## -----------------------------------------------------------------------------
## as an example we calculate the affected copies for the somatic variants:
GR_SOM_SMALL_VARS %>%
  ## cnv information for every variant is required.. merge with cnv object
  IRanges::mergeByOverlaps(GR_SCNA) %>% 
  as_tibble() %>%
  ## select relevant columns
  select(chr=1, pos=2, gene, af, tcn) %>%
  mutate_at(.vars=c("tcn", "af"), .funs=as.numeric) %>%
  rowwise() %>%
  mutate(
    aff_copies = aff_som_copies(chr, af, tcn, PURITY, SEX),
    wt_copies = tcn-aff_copies
  )

## -----------------------------------------------------------------------------
predict_per_variant(purity=PURITY, 
                    sex=SEX,
                    somCna=GR_SCNA,
                    somSmallVars=GR_SOM_SMALL_VARS)


## ----results = FALSE----------------------------------------------------------
fp <- predict_zygosity(
  purity = PURITY, 
  ploidy = PLOIDY,
  sex = SEX,
  somCna = GR_SCNA, 
  somSmallVars = GR_SOM_SMALL_VARS, 
  germSmallVars = GR_GERM_SMALL_VARS, 
  geneModel = GR_GENE_MODEL,
  bamDna = FILE_BAM,
  vcf=VCF,
  haploBlocks = GR_HAPLOBLOCKS
)

## -----------------------------------------------------------------------------
ZP_ov(fp)

## -----------------------------------------------------------------------------
gene_ov(fp, OR2J1)

## -----------------------------------------------------------------------------
sessionInfo()

