---
name: vsnp
description: vSNP is a bioinformatics pipeline that transforms raw sequencing data into annotated SNP tables and phylogenetic trees for disease tracing. Use when user asks to align reads to a reference, call SNPs, generate comparative SNP tables, or build evolutionary trees.
homepage: https://github.com/USDA-VS/vSNP
metadata:
  docker_image: "quay.io/biocontainers/vsnp:2.03--hdfd78af_2"
---

# vsnp

## Overview

vSNP (validate SNPs) is a specialized bioinformatics pipeline designed for high-consequence disease tracing. It provides an accreditation-friendly workflow to transform raw sequencing data into annotated SNP tables and phylogenetic trees. The tool operates in a two-step process: first, aligning raw reads to a reference to generate VCF files, and second, comparing multiple VCF files to build comparative tables and evolutionary trees.

## Installation and Setup

Install vSNP via Conda:
```bash
conda create --name vsnp_env
conda install vsnp -c conda-forge -c bioconda
```

### Managing Reference Options
vSNP uses a specific directory structure for references, including FASTA, GBK (annotation), and defining SNP files.
- Register a reference directory: `vsnp_path_adder.py -d /path/to/reference_options`
- View available references: `vSNP_step1.py -t`
- List current paths: `vsnp_path_adder.py -s`

## Step 1: Alignment and SNP Calling

Process raw FASTQ files to generate a `zc.vcf` file. It is recommended to run each sample in its own directory.

### Common CLI Patterns

**1. Standard Paired-End Run:**
```bash
vSNP_step1.py -r1 sample_R1.fastq.gz -r2 sample_R2.fastq.gz -r <reference_name>
```

**2. Automatic Reference Selection:**
For *Mycobacterium tuberculosis* complex or *Brucella* species, omit the `-r` flag to allow vSNP to find the best reference automatically.
```bash
vSNP_step1.py -r1 sample_R1.fastq.gz -r2 sample_R2.fastq.gz
```

**3. Using a Specific FASTA File:**
```bash
vSNP_step1.py -r1 sample_R1.fastq.gz -r2 sample_R2.fastq.gz -r /path/to/custom_reference.fasta
```

### Expert Tips for Step 1
- **Quality Check**: Review the `(sample_name)_(Date).xlsx` statistics file. Pay attention to Q30 values, genome coverage, and average depth.
- **Coverage Threshold**: Exercise extreme caution with samples having less than 20X average depth, as SNP calls may be unreliable.
- **Data Persistence**: You only need to run Step 1 once per sample/reference combination. Save the resulting VCF files for future comparative analyses in Step 2.

## Step 2: SNP Tables and Phylogenetic Trees

Compare a collection of VCF files generated from the same reference.

### Execution
1. Create a directory containing all `*zc.vcf` files you wish to compare.
2. Run the command within that directory:
```bash
vSNP_step2.py
```

### Output Analysis
- **SNP Table**: An Excel spreadsheet containing SNP calls sorted in evolutionary order, including annotations and genome positions.
- **Phylogenetic Trees**: Newick files (`.tre`) compatible with viewers like FigTree or Geneious.
- **Filtering**: Use the `dependencies/template_defining_filter.xlsx` to create custom subgroups or filter specific positions.

## Utility Scripts

- **Path Management**: Use `vsnp_path_adder.py` to re-establish paths after a tool update (`conda update vsnp`).
- **Help**: Access detailed parameter descriptions using the `-h` flag on any vSNP script.



## Subcommands

| Command | Description |
|---------|-------------|
| vSNP_step1.py | vSNP step 1: Preprocessing and reference selection for variant calling. |
| vsnp_vSNP_step2.py | Current working directory used by default, but can specify working directory with -w. Directory must contain VCF files with file extension ".vcf" |
| vsnp_vsnp_path_adder.py | Using no arguments or -s option show the same output. |

## Reference documentation
- [vSNP Main README](./references/github_com_USDA-VS_vSNP_blob_master_README.md)
- [Detailed Usage Guide](./references/github_com_USDA-VS_vSNP_blob_master_docs_detailed_usage.md)
- [Utility Scripts Overview](./references/github_com_USDA-VS_vSNP_blob_master_docs_utilities.md)