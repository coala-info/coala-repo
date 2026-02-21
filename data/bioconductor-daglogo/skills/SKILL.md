---
name: bioconductor-daglogo
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/dagLogo.html
---

# bioconductor-daglogo

name: bioconductor-daglogo
description: Identification and visualization of significant differential usage of amino acids (DAU) in peptide sequences. Use when Claude needs to perform sequence logo analysis, compare experimental peptide sets against background proteomes, or group amino acids by physico-chemical properties (charge, hydrophobicity, etc.) using the dagLogo R package.

# bioconductor-daglogo

## Overview

The `dagLogo` package is designed for the discovery and visualization of conserved or differentially used amino acid (AA) patterns. Unlike standard sequence logos that focus on information content, `dagLogo` identifies statistically significant over- or under-representation of AAs (or AA groups) at specific positions relative to an anchoring residue. It supports various background models (e.g., whole proteome, random permutations) and allows for grouping amino acids based on physical and chemical properties to find patterns that are conserved by property rather than specific residue.

## Core Workflow

### 1. Data Preparation

You must first prepare your experimental sequences as a `dagPeptides` object. This can be done by fetching sequences from BioMart or formatting local sequences.

```R
library(dagLogo)

# Case: Local sequences (aligned or unaligned)
# 'dat' is a character vector of peptide sequences
# 'proteome' is a Proteome object (see Step 2)
seq <- formatSequence(seq = dat, 
                      proteome = proteome, 
                      upstreamOffset = 14, 
                      downstreamOffset = 15)
```

### 2. Building Background Models

A background model is required for statistical testing. You can generate a `Proteome` object from a FASTA file or UniProt.

```R
# Prepare proteome from FASTA
proteome <- prepareProteome(fasta = "path/to/human.fasta", species = "Homo sapiens")

# Build background model (Fisher's exact test or Z-test)
bg_ztest <- buildBackgroundModel(seq, 
                                 background = "wholeProteome", 
                                 proteome = proteome, 
                                 testType = "ztest")
```

### 3. Differential Amino Acid Usage (DAU) Testing

Perform the statistical test. You can test at the individual residue level or group residues by properties.

```R
# No grouping (individual AA level)
t0 <- testDAU(seq, dagBackground = bg_ztest)

# Grouping by charge
t_charge <- testDAU(seq, 
                    dagBackground = bg_ztest, 
                    groupingScheme = "charge_group")

# Other schemes: "chemistry_property_Mahler_group", "hydrophobicity_KD", "consensus_similarity_SF_group"
```

### 4. Visualization

Results can be visualized as heatmaps or sequence logos.

```R
# Heatmap of significance
dagHeatmap(t0)

# Sequence Logo
# For grouped results, use getGroupingSymbol to label the logo correctly
dagLogo(t_charge, 
        groupingSymbol = getGroupingSymbol(t_charge@group), 
        legend = TRUE)
```

## Custom Grouping Schemes

If standard schemes are insufficient, you can define custom AA groups:

```R
color = c(LVIMC = "#33FF00", AGSTP = "#CCFF00", FYW = '#00FF66', EDNQKRH = "#FF0066")
symbol = c(LVIMC = "L", AGSTP = "A", FYW = "F", EDNQKRH = "E")
group = list(
    LVIMC = c("L", "V", "I", "M", "C"),
    AGSTP = c("A", "G", "S", "T", "P"),
    FYW = c("F", "Y", "W"),
    EDNQKRH = c("E", "D", "N", "Q", "K", "R", "H"))

addScheme(color = color, symbol = symbol, group = group)
t_custom <- testDAU(seq, dagBackground = bg_ztest, groupingScheme = "custom_group")
```

## Tips for Success

- **Anchor Alignment**: Ensure your input sequences are centered on a specific anchoring amino acid or position.
- **Background Selection**: The choice of background (e.g., `wholeProteome` vs `input`) significantly impacts p-values. Use `wholeProteome` when comparing a specific modification site against the general protein population.
- **Cleaning**: Use `cleanPeptides()` to handle input data containing multiple anchoring types or non-standard characters before fetching sequences.

## Reference documentation

- [dagLogo](./references/dagLogo.md)