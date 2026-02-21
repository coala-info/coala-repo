---
name: abnumber
description: "Could not get help from Singularity for: abnumber"
homepage: https://github.com/prihoda/AbNumber
---

# abnumber

## Overview
abnumber provides a streamlined Python API for antibody sequence analysis, acting as a high-level wrapper for ANARCI. It allows you to treat antibody sequences as objects that can be indexed by their numbering, sliced by regions, and aligned to germlines. Use this skill to automate the identification of Complementarity Determining Regions (CDRs) and to facilitate antibody engineering workflows.

## Installation
Install the package via Bioconda:
```bash
conda install -c bioconda abnumber
```
Note: This tool is supported on UNIX and MacOS due to its HMMER dependency.

## Core Workflows

### Initializing a Chain
Create a `Chain` object by providing a protein sequence and a numbering scheme (e.g., 'imgt', 'kabat', 'chothia').
```python
from abnumber import Chain
seq = 'QVQLQQSGAELARPGASVKMSCKASGYTFTRYTMHWVKQRPGQGLEWIGYINPSRGYTNYNQKFKDKATLTTDKSSSTAYMQLSSLTSEDSAVYYCARYYDDHYCLDYWGQGTTLTVSS'
chain = Chain(seq, scheme='imgt')
```

### Extracting CDRs and Regions
Access specific regions directly as attributes or via the `regions` property.
- Get CDR3 sequence: `chain.cdr3_seq`
- Get all regions: `chain.regions`
- Get framework regions: `chain.fr1_seq`, `chain.fr2_seq`, etc.

### Numbering-Based Indexing and Slicing
Access residues using their standardized numbering rather than zero-based array indices.
- Access a specific position: `chain['5']`
- Slice a range of positions: `chain['H2':'H5']`
- Iterate through positions: `for pos, aa in chain: print(pos, aa)`

### Sequence Alignment
Perform pairwise or multiple sequence alignments within the context of the chosen numbering scheme.
- Align to another chain: `chain.align(another_chain)`
- Find the nearest human germline: `chain.find_merged_human_germline()`
- Align to the nearest human germline: `chain.align(chain.find_merged_human_germline())`

### Antibody Humanization
Perform CDR grafting by transferring CDRs from a source chain onto a human germline framework.
```python
humanized_chain = chain.graft_cdrs_onto_human_germline()
```

## Expert Tips and Best Practices
- **Batch Processing**: For large datasets, use `Chain.batch()` to parse multiple sequences at once, which is more efficient than individual object creation.
- **Scheme Consistency**: Always specify the `scheme` explicitly when creating a `Chain` to ensure that slicing and CDR definitions remain consistent across your analysis.
- **Handling Multiple Domains**: If a sequence contains multiple antibody domains, use `Chain.multiple_domains` to identify and process them separately.
- **Vernier Zone Check**: Use `chain.is_in_vernier(position)` to check if a specific residue belongs to the Vernier zone, which is critical for maintaining CDR conformation during humanization.
- **Error Handling**: Wrap chain creation in try-except blocks to catch `ChainParseError`, which occurs when a sequence cannot be successfully numbered by ANARCI (e.g., if it is not an antibody or is too truncated).

## Reference documentation
- [AbNumber GitHub Repository](./references/github_com_prihoda_AbNumber.md)
- [AbNumber Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_abnumber_overview.md)