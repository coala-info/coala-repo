---
name: shmlast
description: shmlast identifies orthologous sequences between a transcriptome and a protein database using the Conditional Reciprocal Best Hits algorithm. Use when user asks to find orthologs, perform conditional reciprocal best hits, or run reciprocal best hits between two species.
homepage: https://github.com/camillescott/shmlast
---


# shmlast

## Overview

shmlast is a specialized tool designed to identify orthologous sequences between two species by implementing the Conditional Reciprocal Best Hits (CRBH) algorithm. Unlike standard Reciprocal Best Hits (RBH) which uses a static e-value cutoff, shmlast trains a model based on sequence length to determine appropriate e-value thresholds. It utilizes the LAST aligner for significantly faster processing compared to traditional BLAST-based methods. It is specifically optimized for comparing a transcriptome (nucleotide) against a protein database (amino acid).

## Common CLI Patterns

### Conditional Reciprocal Best Hits (CRBH)
The primary command for finding orthologs using the length-dependent model:
```bash
shmlast crbl -q transcripts.fa -d proteins.faa
```

### Reciprocal Best Hits (RBL)
To perform a standard reciprocal best hit search without the conditional model:
```bash
shmlast rbl -q transcripts.fa -d proteins.faa
```

### Performance Optimization
Distribute the alignment tasks across multiple CPU cores:
```bash
shmlast crbl -q transcripts.fa -d proteins.faa --n_threads 8
```

### Adjusting Sensitivity
Specify a maximum expectation-value (e-value) cutoff:
```bash
shmlast crbl -q transcripts.fa -d proteins.faa -e 1e-6
```

## Expert Tips and Best Practices

- **Species Selection**: Only use shmlast for comparing two specific species. It is not designed for, and should not be used with, mixed protein databases like UniRef90 or NR.
- **Model Validation**: Always inspect the generated PDF plot (`$QUERY.x.$DATABASE.crbl.model.plot.pdf`) to ensure the model fit is appropriate for your datasets.
- **Input Formats**: Ensure the query file (`-q`) is a nucleotide transcriptome in FASTA format and the database (`-d`) is a protein FASTA file.
- **Data Analysis**: The output is a standard CSV. For downstream analysis, use the Python Pandas library:
  ```python
  import pandas as pd
  df = pd.read_csv('query.x.database.crbl.csv')
  ```
- **Dependencies**: shmlast relies on `lastal` and `gnu-parallel`. If running in a custom environment, ensure these are in your PATH.



## Subcommands

| Command | Description |
|---------|-------------|
| shmlast crbl | Run Conditional Reciprocal Best Hits between the query and database. |
| shmlast rbl | Run Reciprocal Best Hits between the query and database. |

## Reference documentation

- [shmlast README](./references/github_com_camillescott_shmlast_blob_master_README.md)