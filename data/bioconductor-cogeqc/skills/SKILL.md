---
name: bioconductor-cogeqc
description: The cogeqc package provides a suite of tools for comparative genomics quality control, including genome assembly assessment and orthogroup inference evaluation. Use when user asks to compare genome statistics against NCBI references, assess gene space completeness with BUSCO, evaluate orthogroup quality using protein domain homogeneity, or score synteny networks.
homepage: https://bioconductor.org/packages/release/bioc/html/cogeqc.html
---

# bioconductor-cogeqc

## Overview
The `cogeqc` package provides a suite of tools for Comparative Genomics Quality Control. It allows researchers to move beyond isolated metrics by providing context for genome statistics, automated interfaces for gene space completeness (BUSCO), and novel scoring methods for orthogroup and synteny network inference.

## Core Workflows

### 1. Genome Assembly Assessment
Compare your assembly statistics against publicly available genomes from NCBI.

```r
library(cogeqc)

# 1. Retrieve reference stats from NCBI for a taxon
ncbi_stats <- get_genome_stats(taxon = "Zea mays")

# 2. Compare your local stats (requires 'accession' column)
my_stats <- data.frame(
    accession = "my_assembly",
    sequence_length = 2.4e9,
    gene_count_total = 50000,
    CC_ratio = 2
)
comparison <- compare_genome_stats(ncbi_stats, my_stats)

# 3. Visualize distributions with your assembly highlighted
plot_genome_stats(ncbi_stats, user_stats = my_stats)
```

### 2. Gene Space Completeness (BUSCO)
Interface with BUSCO to assess if expected single-copy orthologs are present.

```r
# List available datasets
list_busco_datasets()

# Read BUSCO output directory
busco_summary <- read_busco("path/to/busco_output/")

# Plot results (supports single or batch mode)
plot_busco(busco_summary)
```

### 3. Orthogroup Inference Assessment
Evaluate the quality of orthogroups (e.g., from OrthoFinder) using protein domain homogeneity.

```r
# Read OrthoFinder output
og <- read_orthogroups("Orthogroups.tsv")

# Prepare annotation list (names must match Species column in og)
ann <- list(Ath = interpro_ath, Bol = interpro_bol)

# Calculate homogeneity scores (higher is better)
assessment <- assess_orthogroups(og, ann)
mean(assessment$Mean_score)

# Visualize OrthoFinder summary statistics
stats <- read_orthofinder_stats("Comparative_Genomics_Statistics/")
plot_orthofinder_stats(tree, stats_list = stats)
```

### 4. Synteny Network Assessment
Score synteny networks based on clustering coefficients, node counts, and scale-free topology fit.

```r
# Assess a single synteny network (data frame with anchor1, anchor2)
score <- assess_synnet(synnet)

# Compare multiple networks to find optimal parameters
net_list <- list(params1 = net1, params2 = net2)
assessment <- assess_synnet_list(net_list)
```

## Key Functions and Tips
- **CC Ratio**: Use the `CC_ratio` (contig count / chromosome pairs) as a contiguity metric that allows for better cross-species comparison than N50.
- **Filtering NCBI Data**: Use the `filters` argument in `get_genome_stats()` to narrow references (e.g., `filters = list(filters.assembly_level = "chromosome")`).
- **Protein Domains**: The `assess_orthogroups()` function penalizes "dispersal" (the same domain split across multiple OGs) to detect overclustering.
- **Visualization**: Most plotting functions return `ggplot` or `patchwork` objects that can be further customized.

## Reference documentation
- [Assessing genome assembly and annotation quality](./references/vignette_01_assessing_genome_assembly.md)
- [Assessing orthogroup inference](./references/vignette_02_assessing_orthogroup_inference.md)
- [Assessing synteny identification](./references/vignette_03_assessing_synteny.md)