---
name: vsnp
description: vSNP is a specialized bioinformatics pipeline designed for high-consequence disease investigations and outbreak tracking.
homepage: https://github.com/USDA-VS/vSNP
---

# vsnp

## Overview
vSNP is a specialized bioinformatics pipeline designed for high-consequence disease investigations and outbreak tracking. It transforms raw sequencing data into validated SNP calls and phylogenetic insights through a robust two-step process. The tool is optimized for accuracy and scalability, allowing users to compare thousands of samples against a common reference to produce annotated spreadsheets and evolutionary trees.

## Installation
Install vSNP via Conda to ensure all dependencies (like Samtools and FreeBayes) are correctly managed:
```bash
conda create --name vsnp_env
conda activate vsnp_env
conda install vsnp -c conda-forge -c bioconda
```

## Core Workflow

### 1. Step 1: SNP Calling and Validation
Process raw FASTQ files against a reference genome. This step only needs to be performed once per sample.

**Basic Command:**
```bash
vSNP_step1.py -r1 sample_R1.fastq.gz -r2 sample_R2.fastq.gz -r reference.fasta
```

**Key Features:**
- **Automatic Reference Selection:** For *Mycobacterium tuberculosis* complex and *Brucella* species, omit the `-r` flag to allow vSNP to automatically select the "best reference."
- **Output:** The critical output is the `zc.vcf` file. This file contains the validated SNP calls used for downstream comparative analysis.

### 2. Step 2: Comparative Analysis and Phylogeny
Build SNP tables and trees from a collection of VCF files generated in Step 1. All VCFs in the input directory must have been generated using the same reference genome.

**Basic Command:**
```bash
# Run within a directory containing multiple .zc.vcf files
vSNP_step2.py
```

**Outputs:**
- **SNP Table:** An Excel spreadsheet containing SNP calls sorted in evolutionary order with annotations and genomic positions.
- **Phylogenetic Trees:** Newick format trees corresponding to the SNP table.

## Reference Management
Use the path adder utility to make custom reference genomes and annotation files accessible to the pipeline.

```bash
vsnp_path_adder.py -d /path/to/your/vSNP_reference_options
```

## Expert Tips and Best Practices
- **Directory Organization:** Maintain a strict directory structure. Group `zc.vcf` files by the reference genome used to create them. Step 2 will fail or produce nonsensical results if VCFs from different references are mixed.
- **Custom Filtering:** To filter specific SNP positions or create subgroups, use the template provided in `dependencies/template_defining_filter.xlsx`. This allows for fine-grained control over the phylogenetic output.
- **Re-analysis:** Because Step 1 produces a persistent VCF, you can add new samples to an existing outbreak investigation by simply dropping new `zc.vcf` files into your Step 2 directory and re-running the script.
- **Resource Allocation:** Step 2 is highly efficient and can process thousands of VCF files in minutes, making it suitable for large-scale surveillance.

## Reference documentation
- [vSNP GitHub Repository](./references/github_com_USDA-VS_vSNP.md)
- [vSNP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vsnp_overview.md)