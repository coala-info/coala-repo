---
name: bioconductor-eudysbiome
description: This tool measures the eubiotic and dysbiotic impacts of microbiome taxonomic shifts between different conditions. Use when user asks to annotate microbes by pathogenic potential, visualize abundance variations on a Cartesian plane, or statistically test for significant eubiotic or dysbiotic changes in microbiome data.
homepage: https://bioconductor.org/packages/release/bioc/html/eudysbiome.html
---


# bioconductor-eudysbiome

name: bioconductor-eudysbiome
description: Statistical measurement of eubiotic and dysbiotic impacts in microbiome data. Use this skill when analyzing gut-intestinal (GI) microbiome variations (differential genera) between treatments or environmental conditions to determine if changes are beneficial (eubiotic) or harmful (dysbiotic).

# bioconductor-eudysbiome

## Overview

The `eudysbiome` package provides a framework for interpreting microbiome taxonomic shifts in a clinical or ecological context. It classifies genera as "harmful" or "harmless" based on pathogenic potential and calculates an Eubiotic Index (EI) or Dysbiotic Index (DI). 

- **Eubiotic Impact (EI):** Increase in harmless genera or decrease in harmful genera.
- **Dysbiotic Impact (DI):** Decrease in harmless genera or increase in harmful genera.

## Core Workflow

### 1. Taxonomy Assignment (Optional)
If starting from raw 16S rRNA sequences (FASTA), use `assignTax` to classify sequences to the species level using the SILVA reference set.

```r
library(eudysbiome)
# Requires Mothur to be installed in the system path
assignTax(fasta = "sequences.fasta", cutoff = 80, dir.out = "taxonomy_results")
```

### 2. Microbe Annotation
Annotate a list of genera or a Genus-Species data frame. The package includes a curated `harmGenera` table.

```r
data(harmGenera) # Load reference table
data(diffGenera) # Example genus-species data

# Annotate based on the presence of harmful species within genera
annotation <- microAnnotate(diffGenera, annotated.micro = harmGenera)
```

### 3. Visualizing Impacts (Cartesian Plane)
Plot the abundance variations ($\Delta g$) against the harmful/harmless classification.

```r
data(microDiff) # Example dataset containing $data, $micro.anno, and $comp.anno
attach(microDiff)

# Plotting shifts: Blue box = Eubiotic, Yellow box = Dysbiotic
Cartesian(data, micro.anno = micro.anno, comp.ano = comp.anno, unknown = TRUE)
```

### 4. Statistical Testing
Quantify the frequencies of EI and DI and test for significant differences between conditions using Chi-squared or Fisher's exact tests.

```r
# 1. Construct contingency table of frequencies (cumulated |delta g|)
microCount <- contingencyCount(data, micro.anno = micro.anno, comp.ano = comp.anno)

# 2. Perform significance tests
# alternative = "greater" tests if condition 1 is more eubiotic than condition 2
microTest <- contingencyTest(microCount, alternative = "greater")

# View p-values
microTest$Chisq.p
microTest$Fisher.p
```

## Key Functions

- `assignTax()`: Interfaces with Mothur for RDP-based taxonomic classification.
- `tableSpecies()`: Extracts a Genus-Species mapping from `.taxonomy` files.
- `microAnnotate()`: Categorizes microbes as harmful, harmless, or unknown.
- `Cartesian()`: Generates a four-quadrant plot of microbiome shifts.
- `contingencyCount()`: Aggregates absolute abundance changes into eubiotic/dysbiotic frequencies.
- `contingencyTest()`: Performs Fisher's and Chi-squared tests on the impact frequencies.

## Data Structures

- **Input Data:** A matrix or data frame where rows are genera and columns are comparisons (e.g., Treatment - Control). Values represent the difference in abundance ($\Delta g$).
- **Annotation:** A character vector or data frame mapping the rows of your input data to "harmful", "harmless", or "unknown".

## Reference documentation

- [eudysbiome User Manual](./references/eudysbiome.md)