---
name: omamer
description: OMAmer is a high-performance tool designed for protein family assignment that bypasses traditional sequence alignment in favor of an evolutionary-informed k-mer mapping approach.
homepage: https://github.com/DessimozLab/omamer
---

# omamer

## Overview

OMAmer is a high-performance tool designed for protein family assignment that bypasses traditional sequence alignment in favor of an evolutionary-informed k-mer mapping approach. It maps query sequences to ancestral protein sub-families (HOGs) defined within the OMA (Orthologous Matrix) database. This method is significantly faster than alignment-based tools like DIAMOND and is specifically optimized to prevent over-specific subfamily assignments while maintaining high sensitivity for homologous family-level placement.

## Installation and Environment

OMAmer requires Python >= 3.8. Note that Python 3.12 is currently unsupported due to dependencies on the `numba` package.

```bash
# Recommended installation via Bioconda
conda install bioconda::omamer

# Alternative installation via PyPI
pip install omamer
```

## Core Workflows

### Searching a Database
The primary function of OMAmer is to assign proteins to families and subfamilies using a pre-built H5 database.

```bash
omamer search -d path/to/database.h5 -q query_sequences.fasta -o results.tsv
```

**Key Parameters:**
- `--threshold` (Default: 0.1): Controls the specificity of predicted HOGs. Lowering this value makes predictions more specific (potentially over-specific).
- `--family_alpha` (Default: 1e-6): Significance threshold for filtering families based on a binomial distribution of k-mer hits.
- `--family_only`: Skips subfamily placement; useful for broad classification.
- `--nthreads`: Set the number of threads for parallel processing.
- `--include_extant_genes`: Adds a column with comma-separated extant gene IDs belonging to the predicted HOG.

### Building a Custom Database
To build a database, you must provide the OMA browser's database file and a species phylogeny.

```bash
omamer mkdb --db output_database.h5 --oma_path path/to/OmaServer.h5
```

**Key Parameters:**
- `--min_fam_size`: Minimum protein count for a root-HOG to be included.
- `--root_taxon`: Specify the taxonomic root for the database.

## Interpreting Results

The output is a TSV file. Key columns include:
- **hogid**: The Hierarchical Orthologous Group identifier (e.g., `HOG:0487954.3l.27l`).
- **subfamily_score**: The OMAmer-score capturing the excess similarity shared between the query and the HOG.
- **qseq_overlap**: The proportion of the query sequence overlapping with k-mers of the reference root-HOG. Use this to reject partially homologous matches.
- **family_p**: The p-value (in negative natural log units) of the family-level assignment.

## Expert Tips

- **Pre-built Databases**: Instead of building your own, use pre-built databases for major clades (LUCA, Metazoa, Viridiplantae, Primates) available on the [OMA Browser website](https://omabrowser.org/).
- **Memory Management**: Use the `--chunksize` parameter (default 10,000) to manage the number of queries processed at once if encountering memory constraints.
- **Programmatic Access**: For downstream analysis in Python, use the built-in results reader:
  ```python
  from omamer.results_reader import results_reader
  # Load and parse the TSV output
  ```

## Reference documentation
- [OMAmer GitHub Repository](./references/github_com_DessimozLab_omamer.md)
- [OMAmer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_omamer_overview.md)