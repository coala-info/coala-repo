---
name: covid-spike-classification
description: This tool identifies clinically relevant SARS-CoV-2 spike protein mutations from Sanger sequencing trace files. Use when user asks to classify spike mutations, process AB1 files, or identify SARS-CoV-2 variants from sequencing traces.
homepage: https://github.com/kblin/covid-spike-classification/
---


# covid-spike-classification

## Overview
The `covid-spike-classification` tool is a specialized bioinformatics utility designed to automate the identification of clinically relevant SARS-CoV-2 spike protein mutations. It processes Sanger sequencing trace files (AB1 format) by aligning them to a reference genome and calling mutations based on the resulting pileup. The tool is specifically optimized for public health surveillance, providing a structured output that indicates the presence, absence, or sequencing failure for a predefined list of tracked mutations.

## Installation and Setup
The most efficient way to deploy the tool is via Bioconda.

```bash
# Create environment and install
conda create -n csc -c conda-forge -c bioconda covid-spike-classification
conda activate csc
```

### Building Reference Indices
Before running the classification, you must generate indices for your reference genome (typically NC_045512). If you have the source repository, use the provided script:

```bash
cd ref
./build_indices.sh
```

## Common CLI Patterns

### Basic Analysis
Run the classification on a directory of `.ab1` files. You must provide the path to the reference FASTA file and an output directory.

```bash
covid-spike-classification --reference /path/to/NC_045512.fasta --outdir ./results /path/to/sanger_reads/
```

### Processing Compressed Inputs
The tool natively supports ZIP files, which is useful for handling large batches of traces from sequencing core facilities.

```bash
covid-spike-classification --reference reference.fasta --outdir ./results samples_batch_01.zip
```

### Advanced Options
*   **Silence D614G Warnings**: Since D614G is ubiquitous in most contemporary lineages, you can silence specific warnings related to it using the `--silence-d614g` flag (if available in your version).
*   **Help Menu**: Access detailed parameter descriptions.
    ```bash
    covid-spike-classification --help
    ```

## Expert Tips and Best Practices
*   **Input Organization**: Ensure `.ab1` files are directly inside the provided directory or ZIP. The tool can support nested directories, but a flat structure is more reliable for sample naming.
*   **Reference Genome**: Always use the Wuhan-Hu-1 (NC_045512.2) reference genome to ensure mutation coordinates (e.g., E484K, N501Y) match standard nomenclature.
*   **Interpreting Results**: The output table includes "yes", "no", and "failed" columns. A "failed" result typically indicates poor trace quality or insufficient coverage at that specific residue position.
*   **Error Probabilities**: The tool reports error probabilities for mutation calls based on the Phred scores of the mutated bases. Always check these probabilities if a mutation call seems unexpected.
*   **Tracked Mutations**: The tool tracks a specific list of mutations (e.g., K417N, T478K, L452R, E484Q). If you are looking for emerging variants not in the hardcoded list, you may need to inspect the alignment files manually or check for tool updates.

## Reference documentation
- [Main Repository and Usage](./references/github_com_kblin_covid-spike-classification.md)
- [Version History and Mutation Updates](./references/github_com_kblin_covid-spike-classification_tags.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_covid-spike-classification_overview.md)