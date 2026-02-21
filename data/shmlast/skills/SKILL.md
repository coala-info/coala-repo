---
name: shmlast
description: shmlast is a high-performance tool for orthology assignment that implements the Conditional Reciprocal Best Hits (CRBH) algorithm.
homepage: https://github.com/camillescott/shmlast
---

# shmlast

## Overview

shmlast is a high-performance tool for orthology assignment that implements the Conditional Reciprocal Best Hits (CRBH) algorithm. While traditional Reciprocal Best Hits (RBH) can be overly conservative, shmlast improves sensitivity by learning an appropriate e-value cutoff for specific sequence lengths based on an initial set of RBHs. It replaces the slow NCBI BLAST+ engine with the LAST aligner and utilizes GNU Parallel for efficient multi-core execution. It is specifically designed for transcriptome-to-protein comparisons between two species.

## Common CLI Patterns

### Conditional Reciprocal Best Hits (CRBH)
The primary workflow for finding orthologs between a transcriptome and a protein database:
```bash
shmlast crbl -q transcripts.fa -d proteins.faa
```

### Reciprocal Best Hits (RBL)
To perform a standard Reciprocal Best Hit search without the conditional modeling step:
```bash
shmlast rbl -q transcripts.fa -d proteins.faa
```

### Performance Optimization
shmlast scales well across multiple CPU cores. Use the `--n_threads` option to speed up the LAST alignments:
```bash
shmlast crbl -q transcripts.fa -d proteins.faa --n_threads 16
```

### Adjusting Stringency
You can specify a maximum expectation-value (e-value) for the initial searches:
```bash
shmlast crbl -q transcripts.fa -d proteins.faa -e 0.000001
```

## Best Practices and Expert Tips

### Database Selection
*   **Species-Specific Only**: CRBH is designed for comparing two species. Do not use shmlast to annotate a transcriptome against a mixed protein database (e.g., UniRef90 or NR), as the underlying statistical model assumes a direct evolutionary relationship between two specific proteomes/transcriptomes.
*   **Format**: Ensure your query (`-q`) is a nucleotide transcriptome (FASTA) and your database (`-d`) is a protein database (FASTA).

### Validating the Model
shmlast generates a PDF plot (`$QUERY.x.$DATABASE.crbl.model.plot.pdf`) by default. Always inspect this plot to ensure the model fit (the "fit" line) accurately reflects the distribution of your reciprocal best hits. A poor fit may indicate that the two species are too distantly related for the CRBH algorithm to be effective.

### Handling Outputs
The primary output is a CSV file. You can quickly load and filter this data using Python and Pandas:
```python
import pandas as pd
# Load the CRBH results
df = pd.read_csv('query.x.database.crbl.csv')

# Filter for high-confidence hits based on bitscore or alignment length
top_hits = df[df['bitscore'] > 50]
```

### Known Limitations
*   **IUPAC Codes**: Be cautious with RNA sequences containing non-standard IUPAC codes, as they may cause translation issues in certain versions.
*   **Sequence Types**: Currently, shmlast does not support nucleotide-to-nucleotide or protein-to-protein alignments; it is strictly for transcriptome-to-protein workflows.

## Reference documentation
- [shmlast GitHub Repository](./references/github_com_camillescott_shmlast.md)
- [shmlast Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_shmlast_overview.md)