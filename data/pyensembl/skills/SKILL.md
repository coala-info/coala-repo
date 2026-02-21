---
name: pyensembl
description: PyEnsembl is a Python library and command-line tool designed to simplify access to genomic annotations.
homepage: https://github.com/openvax/pyensembl
---

# pyensembl

## Overview
PyEnsembl is a Python library and command-line tool designed to simplify access to genomic annotations. It automates the downloading and indexing of Ensembl data (GTF and FASTA files) into a local SQLite database, providing a high-level API to query genomic features. Use this skill when you need to perform lookups of genomic elements by ID, name, or locus, or when working with custom genomic annotations that follow the GTF format.

## Installation and Setup
Install the package via pip or conda:
```bash
pip install pyensembl
# OR
conda install bioconda::pyensembl
```

Before querying, you must download and index the desired reference data:
```bash
# Install specific human releases
pyensembl install --release 75 110 --species human

# List currently installed and indexed genomes
pyensembl list
```

## Common CLI Patterns
The `pyensembl` command-line interface is primarily used for data management.
- **Download and Index**: `pyensembl install --release <num> --species <name>`
- **Check Cache**: `pyensembl list` to see which genomes are ready for use in Python scripts.
- **Delete Cache**: Manually clear the directory defined in `PYENSEMBL_CACHE_DIR` if data corruption occurs.

## Python API Best Practices

### Initializing a Genome
Always specify the release and species to ensure reproducibility.
```python
from pyensembl import EnsemblRelease

# Release 77 is a common choice for human GRCh38
data = EnsemblRelease(77)

# For non-human species, specify the species name
fly_data = EnsemblRelease(release=100, species='drosophila_melanogaster')
```

### Querying by Locus
When searching for genes at a specific position, the library returns a list to account for overlapping features.
```python
# Returns a list of gene names at the given chromosome and position
genes = data.gene_names_at_locus(contig=6, position=29945884)
```

### Accessing Feature Hierarchies
Navigate from Genes to Transcripts to Proteins:
```python
gene = data.gene_by_id('ENSG00000068793')
for transcript in gene.transcripts:
    print(transcript.id, transcript.sequence)
    if transcript.is_protein_coding:
        print(transcript.protein_id, transcript.protein_sequence)
```

### Working with Custom Data
Use the `Genome` class for non-Ensembl GTF/FASTA files.
```python
from pyensembl import Genome

custom_data = Genome(
    reference_name='MyRef',
    annotation_name='v1',
    gtf_path_or_url='/path/to/features.gtf',
    transcript_fasta_paths_or_urls=['/path/to/cdna.fa']
)
custom_data.index()
```

## Expert Tips
- **Cache Location**: By default, PyEnsembl uses platform-specific cache folders. Override this by setting the `PYENSEMBL_CACHE_DIR` environment variable to a high-capacity disk, as genomic indices can become quite large.
- **Lazy Loading**: PyEnsembl objects don't load the database into memory until a query is made. You can initialize multiple `EnsemblRelease` objects without significant overhead.
- **Locus Ranges**: Use the `end` parameter in `genes_at_locus` to search across a genomic window rather than a single point.
- **Data Integrity**: If a download is interrupted, the index may be partial. Use `ensembl_object.download(overwrite=True)` and `ensembl_object.index(overwrite=True)` in Python to force a clean state.

## Reference documentation
- [PyEnsembl GitHub Repository](./references/github_com_openvax_pyensembl.md)
- [Bioconda PyEnsembl Overview](./references/anaconda_org_channels_bioconda_packages_pyensembl_overview.md)