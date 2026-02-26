---
name: phamb
description: "phamb identifies and isolates viral metagenome-assembled genomes from metagenomic bins using a Random Forest model. Use when user asks to differentiate viral clusters from bacterial ones, recover high-quality viral MAGs from VAMB output, or reduce the computational search space for viral evaluation."
homepage: https://github.com/RasmussenLab/phamb
---


# phamb

## Overview

`phamb` (Phage from metagenomic bins) is a specialized tool for the discovery and isolation of metagenome-derived viromes. It is designed to process the output of VAMB binning to recover high-quality viral Metagenomic Assembled Genomes (MAGs). By using a Random Forest model trained on viral bins, it significantly reduces the computational search space and time required for viral evaluation. Use this skill when you need to differentiate viral clusters from bacterial ones in large-scale metagenomic assemblies.

## Installation

The recommended installation method is via Bioconda:

```bash
mamba create -n phamb python=3.9
conda activate phamb
mamba install -c conda-forge -c bioconda phamb snakemake cython pygraphviz
```

## Core Workflow and CLI Usage

### 1. Preparation and Annotation
Before running the Random Forest model, you must annotate your contigs. This requires VOGdb (HMMs), MiComplete Bacterial HMMs, and DeepVirFinder.

**Quick Annotation (Non-parallel):**
```bash
# 1. Run DeepVirFinder
python3 /path/to/DeepVirFinder/dvf.py -i contigs.fna -o DVF -l 2000 -c 1

# 2. Predict proteins with Prodigal
prodigal -i contigs.fna -d genes.fna -a proteins.faa -p meta -g 11

# 3. HMM searches
hmmsearch --cpu 8 -E 1.0e-05 --tblout annotations/all.hmmMiComplete105.tbl <micompleteDB> proteins.faa
hmmsearch --cpu 8 -E 1.0e-05 --tblout annotations/all.hmmVOG.tbl <VOGDB> proteins.faa
```

### 2. Running the Random Forest Model
The primary command to isolate viral bins is `run_RF.py`. It requires the original assembly, the VAMB cluster file, and the directory containing your annotations.

```bash
run_RF.py <contigs.fna.gz> <vamb/clusters.tsv> <annotations_dir> <result_dir>
```

**Arguments:**
- `contigs.fna.gz`: The concatenated assembly file used for binning.
- `clusters.tsv`: The cluster output from VAMB.
- `annotations_dir`: Directory containing `all.hmmMiComplete105.tbl`, `all.hmmVOG.tbl`, and `all.DVF.predictions.txt`.
- `result_dir`: Output directory for predictions and isolated bins.

### 3. Output Interpretation
The tool generates several key files in the `result_dir`:
- `vambbins_aggregated_annotation.txt`: Summary of bin annotations.
- `vambbins_RF_predictions.txt`: The classification results for each bin.
- `vamb_bins/`: Directory containing the predicted viral bins in FASTA format.

## Expert Tips and Best Practices

- **Isolate Search Space First**: Always use `phamb` to isolate the virome search space prior to running intensive viral evaluation tools like CheckV or VIBRANT. This can reduce computational time by over 200% on large datasets.
- **CheckV Evaluation**: When evaluating the output bins with CheckV, prioritize the **AAI-model**. The HMM-model in CheckV is often less suited for viral MAGs produced by this workflow.
- **Quality Filtering**: Focus your downstream analysis on "Medium-quality" and "High-quality" viral bins. "Low-quality" bins often represent fragmented viruses or contamination and should be handled with caution.
- **Parallel Processing**: For large assemblies, use the `split_contigs.py` script provided in the repository to break the `contigs.fna.gz` into sample-specific assemblies, allowing for parallel annotation via Snakemake.
- **DVF Header Cleaning**: If aggregating DeepVirFinder results manually, ensure you remove redundant headers from the concatenated file:
  ```bash
  grep -v 'pvalue' annotations/DVF.predictions.txt > annotations/all.DVF.predictions.txt
  ```

## Reference documentation
- [GitHub Repository](./references/github_com_RasmussenLab_phamb.md)
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_phamb_overview.md)