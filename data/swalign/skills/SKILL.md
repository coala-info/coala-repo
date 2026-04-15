---
name: swalign
description: swalign performs local sequence alignment using the Smith-Waterman algorithm with support for custom scoring and gap penalties. Use when user asks to perform local sequence alignment, align nucleotide or protein sequences, or calculate optimal alignments with affine gap penalties and gap decay.
homepage: https://github.com/mbreese/swalign/
metadata:
  docker_image: "quay.io/biocontainers/swalign:0.3.7--pyhdfd78af_0"
---

# swalign

## Overview
The `swalign` skill provides a Python-based implementation of the Smith-Waterman algorithm for local sequence alignment. It is particularly useful when you need to find the optimal local alignment between two sequences where global alignment might fail due to large differences in the sequences' ends. This tool supports custom scoring matrices (nucleotide or identity), affine gap penalties (open and extend), and a unique gap decay feature to handle long insertions or deletions more effectively.

## Installation
Install via conda or pip:
```bash
conda install -c bioconda swalign
# OR
pip install swalign
```

## Python API Usage
The primary way to interact with `swalign` is through its Python interface.

### Basic Nucleotide Alignment
```python
import swalign

# Define scoring parameters
match = 2
mismatch = -1
scoring = swalign.NucleotideScoringMatrix(match, mismatch)

# Initialize the aligner
sw = swalign.LocalAlignment(scoring)

# Perform alignment
alignment = sw.align('ACACACTA', 'AGCACACA')

# Display results
alignment.dump()
```

### Advanced Scoring and Gap Penalties
You can fine-tune the alignment behavior by adjusting gap penalties and using the decay factor.
```python
# gap_penalty: cost to open a gap
# gap_extension_penalty: cost to extend an existing gap
# gap_decay: reduces the penalty for very long gaps
sw = swalign.LocalAlignment(scoring, gap_penalty=-2, gap_extension_penalty=-1, gap_decay=0.01)
```

### Global Alignment Mode
While primarily a local aligner, `swalign` supports a global alignment option:
```python
sw = swalign.LocalAlignment(scoring, global_align=True)
```

### Full Query Mode
To ensure the entire query sequence is matched against the reference:
```python
sw = swalign.LocalAlignment(scoring, full_query=True)
```

## Command Line Interface (CLI)
The package includes a script (usually found in `bin/swalign`) for quick alignments from the terminal.

### Aligning FASTA Files
```bash
swalign reference.fasta query.fasta
```

### Common CLI Options
- `-m`: Match score (default: 2)
- `-x`: Mismatch penalty (default: -1)
- `-g`: Gap open penalty (default: -1)
- `-e`: Gap extension penalty (default: -1)
- `-d`: Gap decay (default: 0.0)
- `--matrix`: Path to a custom scoring matrix file.

## Best Practices
- **Scoring Selection**: Use `NucleotideScoringMatrix` for DNA/RNA. For protein or general text, ensure your scoring matrix accounts for the specific substitution probabilities of the domain.
- **Gap Decay**: Use a small `gap_decay` value (e.g., 0.01 to 0.05) if you expect the sequences to have occasional large structural variations or long indels that shouldn't be penalized linearly.
- **Matrix Files**: When using custom matrices via the CLI or API, ensure the file format allows for comments (starting with `#`) and blank lines, as the parser supports them.

## Reference documentation
- [swalign GitHub README](./references/github_com_mbreese_swalign.md)
- [swalign Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_swalign_overview.md)