---
name: scepia
description: The scepia (Single Cell Epigenome-based Inference of Activity) tool bridges the gap between transcriptomics and epigenomics.
homepage: https://github.com/vanheeringen-lab/scepia
---

# scepia

## Overview
The scepia (Single Cell Epigenome-based Inference of Activity) tool bridges the gap between transcriptomics and epigenomics. It allows researchers to predict which transcription factors are active in specific cell populations by comparing scRNA-seq expression profiles against a library of reference H3K27ac ChIP-seq and ATAC-seq profiles. This is particularly useful for identifying the underlying regulatory drivers of cell states identified through clustering.

## Installation and Setup
Scepia is primarily distributed via bioconda. It requires specific genome sequences to be installed locally via `genomepy` before running inferences.

```bash
# Install scepia
conda install -c bioconda -c conda-forge scepia

# Install required genomes (run once per genome)
# Supported: hg38, hg19, mm10, mm9
genomepy install hg38
```

## Core Workflows

### Inferring TF Motif Activity
The `infer_motifs` command is the primary entry point. It accepts any file format supported by `scanpy.read()` (e.g., `.h5ad`, `.csv`, `.tsv`).

```bash
scepia infer_motifs <input_file> <output_dir> --dataset <dataset_name>
```

**Available Reference Datasets:**
- `ENCODE.H3K27ac.human`: Broad human reference (cell lines and tissues).
- `BLUEPRINT.H3K27ac.human`: Human hematopoietic cell types.
- `Domcke.ATAC.fetal.human`: Human fetal ATAC-seq clusters.
- `Cusanovich.ATAC.adult.mouse`: Adult mouse tissue ATAC-seq clusters.
- `ENCODE.H3K27ac.mouse`: Broad mouse H3K27ac reference.

### Calculating Enhancer-based Regulatory Potential (ERP)
Use the `area27` command to calculate ERP scores from H3K27ac BAM files. This score represents the regulatory influence of enhancers on nearby genes.

```bash
scepia area27 <bamfile> <outfile> -N <threads>
```

## Expert Tips and Best Practices
- **Gene Identifiers**: Scepia requires gene names (symbols) as identifiers. It will fail or produce poor results if Ensembl IDs or other numeric identifiers are used.
- **Data Preprocessing**: For best results with `infer_motifs`, ensure your input data:
    - Is log-transformed.
    - Is filtered to include only hypervariable genes.
    - Has already undergone clustering (Louvain or Leiden).
- **Species Cross-over**: While officially supporting Human and Mouse, scepia can be run on other species if gene names match the reference, though results should be interpreted with caution due to assumptions about regulatory conservation.
- **Memory Management**: The first time a reference dataset is used, scepia will download it, which requires an active internet connection and additional processing time.

## Reference documentation
- [Scepia GitHub Repository](./references/github_com_vanheeringen-lab_scepia.md)
- [Scepia Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scepia_overview.md)