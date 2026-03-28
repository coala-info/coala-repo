---
name: minnow
description: Minnow is a read-level simulation framework that generates raw sequence data for droplet-based single-cell RNA-seq experiments. Use when user asks to index a transcriptome, estimate simulation parameters from experimental data, or simulate synthetic single-cell reads.
homepage: https://github.com/COMBINE-lab/minnow
---


# minnow

## Overview

Minnow is a read-level simulation framework for droplet-based single-cell RNA-seq experiments. Unlike simulators that start with a count matrix, Minnow generates raw sequence data by sampling from a reference transcriptome or a de-Bruijn graph (dBG). This allows researchers to evaluate the impact of read alignment, UMI deduplication, and quantification methods. It is designed to work closely with Salmon/Alevin, using experimental data to inform simulation parameters.

## Core Workflows and CLI Patterns

### 1. Indexing the Transcriptome
The indexing phase constructs a de-Bruijn graph and prepares the reference. It automatically clips polyA tails and replaces ambiguous 'N' bases.

```bash
minnow index -r <transcriptome.fa> -k <read_length> -o <output_dir> -p <threads>
```

*   **Key Option**: `-k` should be set to your desired read length (e.g., 101).
*   **Optimization**: Use `--tmpdir` if working with large transcriptomes to manage disk space during dBG construction.

### 2. Parameter Estimation
To simulate realistic data, Minnow requires probability files generated from actual experimental runs. This requires a `bfh.txt` file produced by Salmon Alevin.

*   **Prerequisite**: Run Salmon Alevin with the `--dumpBfh` flag.
*   **Command**:
    ```bash
    minnow estimate -r <transcriptome.fa> -b <alevin_output/alevin/bfh.txt> -o <estimate_dir>
    ```

### 3. Data Simulation
Once indexed and estimated, use the simulation command to generate the synthetic reads.

*   **Note**: Ensure the cellular barcode and UMI lengths match the protocol being simulated (e.g., Chromium v2 vs v3).

## Expert Tips and Best Practices

*   **Header Cleaning**: Before indexing, clean your FASTA headers to ensure only the transcript ID is present. This prevents mapping issues later.
    ```bash
    sed -e '/^>/ s/|.*//' input.fa > clean_header.fa
    ```
*   **Branch Selection**: Use the `minnow-velocity` branch for the most up-to-date features and stability.
*   **Reference Selection**: Do not pass a whole genome file to `minnow index`; it is specifically designed for transcriptome-scale references.
*   **Memory Management**: When building the dBG for large organisms (like human or mouse), ensure at least 16-32GB of RAM is available, or increase the `-p` thread count to speed up MPHF (Minimal Perfect Hash Function) construction.



## Subcommands

| Command | Description |
|---------|-------------|
| minnow | minnow simulate [--alevin-mode] [--splatter-mode] [--normal-mode] [--testUniqness] [--reverseUniqness] [--useWeibull] [--numOfDoublets <number of Doublets>] -m <mat_file> -o <mat_file> --numMolFile <num mol file> [--gencode] -r <ref_file> [--g2t <gene_tr>] [--rspd <rspd_dist>] [--bfh <BFH file>] [--geneProb <gene level probability>] [--countProb <global count probability>] [--velocity] [--binary] [--dbg] [--noDump] [--gfa <gfa_file>] [--dupCounts] [--useWhiteList] [--generateNoisyCells] [--polyA] [--polyAsite <polyA_site>] [--polyAfraction <polyA_site>] [-s <sample_cells>] [--intronfile <intron_file>] [--genome <genome>] [-c <number of PCR cycles>] [-g <number of transcripts>] [--clusters <number of transcripts>] [--PCR <number of PCR cycles>] [--PCRmodel6] [-e <error rate for sequences>] [-p <number of threads>] [-v]         minnow estimate -eq <eqclass_dir> -o <mat_file> --g2t <gene_tr> --bfh <bfh_file> [--cluster <cluster>] [-v]         minnow --help [-v]         minnow -h [-v]         minnow help [-v] |
| minnow simulate | Simulate single-cell RNA-seq data |

## Reference documentation
- [Minnow README](./references/github_com_COMBINE-lab_minnow_blob_minnow-velocity_README.md)
- [Minnow Repository Overview](./references/github_com_COMBINE-lab_minnow.md)