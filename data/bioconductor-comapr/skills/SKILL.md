---
name: bioconductor-comapr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/comapr.html
---

# bioconductor-comapr

name: bioconductor-comapr
description: Genetic crossover analysis and visualization for single-cell or bulk sequencing data. Use this skill when analyzing recombination events, constructing genetic maps, or identifying crossover hotspots using the comapr R package.

# bioconductor-comapr

## Overview
The `comapr` package provides a specialized framework for detecting and analyzing crossovers (COs) from haplotyped genomic data. It is particularly designed for single-cell gamete sequencing but is applicable to any study where crossover positions need to be mapped and compared across samples or groups. The package uses a `GRanges` based workflow to store crossover intervals and provides tools for genetic distance calculation and visualization.

## Core Workflow

### 1. Data Input and Object Creation
`comapr` typically starts with haplotyped SNP data.
- `readHaplotypedSnps()`: Import SNP data from VCF or text files.
- `makeComaprObj()`: Create the core data object.
- `findHaploSegments()`: Identify haplotype segments for each individual/cell.

### 2. Crossover Detection
- `findCrossovers()`: The primary function to identify CO events. It locates the intervals where haplotype phase changes occur.
- `filterCrossovers()`: Remove low-confidence COs based on interval size or number of supporting SNPs.

### 3. Genetic Mapping and Analysis
- `calGeneticDist()`: Calculate genetic distances (Centimorgans) for specific genomic windows or whole chromosomes.
- `calcCoRate()`: Calculate crossover rates across different sample groups.
- `countCrossovers()`: Generate a count matrix of COs per sample per chromosome.

### 4. Visualization
- `plotCrossovers()`: Visualize the distribution of COs along chromosomes.
- `plotGeneticMap()`: Compare genetic maps across different experimental groups or individuals.
- `plotCoIntervals()`: Detailed view of the genomic intervals where COs were detected.

## Usage Tips
- **Interval Resolution**: The precision of CO detection depends on SNP density. Always check the `interval_size` column in the output of `findCrossovers`.
- **Filtering**: Single-cell data can be noisy. Use `filterCrossovers` to exclude intervals that are too large to be informative or those with insufficient SNP support.
- **Group Comparisons**: Most plotting and calculation functions support a `group_by` argument to facilitate comparisons between wild-type and mutants or different environmental conditions.

## Reference documentation
- [comapr Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/comapr.html)