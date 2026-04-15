---
name: gene-fetch
description: This tool extracts gene or protein sequence data from NCBI for specific species or taxonomic IDs. Use when user asks to fetch sequences for a list of taxa, download specific genes like cox1 or 16S, or automate taxonomic traversal to find sequence matches.
homepage: https://github.com/bge-barcoding/gene_fetch
metadata:
  docker_image: "quay.io/biocontainers/gene-fetch:1.0.21--pyhdfd78af_0"
---

# gene-fetch

## Overview
The `gene-fetch` tool is a specialized Python utility designed for bioinformatics researchers who need to extract sequence data from NCBI without manually constructing complex search queries. It excels at "batch" operations where a list of species or TaxIDs requires specific gene or protein sequences. It includes robust features for handling atypical GenBank annotations, validating taxonomic lineages to avoid homonyms, and resuming interrupted downloads via checkpointing.

## Core CLI Usage

### Required Parameters
Every `gene-fetch` command requires the following core arguments:
- `--gene <name>`: The target gene (e.g., `cox1`, `16S`, `cytb`).
- `--type <type>`: The sequence format: `protein`, `nucleotide`, or `both`.
- `--out <dir>`: Destination for results.
- `--email <email>` and `--api-key <key>`: Required for NCBI Entrez API access.

### Batch Mode (Multiple Taxa)
Use a CSV file to process multiple samples. The input CSV should typically contain Sample IDs and TaxIDs.
```bash
gene-fetch --gene cox1 --type both --in samples.csv --out ./results --email user@example.com --api-key YOUR_NCBI_KEY
```

### Single Mode (Specific Taxon)
To fetch sequences for a single taxonomic group without an input file, use the `-s` flag:
```bash
gene-fetch --gene 16S --type nucleotide -s 9606 --out ./human_16s --email user@example.com --api-key YOUR_NCBI_KEY
```

## Expert Tips and Best Practices

### Sequence Length Filtering
By default, `gene-fetch` applies minimum length filters (500aa for proteins, 1000bp for nucleotides). Adjust these to avoid losing valid shorter sequences or to filter out fragments:
- Use `--protein-size <int>` to set the minimum amino acid length.
- Use `--nucleotide-size <int>` to set the minimum base pair length.

### Handling Missing Data with Traversal
In "batch" mode, the tool automatically performs taxonomic traversal. If a sequence is not found at the species level, it will move up the rank (e.g., Species -> Genus -> Family) until a suitable match is found. This is highly effective for building reference libraries where exact species matches are sparse.

### Resuming Interrupted Runs
`gene-fetch` implements automatic checkpointing. If a large batch job crashes or is timed out:
1. Run the exact same command again.
2. The tool will detect existing progress in the output directory and resume from the last processed TaxID.
3. Use the `--clean` flag only if you want to ignore checkpoints and start from scratch.

### API Performance
To avoid being throttled by NCBI:
- Always provide a valid API key to increase the rate limit to 10 requests per second.
- The tool automatically handles batching and summary information (esummary) when more than 50 matches are found, prioritizing the longest sequences first.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_bge-barcoding_gene_fetch.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_gene-fetch_overview.md)