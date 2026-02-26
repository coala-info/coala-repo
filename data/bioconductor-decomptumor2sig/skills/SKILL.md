---
name: bioconductor-decomptumor2sig
description: This tool decomposes tumor genomes into mutational signatures using quadratic programming to estimate signature contributions. Use when user asks to decompose somatic mutation profiles, perform signature refitting, or determine the exposure of Alexandrov and Shiraishi-type signatures in tumor samples.
homepage: https://bioconductor.org/packages/release/bioc/html/decompTumor2Sig.html
---


# bioconductor-decomptumor2sig

name: bioconductor-decomptumor2sig
description: Decompose tumor genomes into mutational signatures (signature refitting) using quadratic programming. Use this skill to analyze somatic single nucleotide variants (SNVs) from VCF, MPF, or VRanges objects, and determine the contribution of Alexandrov (COSMIC) or Shiraishi-type signatures.

# bioconductor-decomptumor2sig

## Overview
The `decompTumor2Sig` package is designed for "signature refitting"—the process of estimating the contribution (exposure) of known mutational signatures to the somatic mutation profile of an individual tumor. It supports both the high-resolution Alexandrov-type (e.g., COSMIC 96-trinucleotide) and the more parsimonious Shiraishi-type signatures. The package uses quadratic programming to find the optimal non-negative weights that explain the observed mutation distribution.

## Core Workflow

### 1. Load Mutational Signatures
Signatures can be loaded from COSMIC, local files, or converted between types.

```r
library(decompTumor2Sig)

# Load COSMIC v2 signatures (Alexandrov-type)
alex_sigs <- readAlexandrovSignatures()

# Load Shiraishi-type signatures from flat files
sig_files <- system.file("extdata", 
                         paste0("Nik-Zainal_PMID_22608084-pmsignature-sig", 1:4, ".tsv"), 
                         package="decompTumor2Sig")
shi_sigs <- readShiraishiSignatures(files=sig_files)

# Convert Alexandrov to Shiraishi (note: information loss occurs)
converted_sigs <- convertAlexandrov2Shiraishi(alex_sigs)
```

### 2. Prepare Tumor Genome Data
Mutation data must be preprocessed into frequency distributions matching the signature format (e.g., same number of flanking bases and transcription strand settings).

```r
library(BSgenome.Hsapiens.UCSC.hg19)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

refGenome <- BSgenome.Hsapiens.UCSC.hg19
transcriptAnno <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Read from VCF
vcf_file <- system.file("extdata", "Nik-Zainal_PMID_22608084-VCF-convertedfromMPF.vcf.gz", 
                        package="decompTumor2Sig")
genomes <- readGenomesFromVCF(vcf_file, 
                              numBases=5, 
                              type="Shiraishi", 
                              trDir=TRUE, 
                              refGenome=refGenome, 
                              transcriptAnno=transcriptAnno)
```

### 3. Signature Decomposition (Refitting)
Determine the contribution of each signature to the tumor profile.

```r
# Basic decomposition using all signatures in the set
exposures <- decomposeTumorGenomes(genomes, shi_sigs)

# Decomposition with a minimum explained variance threshold (greedy search)
exposures_sub <- decomposeTumorGenomes(genomes, 
                                       shi_sigs, 
                                       minExplainedVariance=0.9, 
                                       greedySearch=TRUE)
```

### 4. Visualization and Evaluation
Assess the quality of the fit and visualize the results.

```r
# Plot the mutation distribution of a signature or genome
plotMutationDistribution(shi_sigs[[1]])

# Plot the calculated exposures
plotDecomposedContribution(exposures[[1]])

# Evaluate fit quality (Explained Variance and Pearson Correlation)
evaluateDecompositionQuality(exposures[[1]], shi_sigs, genomes[[1]], plot=TRUE)
```

## Advanced Features

### Signature Adjustment
If signatures were derived from the whole genome but your data is from Exome sequencing (WES) or a specific panel, adjust the signatures to account for different background nucleotide frequencies.

```r
# Adjust signatures for a specific target region (e.g., promoters or exome)
adjusted_sigs <- adjustSignaturesForRegionSet(alex_sigs, 
                                              regionsTarget=my_granges_object, 
                                              refGenome=refGenome)
```

### Comparing Signature Sets
Map one set of signatures to another (e.g., mapping de novo signatures to COSMIC).

```r
# Find the best matches between two signature sets
mapping <- mapSignatureSets(fromSignatures=set_A, 
                            toSignatures=set_B, 
                            method="frobenius", 
                            unique=TRUE)
```

## Implementation Tips
- **Mutation Count**: For reliable results, tumor samples should ideally have 100+ SNVs.
- **Consistency**: Ensure `numBases`, `type`, and `trDir` parameters are identical when reading both signatures and genomes.
- **Transcription Strand**: If `trDir=TRUE`, mutations in regions with ambiguous (overlapping/opposing) transcription directions are excluded by default (`enforceUniqueTrDir=TRUE`).
- **Greedy Search**: Use `greedySearch=TRUE` in `decomposeTumorGenomes` when dealing with large signature sets to improve performance, though it may find a local optimum.

## Reference documentation
- [A brief introduction to decompTumor2Sig](./references/decompTumor2Sig.Rmd)
- [decompTumor2Sig Vignette](./references/decompTumor2Sig.md)