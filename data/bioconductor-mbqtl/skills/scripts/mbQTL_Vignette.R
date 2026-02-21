# Code example from 'mbQTL_Vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----setup--------------------------------------------------------------------
knitr::opts_chunk$set(
  dpi = 300,
  warning = FALSE,
  collapse = TRUE,
  error = FALSE,
  comment = "#>",
  echo = TRUE
)
library(mbQTL)
library(tidyr)

data("SnpFile")
data("microbeAbund")
data("CovFile")
data("metagenomeSeqObj")

doctype <- knitr::opts_knit$get("rmarkdown.pandoc.to")

## -----------------------------------------------------------------------------
sessionInfo()

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
# microbial count file
# microbeAbund
# SNP file
# SnpFile
# Covariance file
# CovFile

#Check out file formats compatible with mbQTL files.

#head(microbeAbund)
#head(SnpFile)
#head(CovFile)

metagenomeSeqObj


## ----eval=TRUE, echo=TRUE-----------------------------------------------------
compatible_metagenome_seq <- metagenomeSeqToMbqtl(metagenomeSeqObj,
  norm = TRUE, log = TRUE,
  aggregate_taxa = "Genus"
)

# Check for the class of compatible_metagenome_seq

class(compatible_metagenome_seq)


## ----eval=TRUE, echo=TRUE-----------------------------------------------------

# perform linear regression analysis between taxa and snps across 
# samples and produce a data frame of results.(covariate file is
# optional but highly recommended to avoid results which might be
# prone to batch effects and obtaining optimal biological relevance
# for finding snp - taxa relationships.) 

LinearAnalysisTaxaSNP <- linearTaxaSnp(microbeAbund,
  SnpFile,
  Covariate = CovFile
)

## ----eval=TRUE, echo=TRUE, fig.width = 4, fig.height=4, out.width="90%", dpi=300, fig.align="center"----

# Create a histogram of P values across all snp - taxa
# linear regression estimations

histPvalueLm(LinearAnalysisTaxaSNP)


# Create a QQPlot of expected versus estimated P value for all all
# snp - taxa linear regression estimations

qqPlotLm(microbeAbund, SnpFile, Covariate = CovFile)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------

# Estimate taxa SNP - taxa correlation R and estimate R2
# (To what extent variance in one taxa explains the
# variance in snp)

# First estimate R value for all SNP-Taxa relationships

correlationMicrobes <- coringTaxa(microbeAbund)

# Estimate the correlation value (R2) between a specific snp and all taxa.

one_rs_id <- allToAllProduct(SnpFile, microbeAbund, "chr1.171282963_T")

# Estimate the correlation value (R2) between all snps and all taxa.

for_all_rsids <- allToAllProduct(SnpFile, microbeAbund)

# Estimate rho value for all snps and all taxa present in the dataset.

taxa_SNP_Cor <- taxaSnpCor(for_all_rsids, correlationMicrobes)

# Estimate rho value for all snps and all taxa present in the
# dataset and pick the highest and lowest p values in the
# dataset to identify improtant SNP-Taxa relationships.

taxa_SNP_Cor_lim <- taxaSnpCor(for_all_rsids,
  correlationMicrobes,
  probs = c(0.0001, 0.9999)
)

## ----eval=TRUE, echo=TRUE, fig.width = 9, fig.height=5, out.width="90%", dpi=300, fig.align="center"----

## Draw heatmap of rho estimates "taxa_SNP_Cor_lim" is the
# output of taxaSnpCor().
# One can use other pheatmap() settings for extra annotation

mbQtlCorHeatmap(taxa_SNP_Cor_lim,
  fontsize_col = 5,
  fontsize_row = 7
)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------

# perform Logistic regression analysis between taxa and snps 
# across samples microbeAbund is the microbe abundance file
# (a dateframe with rownames as taxa and colnames and sample
# names) and SnpFile is the snp file (0,1,2) values
# (rownames as snps and colnames as samples)

log_link_resA <- logRegSnpsTaxa(microbeAbund, SnpFile)

# Perform Logistic regression for specific microbe

log_link_resB <- logRegSnpsTaxa(microbeAbund, SnpFile,
  selectmicrobe = c("Haemophilus")
)

## ----eval=TRUE, echo=TRUE, fig.width = 5, fig.height=2, out.width="90%", dpi=300, fig.align="center"----

# Create a barplot with the specific rsID, and microbe of interest,
# including the genotype information for the reference versus 
# alternate versus hetrozygous alleles and and presence absence
# of microbe of interest. Note your reference, alternative and
# heterozygous genotype values need to match the genotype of
# your SNP of interest this information can be obtained
# from snpdb data base or GATK/plink files.

Logit_plot <- logitPlotSnpTaxa(microbeAbund, SnpFile,
  selectmicrobe = "Neisseria",
  rsID = "chr2.241072116_A", ref = "GG", alt = "AA", het = "AG"
)

Logit_plot

