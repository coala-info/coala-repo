---
name: recentrifuge
description: Recentrifuge is a bioinformatics suite for robust comparative metagenomics and statistical contamination removal. Use when user asks to analyze metagenomic classifier results, subtract contamination using negative controls, identify shared or exclusive taxa, or extract reads by taxonomic ID.
homepage: https://github.com/khyox/recentrifuge
metadata:
  docker_image: "quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0"
---

# recentrifuge

## Overview
Recentrifuge is a specialized bioinformatics suite designed to provide a high-confidence view of metagenomic samples. Unlike simple visualization tools, it employs a scoring arithmetic that accounts for the confidence levels of taxonomic assignments across 49 NCBI ranks. Its primary value lies in its ability to statistically subtract contamination found in negative controls and identify shared versus exclusive taxa across multiple samples, enabling researchers to isolate minority organisms that might otherwise be dismissed as noise.

## Core CLI Patterns

### 1. Basic Comparative Analysis
To run a standard analysis on classifier outputs, use the main `rcf` script. The tool automatically detects the input format or allows manual specification.

```bash
# Analyze Centrifuge results
rcf -c sample1.results.txt sample2.results.txt

# Analyze Kraken2 results
rcf -k sample1.kraken sample2.kraken
```

### 2. Contamination Removal
To perform contamination subtraction, you must identify one or more samples as negative controls using the `-ctrl` or `--control` flag.

```bash
# Subtract contamination found in 'blank_control.txt' from other samples
rcf -c sample_A.txt sample_B.txt -ctrl blank_control.txt
```

### 3. Advanced Taxonomic Filtering
Use the `--strain` flag to enable infraspecific taxonomic ranks (strains, isolates) for high-resolution clinical or forensic applications.

```bash
# Enable strain-level analysis
rcf -c sample1.txt --strain
```

### 4. Utility Scripts
Recentrifuge includes several auxiliary tools for data preparation and post-processing:

*   **rextract**: Extracts specific reads from a sample based on the taxonomic assignment.
    ```bash
    rextract -c centrifuge_output.txt -r original_reads.fastq -t 562  # Extracts E. coli (taxid 562)
    ```
*   **refasplit**: Symmetrically splits large FASTA files for parallel processing.
    ```bash
    refasplit -n 4 large_database.fasta  # Splits into 4 equal parts
    ```
*   **rextraccnt**: Extracts entries from large NCBI-like databases (e.g., nt) using a list of accessions or taxids.

## Expert Tips
*   **Confidence Scores**: Recentrifuge relies heavily on the "score" column of classifiers. Ensure your classifier is configured to output confidence scores to get the most out of the hierarchical tree arithmetic.
*   **Visualization**: The output is a standalone HTML file. It is optimized for modern browsers (Chrome, Firefox, Safari). Use the interactive legend to toggle between "Raw", "Subtracted", and "Shared" views.
*   **Memory Management**: When dealing with very large NCBI taxonomy dumps, ensure the environment has sufficient RAM for `retaxdump` to build the local taxonomic tree.



## Subcommands

| Command | Description |
|---------|-------------|
| rcf | Robust comparative analysis and contamination removal for metagenomics |
| refasplit | Symmetrically split a FASTA file into several files |
| retaxdump | Get needed taxdump files from NCBI servers |
| rextraccnt | Extraction from fasta with accessions as NCBI nt DB |
| rextract | Selectively extract reads by Centrifuge output |
| rgf | Robust comparative analysis and contamination removal for functional metagenomics |

## Reference documentation
- [Recentrifuge Home](./references/github_com_khyox_recentrifuge_wiki.md)
- [Recentrifuge Command Line](./references/github_com_khyox_recentrifuge_wiki_Recentrifuge-command-line.md)
- [Using rextract to extract reads](./references/github_com_khyox_recentrifuge_wiki_Using-rextract-to-extract-reads-from-the-samples.md)
- [Contamination Removal Logic](./references/github_com_khyox_recentrifuge.md)