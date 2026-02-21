---
name: bioconductor-chemminer
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/ChemmineR.html
---

# bioconductor-chemminer

name: bioconductor-chemminer
description: Comprehensive cheminformatics analysis in R, including SDF/SMILES import/export, structural property calculations, similarity searching (atom pairs/fingerprints), and compound clustering. Use this skill when you need to process small molecule data, calculate molecular weights/formulas, perform Tanimoto similarity searches, or cluster chemical libraries.

# bioconductor-chemminer

## Overview
`ChemmineR` is a powerful toolkit for analyzing drug-like small molecules within the R environment. It provides S4 classes for handling Structural Data Files (SDF) and SMILES strings, allowing for efficient structural property predictions, similarity searching, and clustering. It integrates with `ChemmineOB` (OpenBabel) for advanced coordinate generation and format conversion.

## Core Workflows

### 1. Data Import and Export
The package uses `SDFset` and `SMIset` containers to manage multiple molecules.

```r
library(ChemmineR)

# Import SDF or SMILES
sdfset <- read.SDFset("molecules.sdf")
smiset <- read.SMIset("molecules.smi")

# Basic inspection
view(sdfset[1:4])
cid(sdfset) # Get compound IDs
sdfid(sdfset) # Get IDs from SDF header

# Export
write.SDF(sdfset, file="output.sdf")
write.SMI(smiset, file="output.smi")
```

### 2. Molecular Property Calculation
Calculate physicochemical descriptors and atom frequencies.

```r
# Molecular Weight and Formula
mws <- MW(sdfset)
mfs <- MF(sdfset)

# Atom counts and functional groups
prop_matrix <- data.frame(
    MW = MW(sdfset),
    MF = MF(sdfset),
    atomcountMA(sdfset),
    groups(sdfset, type="countMA"),
    rings(sdfset, upper=6, type="count", arom=TRUE)
)

# Extract data blocks (annotations) to matrix
db_matrix <- datablock2ma(datablock(sdfset))
```

### 3. Structural Similarity Searching
Use Atom Pairs (AP) or Fingerprints (FP) for similarity comparisons.

```r
# Generate Atom Pair descriptors
apset <- sdf2ap(sdfset)

# Tanimoto similarity search
# type=3 returns a data frame with scores
search_results <- cmp.search(apset, apset[1], type=3, cutoff=0.3)

# Using Fingerprints (FPset)
fpset <- desc2fp(apset)
fp_sim <- fpSim(fpset[1], fpset, method="Tanimoto", cutoff=0.4)
```

### 4. Clustering
Group compounds based on structural similarity.

```r
# Binning clustering (Single linkage)
clusters <- cmp.cluster(db=apset, cutoff=c(0.6, 0.8))

# Jarvis-Patrick clustering
nn <- nearestNeighbors(fpset, numNbrs=6)
jp_clusters <- jarvisPatrick(nn, k=5, mode="a1a2b")

# Visualize clusters using MDS
cluster.visualize(apset, clusters, size.cutoff=2)
```

### 5. Visualization
Render 2D structures directly in R or via web interfaces.

```r
# Plot to R graphics device
plot(sdfset[1:4])

# Highlight substructures (by atom index)
plot(sdfset[1], colbonds=c(1, 2, 3, 5))

# Web-based visualization
sdf.visualize(sdfset[1:4])
```

## Advanced Features
- **OpenBabel Integration**: If `ChemmineOB` is installed, use `regenerateCoords(sdfset)` for better plots or `generate3DCoords(sdfset)`.
- **Large Scale Processing**: Use `sdfStream` to process millions of molecules by streaming through files without loading everything into memory.
- **Database Support**: Use `initDb`, `loadSdf`, and `findCompounds` to manage molecules in an SQLite database for fast retrieval.

## Tips for Success
- **Hydrogen Handling**: Many functions (MW, MF, atomcount) have an `addH` parameter. Set `addH=TRUE` if your source SDFs lack explicit hydrogens to ensure accurate calculations.
- **Unique IDs**: Use `makeUnique(sdfid(sdfset))` and assign it to `cid(sdfset)` to prevent errors in downstream clustering or searching caused by duplicate names.
- **Subsetting**: `SDFset` objects behave like lists. Use `sdfset[1:10]` for a subset and `sdfset[[1]]` to extract a single `SDF` object.

## Reference documentation
- [ChemmineR: Cheminformatics Toolkit for R](./references/ChemmineR.md)
- [ChemmineR Vignette Source](./references/ChemmineR.Rmd)