---
name: bioconductor-branchpointer
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/branchpointer.html
---

# bioconductor-branchpointer

name: bioconductor-branchpointer
description: Predicts and analyzes cis-acting intronic branch point sites in RNA splicing. Use this skill when identifying branch point locations, evaluating the impact of genetic variants (SNPs/indels) on splicing branch points, or processing genomic coordinates to find potential branch point sequences.

# bioconductor-branchpointer

## Overview
The `branchpointer` package utilizes a machine learning model to identify branch point sites within the 18-44 nucleotides upstream of an exon's 5' splice site. It is specifically designed to predict the probability of a site being a functional branch point and can evaluate how sequence variations (like SNPs) change these probabilities, which is critical for understanding splicing-related diseases.

## Core Workflow

1.  **Prepare Input Data**: Define the query regions. This is typically a BED file or a data frame containing coordinates of the 3' splice sites or specific variants.
2.  **Retrieve Sequences**: Use a `BSgenome` object (e.g., `BSgenome.Hsapiens.UCSC.hg38`) to extract the genomic sequences for the regions of interest.
3.  **Predict Branch Points**: Run the prediction model to calculate scores for all potential sites in the specified window.
4.  **Analyze Variants (Optional)**: If working with SNPs, provide both the reference and alternative alleles to calculate the change in branch point probability.
5.  **Visualization**: Generate plots to visualize the distribution of branch point scores relative to the splice site.

## Key Functions

### Data Loading and Pre-processing
- `readQueryFile()`: Reads a formatted file (BED or GTF) containing the locations of interest.
- `getBranchpointSequence()`: Extracts the required sequence window from a `BSgenome` object. Requires a query object and a genome object.

### Prediction and Analysis
- `predictBranchpoints()`: The primary function that applies the pre-trained model to the sequences. It returns a data frame with scores for each position.
- `predictionsToExons()`: Collapses site-specific predictions to provide an overview of the branch point architecture for a given exon.
- `predictVariantEffect()`: Specifically compares reference and alternative sequences to quantify the impact of a mutation on branch point strength.

### Visualization
- `plotBranchpoint()`: Creates a visualization of the predicted branch point probability across the intronic window.

## Usage Examples

### Basic Prediction
```r
library(branchpointer)
library(BSgenome.Hsapiens.UCSC.hg38)

# Load query regions
query <- readQueryFile("path/to/query.bed", type = "bed")

# Get sequences
query_seqs <- getBranchpointSequence(query, BSgenome.Hsapiens.UCSC.hg38)

# Predict
predictions <- predictBranchpoints(query_seqs)

# Filter for high-confidence sites (e.g., probability > 0.5)
hc_sites <- predictions[predictions$probability > 0.5, ]
```

### Evaluating a Variant
```r
# Assuming query contains 'ref_allele' and 'alt_allele' columns
var_effects <- predictVariantEffect(query_seqs)

# Identify variants that significantly decrease branch point probability
disruptive_vars <- var_effects[var_effects$delta_prob < -0.3, ]
```

## Tips and Best Practices
- **Window Size**: By default, `branchpointer` looks at the -18 to -44 region relative to the 3' splice site. Ensure your input coordinates are correctly formatted to target this area.
- **Genome Version**: Always ensure the `BSgenome` object matches the assembly version used to generate your query coordinates (e.g., hg19 vs hg38).
- **Probability Interpretation**: Scores range from 0 to 1. While 0.5 is a common threshold, functional branch points often score > 0.8.
- **U-richness**: The model accounts for the pentamer sequence and the distance to the 3' splice site; remember that branch points are typically followed by a polypyrimidine tract.

## Reference documentation
- [branchpointer Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/branchpointer.html)