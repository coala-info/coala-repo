---
name: bioconductor-spacepac
description: This tool identifies mutational clusters in 3D protein tertiary structures using simulation or Poisson distribution methods. Use when user asks to identify mutational hotspots in protein space, find optimal spheres capturing significant mutations, or analyze somatic mutation data in the context of protein folding.
homepage: https://bioconductor.org/packages/3.6/bioc/html/SpacePAC.html
---


# bioconductor-spacepac

name: bioconductor-spacepac
description: Identify mutational clusters (hotspots) in 3D protein tertiary structure using simulation or Poisson distribution methods. Use this skill when analyzing somatic mutation data in the context of protein folding to find 1, 2, or 3 non-overlapping spheres that capture a statistically significant number of mutations.

## Overview

SpacePAC (Spatial Protein Amino acid Clustering) identifies mutational hotspots directly in 3D space, providing an alternative to methods that remap proteins to 1D space (like iPAC or GraphPAC). It identifies the optimal 1, 2, or 3 spheres of a given radius that cover the maximum number of mutations and calculates significance via simulation or a Poisson distribution.

## Typical Workflow

### 1. Data Preparation
SpacePAC requires three components:
- **Positional Data**: 3D coordinates of amino acids (usually from PDB/CIF files).
- **Mutation Data**: An $m \times n$ matrix (individuals $\times$ residues) where 1 indicates a mutation. Column names must be `V1, V2, ..., Vn`.
- **Alignment**: Reconciliation between the protein sequence and the structural data.

```r
library(SpacePAC)
# Example: Get positions for PIK3CA (PDB: 2ENQ)
CIF <- "http://www.pdb.org/pdb/files/2ENQ.cif"
Fasta <- "http://www.uniprot.org/uniprot/P42336.fasta"
# get.AlignedPositions is inherited/shared logic with iPAC
PIK3CA.Positions <- get.AlignedPositions(CIF, Fasta, "A")

# Load mutation data (example dataset provided in package)
data(PIK3CA.Mutations)
```

### 2. Identifying Clusters (Simulation Method)
The `SpaceClust` function is the primary interface. The `SimMax` method is generally preferred as it accounts for multiple radii and sphere combinations through simulation.

```r
# Identify clusters using simulation
my.clusters <- SpaceClust(
  mutation.data = PIK3CA.Mutations, 
  position.data = PIK3CA.Positions$Positions, 
  numsims = 1000, 
  simMaxSpheres = 3, 
  radii.vector = c(1, 2, 3, 4), 
  method = "SimMax"
)

# View results
print(my.clusters$p.value)
print(my.clusters$optimal.num.spheres)
print(my.clusters$optimal.radius)
```

### 3. Identifying Clusters (Poisson Method)
Use the Poisson method for faster calculation on shorter proteins or when only considering a single radius. Note that this method requires multiple comparison adjustments.

```r
# Identify clusters using Poisson distribution
poisson.clusters <- SpaceClust(
  mutation.data = KRAS.Mutations, 
  position.data = KRAS.Positions$Positions, 
  radii.vector = c(1, 2, 3, 4), 
  alpha = 0.05, 
  method = "Poisson"
)
```

### 4. Visualization
SpacePAC provides basic 3D plotting using the `rgl` package to render a sphere on the protein structure.

```r
# Plot a sphere of radius 3 centered at residue 12
make.3D.Sphere(KRAS.Positions$Positions, center = 12, radius = 3)
```

## Key Parameters for SpaceClust
- `mutation.data`: Matrix of mutations (0/1).
- `position.data`: Matrix of X, Y, Z coordinates.
- `numsims`: Number of simulations (typically $\ge 1000$).
- `simMaxSpheres`: Maximum number of non-overlapping spheres to consider (1, 2, or 3).
- `radii.vector`: A vector of radii (e.g., in Angstroms) to test.
- `method`: Either `"SimMax"` (Simulation) or `"Poisson"`.

## Interpreting Results
The output object contains:
- `p.value`: The significance of the observed mutational capture.
- `optimal.num.spheres`: The number of spheres (1-3) that yielded the best result.
- `optimal.radius`: The radius from the `radii.vector` that was most significant.
- `optimal.sphere`: Details on the centers and mutation counts of the identified hotspots.

## Reference documentation
- [SpacePAC](./references/SpacePAC.md)