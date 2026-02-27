---
name: bioconductor-pbase
description: Bioconductor-pbase provides a framework for managing, mapping, and visualizing protein sequences and proteomics identification data using Proteins objects. Use when user asks to load protein sequences from FASTA files, map peptide-spectrum matches onto protein coordinates, or generate protein-centric visualizations of MS/MS data.
homepage: https://bioconductor.org/packages/3.6/bioc/html/Pbase.html
---


# bioconductor-pbase

name: bioconductor-pbase
description: Specialized for protein sequence and proteomics data analysis using the Bioconductor Pbase package. Use this skill when you need to manage, map, and visualize protein sequences (fasta) alongside identification data (MS/MS PSMs). It is particularly useful for mapping peptide features onto protein coordinates, handling Proteins objects, and generating protein-centric visualizations.

# bioconductor-pbase

## Overview

The `Pbase` package provides a framework for protein-centric data analysis. Its core data structure is the `Proteins` object, which encapsulates protein sequences, their annotations, and associated peptide features (such as those derived from mass spectrometry experiments). This skill enables the mapping of experimental peptide data onto reference protein sequences to facilitate spatial analysis of proteomics results.

## Core Workflows

### 1. Creating Proteins Objects
The primary entry point is loading protein sequences from a FASTA file.

```r
library(Pbase)

# Load from FASTA
fafile <- system.file("extdata/HUMAN_2015_02_selected.fasta", package = "Pbase")
p <- Proteins(fafile)
```

### 2. Adding Identification Data
You can map peptide-spectrum matches (PSMs) from identification files (e.g., .mzid) onto the protein sequences.

```r
idfile <- system.file("extdata/Thermo_Hela_PRTC_selected.mzid", package = "Pbase")
p <- addIdentificationData(p, idfile)
```

### 3. Data Access and Inspection
Use specific accessors to retrieve different components of the `Proteins` object:

*   `aa(p)`: Returns the amino acid sequences as an `AAStringSet`.
*   `seqnames(p)`: Returns the names/accessions of the proteins.
*   `pranges(p)`: Returns the coordinates (ranges) of peptides mapped to the proteins.
*   `pfeatures(p)`: Returns the actual peptide sequences.
*   `acols(p)`: Accesses protein-level annotation columns (DataFrame).
*   `pcols(p)`: Accesses peptide-level annotation columns (DataFrame).
*   `metadata(p)`: Returns general metadata about the object.

### 4. Visualization
`Pbase` provides a default plot method to visualize the protein sequences and the distribution of mapped peptides.

```r
# Plot specific proteins by index or name
plot(p[c(1, 9)])
```

### 5. Subsetting
`Proteins` objects support standard R indexing to focus on specific proteins of interest.

```r
# Subset by index
p_sub <- p[1:5]

# Subset by name
p_named <- p["P02768"]
```

## Tips for Success
*   **Data Consistency**: Ensure that the protein accessions in your identification data (mzid) match the headers in your FASTA file for successful mapping.
*   **Memory Management**: For very large FASTA databases, consider subsetting the `Proteins` object to only those proteins identified in your experiment to improve performance.
*   **Integration**: `Pbase` integrates with other Bioconductor classes like `AAStringSet` (from `Biostrings`) and `DataFrame` (from `S4Vectors`), allowing for standard Bioconductor data manipulation patterns.

## Reference documentation
- [Pbase example data](./references/Pbase-data.Rmd)