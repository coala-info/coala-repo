---
name: bioconductor-simffpe
description: "bioconductor-simffpe simulates NGS reads for FFPE samples by incorporating artificial chimeric reads and normal reads to mimic formalin-fixation artifacts. Use when user asks to simulate FFPE-specific sequencing artifacts, generate synthetic datasets with artificial chimeric reads, or estimate Phred score profiles from BAM files."
homepage: https://bioconductor.org/packages/release/bioc/html/SimFFPE.html
---


# bioconductor-simffpe

name: bioconductor-simffpe
description: Simulate NGS reads for FFPE (Formalin-Fixed Paraffin-Embedded) samples, including artificial chimeric reads (ACRs) and normal reads. Use this skill to generate synthetic datasets that mimic FFPE-specific artifacts like chimeric reads derived from single-stranded DNA fragments, which often lead to false-positive structural variant calls.

## Overview

SimFFPE is designed to simulate the unique sequencing artifacts found in FFPE samples. These artifacts, primarily artificial chimeric reads (ACRs), result from the combination of two single-stranded DNA (ss-DNA) fragments with short reverse complementary regions (SRCR). The package allows for fine-tuned simulation of whole genomes, specific chromosomes, or targeted regions (exomes/panels) with support for both enzymatic and random fragmentation.

## Typical Workflow

### 1. Prepare Input Data
The simulation requires a reference genome (as a `DNAStringSet`) and a Phred score profile.

```r
library(SimFFPE)
library(Biostrings)

# Load reference genome
ref_path <- system.file("extdata", "example.fasta", package = "SimFFPE")
reference <- readDNAStringSet(ref_path)

# Define target regions (optional, for targeted sequencing)
region_path <- system.file("extdata", "regionsSim.txt", package = "SimFFPE")
target_regions <- read.table(region_path)
```

### 2. Generate Phred Score Profile
You can estimate the Phred score profile from an existing BAM file to match the error characteristics of your specific sequencing platform.

```r
# Calculate profile from a BAM file
bam_path <- system.file("extdata", "example.bam", package = "SimFFPE")
phred_profile <- calcPhredScoreProfile(bam_path, targetRegions = target_regions)
```

### 3. Run Simulation
There are two primary functions depending on the scale of the simulation:

**For Whole Genome or Large Regions:**
Use `readSimFFPE()`. This function is optimized for simulating reads across entire chromosomes or large genomic segments.

```r
out_prefix <- file.path(tempdir(), "wgs_sim")
readSimFFPE(reference[1:3], ref_path, phred_profile, out_prefix,
            coverage = 80, 
            readLen = 150, 
            enzymeCut = TRUE, 
            threads = 2)
```

**For Targeted Regions (Exome/Panels):**
Use `targetReadSimFFPE()`. This function is designed for specific coordinates.

```r
out_prefix_target <- file.path(tempdir(), "target_sim")
targetReadSimFFPE(ref_path, phred_profile, target_regions, out_prefix_target,
                  coverage = 120, 
                  readLen = 100, 
                  meanInsertLen = 180,
                  enzymeCut = FALSE)
```

## Fine-Tuning Parameters

Adjust these parameters to control the "FFPE-ness" of the simulated data:

*   `chimericProp`: The proportion of artificial chimeric fragments (0 to 1). Higher values increase the number of improper pairs and soft-clipped reads.
*   `enzymeCut`: Set to `TRUE` to simulate enzymatic fragmentation (where chimeric pairs may map to identical locations) or `FALSE` for random fragmentation.
*   `sameChrProp`: Controls the ratio of intra-chromosomal vs. inter-chromosomal chimeras.
*   `adjChimProp`: Controls the proportion of chimeras derived from adjacent genomic regions versus distant ones.
*   `sameStrandProb`: Adjusts the orientation of adjacent chimeras (RR, LL, or RL).
*   `highNoiseRate` & `highNoiseProb`: Simulate specific "noisy" reads with higher base error rates.

## Reference documentation

- [An Introduction to SimFFPE](./references/SimFFPE.md)