---
name: plannotate
description: pLannotate automatically annotates engineered genetic constructs and plasmids to identify functional features like promoters and markers. Use when user asks to annotate DNA sequences, generate interactive plasmid maps, create GenBank files, or identify features in synthetic DNA fragments.
homepage: https://github.com/barricklab/pLannotate
metadata:
  docker_image: "quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0"
---

# plannotate

## Overview
pLannotate is a specialized tool designed for the automated annotation of engineered genetic constructs, particularly plasmids. It bridges the gap between raw sequence data and functional maps by identifying common features like promoters, antibiotic resistance markers, origins of replication, and tags. You should use this skill to streamline the characterization of synthetic DNA, ensure consistent feature naming, and produce visualization-ready files for molecular biology workflows.

## Installation and Setup
Before first use, the local database must be initialized:
```bash
plannotate setupdb
```

## Command Line Usage
The primary interface for processing sequences is the `batch` command.

### Basic Annotation
To annotate a sequence and generate a standard GenBank file:
```bash
plannotate batch -i sequence.fasta -o ./output_folder
```

### Generating Visual Maps
To create an interactive HTML plasmid map alongside the GenBank file:
```bash
plannotate batch -i sequence.fasta --html
```

### Handling Linear Fragments
If the input is a linear DNA fragment (e.g., a PCR product or synthetic block) rather than a circular plasmid, use the `--linear` flag to prevent the tool from searching for features that wrap around the sequence ends:
```bash
plannotate batch -i fragment.fasta --linear --html
```

### High-Sensitivity Search
For sequences where standard annotation might miss truncated or divergent features, use the detailed mode. Note that this increases the likelihood of false positives:
```bash
plannotate batch -i sequence.fasta --detailed
```

## Expert Tips
- **Output Control**: By default, pLannotate appends `_pLann` to output files. Use `-s ''` to disable this suffix or `-f custom_name` to specify a completely different filename.
- **Data Extraction**: Use the `--csv` flag to generate a spreadsheet of all identified hits, which is useful for programmatic analysis of feature coordinates and identities.
- **Python Integration**: For complex workflows, pLannotate can be imported directly into Python scripts using `from plannotate.annotate import annotate` to return a Pandas DataFrame of hits.



## Subcommands

| Command | Description |
|---------|-------------|
| plannotate batch | Annotates engineered DNA sequences, primarily plasmids. Accepts a FASTA or GenBank file and outputs a GenBank file with annotations, as well as an optional interactive plasmid map as an HTLM file. |
| plannotate streamlit | Launches pLannotate as an interactive web app. |
| plannotate_yaml | Annotates sequences with information from various databases. |

## Reference documentation
- [pLannotate README](./references/github_com_barricklab_pLannotate_blob_master_README.md)
- [pLannotate Repository Overview](./references/github_com_barricklab_pLannotate.md)