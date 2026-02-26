---
name: r-bio3d
description: The r-bio3d tool provides utilities for processing, organizing, and exploring biological structure, sequence, and dynamics data in R. Use when user asks to manipulate PDB files, perform sequence or structure alignment, conduct Normal Mode Analysis, execute Principal Component Analysis on structural ensembles, or analyze molecular dynamics trajectories.
homepage: https://cloud.r-project.org/web/packages/bio3d/index.html
---


# r-bio3d

name: r-bio3d
description: Utilities for processing, organizing, and exploring biological structure, sequence, and dynamics data. Use this skill when performing structural bioinformatics in R, including PDB manipulation, atom selection, sequence/structure alignment, Normal Mode Analysis (NMA), Principal Component Analysis (PCA) of structures, and molecular dynamics trajectory analysis.

## Overview

The `bio3d` package is a comprehensive R framework for biological structure analysis. It bridges the gap between structural data (PDB, CHARMM/NAMD/GROMACS trajectories) and the statistical power of R. Key capabilities include:
- Reading/writing PDB and trajectory files.
- Atom selection and coordinate manipulation.
- Sequence and structure alignment.
- Normal Mode Analysis (NMA) and Ensemble NMA (eNMA).
- Principal Component Analysis (PCA) of structural ensembles.
- Correlation Network Analysis (CNA).

## Installation

Install the package from CRAN:

```r
install.packages("bio3d")
library(bio3d)
```

## Core Workflows

### 1. PDB Structure Manipulation
Read a structure and perform atom selection to isolate specific components.

```r
# Read a PDB file
pdb <- read.pdb("1hel")

# Select CA atoms
ca.inds <- atom.select(pdb, "calpha")

# Access coordinates and sequence
coords <- pdb$xyz[, ca.inds$xyz]
seq <- pdbseq(pdb)

# Trim PDB to selection
new.pdb <- trim.pdb(pdb, ca.inds)
write.pdb(new.pdb, file="ca_only.pdb")
```

### 2. Sequence and Structure Alignment
Align multiple structures to a common reference for comparative analysis.

```r
# Get PDB codes
ids <- c("1hel", "1dqz", "1ghl")
files <- get.pdb(ids, split=TRUE)

# Align sequences
pdbs <- pdbaln(files)

# Superimpose structures
xyz <- pdbfit(pdbs)

# Calculate Root Mean Square Fluctuations (RMSF)
rd <- rmsf(xyz)
plot(rd, typ="l", ylab="RMSF", xlab="Residue Index")
```

### 3. Normal Mode Analysis (NMA)
Predict protein flexibility and large-scale conformational changes.

```r
# Single structure NMA
pdb <- read.pdb("1hel")
modes <- nma(pdb)
plot(modes)

# Visualize first mode
m7 <- mktrj(modes, mode=7, file="mode_7.pdb")

# Ensemble NMA (eNMA) for multiple structures
# Assumes 'pdbs' object from pdbaln()
modes.ens <- nma(pdbs)
```

### 4. Principal Component Analysis (PCA)
Analyze the dominant variance in a structural ensemble or trajectory.

```r
# PCA on aligned coordinates
pc <- pca.xyz(pdbs$xyz)

# Plot PCA results (Conformational space)
plot(pc, col=annotation[, "color"])

# Identify residues contributing to PC1
res <- flux(pc, pc=1)
```

### 5. Trajectory Analysis
Process Molecular Dynamics (MD) data.

```r
# Read topology and trajectory
pdb <- read.pdb("topo.pdb")
trj <- read.dcd("traj.dcd")

# Align trajectory to reference
trj <- fit.xyz(fixed=pdb$xyz, mobile=trj,
               fixed.inds=atom.select(pdb, "calpha")$xyz,
               mobile.inds=atom.select(pdb, "calpha")$xyz)

# Calculate RMSD over time
rd <- rmsd(pdb$xyz, trj)
```

## Tips and Best Practices
- **Atom Selection**: Use `atom.select()` with strings like "calpha", "backbone", or "protein" for quick filtering. Use `combine.select()` for complex logic.
- **Coordinate Format**: Bio3D stores coordinates in a 1D vector (x1, y1, z1, x2, y2, z2...). Use `as.xyz()` to convert matrices if needed.
- **Parallelization**: Many functions like `nma.pdbs()` support `ncore` arguments to utilize multiple CPU cores.
- **External Tools**: For certain functions (like `muscle` for alignment), ensure the external executable is in your system PATH or specify the path in the function call.

## Reference documentation
- [bio3d Vignettes](./references/bio3d_vignettes.Rmd)