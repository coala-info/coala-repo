---
name: plinkio
description: plinkio is a lightweight library focused on the I/O operations of PLINK genotype datasets.
homepage: https://github.com/mfranberg/libplinkio
---

# plinkio

## Overview

plinkio is a lightweight library focused on the I/O operations of PLINK genotype datasets. It provides a high-performance way to parse binary BED files and their associated metadata (BIM for loci and FAM for samples) without the overhead of larger genomic analysis suites. Use this skill to automate genotype data extraction, iterate through SNP rows, or generate new PLINK-formatted datasets from raw data.

## Installation and Setup

The library can be installed via Conda or Pip:

```bash
# Via Bioconda
conda install bioconda::plinkio

# Via Pip
pip install plinkio
```

## Python Usage Patterns

The Python API is the most common way to interact with plinkio.

### Reading Genotypes
When opening a file, provide the prefix only (do not include .bed, .bim, or .fam extensions).

```python
from plinkio import plinkfile

# Open the dataset
plink_file = plinkfile.open("/path/to/data_prefix")

# Verify orientation (SNPs as rows, samples as columns)
if not plink_file.one_locus_per_row():
    print("Data is not in SNP-major format.")

# Get metadata lists
samples = plink_file.get_samples()
loci = plink_file.get_loci()

# Iterate through genotypes
# Each 'row' is a list of genotypes for all samples at one locus
for locus, row in zip(loci, plink_file):
    for sample, genotype in zip(samples, row):
        # genotype: 0, 1, 2 (count of A2 alleles), or 3 (missing)
        if genotype != 3:
            print(f"Sample {sample.iid}, SNP {locus.name}: {genotype}")

plink_file.close()
```

### Creating New PLINK Files
You can create new datasets by defining Sample objects and writing rows.

```python
from plinkio import plinkfile

# Define samples (fid, iid, father, mother, sex, affection)
samples = [
    plinkfile.Sample("Fam1", "Ind1", "0", "0", 1, 1),
    plinkfile.Sample("Fam1", "Ind2", "0", "0", 2, 2)
]

# Create the file
new_file = plinkfile.create("output_prefix", samples)
# Note: Loci and genotypes are typically added during the writing process
```

## Data Representation

*   **Genotype Coding**: 
    *   `0, 1, 2`: Represents the number of **A2 alleles** as specified in the `.bim` file.
    *   `3`: Represents a **missing** genotype.
*   **Sample Attributes**: Accessible via `sample.fid`, `sample.iid`, `sample.sex`, `sample.affection`, and `sample.phenotype`.
*   **Locus Attributes**: Accessible via `locus.chromosome`, `locus.name`, `locus.position`, `locus.bp_position`, `locus.allele1`, and `locus.allele2`.

## Expert Tips and Best Practices

1.  **Prefix-Only Paths**: Always omit the file extension when calling `plinkfile.open()`. The library automatically looks for the triplet of files (.bed, .bim, .fam).
2.  **Orientation Check**: Always call `one_locus_per_row()` before processing. Most downstream tools expect SNP-major (locus-per-row) format. If it returns false, the file is in individual-major format.
3.  **Memory Management**: For very large datasets, use the iterator pattern (`for row in plink_file`) rather than loading all genotypes into a list. This streams the data from the binary file.
4.  **C Integration**: If performance is critical and you are working in C, use `pio_open` and `pio_next_row`. Ensure you allocate a buffer using `pio_row_size` to hold the genotypes for a single row.

## Reference documentation

- [libplinkio GitHub Repository](./references/github_com_mfranberg_libplinkio.md)
- [plinkio Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_plinkio_overview.md)