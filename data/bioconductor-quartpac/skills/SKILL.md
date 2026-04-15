---
name: bioconductor-quartpac
description: Bioconductor-quartpac identifies mutational clusters in protein quaternary structures by integrating data from multiple subunits. Use when user asks to identify somatic mutation hotspots in protein assemblies, analyze mutational clusters across different protein chains, or run iPAC, GraphPAC, and SpacePAC algorithms on quaternary structures.
homepage: https://bioconductor.org/packages/3.6/bioc/html/QuartPAC.html
---

# bioconductor-quartpac

name: bioconductor-quartpac
description: Identify mutational clusters in protein quaternary structures by integrating data from multiple subunits. Use this skill when analyzing somatic mutation hotspots while accounting for the 3D arrangement of protein assemblies, specifically using the iPAC, GraphPAC, and SpacePAC algorithms on quaternary structures.

## Overview
QuartPAC (Quaternary Protein Amino acid Clustering) identifies statistically significant mutational hotspots by considering the entire protein assembly rather than individual subunits in isolation. It acts as a preprocessing and integration layer that maps mutational data onto quaternary structures (from .pdb1 files) and then executes established clustering algorithms (iPAC, GraphPAC, and SpacePAC). This approach can reveal clusters that span across different protein chains which would be missed in tertiary structure analysis.

## Core Workflow

### 1. Data Preparation
QuartPAC requires four specific data components:
- **UniProt ID**: The accession number for the protein subunits.
- **Mutation Data**: An $m \times n$ matrix (individuals $\times$ residues) where 1 indicates a mutation. Column headers must be "V1", "V2", ..., "Vn".
- **Tertiary Structure**: Standard .pdb file.
- **Quaternary Structure**: The assembly file (.pdb1).

### 2. Loading Mutations
Use `getMutations` to aggregate mutation files for all subunits in the assembly.

```r
library(QuartPAC)

# List paths to mutation text files for each subunit
mutation_files <- list(
  system.file("extdata", "Subunit1_Mutations.txt", package = "QuartPAC"),
  system.file("extdata", "Subunit2_Mutations.txt", package = "QuartPAC")
)

# Corresponding UniProt IDs
uniprots <- list("Q30201", "P61769")

mutation.data <- getMutations(mutation_files = mutation_files, uniprots = uniprots)
```

### 3. Creating the Superstructure
Align the mutational data with the quaternary assembly using `makeAlignedSuperStructure`.

```r
pdb.location <- "https://files.rcsb.org/view/1A6Z.pdb"
assembly.location <- "https://files.rcsb.org/download/1A6Z.pdb1"

structural.data <- makeAlignedSuperStructure(pdb.location, assembly.location)
```

### 4. Running Cluster Analysis
The `quartCluster` function executes the analysis. You can toggle specific algorithms (iPAC, GraphPAC, SpacePAC) on or off.

```r
quart_results <- quartCluster(
  mutation.data, 
  structural.data, 
  perform.ipac = "Y", 
  perform.graphpac = "Y", 
  perform.spacepac = "Y",
  create.map = "Y",        # Generates MDS remapping plot
  alpha = 0.05,            # Significance threshold
  MultComp = "BH",         # Multiple comparison adjustment (e.g., "None", "BH")
  radii.vector = c(1:3)    # For SpacePAC simulation
)
```

## Interpreting Results

### Accessing Cluster Information
Results are organized by the method used. Note that amino acid positions in QuartPAC refer to **serial numbers** within the .pdb1 file.

- **iPAC/GraphPAC**: `quart_results$ipac` or `quart_results$graphpac`
- **SpacePAC**: `quart_results$spacepac$optimal.sphere`

### Mapping Serial Numbers to Residues
To find which specific residue a cluster serial number refers to, query the `aligned_structure` within the structural data object:

```r
# Find residue info for serial number 1265
res_info <- structural.data$aligned_structure[structural.data$aligned_structure$serial == 1265, ]
print(res_info)
```

### Visualization
- **MDS Plot**: Automatically generated if `create.map = "Y"` in `quartCluster`.
- **Jump Plot (GraphPAC)**: Use `Plot.Protein.Linear` to visualize the reordering of the protein path.

```r
Plot.Protein.Linear(
  quart_results$graphpac$candidate.path, 
  colCount = 10, 
  title = "GraphPAC 1D Reordering"
)
```

## Tips and Constraints
- **Input Format**: Ensure mutation matrices use the "V" prefix for column names (V1, V2...).
- **Mutation Types**: Only missense mutations are supported; indels are currently excluded.
- **Significance**: If no clusters are found for iPAC or GraphPAC after multiple comparison adjustment, the result may return null. SpacePAC always returns the most significant spheres regardless of p-value.
- **External Tools**: For 3D visualization (like PyMOL), use the `chainID` and `resSeq` columns extracted from `structural.data$aligned_structure` using the cluster serial numbers.

## Reference documentation
- [QuartPAC](./references/QuartPAC.md)