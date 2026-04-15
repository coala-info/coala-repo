---
name: bioconductor-geneticsdesign
description: This tool performs power calculations and experimental design for genetic association studies. Use when user asks to calculate statistical power for case-control studies, determine sample sizes for genetic markers, or account for linkage disequilibrium in association testing.
homepage: https://bioconductor.org/packages/3.6/bioc/html/GeneticsDesign.html
---

# bioconductor-geneticsdesign

name: bioconductor-geneticsdesign
description: Power calculation and experimental design for genetic association studies. Use this skill to calculate the statistical power of case-control studies testing the association between a disease and a marker (e.g., SNP), accounting for linkage disequilibrium (LD) between the marker and the actual disease susceptibility locus (DSL).

## Overview

The `GeneticsDesign` package provides tools for investigators to determine appropriate sample sizes during the design phase of genetic association studies. It specifically addresses the scenario where the disease susceptibility locus (DSL) is unknown, and association is tested indirectly via a biallelic marker. The power calculation integrates minor allele frequencies (MAF) for both the DSL and the marker, relative risks, linkage disequilibrium (D' or r²), and sample sizes for cases and controls.

## Core Workflow

### 1. Loading the Package
```R
library(GeneticsDesign)
```

### 2. Calculating Power with GPC.default
The primary function is `GPC.default()`, which implements the Genetic Power Calculator logic for case-control designs.

**Key Parameters:**
- `pA`: Minor allele frequency (MAF) of the Disease Susceptibility Locus (DSL).
- `pB`: Minor allele frequency (MAF) of the Marker.
- `pD`: Disease prevalence in the population.
- `RRAa`: Genotype relative risk of the heterozygote (Aa) compared to the baseline (aa).
- `RRAA`: Genotype relative risk of the homozygote (AA) compared to the baseline (aa).
- `Dprime`: Linkage disequilibrium (D') between the DSL and the marker (0 to 1).
- `ncase`: Number of cases.
- `ncontrol`: Number of controls.
- `alpha`: Significance level (default is 0.05).
- `quiet`: Boolean to suppress progress output.

### 3. Example: Power Analysis for Varying Risk
A common workflow involves testing a range of relative risks or allele frequencies to see how they impact power.

```R
# Define ranges for MAF and Relative Risk
maf_set <- seq(0.1, 0.5, by = 0.1)
rr_set <- c(1.25, 1.5, 1.75, 2.0)

# Initialize results matrix
power_mat <- matrix(0, nrow = length(maf_set), ncol = length(rr_set))
rownames(power_mat) <- paste0("MAF=", maf_set)
colnames(power_mat) <- paste0("RR=", rr_set)

# Iterate through combinations
for(i in seq_along(maf_set)) {
  for(j in seq_along(rr_set)) {
    # Assuming additive model: RRAa = (1 + RRAA)/2
    res <- GPC.default(
      pA = maf_set[i], 
      pB = maf_set[i], 
      pD = 0.1, 
      RRAa = (1 + rr_set[j])/2, 
      RRAA = rr_set[j], 
      Dprime = 1, 
      ncase = 500, 
      ncontrol = 500, 
      quiet = TRUE
    )
    power_mat[i, j] <- res$power
  }
}

print(round(power_mat, 3))
```

## Interpreting Results

The `GPC.default` function returns a list containing:
- `power`: The calculated statistical power (0 to 1).
- `ncp`: The non-centrality parameter ($\lambda_T$) for the linear trend test statistic.
- `sampling_probs`: Probabilities for genotypes in cases and controls.

## Tips for Genetic Design
- **Linkage Disequilibrium**: If the marker is the DSL itself, set `pA = pB` and `Dprime = 1`.
- **Model Selection**: For an additive model, set `RRAa = (1 + RRAA) / 2`. For a dominant model, set `RRAa = RRAA`. For a recessive model, set `RRAa = 1`.
- **D' vs r²**: The package primarily uses D' for LD. Ensure your input matches the expected scale (0 to 1).

## Reference documentation
- [GPC](./references/GPC.md)