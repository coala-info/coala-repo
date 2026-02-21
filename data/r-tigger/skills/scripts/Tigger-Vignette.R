# Code example from 'Tigger-Vignette' vignette. See references/ for full tutorial.

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# Load packages required for this example
library(tigger)
library(dplyr)

## ----eval=TRUE, warning=FALSE-------------------------------------------------
# Detect novel alleles
novel <- findNovelAlleles(AIRRDb, SampleGermlineIGHV, nproc=1)

## ----eval=TRUE, warning=FALSE-------------------------------------------------
# Extract and view the rows that contain successful novel allele calls
novel_rows <- selectNovel(novel)

## ----eval=TRUE, warning=FALSE, fig.width=6, fig.height=8----------------------
# Plot evidence of the first (and only) novel allele from the example data
novel_row <- which(!is.na(novel$polymorphism_call))[1]
plotNovel(AIRRDb, novel[novel_row, ])

## ----eval=TRUE, warning=FALSE, fig.width=4, fig.height=3----------------------
# Infer the individual's genotype, using only unmutated sequences and checking
# for the use of the novel alleles inferred in the earlier step.
geno <- inferGenotype(AIRRDb, germline_db=SampleGermlineIGHV, novel=novel,
                      find_unmutated=TRUE)
# Save the genotype sequences to a vector
genotype_db <- genotypeFasta(geno, SampleGermlineIGHV, novel)
# Visualize the genotype and sequence counts
print(geno)
# Make a colorful visualization. Bars indicate presence, not proportion.
plotGenotype(geno, text_size = 10)

## ----eval=TRUE, warning=FALSE, fig.width=4, fig.height=3----------------------
# Infer the individual's genotype, using the bayesian method
geno_bayesian <- inferGenotypeBayesian(AIRRDb, germline_db=SampleGermlineIGHV, 
                                       novel=novel, find_unmutated=TRUE)
# Visualize the genotype and sequence counts
print(geno_bayesian)
# Make a colorful visualization. Bars indicate presence, not proportion.
plotGenotype(geno_bayesian, text_size=10)

## ----eval=TRUE, warning=FALSE-------------------------------------------------
# Use the personlized genotype to determine corrected allele assignments
# Updated genotype will be placed in the v_call_genotyped column
sample_db <- reassignAlleles(AIRRDb, genotype_db)

## ----eval=TRUE, warning=FALSE-------------------------------------------------
# Find the set of alleles in the original calls that were not in the genotype
not_in_genotype <- sample_db$v_call %>%
    strsplit(",") %>%
    unlist() %>%
    unique() %>%
    setdiff(names(genotype_db))

# Determine the fraction of calls that were ambigious before/after correction
# and the fraction that contained original calls to non-genotype alleles. Note
# that by design, only genotype alleles are allowed in "after" calls.
data.frame(Ambiguous=c(mean(grepl(",", sample_db$v_call)),
                       mean(grepl(",", sample_db$v_call_genotyped))),
           NotInGenotype=c(mean(sample_db$v_call %in% not_in_genotype),
                           mean(sample_db$v_call_genotyped %in% not_in_genotype)),
           row.names=c("Before", "After")) %>% 
    t() %>% round(3)

## ----eval=TRUE, warning=FALSE-------------------------------------------------
evidence <- generateEvidence(sample_db, novel, geno, genotype_db, SampleGermlineIGHV, fields = NULL)

evidence %>%
  select(gene, allele, polymorphism_call, sequences, unmutated_frequency)

