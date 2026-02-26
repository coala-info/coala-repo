---
name: icescreen
description: ICEscreen is a bioinformatic pipeline that automates the discovery and annotation of Integrative and Conjugative Elements (ICEs) and Integrative and Mobilizable Elements (IMEs) in bacterial genomes. Use when user asks to detect ICEs or IMEs, identify signature proteins associated with conjugation and mobilization, or define the boundaries of mobile genetic elements.
homepage: https://forgemia.inra.fr/ices_imes_analysis/icescreen
---


# icescreen

## Overview
ICEscreen is a specialized bioinformatic pipeline designed to automate the discovery of ICEs and IMEs within the genomes of Bacillota. It works by identifying core signature proteins associated with conjugation and mobilization machinery and then grouping these hits to define the boundaries of mobile genetic elements. This tool is essential for researchers studying bacterial evolution, antibiotic resistance spread, and genome plasticity in Gram-positive bacteria.

## Installation and Setup
The recommended way to install icescreen is via Conda to manage its numerous dependencies (such as HMMER, Blast, and Prodigal).

```bash
conda install -c bioconda icescreen
```

## Common CLI Patterns

### Basic Annotation Workflow
To run the detection pipeline on a genome in GenBank format:
```bash
icescreen --genome input_genome.gbk --outdir output_directory
```

### Key Arguments
- `--genome`: Path to the input genome file (GenBank format with protein translations is preferred).
- `--outdir`: Directory where results, including detected elements and annotation tables, will be stored.
- `--jobs`: Specify the number of CPU cores to use for HMM searches and BLAST.

## Expert Tips and Best Practices
- **Input Quality**: Ensure your GenBank files contain `/translation` tags for CDS features. If starting from a FASTA file, use a tool like Prokka or Bakta first to generate a standardized GenBank file.
- **Taxonomic Focus**: While icescreen is optimized for Bacillota (Firmicutes), it relies on specific HMM profiles. If working with highly divergent species, manually inspect "orphan" signature proteins that fail to be grouped into formal ICE/IME structures.
- **Result Interpretation**: 
    - Check the `detected_SP.tsv` for individual signature protein hits.
    - Review the `detected_elements.tsv` for the predicted boundaries of the mobile elements.
    - Pay close attention to the "Validation" status of detected elements; "Incomplete" elements may indicate truncated sequences at contig edges.

## Reference documentation
- [ICEscreen Project Overview](./references/forge_inrae_fr_ices_imes_analysis_icescreen.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_icescreen_overview.md)