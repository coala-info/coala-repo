---
name: xtea
description: xTea detects non-reference transposable element insertions. Use when user asks to detect non-reference transposable element insertions, identify germline TE insertions, identify somatic TE insertions, or analyze TE insertions using hybrid data.
homepage: https://github.com/parklab/xTea
metadata:
  docker_image: "quay.io/biocontainers/xtea:0.1.9--hdfd78af_0"
---

# xtea

## Overview

xTea (comprehensive transposable element analyzer) is a tool designed to detect non-reference transposable element insertions. It works by analyzing discordant read pairs, split reads, and performing local assembly to identify insertions across various sequencing technologies. It is highly effective for both germline and somatic (mosaic) TE discovery in human genomes (hg19, hg38, and CHM13).

## Installation and Setup

The most reliable way to install xtea and its dependencies is via Bioconda:

```bash
conda create -n xtea_env
conda activate xtea_env
conda install -c bioconda -c conda-forge xtea
```

**Required External Dependencies:**
Ensure the following are in your `$PATH`:
- `bwa` (v0.7.17+)
- `samtools` (v1.0+)
- `minimap2` (for long reads)
- `wtdbg2` (for long reads)

## Input Preparation

xtea requires specific text-based input lists to manage samples and their corresponding data files.

1.  **Sample ID List (`sample_id.txt`):** A file with one unique sample ID per line.
2.  **Illumina BAM List (`illumina_bam_list.txt`):** Two columns (tab or space separated): `SampleID /path/to/bam`.
3.  **10X BAM List (`10X_bam_list.txt`):** Three columns: `SampleID /path/to/bam /path/to/barcode_index_bam`.
4.  **Case-Control List:** Three columns: `SampleID /path/to/case_bam /path/to/control_bam`.

## Common CLI Patterns

xtea typically functions by generating a submission script (e.g., `submit_jobs.sh`) which then executes the actual pipeline.

### Standard Illumina Germline Analysis
```bash
xtea -i sample_id.txt \
     -b illumina_bam_list.txt \
     -p ./work_folder/ \
     -o submit_jobs.sh \
     -l /path/to/rep_lib_annotation/ \
     -r /path/to/genome.fa \
     -g /path/to/gene_annotation.gff3 \
     --xtea /path/to/xtea_scripts/ \
     -f 5907 -y 7 \
     --slurm -t 0-12:00 -n 8 -m 25
```

### Case-Control (Somatic/Tumor) Analysis
Use the `--case_ctrl` and `--tumor` flags to identify somatic insertions.
```bash
xtea --case_ctrl --tumor \
     -i sample_id.txt \
     -b case_ctrl_bam_list.txt \
     -p ./work_folder/ \
     -o submit_jobs.sh \
     -l /path/to/rep_lib_annotation/ \
     -r /path/to/genome.fa \
     -g /path/to/gene_annotation.gff3 \
     --xtea /path/to/xtea_scripts/
```

### Hybrid Data (10X + Illumina)
```bash
xtea -i sample_id.txt \
     -b illumina_bam_list.txt \
     -x 10X_bam_list.txt \
     -p ./work_folder/ \
     -o submit_jobs.sh \
     -l /path/to/rep_lib_annotation/ \
     -r /path/to/genome.fa \
     -g /path/to/gene_annotation.gff3 \
     --xtea /path/to/xtea_scripts/
```

## Expert Tips and Best Practices

- **Reference Genome Versions:** By default, xtea assumes **GRCh38/hg38**. If working with **hg19/GRCh37**, you must use the `xtea_hg19` command. For **CHM13**, use the `gnrt_pipeline_local_chm13.py` script.
- **Resource Allocation:** Each core typically requires **2-3GB of memory**. For high-depth BAM files, increase the runtime (`-t`) and memory (`-m`) parameters.
- **Repeat Library:** The repeat library (`rep_lib_annotation.tar.gz`) is a mandatory resource. Ensure it is downloaded and decompressed before running.
- **Gene Annotations:** xtea requires decompressed GFF3 files from GENCODE.
- **Pathing:** The `--xtea` argument must point to the exact directory containing the xtea Python scripts if you are using an "install-free" or manual installation.
- **Cluster Systems:** Use `--slurm` or `--lsf` to automatically generate headers for job schedulers. If using a different system, you will need to manually edit the generated `submit_jobs.sh`.

## Reference documentation
- [xTea GitHub Repository](./references/github_com_parklab_xTea.md)
- [Bioconda xtea Package Overview](./references/anaconda_org_channels_bioconda_packages_xtea_overview.md)