---
name: bioconductor-cleaver
description: The cleaver package performs in-silico digestion of polypeptide sequences using various enzymatic and chemical cleavage rules. Use when user asks to cleave protein sequences, find cleavage sites or ranges, or simulate missed cleavages for proteomics workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/cleaver.html
---

# bioconductor-cleaver

## Overview

The `cleaver` package provides functions for the in-silico digestion of polypeptide sequences. It implements cleavage rules from the ExPASy PeptideCutter tool, allowing researchers to generate theoretical peptide fragments from protein sequences. This is particularly useful for proteomics workflows, such as creating theoretical mass spectrometry data or planning digestion experiments.

## Core Functions

The package revolves around three primary functions that accept either character vectors or `AAStringSet` objects:

- `cleave()`: Returns the actual amino acid sequences of the resulting fragments.
- `cleavageRanges()`: Returns the start and end positions of the fragments.
- `cleavageSites()`: Returns the specific indices where cleavage occurs.

## Usage Patterns

### Basic Cleavage
To cleave a sequence, specify the sequence and the enzyme (e.g., "trypsin", "pepsin", "cyanogen bromide").

```r
library(cleaver)

# Cleave a simple peptide
sequence <- "LAAGKVEDSD"
fragments <- cleave(sequence, enzym = "trypsin")
# Result: "LAAGK", "VEDSD"

# Get the numeric positions of cleavage
sites <- cleavageSites(sequence, enzym = "trypsin")
# Result: 5
```

### Handling Missed Cleavages
In real-world experiments, enzymes often miss cleavage sites. You can simulate this using the `missedCleavages` parameter.

```r
# Simulate exactly 1 missed cleavage
cleave(sequence, enzym = "trypsin", missedCleavages = 1)

# Generate all possible fragments with 0 to 2 missed cleavages
cleave(sequence, enzym = "trypsin", missedCleavages = 0:2)
```

### Integration with Biostrings
`cleaver` is designed to work seamlessly with the `Biostrings` ecosystem.

```r
library(Biostrings)
proteins <- AAStringSet(c(p1 = "LAAGKVEDSD", p2 = "AGEPKLDAGV"))

# Returns an AAStringSetList
cleaved_list <- cleave(proteins, enzym = "trypsin")

# Returns an IRangesList
ranges_list <- cleavageRanges(proteins, enzym = "trypsin")
```

## Available Enzymes
To see a full list of supported cleavage rules and enzymes, use:
```r
help("cleave")
```
Commonly used rules include: `trypsin`, `pepsin`, `chymotrypsin`, `cnbr` (Cyanogen bromide), `arg-c`, `asp-n`, and `lys-c`.

## Workflow Tips
1. **Data Cleaning**: Ensure sequences do not contain whitespaces or non-amino acid characters before processing. Use `gsub("[[:space:]]", "", x)` if necessary.
2. **Mass Spectrometry**: Combine `cleaver` with packages like `BRAIN` or `IsotopicDistribution` to calculate theoretical masses of the generated fragments.
3. **Large Scales**: When working with whole proteomes, use `AAStringSet` objects to maintain metadata and improve computational efficiency.

## Reference documentation
- [In-silico cleavage of polypeptides using the cleaver package](./references/cleaver.md)