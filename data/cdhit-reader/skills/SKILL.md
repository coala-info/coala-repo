---
name: cdhit-reader
description: The `cdhit-reader` tool (also known as `cdhit-parser`) provides a Python API and command-line utilities to interact with the output of the CD-HIT clustering suite.
homepage: https://github.com/telatin/cdhit-parser
---

# cdhit-reader

## Overview
The `cdhit-reader` tool (also known as `cdhit-parser`) provides a Python API and command-line utilities to interact with the output of the CD-HIT clustering suite. It transforms the standard text-based `.clstr` format into accessible Python objects, allowing for easy integration into data analysis pipelines. Additionally, it includes a comparison tool to identify overlaps and redundancies between different sequence sets.

## Installation
Install via Bioconda or pip:
```bash
conda install -c bioconda cdhit-reader
# OR
pip install cdhit-reader
```

## Python API Usage

### Parsing Cluster Files
The `read_cdhit` function returns an iterator of cluster objects. This is memory-efficient for large datasets.

```python
from cdhit_reader import read_cdhit

# Iterate through clusters
for cluster in read_cdhit("results.clstr"):
    print(f"Cluster: {cluster.name}")
    print(f"Representative: {cluster.refname}")
    
    # Access individual members
    for member in cluster.sequences:
        status = "REF" if member.is_ref else f"{member.identity}%"
        print(f" - {member.name} ({member.length} aa/nt) [{status}]")
```

### Loading into Memory
If the dataset is small and you need random access, load all clusters into a list:
```python
clusters = read_cdhit("results.clstr").read_items()
```

### Reading FASTA Files
The library also includes a FASTA reader that supports line wrapping:
```python
import cdhit_reader

for seq in cdhit_reader.read_fasta("sequences.fasta", line_len=60):
    print(f">{seq.name} {seq.comment}")
    print(seq.sequence)
```

## Command Line Utilities

### Comparing FASTA Files
The `cdhit-compare` tool identifies shared and unique sequences between two files. 
**Note**: This requires `cd-hit` to be installed and available in your system PATH.

```bash
cdhit-compare file1.faa file2.faa --id 0.99
```

**Output Categories:**
- `input1` / `input2`: Sequence unique to that specific file.
- `both`: Sequence present in both files (one instance each).
- `dupl_input1`: Sequence is duplicated within file 1.
- `multi`: Sequence appears multiple times across at least one dataset.

### Cluster Statistics
Use the built-in demo script to get quick statistics on a cluster file:
```bash
cdhit-reader.py your_clusters.clstr
```

## Expert Tips
- **Memory Management**: Always prefer the iterator approach (`for cluster in read_cdhit(...)`) over `read_items()` when dealing with metagenomic datasets or large-scale protein clusterings to avoid MemoryErrors.
- **Identity Thresholds**: When using `cdhit-compare`, the `--id` parameter behaves like the `-c` parameter in CD-HIT. Ensure your threshold matches the stringency used in your initial clustering.
- **Reference Sequences**: In the Python API, `member.is_ref` is a boolean flag that specifically identifies the sequence CD-HIT chose as the cluster representative (the one marked with `*` in the `.clstr` file).

## Reference documentation
- [cdhit-reader Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cdhit-reader_overview.md)
- [cdhit-parser GitHub Documentation](./references/github_com_telatin_cdhit-parser.md)