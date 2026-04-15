---
name: danbing-tk
description: danbing-tk is a bioinformatics toolkit that genotypes Variable Number Tandem Repeats using a k-mer based repeat-pan genome graph approach. Use when user asks to genotype VNTRs from short-read sequencing data, build a repeat-pan genome graph, or predict motif dosage.
homepage: https://github.com/ChaissonLab/danbing-tk
metadata:
  docker_image: "quay.io/biocontainers/danbing-tk:1.3.2.5--h9948957_0"
---

# danbing-tk

## Overview

danbing-tk is a specialized bioinformatics toolkit designed to address the challenges of genotyping Variable Number Tandem Repeats (VNTRs). Unlike traditional methods that struggle with repetitive regions, danbing-tk utilizes a k-mer based repeat-pan genome graph (RPGG) approach. This allows for genome-wide profiling of VNTRs, targeted genotyping of specific alleles, and motif dosage estimation. It is particularly effective for analyzing short-read sequencing (SRS) data by mapping reads to a graph representation of known repeat variations.

## Core Workflows

### 1. Genotyping (danbing-tk align)
Use this workflow to genotype a short-read sequencing sample against a pre-built RPGG.

*   **Input**: SRS data (BAM or FASTQ) and a decompressed RPGG.
*   **Standard Pattern**: Pipe FASTA data from samtools directly into the aligner to save disk space.
*   **Command**:
    ```bash
    samtools fasta -@ [threads] -n input.bam | \
    danbing-tk -gc 85 3 -ae -kf 4 1 -cth 45 -o output_prefix \
    -k 21 -qs pan -fa /dev/stdin -p [threads] | gzip > output_prefix.aln.gz
    ```
*   **Key Parameters**:
    *   `-k`: K-mer size (typically 21).
    *   `-qs`: Query set name (e.g., "pan").
    *   `-fa`: Input file (use `/dev/stdin` for piping).

### 2. Building an RPGG (danbing-tk build)
There are two primary scenarios for graph construction:

**Scenario A: Single TR Locus (vntr2kmers_thread)**
Use when you have specific VNTR alleles (FASTA) for a single locus.
```bash
vntr2kmers_thread -g -k 21 -fs 700 -ntr 700 -on [name] -fa [num_haps] [list_of_fastas]
```
*   **Note**: Ensure at least 500bp-700bp flanks are included in the FASTA for accurate mapping.
*   **Indexing**: After building, serialize the graph for use in alignment:
    ```bash
    ktools serialize [name]
    ```

**Scenario B: Genome-wide from Assemblies**
Use the Snakemake pipeline (`GoodPanGenomeGraph.snakefile`) when building from haplotype-resolved assemblies. This requires a `goodPanGenomeGraph.json` config and a `genome.bam.tsv` mapping file.

### 3. Dosage Prediction (danbing-tk predict)
Use this to normalize k-mer counts into VNTR dosage (length proxy) or motif dosage.

```bash
danbing-tk-pred trkmers.meta.txt ikmer.meta corrected.gt.tsv bias.tsv
```
*   **Bias Correction**: Essential for association studies. It uses invariant k-mers (`ikmer.meta`) to correct for local read depth deviations.

## Expert Tips and Best Practices

*   **Memory Management**: Alignment is relatively efficient (~12 CPU hours for 30x coverage), but building a full RPGG is compute-intensive (~1200 CPU hours). Use cluster execution for the build pipeline.
*   **Input Preparation**: For genome-wide builds, use GRCh38 major chromosomes only. Avoid minor contigs to reduce graph complexity.
*   **Output Interpretation**: The `.tr.kmers` output from the alignment step does not contain locus info by default to save space. Use the provided scripts/tools to reconstruct the full table if needed.
*   **Quality Control**: If comparing genotypes across individuals (e.g., eQTL studies), always perform bias correction using the `danbing-tk-pred` tool or the provided bias correction notebooks.
*   **Environment**: Use the specific Python 3.11.4 environment recommended in the documentation to avoid dependency conflicts with `snakemake` and `statsmodels`.

## Reference documentation
- [danbing-tk GitHub Repository](./references/github_com_ChaissonLab_danbing-tk.md)
- [danbing-tk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_danbing-tk_overview.md)