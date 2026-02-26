---
name: plannotate
description: pLannotate is a specialized tool designed to annotate features and components within engineered plasmid sequences. Use when user asks to annotate synthetic DNA constructs, generate plasmid maps, or identify genetic parts in circular and linear sequences.
homepage: https://github.com/barricklab/pLannotate
---


# plannotate

## Overview
pLannotate is a specialized tool designed to streamline the annotation of engineered plasmids. Unlike general-purpose genomic annotators, it focuses on the components typically found in synthetic DNA constructs. It can be used as a command-line tool for batch processing, a local web-based GUI via Streamlit, or integrated directly into Python bioinformatics pipelines. This skill provides the necessary patterns to execute these annotations efficiently and interpret the results.

## Installation and Setup
Before first use, the database must be initialized.
```bash
# Install via bioconda
conda install bioconda::plannotate

# Essential: Download and setup the annotation databases
plannotate setupdb
```

## Command Line Interface (Batch Mode)
The `batch` command is the primary method for annotating sequence files.

### Basic Annotation
Annotate a sequence and generate a standard GenBank file:
```bash
plannotate batch -i sequence.fasta -o ./output_folder
```

### Generating Visual and Tabular Reports
To get an interactive plasmid map and a spreadsheet of features:
```bash
plannotate batch -i sequence.gbk --html --csv --file_name my_plasmid
```

### Handling Linear DNA
By default, pLannotate assumes circular topology. For linear fragments or PCR products:
```bash
plannotate batch -i fragment.fa --linear
```

### Sensitivity Tuning
If standard annotation misses expected features, use the detailed mode. Note that this increases the likelihood of false positives:
```bash
plannotate batch -i sequence.fa --detailed
```

## Python API Usage
For integration into custom scripts, use the `annotate` module.

```python
from plannotate.annotate import annotate
from plannotate.resources import get_seq_record

seq = "ATGC..." # Your DNA string

# Perform annotation
hits = annotate(seq, is_detailed=True, linear=False)

# Convert hits to a Biopython SeqRecord
seq_record = get_seq_record(hits, seq)
```

## Expert Tips
- **Output Suffixes**: By default, pLannotate appends `_pLann` to output files. Use `-s ''` to disable this behavior if you require strict naming conventions.
- **GUI Access**: If you prefer a visual interface for single-file uploads, run `plannotate streamlit` to launch a local web server at `http://localhost:8501`.
- **Database Customization**: You can generate a template for custom databases using `plannotate yaml > config.yaml`. While this skill focuses on CLI usage, this command is the entry point for advanced users needing to point the tool at proprietary feature sets.

## Reference documentation
- [pLannotate GitHub Repository](./references/github_com_barricklab_pLannotate.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_plannotate_overview.md)