---
name: bioconductor-varcon
description: VarCon analyzes the functional impact of single nucleotide variants on RNA splicing by calculating regulatory scores and splice site strengths. Use when user asks to translate variant coordinates, retrieve genomic sequences for SNVs, calculate HEXplorer scores, or predict the impact of mutations on splicing regulatory properties.
homepage: https://bioconductor.org/packages/release/bioc/html/VarCon.html
---

# bioconductor-varcon

## Overview
VarCon is a Bioconductor package designed to analyze the functional impact of SNVs on RNA splicing. It translates SNV positional information between genomic (g.) and coding (c.) coordinates, retrieves the surrounding nucleotide sequence from a reference genome, and predicts changes in splicing regulatory properties. It specifically calculates HEXplorer scores to assess the recruitment of splicing regulatory proteins and evaluates the intrinsic strength of splice sites using HBond and MaxEnt scores.

## Core Workflow

### 1. Data Preparation
Before analysis, you must prepare the reference genome and transcript metadata. VarCon requires a `DNAStringSet` object for the genome and specific transcript tables.

```r
library(VarCon)
library(Biostrings)

# Load reference genome from a fasta file
# Ensure chromosome names match Ensembl format (e.g., "1", "MT")
referenceDnaStringSet <- prepareReferenceFasta("path/to/genome.fasta")

# Use built-in transcript tables (transCoord for GRCh38 or transCoord_37 for GRCh37)
# Or download a custom one via Biomart following the package schema
data(transCoord) 
```

### 2. Retrieving Sequence Information
The primary function `getSeqInfoFromVariation` retrieves the genomic context of an SNV.

```r
# Define parameters
transcriptID <- "ENST00000544455"
variation <- "c.8754+3G>C" # Supports coding (c.) or genomic (g.) notation
window_size <- 20 # Number of nucleotides upstream/downstream

# Execute retrieval
results <- getSeqInfoFromVariation(
  referenceDnaStringSet = referenceDnaStringSet,
  transcriptID = transcriptID,
  variation = variation,
  ntWindow = window_size,
  transcriptTable = transCoord
)

# Access results
# results$sequence (Reference)
# results$altSeq (Variant)
# results$genomicCoordinate
```

### 3. Using Gene Names
If you prefer using gene names instead of Ensembl transcript IDs, provide a mapping table.

```r
gene2transcript <- data.frame(
  gene_name = "BRCA2",
  gene_ID = "ENSG00000139618",
  transcriptID = "ENST00000544455"
)

results <- getSeqInfoFromVariation(
  referenceDnaStringSet = referenceDnaStringSet,
  transcriptID = "BRCA2",
  variation = "c.8754+3G>C",
  ntWindow = 20,
  transcriptTable = transCoord,
  gene2transcript = gene2transcript
)
```

### 4. Visualization and Splicing Analysis
Visualize the impact of the SNV on splicing regulatory elements and splice site strength.

```r
# Generate a HEXplorer plot
# This visualizes HZEI scores (regulatory recruitment) and splice site strengths
generateHEXplorerPlot(results)
```

### 5. Interactive Analysis
For an interactive session, VarCon includes a Shiny application.

```r
# Launch the GUI
startVarConApp()
```

## Key Metrics
*   **HZEI Score:** Calculated via the HEXplorer algorithm. Positive scores indicate splicing enhancers; negative scores indicate silencers.
*   **HBond Score:** Measures Splice Donor (SD) strength based on hydrogen bonds with U1 snRNA.
*   **MaxEnt Score:** Measures Splice Acceptor (SA) strength based on maximum entropy modeling of sequence distributions.

## Tips
*   **Perl Dependency:** VarCon relies on a Perl script for certain calculations. Ensure Perl (e.g., Strawberry Perl on Windows) is installed and in your system PATH.
*   **Coordinate Systems:** When using coding (c.) coordinates, VarCon automatically handles intronic offsets (e.g., `+3` or `-5`) relative to the transcript's exon boundaries.
*   **Reference Matching:** Ensure the `transcriptTable` assembly (GRCh37 vs GRCh38) matches the version of the `referenceDnaStringSet` being used.

## Reference documentation
- [Analysing SNVs with VarCon](./references/VarCon.md)