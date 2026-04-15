---
name: biocommons.seqrepo
description: biocommons.seqrepo is a system for the local storage, deduplication, and retrieval of biological sequences using hash-based identifiers. Use when user asks to retrieve sequence slices, map between different sequence identifier namespaces, or maintain a local mirror of public sequence databases.
homepage: https://github.com/biocommons/biocommons.seqrepo
metadata:
  docker_image: "quay.io/biocontainers/biocommons.seqrepo:0.6.11--pyhdfd78af_0"
---

# biocommons.seqrepo

## Overview
biocommons.seqrepo is a specialized system for storing and accessing biological sequences locally. It solves the problem of redundant sequence storage by using hash-based deduplication and provides a unified interface to map various external accessions to the same underlying sequence. 

Use this skill when you need to:
- Retrieve specific sub-sequences (slices) from large genomic files without loading the entire sequence into memory.
- Map between different sequence identifier namespaces (e.g., converting a RefSeq ID to an Ensembl ID or a checksum).
- Maintain a local, versioned mirror of public sequence databases for offline or high-throughput analysis.
- Ensure sequence integrity using built-in SHA-512 and MD5 digests.

## Installation and Setup
The tool requires `rsync` for data transfers and `bgzip` (from htslib/tabix) for writing sequences.

```bash
# Install via pip
pip install biocommons.seqrepo

# Initialize and pull a specific data snapshot
sudo mkdir -p /usr/local/share/seqrepo
sudo chown $USER /usr/local/share/seqrepo
seqrepo pull -i 2024-12-20
```

## Common CLI Patterns

### Repository Management
Check the status and statistics of a local repository instance:
```bash
seqrepo show-status -i 2024-12-20
```

### Exporting Sequences
Export sequences in a format that includes various digests (MD5, SEGUID, SHA1, VMC, GA4GH):
```bash
seqrepo export -i 2024-12-20 | head -n 20
```

### Interactive Exploration
Launch an IPython shell pre-configured with a `SeqRepo` object (`sr`):
```bash
seqrepo start-shell -i 2024-12-20
```

## Python API Usage
The Python interface is the most efficient way to integrate seqrepo into bioinformatics scripts.

### Basic Retrieval
```python
from biocommons.seqrepo import SeqRepo

# Initialize the repository
sr = SeqRepo("/usr/local/share/seqrepo/2024-12-20")

# Fetch a sequence slice using a RefSeq accession
# Coordinates are 0-based, half-open (standard Python slicing)
sequence_slice = sr["NC_000001.11"][780000:780020]
```

### Working with Aliases
SeqRepo allows lookup via any known alias. It is best practice to use "fully-qualified" identifiers (namespace:accession) to avoid ambiguity.
```python
# Lookup by different namespaces
seq_refseq = sr["refseq:NM_000551.3"]
seq_ensembl = sr["ensembl:ENSP00000354464"]

# Get all aliases associated with a specific sequence
aliases = sr.aliases.find_aliases(alias="NM_000551.3")
```

## Expert Tips and Best Practices
- **Namespace Discipline**: Always provide a namespace (e.g., `GRCh38:1` vs just `1`) when working with multiple assemblies to prevent `AmbiguousIdentifierError`.
- **Performance**: SeqRepo uses BGZF (Block GZipped Format) for compression, which allows for fast random access. Slicing a small region of a chromosome is nearly instantaneous regardless of the total chromosome size.
- **Snapshot Reproducibility**: When building pipelines, hardcode the specific instance date (e.g., `2024-12-20`) rather than using a "latest" symbolic link to ensure results remain reproducible over time.
- **Storage Efficiency**: Because SeqRepo is non-redundant and uses hardlinks across snapshots, adding a new snapshot typically only consumes additional space for the updated SQLite database (approx. 2GB), while the sequence data itself is shared.

## Reference documentation
- [biocommons.seqrepo Overview](./references/anaconda_org_channels_bioconda_packages_biocommons.seqrepo_overview.md)
- [SeqRepo GitHub Repository and README](./references/github_com_biocommons_biocommons.seqrepo.md)