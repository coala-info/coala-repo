---
name: pysnptools
description: Pysnptools is a high-performance Python library for efficiently loading, subsetting, and processing large-scale genomic datasets using memory-mapping and lazy-loading. Use when user asks to load PLINK files, subset genetic data by individuals or markers, standardize genotypes, or prepare SNP matrices for GWAS and machine learning workflows.
homepage: http://research.microsoft.com/en-us/um/redmond/projects/mscompbio/
metadata:
  docker_image: "quay.io/biocontainers/pysnptools:0.3.13--py27_0"
---

# pysnptools

## Overview
The `pysnptools` library is a high-performance Python toolkit developed by Microsoft Research for genomic data science. It excels at handling massive genetic datasets that exceed memory capacity by using memory-mapping and lazy-loading techniques. Use this skill to streamline the process of loading SNP data, subsetting individuals or markers, and preparing data for Genome-Wide Association Studies (GWAS) or machine learning workflows.

## Core Usage Patterns

### Loading Genetic Data
The library uses a consistent interface for different file formats. The most common is the PLINK Bed format.

```python
from pysnptools.snpreader import Bed, Pheno, Dat

# Load a PLINK dataset (lazy loading)
snp_reader = Bed("path/to/data.bed", count_A1=True)

# Load phenotypes or covariates
pheno_reader = Pheno("path/to/pheno.txt")
```

### Data Inspection
Access metadata without loading the entire genotype matrix into memory.

```python
# Get dimensions
num_individuals = snp_reader.iid_count
num_snps = snp_reader.sid_count

# Access IDs
individual_ids = snp_reader.iid  # Family ID and Individual ID pairs
snp_ids = snp_reader.sid         # SNP identifiers
pos = snp_reader.pos             # Chromosome, genetic distance, basepair position
```

### Slicing and Subsetting
`pysnptools` supports advanced indexing to create "views" of the data without copying.

```python
# Subset by index: first 100 individuals and specific SNPs
subset = snp_reader[:100, [0, 5, 10]]

# Subset by ID using logic
mask = [id.startswith('HG') for id in snp_reader.sid]
filtered_reader = snp_reader[:, mask]
```

### Reading into Memory
To perform calculations, read the data into a NumPy-based `SnpData` object.

```python
# Read all data into memory (as float64 by default)
snp_data = snp_reader.read()

# Read as float32 to save memory
snp_data_32 = snp_reader.read(dtype='float32')

# Access the underlying NumPy array
matrix = snp_data.val
```

## Expert Tips
- **Memory Efficiency**: Always perform subsetting (slicing) on the `Reader` object *before* calling `.read()`. This ensures only the necessary data is loaded into RAM.
- **Standardization**: Use `snp_data.standardize()` to center and unit-variance scale genotypes, which is a requirement for many linear mixed model (LMM) solvers.
- **Kernel Calculation**: For relationship matrices, use the `KernelReader` classes to compute $XX^T$ efficiently.
- **Missing Data**: `pysnptools` represents genotypes as floats (0.0, 1.0, 2.0). Missing values are typically represented as `NaN`.

## Reference documentation
- [pysnptools Overview](./references/anaconda_org_channels_bioconda_packages_pysnptools_overview.md)