---
name: pytwobit
description: pytwobit is a high-performance Python interface for reading and querying genomic sequences from local or remote UCSC .2bit files. Use when user asks to fetch sequences from specific chromosomal regions, read .2bit files, or access remote reference genomes without downloading the full file.
homepage: https://github.com/jrobinso/pytwobit
---


# pytwobit

## Overview

pytwobit is a high-performance Python interface for reading UCSC .2bit files. It excels at "lazy loading" genomic data, allowing users to query specific chromosomal regions from either local disk or remote HTTP/HTTPS endpoints. This is the preferred tool when working with large reference genomes where downloading the full multi-gigabyte file is impractical, or when building bioinformatics pipelines that require rapid random access to sequence data.

## Installation

Install via pip or conda:

```bash
pip install pyTwobit
# OR
conda install -c bioconda pytwobit
```

## Core Usage Patterns

### Initializing the Reader
The `TwoBit` object handles both local paths and remote URLs transparently.

```python
from pytwobit import TwoBit

# Local access
tb_local = TwoBit('path/to/genome.2bit')

# Remote access (e.g., hg38 from IGV/UCSC)
tb_remote = TwoBit("https://igv.org/genomes/data/hg38/hg38.2bit")
```

### Fetching Sequences
The `fetch` method is the primary interface. It requires the chromosome name, a start index, and an end index.

```python
# Syntax: fetch(chromosome, start, end)
sequence = tb_remote.fetch("chr1", 1000, 1050)
```

## Expert Tips and Best Practices

### 1. Coordinate Convention
pytwobit follows the **UCSC coordinate convention**:
- **0-based**: The first base of a sequence is index 0.
- **Half-open**: The start is inclusive, and the end is exclusive.
- *Example*: To get the first 10 bases, use `fetch("chr1", 0, 10)`.

### 2. Performance Optimization
- **Persistent Objects**: Instantiate the `TwoBit` object once and reuse it for multiple queries. Re-instantiating for every fetch, especially for remote files, creates unnecessary network overhead and handshake delays.
- **Remote Latency**: When querying remote files, pytwobit uses range requests. While fast, many small sequential requests are slower than a single larger request due to network latency. If you need many nearby regions, consider fetching the entire spanning block once.

### 3. Handling Masked Sequences
.2bit files can contain "masked" (lowercase) or "N" (unknown) bases. pytwobit preserves this casing:
- **Uppercase (ACTG)**: Standard sequence.
- **Lowercase (actg)**: Soft-masked sequence (often repeats).
- **N/n**: Gaps or unsequenced regions.

### 4. Error Handling
Always verify chromosome naming conventions (e.g., "chr1" vs "1") based on the specific .2bit file source, as fetching a non-existent chromosome will raise an error.

## Reference documentation
- [pyTwobit GitHub Repository](./references/github_com_igvteam_pyTwobit.md)
- [pytwobit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pytwobit_overview.md)