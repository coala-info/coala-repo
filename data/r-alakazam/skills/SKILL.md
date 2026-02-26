---
name: r-alakazam
description: The alakazam package provides tools for high-throughput B cell and T cell repertoire analysis, including clonal diversity estimation and gene usage quantification. Use when user asks to analyze clonal abundance, calculate diversity curves, quantify V(D)J gene usage, or evaluate physicochemical properties of CDR3 sequences.
homepage: https://cran.r-project.org/web/packages/alakazam/index.html
---


# r-alakazam

## Overview
The `alakazam` package is part of the Immcantation framework. It provides tools for high-throughput B cell and T cell repertoire analysis, focusing on clonal abundance, diversity curves, gene usage, and physicochemical properties of CDR3 sequences.

## Installation
To install the package from CRAN:
```r
install.packages("alakazam")
```

## Core Workflows

### 1. Data Input and Output
Alakazam uses the AIRR Community Data Standard. While it has legacy support for Change-O files, AIRR-formatted files are preferred.

```r
library(alakazam)
library(airr)

# Read AIRR-formatted TSV
db <- airr::read_rearrangement("path/to/file.tsv")

# Legacy Change-O format
db_legacy <- readChangeoDb("path/to/file.tab")
```

### 2. Clonal Abundance and Diversity
Analyze the repertoire using Hill numbers ($q=0$ for richness, $q=1$ for Shannon entropy, $q=2$ for Simpson's index).

```r
# Count clones by group
clones <- countClones(db, group="sample_id", clone="clone_id")

# Estimate abundance with confidence intervals (bootstrapping)
abund <- estimateAbundance(db, group="sample_id", nboot=100)
plot(abund, legend_title="Sample")

# Generate diversity curves (alpha diversity)
div <- alphaDiversity(db, group="sample_id", min_q=0, max_q=4, step_q=0.1, nboot=100)
plot(div, log_q=TRUE, log_d=TRUE)

# Test significance at a specific order (e.g., q=1)
print(div@tests)
```

### 3. Gene Usage Analysis
Quantify V(D)J gene, family, or allele usage.

```r
# Tabulate V-gene usage by sample
gene_usage <- countGenes(db, gene="v_call", groups="sample_id", mode="gene")

# Sort genes for plotting (lexicographical or genomic position)
gene_usage$gene <- factor(gene_usage$gene, levels=sortGenes(unique(gene_usage$gene), method="name"))

# Extract family from gene calls
db$v_family <- getFamily(db$v_call)
```

### 4. Amino Acid Property Analysis
Calculate physicochemical properties of CDR3 regions (or other regions).

```r
# Calculate properties for the junction (CDR3)
# trim=TRUE removes the conserved flanking residues
db_props <- aminoAcidProperties(db, seq="junction", trim=TRUE, label="cdr3")

# Available properties: length, gravy, bulkiness, polarity, aliphatic, charge, acidic, basic, aromatic
# Plotting example
library(ggplot2)
ggplot(db_props, aes(x=sample_id, y=cdr3_aa_gravy)) + 
    geom_boxplot(aes(fill=sample_id)) +
    scale_fill_manual(values=IG_COLORS) # Use built-in Ig color palette
```

### 5. Sequencing Quality and Masking
Integrate FASTQ quality scores into the AIRR dataframe.

```r
# Load quality scores from FASTQ
db <- readFastqDb(db, fastq_file="data.fastq", style="both")

# Mask low quality positions (replace with 'N')
db <- maskPositionsByQuality(db, min_quality=70, sequence="sequence_alignment", quality="quality_alignment_num")
```

## Tips and Best Practices
- **Column Names**: Ensure your data follows AIRR standards (e.g., `v_call`, `clone_id`, `sequence_alignment`).
- **Clonal Analysis**: Always perform clonal clustering (e.g., using `scoper` or `changeo`) before running `alphaDiversity` or `countClones`.
- **Visualization**: Use `gridPlot` for multi-panel figures and `baseTheme()` for consistent Immcantation-style aesthetics.
- **Filtering**: Use `dplyr` to filter for specific isotypes or samples before running heavy bootstrap calculations.

## Reference documentation
- [Amino acid property analysis](./references/AminoAcids-Vignette.Rmd)
- [Diversity analysis](./references/Diversity-Vignette.Rmd)
- [Using sequencing quality scores](./references/Fastq-Vignette.Rmd)
- [File input and output](./references/Files-Vignette.Rmd)
- [Gene usage analysis](./references/GeneUsage-Vignette.Rmd)