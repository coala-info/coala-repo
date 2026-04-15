---
name: bioconductor-metagenomefeatures
description: This tool manages and explores taxonomic composition, sequences, and phylogenetic trees from marker-gene databases and metagenome experiments. Use when user asks to subset reference databases like Greengenes or SILVA, retrieve taxonomic data and sequences for specific taxa, or integrate marker-gene features with the phyloseq package.
homepage: https://bioconductor.org/packages/3.8/bioc/html/metagenomeFeatures.html
---

# bioconductor-metagenomefeatures

name: bioconductor-metagenomefeatures
description: Exploration and management of taxonomic composition for marker-gene (16S rRNA) databases and metagenome experiments. Use this skill to work with MgDb and mgFeatures S4 classes, subset reference databases (Greengenes, SILVA, RDP), retrieve sequences and phylogenetic trees for specific taxa, and integrate marker-gene data with the phyloseq package.

# bioconductor-metagenomefeatures

## Overview
The `metagenomeFeatures` package provides a standardized framework for interacting with 16S rRNA reference databases and marker-gene survey data. It utilizes two primary S4 classes: `MgDb` (for large reference databases stored in SQLite) and `mgFeatures` (for smaller, experiment-specific feature sets). The package allows for efficient subsetting of taxonomic data, sequences, and phylogenetic trees without loading entire databases into memory.

## Core Workflows

### 1. Working with MgDb Objects
`MgDb` objects connect to reference databases. The package includes a small example database (`gg85`), while full databases are available via separate annotation packages (e.g., `greengenesMgDb13.5`).

```r
library(metagenomeFeatures)

# Load the included Greengenes 13.8 85% OTU database
gg85 <- get_gg13.8_85MgDb()

# Explore database structure
taxa_keytypes(gg85) # Column names (Kingdom, Phylum, etc.)
taxa_columns(gg85)  # Taxonomy-specific columns
head(taxa_keys(gg85, keytype = "Family")) # List all families
```

### 2. Subsetting and Selecting Data
Use `mgDb_select` to retrieve specific taxonomic groups. The `type` argument controls whether you get taxonomy, sequences, trees, or all three.

```r
# Select specific families
ve_select <- mgDb_select(gg85, 
                         type = "all", 
                         keys = c("Vibrionaceae", "Enterobacteriaceae"), 
                         keytype = "Family")

# Access components
ve_taxa <- ve_select$taxa  # Tibble
ve_seq  <- ve_select$seq   # DNAStringSet
ve_tree <- ve_select$tree  # phylo object
```

### 3. Creating and Using mgFeatures Objects
`mgFeatures` objects store feature data for a specific experiment. You can create them from scratch or by annotating a list of database IDs.

```r
# Annotate a list of Greengenes IDs
ids <- c("1107824", "824826", "694268")
my_features <- annotateFeatures(gg85, ids)

# Accessors
mgF_taxa(my_features)
mgF_seq(my_features)
mgF_tree(my_features)
```

### 4. Integration with Phyloseq
`metagenomeFeatures` is often used to "fill in" missing sequences or trees in a `phyloseq` object if the OTUs were clustered against a supported reference database.

```r
library(phyloseq)

# Assuming 'ps' is a phyloseq object with Greengenes IDs as taxa names
# 1. Annotate features to get tree and sequences
mgF_data <- annotateFeatures(gg85, taxa_names(ps))

# 2. Prune phyloseq to match available database features
ps_subset <- prune_taxa(taxa_names(mgF_data), ps)

# 3. Assign tree and sequences to phyloseq
phy_tree(ps_subset) <- mgF_tree(mgF_data)
ps_subset@refseq <- mgF_seq(mgF_data)
```

## Tips and Best Practices
- **Memory Efficiency**: `MgDb` uses SQLite and `DECIPHER` under the hood. Avoid trying to convert the entire database to a data frame; use `mgDb_select` to pull only what you need.
- **Taxonomy Strings**: Greengenes taxonomy often uses prefixes (e.g., `k__Bacteria`, `f__Vibrionaceae`). Ensure your `keys` match this format when querying.
- **Annotation Packages**: For production workflows, install the full databases:
  - `greengenesMgDb13.5`
  - `ribosomaldatabaseproject11.5MgDb`
  - `silva128.1MgDb`
- **Visualization**: Use the `ggtree` package to visualize the phylogenetic trees retrieved from `MgDb` or `mgFeatures` objects.

## Reference documentation
- [metagenomeFeatures classes and methods.](./references/MgDb_and_mgFeatures_classes.md)
- [Exploring sequence and phylogenetic diversity for a taxonomic group of interest.](./references/database-explore.md)
- [Using metagenomeFeatures to Retrieve Feature Data.](./references/retrieve-feature-data.md)