---
name: pyensembl
description: "Pyensembl provides a Python interface for downloading, indexing, and querying Ensembl reference genome metadata and sequences. Use when user asks to retrieve genomic features by ID or name, find genes at specific chromosomal coordinates, or access protein sequences from Ensembl releases."
homepage: https://github.com/openvax/pyensembl
---

# pyensembl

## Overview

The `pyensembl` tool provides a streamlined Python interface for interacting with Ensembl reference genome metadata. It automates the process of downloading GTF and FASTA files from Ensembl FTP servers and indexing them into a local SQLite database for fast querying. This skill enables efficient retrieval of genomic elements based on IDs, names, or chromosomal coordinates, and supports both standard Ensembl releases and custom user-provided genomic data.

## Installation and Setup

Before querying, you must download and index the reference data.

### CLI Management
Use the command line to prepare the local environment:

```bash
# Install specific human releases
pyensembl install --release 75 100 --species human

# List all currently installed and indexed genomes
pyensembl list
```

### Cache Configuration
By default, data is stored in a platform-specific cache folder. To use a specific directory (e.g., on a high-capacity drive), set the environment variable:

```bash
export PYENSEMBL_CACHE_DIR=/path/to/genomic_data
```

## Core Python API Usage

### Initializing a Reference
The `EnsemblRelease` object is the primary entry point for standard Ensembl data.

```python
from pyensembl import EnsemblRelease

# Load human GRCh38 (Release 77)
data = EnsemblRelease(77)

# If not already installed via CLI, you can trigger it in script:
# data.download()
# data.index()
```

### Common Query Patterns

#### Locus-based Lookups
Find features overlapping a specific genomic position:

```python
# Returns a list of gene names at a specific locus
genes = data.gene_names_at_locus(contig=6, position=29945884)

# Get full Gene objects for a range
gene_objects = data.genes_at_locus(contig='1', start=1000, end=2000)
```

#### ID and Name Mapping
Convert between different genomic identifiers:

```python
# Get gene ID from name
gene_ids = data.gene_ids_of_gene_name('BRCA1')

# Get transcript IDs for a gene
transcript_ids = data.transcript_ids_of_gene_name('HLA-A')

# Access specific objects
gene = data.gene_by_id('ENSG00000012048')
transcript = data.transcript_by_id('ENST00000369985')
```

### Working with Sequences
If FASTA files were indexed, you can access protein information:

```python
transcript = data.transcript_by_id('ENST00000369985')
print(transcript.protein_id)
print(transcript.protein_sequence)
```

## Custom Genomes
For non-Ensembl data or specific versions not in the main repository, use the `Genome` class with local paths:

```python
from pyensembl import Genome

custom_data = Genome(
    reference_name='MyRef',
    annotation_name='v1',
    gtf_path_or_url='/path/to/features.gtf',
    transcript_fasta_paths_or_urls=['/path/to/transcripts.fa']
)

custom_data.index()
```

## Expert Tips
- **Contig Naming**: Ensembl typically uses bare numbers/letters (e.g., `1`, `X`) rather than `chr1`. Ensure your `contig` arguments match the Ensembl convention unless using a custom GTF.
- **Memory Efficiency**: `pyensembl` uses a local SQLite database, making it memory-efficient for large genomes compared to loading full GTF files into Pandas.
- **Batch Processing**: When performing thousands of lookups, reuse the same `EnsemblRelease` or `Genome` instance to avoid repeated database connection overhead.



## Subcommands

| Command | Description |
|---------|-------------|
| pyensembl | Manipulate pyensembl's local cache. |
| pyensembl | Manipulate pyensembl's local cache. |
| pyensembl | Manipulate pyensembl's local cache. |
| pyensembl delete-index-files | Deletes all files other than the original GTF and FASTA files for a genome. |

## Reference documentation
- [GitHub - openvax/pyensembl](./references/github_com_openvax_pyensembl.md)