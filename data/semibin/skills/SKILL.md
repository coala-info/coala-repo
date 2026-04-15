---
name: semibin
description: SemiBin is a deep-learning-based tool used for metagenomic binning to cluster contigs into high-quality bins. Use when user asks to bin metagenomic contigs, perform single-sample or multi-sample binning, or process long-read sequencing data for binning.
homepage: https://github.com/BigDataBiology/SemiBin
metadata:
  docker_image: "quay.io/biocontainers/semibin:2.2.1--pyhdfd78af_0"
---

# semibin

## Overview
SemiBin (specifically the SemiBin2 command) is a deep-learning-based tool for metagenomic binning that utilizes Siamese neural networks. It excels at clustering contigs into high-quality bins by learning from the data's own features (self-supervised learning). It supports a wide range of environments through pre-trained models and is optimized for both traditional short-read and newer long-read sequencing technologies.

## Installation and Setup
The recommended way to install SemiBin is via Conda or Pixi to ensure all dependencies (Bedtools, Hmmer, Samtools) are correctly managed.

```bash
conda create -n SemiBin
conda activate SemiBin
conda install -c conda-forge -c bioconda semibin
```

Verify the installation and check for GPU support:
```bash
SemiBin2 check_install
```

## Common CLI Patterns

### Single-Sample or Co-assembly Binning
Use `single_easy_bin` when you have one assembly and one or more BAM files representing the same sample or a co-assembly.

```bash
SemiBin2 single_easy_bin \
    --input-fasta contig.fa \
    --input-bam sample.sorted.bam \
    --environment human_gut \
    --output output_dir
```

### Multi-Sample Binning
Use `multi_easy_bin` for datasets with multiple samples. This requires contigs to be named using the format `sample_name:contig_name`.

1. **Concatenate FASTA files**:
   ```bash
   SemiBin2 concatenate_fasta -i sample1.fa sample2.fa -o concatenated.fa
   ```
2. **Run binning**:
   ```bash
   SemiBin2 multi_easy_bin \
       -i concatenated.fa \
       -b sample1.sorted.bam sample2.sorted.bam \
       -o output_dir
```

### Long-Read Binning
For assemblies generated from long reads (e.g., PacBio or Oxford Nanopore), use the `long_read` sequencing type.

```bash
SemiBin2 single_easy_bin \
    -i long_read_contig.fa \
    -b mapped_reads.sorted.bam \
    --sequencing-type long_read \
    -o output_dir
```

## Expert Tips and Best Practices

- **Environment Selection**: Always specify an `--environment` if your sample matches one of the supported niches (e.g., `human_gut`, `ocean`, `soil`, `wastewater`). If no specific environment fits, use `--environment global`.
- **Training from Scratch**: If you do not provide an `--environment` flag, SemiBin will train a new model on your data. Note that this is computationally expensive and requires significant time and disk space.
- **Abundance Estimation**: For faster processing, SemiBin2 supports abundance information from `strobealign-aemb` using the `--abundance` or `-a` flag.
- **GPU Acceleration**: SemiBin uses PyTorch. If a CUDA-compatible GPU is available, SemiBin will automatically attempt to use it, significantly speeding up the training and embedding steps.
- **Output Interpretation**: The primary results are located in the `output_bins` directory. Files named `bin.*.fa` are the initial bins, while `recluster.*.fa` represent refined bins if reclustering was performed.
- **Memory Management**: When running on large co-assemblies, ensure you have sufficient RAM for the embedding step, as Siamese neural networks can be memory-intensive.

## Reference documentation
- [SemiBin GitHub Repository](./references/github_com_BigDataBiology_SemiBin.md)
- [Bioconda SemiBin Overview](./references/anaconda_org_channels_bioconda_packages_semibin_overview.md)
- [SemiBin Version Tags and Changes](./references/github_com_BigDataBiology_SemiBin_tags.md)