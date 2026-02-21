---
name: pyhmmsearch
description: pyhmmsearch is a high-performance Python implementation of the `hmmsearch` algorithm from the HMMER suite.
homepage: https://github.com/new-atlantis-labs/pyhmmsearch-stable
---

# pyhmmsearch

## Overview

pyhmmsearch is a high-performance Python implementation of the `hmmsearch` algorithm from the HMMER suite. By leveraging `PyHmmer`, it achieves significant speedups over traditional HMMER by keeping data in memory and avoiding intermediate file creation. It is specifically designed for bioinformatics pipelines that need to annotate large protein sets against HMM databases like Pfam or custom marker sets. This tool is most effective on systems with high RAM and multiple CPU cores.

## Installation

Install via Bioconda or pip:

```bash
conda install bioconda::pyhmmsearch
# OR
pip install pyhmmsearch
```

## Core CLI Patterns

### Basic Search
Run a search using a standard HMM database against a protein FASTA file (supports `.gz`).

```bash
pyhmmsearch -i proteins.faa.gz -o results.tsv -d Pfam-A.hmm.gz -p 12
```

### Database Serialization (Optimization)
For repeated searches, convert HMM files into a serialized Python pickle format. This significantly reduces database loading time in subsequent runs.

```bash
# From a single HMM file
serialize_hmm_models -d Pfam-A.hmm.gz -b database.pkl.gz

# From a directory of HMMs
serialize_hmm_models -d ./hmm_dir/ -b database.pkl.gz

# Run search using the serialized database
pyhmmsearch -i proteins.faa.gz -o results.tsv -b database.pkl.gz -p -1
```

### Custom Thresholding
Apply specific score cutoffs (e.g., for BUSCO markers) using a threshold table.

```bash
pyhmmsearch -i proteins.faa.gz -o results.tsv -d markers.hmm.gz -s scores_cutoff.tsv -f name
```

## Output Management

### Reformatting Results
The default output is a detailed TSV. Use `reformat_pyhmmsearch` to group hits by query protein or filter for best hits.

```bash
# Group hits by query protein
reformat_pyhmmsearch -i results.tsv -o results.reformatted.tsv

# Extract only the best hit per protein
reformat_pyhmmsearch -i results.tsv -o results.best_hits.tsv --best_hits_only
```

## Expert Tips

- **Thread Optimization**: Use `-p -1` to automatically utilize all available CPU threads.
- **Memory Usage**: Since pyhmmsearch loads the database and sequences into memory, ensure your system RAM exceeds the combined size of the uncompressed database and the protein sequences.
- **Marker Fields**: When using custom databases, use `-f name` or `-f accession` to match the identifier type used in your threshold files.
- **Threshold Methods**: Beyond E-values (`-m e`), you can use HMMER-specific cutoffs like `--threshold_method gathering` (GA), `trusted` (TC), or `noise` (NC) if the HMM models provide them.

## Reference documentation
- [pyhmmsearch Overview](./references/anaconda_org_channels_bioconda_packages_pyhmmsearch_overview.md)
- [pyhmmsearch GitHub Repository](./references/github_com_new-atlantis-labs_pyhmmsearch-stable.md)