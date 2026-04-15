---
name: abnumber
description: The abnumber tool provides a Python interface for antibody sequence numbering and structural region identification using the ANARCI tool. Use when user asks to number antibody sequences, extract CDR or framework regions, perform human germline alignment, or conduct CDR grafting for antibody engineering.
homepage: https://github.com/prihoda/AbNumber
metadata:
  docker_image: "quay.io/biocontainers/abnumber:0.4.4--pyhdfd78af_0"
---

# abnumber

## Overview
The `abnumber` skill provides a streamlined interface for antibody sequence analysis, acting as a high-level Python API for the ANARCI numbering tool. You should use this skill to automate the identification of structural regions (CDRs and Frameworks), perform sequence alignments, and map sequences to human germlines. It transforms raw protein sequences into structured `Chain` objects that support intuitive indexing, slicing, and grafting, which are essential for antibody engineering and therapeutic development.

## Core Usage Patterns

### Initializing a Chain
To analyze a sequence, create a `Chain` object. You must specify the numbering scheme (e.g., 'imgt', 'kabat', 'chothia', 'martin', 'bentley').

```python
from abnumber import Chain

seq = 'QVQLQQSGAELARPGASVKMSCKASGYTFTRYTMHWVKQRPGQGLEWIGYINPSRGYTNYNQKFKDKATLTTDKSSSTAYMQLSSLTSEDSAVYYCARYYDDHYCLDYWGQGTTLTVSS'
chain = Chain(seq, scheme='imgt')
```

### Extracting Regions
Access specific antibody regions directly through object attributes:
- `chain.cdr1_seq`, `chain.cdr2_seq`, `chain.cdr3_seq`: Get CDR sequences.
- `chain.fr1_seq`, `chain.fr2_seq`, `chain.fr3_seq`, `chain.fr4_seq`: Get Framework sequences.
- `chain.regions`: Returns a dictionary of all identified regions.

### Indexing and Slicing
`abnumber` allows indexing based on the numbering scheme rather than zero-based array positions.
- **Single Position**: `chain['5']` returns the amino acid at position 5.
- **Slicing**: `chain['H2':'H5']` returns a sub-chain or iterator for the specified range.
- **Iteration**: `for pos, aa in chain: print(pos, aa)` iterates through positions using the scheme's labels.

### Sequence Alignment
Align a chain to another sequence or a germline:
- **Pairwise**: `chain.align(another_chain)`
- **Human Germline**: `chain.find_merged_human_germline()` finds the closest human V and J genes.
- **Identity**: Use `chain.align(germline)` to calculate sequence identity against reference genes.

### Humanization (CDR Grafting)
Perform CDR grafting by moving CDRs from a source chain onto a human germline framework:
```python
human_germline = chain.find_merged_human_germline()
humanized_chain = chain.graft_cdrs_onto_human_germline(human_germline)
```

### Batch Processing
For high-throughput tasks, use `Chain.batch` to process multiple sequences efficiently. This is significantly faster than initializing individual `Chain` objects in a loop.
```python
sequences = {'id1': 'SEQ1...', 'id2': 'SEQ2...'}
chains = Chain.batch(sequences, scheme='imgt')
```

## Expert Tips and Best Practices
- **Scheme Consistency**: Always explicitly define your `scheme`. Mixing 'imgt' and 'kabat' indices will lead to incorrect region boundaries.
- **Error Handling**: Wrap chain initialization in a `try-except` block for `ChainParseError`. This occurs if a sequence is not an antibody, contains multiple domains (unless `multiple_domains=True` is set), or is otherwise unparseable by ANARCI.
- **Platform Limitation**: Remember that `abnumber` requires `HMMER` and is only supported on UNIX and MacOS. It will not function natively on Windows.
- **Insertion Codes**: When indexing, be aware of insertion codes (e.g., '82A' in Kabat). `abnumber` supports multi-letter insertion codes in recent versions.
- **Vernier Zones**: Use `chain.is_in_vernier(position)` to check if a specific residue belongs to the vernier zone, which is critical for maintaining CDR conformation during grafting.

## Reference documentation
- [AbNumber Overview](./references/anaconda_org_channels_bioconda_packages_abnumber_overview.md)
- [AbNumber GitHub Repository](./references/github_com_prihoda_AbNumber.md)