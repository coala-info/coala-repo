# Code example from 'rTANDEM' vignette. See references/ for full tutorial.

### R code from vignette source 'rTANDEM.Rnw'

###################################################
### code chunk number 1: Loading Rtandem
###################################################
library(rTANDEM)


###################################################
### code chunk number 2: Building rTTaxo
###################################################
taxonomy <- rTTaxo(
  taxon="yeast",
  format="peptide", 
  URL=system.file("extdata/fasta/scd.fasta.pro", package="rTANDEM")
)
taxonomy


###################################################
### code chunk number 3: Building rTParam
###################################################
param <- rTParam()
param <- setParamValue(param, 'protein', 'taxon', value="yeast")
param <- setParamValue(param, 'list path', 'taxonomy information', taxonomy)
param <- setParamValue(param, 'list path', 'default parameters',
  value=system.file("extdata/default_input.xml", package="rTANDEM"))
param <- setParamValue(param, 'spectrum', 'path',
  value=system.file("extdata/test_spectra.mgf", package="rTANDEM"))
param <- setParamValue(param, 'output', 'xsl path',
  value=system.file("extdata/tandem-input-style.xsl", package="rTANDEM"))
param <- setParamValue(param, 'output', 'path',
  value=paste(getwd(), "output.xml", sep="/"))


###################################################
### code chunk number 4: Launching rTANDEM
###################################################
result.path <- tandem(param)
result.path


###################################################
### code chunk number 5: Loading results in R
###################################################
result.R <- GetResultsFromXML(result.path)


###################################################
### code chunk number 6: Getting the proteins
###################################################
proteins <- GetProteins(result.R, log.expect=-1.3, min.peptides=2)
proteins[, c(-4,-5), with=FALSE]  # columns were removed for better display


###################################################
### code chunk number 7: Answering common questions
###################################################
# How many proteins have been identified with appropriate confidence?
length(proteins[['uid']])
# What are the top 5 proteins identified?
proteins[1:5, c("label", "expect.value"), with=FALSE]
# Were proteins YFR053C or P02267 identified in the sample?
c("YFR053C", "P02267") %in% proteins[,"label", with=FALSE][[1]]


###################################################
### code chunk number 8: Exploring peptides
###################################################
peptides <- GetPeptides(
  protein.uid=subset(proteins, label=="YFR053C", uid)[[1]], 
  results    =result.R, 
  expect     =0.05
  )
peptides


###################################################
### code chunk number 9: Exploring degeneracy
###################################################
proteins.of.the.peptide <- GetDegeneracy(peptides[[1,"pep.id"]], result.R)
proteins.of.the.peptide[,label]  
# Careful! This peptide belongs to 2 different proteins! It should not be 
# used for quantification, for MRM or as a biomarker.


###################################################
### code chunk number 10: Change display
###################################################
options("width"=70)


###################################################
### code chunk number 11: Using biomaRt (eval = FALSE)
###################################################
## library(biomaRt)
## ensembl.mart<- useMart(biomart="ensembl", dataset="scerevisiae_gene_ensembl")
## str(getBM(mart=ensembl.mart, filters="ensembl_peptide_id", values="YFR053C", 
##           attributes="description"), 
##     strict.width="wrap", nchar.max=500) 
## getBM(mart=ensembl.mart, filters="ensembl_peptide_id", values="YFR053C", 
##       attributes=c("ensembl_peptide_id", "uniprotswissprot"))
## getBM(mart=ensembl.mart, filters="ensembl_peptide_id", values="YFR053C", 
##       attributes=c("go_id", "name_1006"))


