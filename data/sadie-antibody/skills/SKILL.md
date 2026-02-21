---
name: sadie-antibody
description: The `sadie-antibody` library is a comprehensive toolkit for immunoinformatics.
homepage: https://sadie.jordanrwillis.com
---

# sadie-antibody

## Overview
The `sadie-antibody` library is a comprehensive toolkit for immunoinformatics. It provides both a command-line interface and a Python API to process antibody sequences. You should use this skill to identify CDRs and frameworks, calculate somatic hypermutation levels, assign V(D)J genes, and cluster repertoires. It is particularly useful for transforming raw FASTA sequences into standardized AIRR (Adaptive Immune Receptor Repertoire) tables for downstream data science workflows.

## Installation
Install via pip or conda:
```bash
pip install sadie-antibody
# For M1/M2 Macs, biopython must be installed via conda-forge
conda install -c conda-forge biopython
```

## Command Line Interface (CLI)
The primary entry point is the `sadie` command.

### AIRR Annotation
Annotate sequences using the AIRR module (wraps IgBLAST):
```bash
# Annotate a FASTA file against human germline and output to CSV
sadie airr -n human my_sequences.fasta output.csv
```

### Sequence Numbering
Renumber sequences using HMMER-based alignment:
```bash
# Renumber amino acid sequences in a FASTA file
sadie renumbering -q sequences.fasta
```

## Python API Usage
The Python API is built on top of Pandas, returning `AirrTable` objects which are subclasses of `pandas.DataFrame`.

### Single Sequence Annotation
```python
from sadie.airr import Airr

# Initialize for a specific species
airr_api = Airr("human")

# Run annotation
airr_table = airr_api.run_single("Sequence_ID", "CAGCGATTAGT...")

# Export to AIRR-compliant TSV
airr_table.to_airr("output.tsv")
```

### Sequence Numbering and Region Definition
SADIE supports multiple schemes (Kabat, Chothia, IMGT) and region definitions.
```python
from sadie.renumbering import Renumbering

# Setup renumbering with specific scheme and region definitions
renumbering_api = Renumbering(scheme="chothia", region_assign="imgt")
numbering_table = renumbering_api.run_single("ID", "VRC26_SEQ...")

# Get a flattened alignment table
alignment_df = numbering_table.get_alignment_table()
```

### Sequence Clustering
Cluster sequences based on CDR similarity, often used for clonal lineage identification.
```python
from sadie.cluster import Cluster
from sadie.airr.airrtable import LinkedAirrTable

# For paired heavy/light chains, use LinkedAirrTable
linked_table = LinkedAirrTable(df, key_column="cellid")

# Cluster based on CDR amino acid identity
cluster_api = Cluster(linked_table, lookup=["cdr3_aa_heavy", "cdr3_aa_light"])
clustered_df = cluster_api.cluster(distance_cutoff=5)
```

## Best Practices
- **Pandas Integration**: Since `AirrTable` is a DataFrame, use standard pandas methods (`.query()`, `.groupby()`, `.sort_values()`) for filtering and analysis.
- **Multiprocessing**: When processing large files in scripts, wrap calls in a function and use `run_multiproc=True` in the `Renumbering` or `Airr` constructors.
- **Reference Database**: SADIE uses the Germline Gene Gateway (G3) API. If you need custom germlines, refer to the `sadie.reference` module to build local databases.
- **File Formats**: While `to_airr()` produces standard TSV files, use `to_parquet()` or `to_feather()` for high-performance IO with large repertoires.

## Reference documentation
- [AIRR Sequence Annotation](./references/sadie_jordanrwillis_com_annotation.md)
- [Sequence Numbering](./references/sadie_jordanrwillis_com_renumbering.md)
- [Sequence Clustering](./references/sadie_jordanrwillis_com_clustering.md)
- [Reference Database (G3)](./references/sadie_jordanrwillis_com_reference.md)
- [BCR/TCR Objects](./references/sadie_jordanrwillis_com_models.md)