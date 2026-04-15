---
name: bioconductor-ipac
description: This tool identifies somatic mutation clustering in proteins by integrating 3D structural data with mutational data. Use when user asks to identify non-random mutational clusters, map 3D protein coordinates into 1D space, or align structural and canonical sequences to detect physically close mutations.
homepage: https://bioconductor.org/packages/3.6/bioc/html/iPAC.html
---

# bioconductor-ipac

name: bioconductor-ipac
description: Identification of Protein Amino acid Mutations (iPAC). Use this skill to identify somatic mutation clustering in proteins while accounting for 3D structural information. It maps 3D coordinates into 1D space using Multidimensional Scaling (MDS) or linear methods to detect clusters that are physically close but may be distant in the primary sequence.

## Overview

The `iPAC` package identifies non-random mutational clusters in proteins by integrating structural data from the Protein Data Bank (PDB) with mutational data (e.g., from COSMIC). It uses the Nonrandom Mutation Clustering (NMC) algorithm to determine if pairwise mutations are closer than expected by chance.

## Core Workflow

### 1. Load Data
You need a mutation matrix (rows = samples/mutations, columns = amino acids) and structural data (CIF and FASTA files).

```r
library(iPAC)
# Example mutation data
data(KRAS.Mutations)
```

### 2. Align Structural and Canonical Sequences
Because PDB numbering often differs from canonical numbering, you must align them to create a position matrix.

*   **get.Positions**: Extracts positions directly from a CIF file.
*   **get.AlignedPositions**: Uses a pairwise alignment algorithm (more robust for complex files).

```r
CIF <- "https://files.rcsb.org/view/3GFT.cif"
Fasta <- "http://www.uniprot.org/uniprot/P01116-2.fasta"

# Extract positions for chain A
KRAS.Positions <- get.Positions(CIF, Fasta, "A")
```

### 3. Find Clusters in 3D Space
Use `ClusterFind` to perform the remapping and cluster detection. The "MDS" method is recommended for statistical rigor.

```r
results <- ClusterFind(mutation.data = KRAS.Mutations, 
                       position.data = KRAS.Positions$Positions, 
                       method = "MDS", 
                       create.map = "Y", 
                       Show.Graph = "Y")
```

## Interpreting Results

The `ClusterFind` function returns a list:
*   **$Remapped**: Clusters found using 3D structural information.
*   **$OriginalCulled**: Clusters found using the NMC algorithm on only the amino acids that have 3D coordinates.
*   **$Original**: Clusters found using the NMC algorithm on the full sequence (ignoring 3D data).
*   **$MissingPositions**: Amino acids present in the mutation data but missing from the structural data.

**Note:** To evaluate the impact of 3D structure, compare `$Remapped` against `$OriginalCulled`.

## Tips and Best Practices
*   **Method Selection**: Always prefer `method = "MDS"` over `"Linear"` for publication-quality analysis.
*   **Data Consistency**: Ensure the FASTA file used for alignment matches the source of your mutation data (e.g., if using COSMIC mutations, use the COSMIC canonical sequence).
*   **Mismatches**: Check `KRAS.Positions$External.Mismatch` and `KRAS.Positions$PDB.Mismatch` to identify residues that do not align between the structural and canonical sequences.

## Reference documentation
- [iPAC](./references/iPAC.md)