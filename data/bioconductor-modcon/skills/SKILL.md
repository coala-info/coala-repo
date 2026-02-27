---
name: bioconductor-modcon
description: This tool modifies splice donor context through synonymous codon selection to adjust splice site strength while preserving amino acid sequences. Use when user asks to optimize or silence splice sites, adjust Splice Site HEXplorer Weight, or degrade intrinsic splice site strength in coding sequences.
homepage: https://bioconductor.org/packages/release/bioc/html/ModCon.html
---


# bioconductor-modcon

name: bioconductor-modcon
description: Modifying Splice Donor (SD) context via codon selection to adjust Splice Site HEXplorer Weight (SSHW) while preserving amino acid sequences. Use this skill when you need to optimize or silence splice sites in coding sequences (CDS) for splicing reporters or expression vectors.

# bioconductor-modcon

## Overview

The `ModCon` package allows for the targeted adjustment of the Splice Site HEXplorer Weight (SSHW) of splice donor sites. By utilizing synonymous codon selection, the tool can increase or decrease the likelihood of splice site activation without altering the underlying protein sequence. It employs a sliding window approach for 100% optimization and a genetic algorithm for partial adjustments (e.g., 60% optimization). Additionally, it provides functions to degrade the intrinsic strength of splice sites using HBond or MaxEntScan scores.

## Core Workflow

### 1. Basic SSHW Optimization
The primary function is `ModCon()`. It requires a coding sequence and the 1-based nucleotide position of the first nucleotide of the Splice Donor (SD).

```R
library(ModCon)

# Define CDS
cds <- "ATGGAAGACGCC...[sequence]...TACTTCGAA"

# Increase SSHW (Maximize activation)
cds_high <- ModCon(cds, index = 103, optimizeContext = TRUE)

# Decrease SSHW (Minimize activation/Silence)
cds_low <- ModCon(cds, index = 103, optimizeContext = FALSE)
```

### 2. Partial Optimization (Genetic Algorithm)
To achieve a specific percentage of the maximum possible optimization, use the `optiRate` parameter. Values other than 100 trigger a genetic algorithm.

```R
# Optimize to 60% of maximum
cds_60 <- ModCon(cds, index = 103, optiRate = 60, nCores = 1)

# Advanced Genetic Algorithm parameters
cds_adv <- ModCon(cds, index = 103, 
                  optiRate = 60,
                  nGenerations = 10, 
                  parentSize = 200,
                  mutationRate = 1e-03)
```

### 3. Adjusting Sequence Window
By default, 16 codons upstream and downstream are modified. You can adjust this range:

```R
cds_custom_window <- ModCon(cds, index = 103, 
                            upChangeCodonsIn = 20, 
                            downChangeCodonsIn = 20)
```

### 4. Modifying Intrinsic Site Strength (HBond Score)
To specifically target the intrinsic strength of a donor site (GT site) via codon selection:

```R
# Decrease intrinsic strength
cds_hbond_down <- decreaseGTsiteStrength(cds, index = 103)

# Increase intrinsic strength
cds_hbond_up <- increaseGTsiteStrength(cds, index = 103)
```

### 5. Bulk Degradation of Splice Sites
To degrade all potential splice donors or acceptors within a sequence that exceed a specific threshold:

```R
library(data.table)

# 1. Create a codon matrix
codon_mat <- createCodonMatrix(ntSequence)

# 2. Degrade all SDs exceeding HBond score of 10
cds_sd_degraded <- degradeSDs(codon_mat, maxhbs = 10, increaseHZEI = TRUE)

# 3. Degrade all SAs exceeding MaxEntScan score of 4
cds_sa_degraded <- degradeSAs(codon_mat, maxhbs = 10, maxME = 4, increaseHZEI = TRUE)
```

## Tips and Requirements
- **Perl Requirement**: MaxEntScan score calculations require Perl to be installed on the system.
- **Parallelization**: Use the `nCores` parameter in `ModCon()` to speed up genetic algorithm calculations.
- **Shiny Interface**: You can launch a graphical user interface using `startModConApp()`.
- **Preservation**: All functions in this package are designed to maintain the original amino acid sequence (synonymous mutations only).

## Reference documentation
- [Designing SD context with ModCon](./references/ModCon.Rmd)
- [Designing SD context with ModCon (Markdown)](./references/ModCon.md)