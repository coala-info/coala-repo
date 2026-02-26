---
name: agrvate
description: AgrVATE characterizes the accessory gene regulator locus in *Staphylococcus aureus* by performing kmer-based typing and identifying frameshift mutations. Use when user asks to assign agr groups, extract the agr operon, or detect mutations that lead to loss of function in genomic assemblies.
homepage: https://github.com/VishnuRaghuram94/AgrVATE
---


# agrvate

## Overview
AgrVATE (Agr Variant Assessment & Typing Engine) is a specialized bioinformatics tool designed for the rapid characterization of the accessory gene regulator (agr) locus in *Staphylococcus aureus*. It automates the assignment of agr groups using a kmer-based typing system and performs in-silico PCR to extract the agr operon. By comparing the extracted sequence against group-specific references, it identifies frameshifts and other mutations that may lead to loss of function. This skill provides the necessary command-line patterns and interpretive guidance to use AgrVATE effectively for clinical or research-based genomic analysis.

## Installation and Setup
The tool is available via Bioconda:
`conda install -c bioconda agrvate`

**Important Dependency Note**: AgrVATE relies on the 32-bit version of Usearch. Due to licensing, you must manually download the binary and add it to your PATH. If you are on a system that does not support 32-bit binaries (like modern macOS or certain WSL setups), you must use the MUMmer fallback option (`-m`).

## Common CLI Patterns

### Standard Analysis
Run the full typing and variant calling pipeline on a genome assembly:
`agrvate -i genome.fasta`

### Typing Only
If you only need to know the agr group and do not require operon extraction or frameshift detection:
`agrvate -i genome.fasta -t`

### Batch Processing
To process a directory full of FASTA files efficiently:
`ls *.fasta | xargs -I {} agrvate -i {}`

### MUMmer Fallback (Beta)
Use MUMmer instead of Usearch for operon extraction (recommended if Usearch is not installed or supported):
`agrvate -i genome.fasta -m`

## Interpreting Outputs
All outputs are placed in a directory named `[input_filename]-results`.

### fasta-summary.tab
This is the primary results file. Key columns include:
- **Column 2 (Agr group)**: Assigned group (gp1, gp2, gp3, gp4). 'u' means unknown.
- **Column 3 (Match score)**: Number of kmers matched (max 15). Scores **< 5** indicate low confidence.
- **Column 5 (Single/Multiple)**: 's' for single isolate, 'm' if multiple agr groups were detected (suggesting a mixed sample).
- **Column 6 (Frameshifts)**: Count of frameshift mutations in the agr operon.

### fasta-agr_operon_frameshifts.tab
Contains the specific coordinates and details of frameshift mutations detected by Snippy.

## Expert Tips and Best Practices
- **Result Consolidation**: When running multiple samples, use the following command to merge all summary tables into one file for easier analysis:
  `awk 'FNR==1 && NR!=1 { while (/^#/) getline; } 1 {print}' ./*-results/*-summary.tab > total_summary.tab`
- **Input Quality**: While AgrVATE accepts multi-fasta files, ensure your assembly is of sufficient quality. If the agr operon is split across multiple contigs, in-silico PCR may fail to extract an intact operon, leading to 'u' (unknown) values in the frameshift column.
- **Force Overwrite**: AgrVATE will not run if the output directory already exists. Use the `-f` or `--force` flag to overwrite previous results.
- **Database Path**: If you are not using a Conda installation, you must specify the path to the required databases using the `-d` flag.

## Reference documentation
- [AgrVATE GitHub Repository](./references/github_com_VishnuRaghuram94_AgrVATE.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_agrvate_overview.md)