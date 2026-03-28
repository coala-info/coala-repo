---
name: vsnp3
description: vSNP3 is a bioinformatics pipeline for pathogen surveillance that performs single-nucleotide polymorphism calling and phylogenetic analysis. Use when user asks to align sequencing reads, call SNPs, generate comparative matrices, or build phylogenetic trees for outbreak investigation.
homepage: https://github.com/USDA-VS/vsnp3
---

# vsnp3

## Overview

vSNP3 is a bioinformatics pipeline designed for pathogen surveillance and outbreak investigation. It provides single-nucleotide resolution to differentiate closely related strains. The tool is structured into a two-step process: first, individual samples are aligned and SNPs are called; second, these results are aggregated to produce comparative matrices and phylogenetic trees. This modular approach allows users to build and update strain databases incrementally without reprocessing existing data.

## Core Workflow

### 1. Environment Setup and Dependencies
Before running analysis, ensure the reference dependencies are correctly mapped.

*   **Add Reference Paths**: Use the path adder to point the tool to your reference genomes and defining SNP files.
    ```bash
    vsnp3_path_adder.py -d /path/to/vsnp_dependencies
    ```
*   **Verify References**: List all currently installed reference types and their associated file paths.
    ```bash
    vsnp3_path_adder.py -s
    ```

### 2. Step 1: Alignment and SNP Calling
Process raw sequencing reads for each sample individually. This step only needs to be performed once per sample.

*   **Basic Command**:
    ```bash
    vsnp3_step1.py -r1 sample_R1.fastq.gz -r2 sample_R2.fastq.gz -t <reference_type>
    ```
*   **Key Outputs**:
    *   `.vcf`: High-quality SNP calls.
    *   `.bam`: Read alignments.
    *   `stats.csv`: Quality metrics and alignment coverage.

### 3. Step 2: Matrix and Tree Generation
Combine VCF files from multiple samples to perform comparative analysis.

*   **Basic Command**:
    ```bash
    vsnp3_step2.py -a -t <reference_type>
    ```
*   **Key Outputs**:
    *   **SNP Matrix**: An Excel or HTML table showing SNP positions across all samples.
    *   **Phylogenetic Tree**: A Newick file (`.nwk`) for visualization in tools like FigTree or ITOL.
    *   **Summary Report**: An HTML file summarizing the group relationships.

## Expert Tips and Best Practices

*   **Defining SNPs**: vSNP3 uses "defining SNPs" to automatically categorize samples into hierarchical groups. If a sample contains a specific SNP at a known position, the tool will automatically assign it to a subgroup, allowing for focused analysis of relevant clusters.
*   **Zero Coverage Tracking**: Unlike many SNP callers, vSNP3 tracks regions with no sequence data. This prevents "false negatives" where a lack of data is mistaken for a reference allele.
*   **Mixed Strains**: The tool uses IUPAC ambiguity codes to represent positions with multiple alleles, which is critical for identifying mixed infections or contaminated samples.
*   **Incremental Updates**: When new samples arrive during an outbreak, only run Step 1 on the new data. You can then run Step 2 on the entire collection of VCFs (old and new) to see the updated relationships.
*   **Reference Selection**: Ensure the `-t` (reference type) matches the specific pathogen being analyzed, as this determines which reference genome and defining SNP set are used.



## Subcommands

| Command | Description |
|---------|-------------|
| vsnp3_step1.py | When running samples through step1 and 2 of vSNP, or when running a routine analysis, set up dependencies using vsnp3_path_adder.py |
| vsnp3_vsnp3_path_adder.py | vsnp3_path_adder.py is used to add reference types. |
| vsnp3_vsnp3_step2.py | Store VCF files from vSNP step1 to step 2 directory. VCF files must be stored by reference type. Make a VCF file directory database that will build over time as samples are ran in step 1 |

## Reference documentation
- [vSNP3 Main Repository](./references/github_com_USDA-VS_vSNP3.md)
- [vSNP3 README and Quick Start](./references/github_com_USDA-VS_vSNP3_blob_main_README.md)
- [Conda Installation Guide](./references/github_com_USDA-VS_vSNP3_blob_main_docs_instructions_conda_instructions.md)