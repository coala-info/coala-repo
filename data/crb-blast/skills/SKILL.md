---
name: crb-blast
description: CRB-BLAST identifies orthologous sequences between two datasets by applying a conditional reciprocal best hit approach to improve sensitivity over standard methods. Use when user asks to identify orthologs between a transcriptome and a proteome, find reciprocal best hits with improved sensitivity, or perform conditional reciprocal best BLAST.
homepage: https://github.com/cboursnell/crb-blast
metadata:
  docker_image: "quay.io/biocontainers/crb-blast:0.6.9--hdfd78af_0"
---

# crb-blast

## Overview
CRB-BLAST (Conditional Reciprocal Best BLAST) is a tool designed to identify orthologous sequences between two datasets, such as a de-novo transcriptome assembly and a reference proteome. While standard Reciprocal Best Hits (RBH) can be overly restrictive, CRB-BLAST improves sensitivity by learning an appropriate e-value cutoff for each pairwise alignment. It achieves this by fitting a function to the distribution of alignment e-values relative to sequence lengths, providing a more nuanced filtering mechanism than a single static e-value threshold.

## Installation
The tool can be installed via Bioconda or RubyGems:

```bash
# Via Conda
conda install bioconda::crb-blast

# Via RubyGems
gem install crb-blast
```

**Prerequisites**: NCBI BLAST+ must be installed and available in your system `$PATH`.

## Common CLI Patterns

### Basic Ortholog Assignment
To run a standard analysis comparing a query assembly against a reference target:
```bash
crb-blast --query assembly.fa --target reference_proteins.fa --output orthologs.tsv
```

### Performance Optimization
For large datasets, use multiple threads and the split functionality to speed up the BLAST phases:
```bash
crb-blast --query assembly.fa --target reference.fa --threads 8 --split --output results.tsv
```

### Adjusting Stringency
While the tool calculates a conditional cutoff, you can set the initial e-value threshold for the underlying BLAST searches:
```bash
crb-blast -q query.fa -t target.fa -e 1e-10 -o results.tsv
```

## Command Line Options
- `--query, -q <file>`: Query FASTA file (nucleotide format).
- `--target, -t <file>`: Target FASTA file (nucleotide or protein format).
- `--evalue, -e <float>`: Initial e-value cutoff for BLAST (default: 1.0e-05).
- `--threads, -h <int>`: Number of threads for BLAST execution (default: 1).
- `--output, -o <file>`: Path for the output TSV file.
- `--split, -s`: Splits FASTA files into chunks to run multiple BLAST jobs before combining results.

## Output Format
The output is a Tab-Separated Values (TSV) file containing the following columns:
1.  **query**: Name of the sequence from the query FASTA.
2.  **target**: Name of the sequence from the target FASTA.
3.  **id**: Percent sequence identity.
4.  **alnlen**: Alignment length.
5.  **evalue**: BLAST e-value.
6.  **bitscore**: BLAST bitscore.
7.  **qstart..qend**: Alignment coordinates in the query.
8.  **tstart..tend**: Alignment coordinates in the target.
9.  **qlen**: Total length of the query sequence.
10. **tlen**: Total length of the target sequence.

## Expert Tips
- **Target Format**: The target file can be either nucleotide or protein. CRB-BLAST automatically handles the underlying BLAST program selection (e.g., BLASTN, BLASTX, or TBLASTN) based on the input types.
- **Memory Management**: If you encounter memory issues with very large FASTA files, ensure you use the `--split` flag to process the data in smaller chunks.
- **Ruby Environment**: If not using Conda, it is recommended to manage the Ruby environment using RVM to ensure compatibility with Ruby v2.0 or later.

## Reference documentation
- [github_com_cboursnell_crb-blast.md](./references/github_com_cboursnell_crb-blast.md)
- [anaconda_org_channels_bioconda_packages_crb-blast_overview.md](./references/anaconda_org_channels_bioconda_packages_crb-blast_overview.md)