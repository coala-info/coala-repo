# Code example from 'SynMut' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, message = FALSE----------------------------------------------
url <- paste0("https://raw.githubusercontent.com/Koohoko/Koohoko.github.io/",
  "master/SynMut/images/component.png")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# if (!requireNamespace("SynMut"))
#     BiocManager::install("SynMut")

## ----message=FALSE------------------------------------------------------------
library("SynMut")
filepath.fasta <- system.file("extdata", "example.fasta", package = "SynMut")
filepath.csv <- system.file("extdata", "target_regions.csv", package = "SynMut")
region <- read.csv(filepath.csv)

## -----------------------------------------------------------------------------
rgd.seq <- input_seq(filepath.fasta, region)
rgd.seq

## -----------------------------------------------------------------------------
get_dna(rgd.seq)

## -----------------------------------------------------------------------------
str(get_region(rgd.seq))
get_region(input_seq(filepath.fasta))

## -----------------------------------------------------------------------------
get_cu(rgd.seq)
get_du(rgd.seq)
get_nu(rgd.seq)

## -----------------------------------------------------------------------------
# Random synonymous mutations
mut.seq <- codon_random(rgd.seq)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)

# Keeping the original codon usage pattern
mut.seq <- codon_random(rgd.seq, keep = TRUE)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)

## -----------------------------------------------------------------------------
# Fifty percent of the codons were allowed for mutation
mut.seq <- codon_random(rgd.seq, n = 0.5)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)

## -----------------------------------------------------------------------------
# Generate AAC-maximized mutations
mut.seq <- codon_to(rgd.seq, max.codon = "AAC")
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)

# Generate AAC-minimized mutations
mut.seq <- codon_to(rgd.seq, min.codon = "AAC")
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)

## -----------------------------------------------------------------------------
# Maximaize the usage of "CG" dinucleotide in the pre-defined region
mut.seq <- dinu_to(rgd.seq, max.dinu = "cg")
# Check the dinucelotide usage difference between the mutant and the original
get_du(mut.seq) - get_du(rgd.seq)

# Minimize the usage of "CA", and compare the dinucleotide usage.
mut.seq <- dinu_to(rgd.seq, min.dinu = "CA")
get_du(mut.seq) - get_du(rgd.seq)

# Maximize the usage of "CG" while keeping the original codon usage
mut.seq <- dinu_to(rgd.seq, max.dinu = "cg", keep = TRUE)
# Compare the dinucleotide usage
get_du(mut.seq) - get_du(rgd.seq)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)


## -----------------------------------------------------------------------------
# Use a codon usage vector as a target
target <- get_cu(rgd.seq)[2,]
mut.seq <- codon_mimic(rgd.seq, alt = target)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)

# Use a sequence as a target
target <- Biostrings::DNAStringSet("TTGAAAA-CTC-N--AAG")
mut.seq <- codon_mimic(rgd.seq, alt = target)
# Compare the codon usage
get_cu(mut.seq) - get_cu(rgd.seq)
# Compare the synonymous codon usage frequency
get_freq(mut.seq) - get_freq(rgd.seq)
# Compare the Relative Synonymous Codon Usage (RSCU)
get_rscu(mut.seq) - get_rscu(rgd.seq)


## ----eval = FALSE-------------------------------------------------------------
# Biostrings::writeXStringSet(get_dna(rgd.seq), "rgd.fasta")

## -----------------------------------------------------------------------------
sessionInfo()

