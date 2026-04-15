---
name: alloshp
description: AlloSHP identifies homeologous polymorphisms in allopolyploid species by comparing polyploid VCF data against diploid ancestral genomes. Use when user asks to perform whole-genome alignments between progenitors, convert VCF data into alignments, or generate synteny-aware multiple sequence alignments for polyploid phylogenetics.
homepage: https://github.com/eead-csic-compbio/AlloSHP
metadata:
  docker_image: "quay.io/biocontainers/alloshp:2025.09.12--h7b50bb2_0"
---

# alloshp

## Overview

AlloSHP is a specialized bioinformatics suite designed for the study of allopolyploid species. It facilitates the identification of homeologous polymorphisms by comparing polyploid sequence data (VCF) against the genomes of their diploid ancestors. The workflow typically follows a three-stage process: performing whole-genome alignments (WGA) between diploid progenitors, converting VCF data into alignments, and finally generating synteny-aware multiple sequence alignments. This tool is essential for researchers working on genome evolution, subgenome differentiation, and polyploid phylogenetics.

## Core Workflow and CLI Usage

### 1. Whole-Genome Alignment (WGA)
Before processing VCF data, you must identify syntenic regions between your diploid reference genomes.

*   **Basic Alignment**:
    `WGA -A progenitor_A.fna.gz -B progenitor_B.fna.gz -o output_folder`
*   **Using GSAlign**: Add the `-g` flag to use GSAlign instead of the default CGaln.
*   **Masking**: By default, the tool uses `Red` for soft-masking. If your genomes are already soft-masked, use the `-m` flag to save time.
*   **Contig Filtering**: Use `-l [Mbp]` to set the minimum contig length (default is often 10 Mbp for major assemblies).

### 2. VCF to Alignment (vcf2alignment)
This step extracts sequence information from the VCF file based on the syntenic segments identified in the WGA step.

*   **Standard Execution**:
    `vcf2alignment -v polyploid_data.vcf.gz -c config.tsv -l analysis_log.gz -d 5 -m 3`
*   **Key Parameters**:
    *   `-d [int]`: Minimum depth of coverage required to consider a site.
    *   `-m [int]`: Minimum number of individuals that must have data at a site.
    *   `-c [file]`: Path to the configuration TSV defining the relationship between VCF samples and subgenomes.

### 3. VCF to Synteny (vcf2synteny)
The final step produces the Multiple Sequence Alignment (MSA) files used for downstream phylogenetic or population genetic analysis.

*   **Generating MSA**:
    `vcf2synteny -v polyploid_data.vcf.gz -c config.synteny.tsv -l analysis_log.gz -r ReferenceName -o subgenome_msa.fasta`
*   **Outgroup Support**: Use a configuration file that includes outgroup specifications (e.g., `config.outg.synteny.tsv`) to include a reference outgroup in the final MSA.

## Expert Tips and Best Practices

*   **Unique Chromosome Names**: Ensure that every chromosome/scaffold across all input FASTA files has a unique identifier. Concatenating genomes with overlapping names (e.g., both having "Chr01") will cause the pipeline to fail or produce incorrect mappings.
*   **Configuration Accuracy**: The `config.tsv` file is the most common source of error. Double-check that the sample names in the VCF exactly match the entries in your configuration files.
*   **Memory Management**: WGA of large plant genomes is memory-intensive. Use the `-n` flag in the `WGA` script to specify the number of CPU cores, but monitor RAM usage closely when aligning assemblies larger than 1Gb.
*   **Soft-masking**: If the alignment step is taking too long or producing too many non-syntenic hits, ensure your reference genomes are properly soft-masked to ignore repetitive elements.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/WGA | Whole Genome Alignment tool for comparing two genomes |
| vcf2alignment | Convert VCF files to multiple sequence alignments (MSA) with optional filtering and configuration. |
| vcf2synteny | Convert VCF files to synteny FASTA/VCF formats based on a configuration file and reference genome. |

## Reference documentation
- [AlloSHP Repository Overview](./references/github_com_eead-csic-compbio_AlloSHP.md)
- [AlloSHP README and Pipeline Guide](./references/github_com_eead-csic-compbio_AlloSHP_blob_master_README.md)
- [Makefile Test Examples](./references/github_com_eead-csic-compbio_AlloSHP_blob_master_Makefile.md)