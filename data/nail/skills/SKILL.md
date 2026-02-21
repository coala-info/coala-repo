---
name: nail
description: Nail (Alignment Inference tooL) is a bioinformatics utility designed for efficient protein sequence alignment.
homepage: https://github.com/TravisWheelerLab/nail
---

# nail

## Overview
Nail (Alignment Inference tooL) is a bioinformatics utility designed for efficient protein sequence alignment. It implements a fast approximation of the HMMER3 Forward/Backward algorithm, utilizing the MMseqs2 search pipeline to identify candidate alignment seeds. This approach allows for high-sensitivity probabilistic modeling at a significantly lower computational cost than standard HMMER3 searches. Currently, the tool is optimized for amino acid sequences and requires a query (either a p7HMM or FASTA file) and a target sequence database (FASTA).

## Command Line Usage

### Basic Search
The primary subcommand is `search`. By default, it writes a tabular report to `results.tbl` and outputs alignments to `stdout`.

```bash
nail search query.hmm target.fa
```

### Capturing Alignment Output
To save the detailed alignment visualization to a specific file instead of viewing it in the terminal, use the `--ali-out` flag.

```bash
nail search --ali-out output.ali query.hmm target.fa
```

### Input Requirements
- **Query**: Accepts `.hmm` (HMMER3 profile HMMs) or `.fa`/`.fasta` files.
- **Target**: A FASTA format protein sequence database.
- **Dependency**: `mmseqs` must be available in your system `$PATH` as it is used for the initial seed discovery.

## Output Interpretation

### Tabular Results (`results.tbl`)
The tabular output provides a summary of hits with the following key metrics:
- **score**: The bit score of the alignment.
- **bias**: The composition bias correction.
- **evalue**: The statistical significance (Expect value).
- **cell frac**: The fraction of the DP matrix cells computed (indicates the "sparseness" of the alignment).

### Alignment Output
The alignment file shows the query consensus vs. the target sequence, including:
- **Transition line**: Indicates matches (+), identities (letters), or mismatches (spaces).
- **Confidence line**: Numeric values (0-9, *) representing the posterior probability/certainty of each aligned residue.

## Best Practices and Tips
- **Environment**: If running in a container or restricted environment, ensure `mmseqs` is installed (e.g., via `conda install mmseqs2`).
- **Temporary Files**: Nail creates a `./tmp/` directory to store intermediate MMseqs2 files. Ensure the working directory has write permissions or clean this directory between large runs.
- **Sequence Type**: Currently, Nail only supports amino acid searches. Do not use it for nucleotide-to-nucleotide alignments until future updates add support.
- **Performance**: Nail is significantly faster than HMMER3 because it only calculates the Forward/Backward algorithm around the seeds identified by MMseqs2.

## Reference documentation
- [Nail GitHub Repository](./references/github_com_TravisWheelerLab_nail.md)
- [Nail Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nail_overview.md)