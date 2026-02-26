---
name: deeparg
description: DeepARG predicts Antibiotic Resistance Genes (ARGs) from metagenomic data using deep learning. Use when user asks to predict antibiotic resistance genes, analyze metagenomic sequences for ARGs, or identify ARGs in microbial communities.
homepage: https://bitbucket.org/gusphdproj/deeparg-ss/
---


# deeparg

deeparg/
├── SKILL.md
└── references/
    ├── anaconda_org_channels_bioconda_packages_deeparg_overview.md
    └── bitbucket_org_gusphdproj_deeparg-ss.md
```

```md
name: deeparg
description: Predicts Antibiotic Resistance Genes (ARGs) from metagenomic data using deep learning. Use when analyzing metagenomic sequences to identify potential ARGs, understand microbial resistance profiles, or assess the risk of antibiotic resistance spread.
---
## Overview

DeepARG is a powerful tool that leverages deep learning to identify Antibiotic Resistance Genes (ARGs) directly from metagenomic sequencing data. It's designed to help researchers understand the prevalence and diversity of antibiotic resistance mechanisms within microbial communities, which is crucial for fields like environmental microbiology, public health, and infectious disease research.

## Usage Instructions

DeepARG operates primarily through its command-line interface. The core functionality involves providing input sequences and specifying output options.

### Basic Usage

The most fundamental command requires an input FASTA file and an output file prefix.

```bash
deeparg -i input.fasta -o output_prefix
```

### Key Options and Best Practices

*   **`-i` / `--input`**: Specify the input FASTA file containing your metagenomic sequences. Ensure this file is properly formatted.
*   **`-o` / `--output`**: Define a prefix for all output files. DeepARG will generate multiple files (e.g., `.ARG`, `.ARG.txt`, `.ARG.json`) based on this prefix.
*   **`-d` / `--database`**: Select the ARG database to use. Common options include `all`, `ncbi`, `card`, `megares`. The `all` option uses a comprehensive set of databases. For specific analyses, choosing a targeted database like `card` or `ncbi` can be more efficient.
    ```bash
    deeparg -i input.fasta -o output_prefix -d card
    ```
*   **`-a` / `--alignment`**: Choose the alignment method. Options typically include `blast` or `diamond`. Diamond is generally faster for large datasets.
    ```bash
    deeparg -i input.fasta -o output_prefix -a diamond
    ```
*   **`-t` / `--threshold`**: Set the similarity threshold for ARG identification. The default is usually sufficient, but you may adjust it based on your research question and the stringency required. Lower thresholds may identify more potential ARGs, while higher thresholds focus on highly similar matches.
*   **`-m` / `--mode`**: Specify the prediction mode. Common modes include `complete` (predicts ARGs from complete sequences) and `partial` (predicts ARGs from partial sequences). The `complete` mode is generally recommended for higher confidence.
*   **`-p` / `--threads`**: Utilize multiple CPU cores for faster processing. This is highly recommended for large input files.
    ```bash
    deeparg -i input.fasta -o output_prefix -p 8
    ```
*   **`-l` / `--local`**: Use local alignment instead of global alignment. This can be useful for identifying ARGs within longer contigs where only a portion might match.

### Output Files

DeepARG generates several output files:

*   **`.ARG.txt`**: A tab-separated file containing detailed information about each identified ARG, including sequence ID, ARG name, gene family, alignment score, and coverage. This is often the primary file for downstream analysis.
*   **`.ARG.json`**: A JSON-formatted file with the same information as `.ARG.txt`, useful for programmatic parsing.
*   **`.ARG`**: A FASTA file containing the sequences that were identified as ARGs.

### Expert Tips

*   **Pre-processing**: Ensure your input FASTA file is clean and contains only the sequences you intend to analyze. Remove any adapter sequences or low-quality reads if necessary.
*   **Database Selection**: Carefully consider which database (`-d`) is most relevant to your research. Using a specific database can reduce noise and improve the relevance of your findings.
*   **Performance**: For large datasets, always use the `-p` option to leverage multi-threading and consider using `diamond` for alignment (`-a diamond`) for significant speed improvements.
*   **Thresholding**: Experiment with the `-t` threshold if you are seeing too many or too few hits. Understand the trade-offs between sensitivity and specificity for your specific application.
*   **Mode Selection**: The `complete` mode is generally more reliable. Use `partial` mode cautiously and be aware of potential false positives.

## Reference documentation

- [DeepARG Overview](./references/anaconda_org_channels_bioconda_packages_deeparg_overview.md)