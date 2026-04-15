---
name: bioconductor-syntenet
description: This tool provides a network-based framework for analyzing synteny and conserved gene order across multiple species. Use when user asks to infer synteny networks, cluster conserved gene groups, perform phylogenomic profiling, identify taxon-specific synteny patterns, or reconstruct species trees from synteny data.
homepage: https://bioconductor.org/packages/release/bioc/html/syntenet.html
---

# bioconductor-syntenet

## Overview

The `syntenet` package provides a comprehensive framework for analyzing synteny (conserved gene order) using a network-based approach. Instead of traditional pairwise comparisons, it represents genes as nodes and syntenic relationships as edges. This allows for global analyses across multiple species, including network clustering to find conserved gene groups and phylogenomic profiling to identify taxon-specific synteny patterns.

## Core Workflow

### 1. Data Preparation and Input
The package requires two main inputs: protein sequences and gene annotations.

```r
library(syntenet)

# Load from directories
# fasta_dir should contain .fa or .fasta files
# gff_dir should contain .gff, .gff3, or .gtf files
seqs <- fasta2AAStringSetlist(fasta_dir)
annot <- gff2GRangesList(gff_dir)

# Validate and process
if(check_input(seqs, annot)) {
    pdata <- process_input(seqs, annot)
}
```

**Note on RefSeq data:** If sequence names (protein IDs) don't match annotation IDs (gene IDs), use `collapse_protein_ids()` to map them and keep only the longest isoform per gene.

### 2. Similarity Searching
Synteny detection requires all-vs-all protein similarity results (BLASTp-like).

```r
# Requires DIAMOND or LAST to be installed and in PATH
blast_list <- run_diamond(seq = pdata$seq)

# For specific interspecies comparisons only
comp <- make_bidirectional(data.frame(query = "spA", db = "spB"))
blast_list_inter <- run_diamond(pdata$seq, compare = comp)
```

### 3. Synteny Detection
`syntenet` includes a native Rcpp implementation of the MCScanX algorithm.

```r
# For network inference (multi-species)
net <- infer_syntenet(blast_list, pdata$annotation)

# For simple pairwise or intraspecies detection
# Returns path to .collinearity file
col_file <- intraspecies_synteny(blast_list, pdata$annotation)
# or
col_file <- interspecies_synteny(blast_list, pdata$annotation)

# Parse results
anchors <- parse_collinearity(col_file, as = "all")
```

### 4. Network Analysis and Profiling
Once the network is inferred, you can cluster it and analyze the distribution of clusters across species.

```r
# Cluster using Infomap (default)
clusters <- cluster_network(net)

# Generate phylogenomic profiles (presence/count of genes per cluster per species)
profiles <- phylogenomic_profile(clusters)

# Find group-specific clusters (e.g., family-specific)
# species_annotation is a df with 'Species' and 'Group' columns
gs_clusters <- find_GS_clusters(profiles, species_annotation)
```

### 5. Visualization
```r
# Heatmap of profiles
plot_profiles(profiles, species_annotation)

# Network visualization (static or interactive)
plot_network(net, clusters, cluster_id = c(1, 2, 3), interactive = TRUE)
```

### 6. Phylogeny Reconstruction
Reconstruct species trees based on the presence/absence of syntenic clusters.

```r
# Binarize profile matrix
bt_mat <- binarize_and_transpose(profiles)

# Infer tree using IQ-TREE (must be installed)
phylo_files <- infer_microsynteny_phylogeny(bt_mat, outgroup = "SpeciesName")
```

## Tips and Best Practices
- **Species IDs:** `process_input` adds 3-5 character prefixes to gene IDs to ensure uniqueness across the network. Use `create_species_id_table()` to map these back to original names.
- **External Tools:** DIAMOND and IQ-TREE are external dependencies. If they are not in your system PATH, use `Sys.setenv(PATH = ...)` within R to point to their location.
- **Large Datasets:** For very large genomes, run DIAMOND on a cluster, then import results using `read_diamond()`.

## Reference documentation
- [Inference and analysis of synteny networks](./references/vignette_01_inference_and_analysis_of_synteny_networks.md)
- [Synteny detection with syntenet](./references/vignette_02_synteny_detection_with_syntenet.md)