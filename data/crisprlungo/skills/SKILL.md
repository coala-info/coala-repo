---
name: crisprlungo
description: CRISPRlungo is a bioinformatics pipeline for quantifying genome editing efficiency from single-anchor amplicon sequencing data, particularly long-read data. Use when user asks to quantify genome editing efficiency, process Nanopore amplicon reads, perform background error filtering with a control sample, or analyze UMI-tagged CRISPR sequencing data.
homepage: https://github.com/pinellolab/CRISPRlungo
---


# crisprlungo

## Overview
CRISPRlungo is a specialized bioinformatics pipeline for processing single-anchor amplicon sequencing data to quantify genome editing efficiency. It excels at handling long-read data (like Nanopore) where higher error rates necessitate sophisticated filtering and background correction. The tool automates the alignment, chimera removal, UMI clustering, and statistical quantification of mutations, providing both tabular data and visual summaries of the edit spectrum.

## Core CLI Usage Patterns

### 1. Standard Analysis
The basic command requires a reference FASTA, the sequencing FASTQ, an output directory, and the target sequence (the specific guide/target site).
```bash
CRISPRlungo reference.fasta sample.fastq ./results "GGCGCCCTGGCCAGTCGTCT"
```

### 2. Background Error Filtering
Essential for long-read data to distinguish true edits from sequencing noise. Provide a non-edited control sample.
```bash
CRISPRlungo reference.fasta sample.fastq ./results "TARGET_SEQ" --control control.fastq
```

### 3. UMI-Tagged Sequencing
When using UMIs for high-accuracy consensus, the UMI pattern must be defined in the reference FASTA using parentheses, e.g., `...AGGTTT(VVVVTTVVVV)TTTGGG...`.
```bash
CRISPRlungo --umi reference_with_umi.fasta sample.fastq ./results "TARGET_SEQ"
```

## Expert Parameters and Best Practices

### Refining Mutation Detection
- **Cleavage Position**: By default, the tool assumes cleavage at position 16 relative to the target. Use `--cleavage_pos` to adjust for different nucleases or nickases.
- **Analysis Window**: Use `--window` (default is often sufficient) to define the area around the cleavage site for indel quantification.
- **Intended Mutations**: For Prime Editing or Base Editing, provide the expected edited sequence via `--induced_sequence_path` to specifically quantify the "intended" outcome versus "unintended" indels.

### Advanced Filtering
- **Chimeras**: The tool automatically identifies and removes PCR-induced chimeras, which is critical for accurate long-read amplicon analysis.
- **Substitution Merging**: Use `--merge_substitution` to treat consecutive mismatches as a single event, which is helpful in high-noise environments or specific base-editing contexts.
- **Statistical Thresholds**: Adjust `--p_value_threshold` and `--mut_freq_threshold` to fine-tune the sensitivity of the background error model when using a control sample.

### Post-Analysis with CRISPRlungoAllele
To perform deep classification of specific allele groups or to filter out complex PCR artifacts after the main run:
```bash
CRISPRlungoAllele -i ./results/Allele_mutations.txt ./results/custom_category_file.txt
```
*Note: The custom category file is a tab-separated document defining specific mutation conditions (WT, Sub, Deletion) and their coordinate ranges.*

## Key Output Files
- `combined_graphs.html`: The primary visual report containing indel distributions and substitution patterns.
- `Allele_table.txt`: Detailed classification of every detected allele with counts and frequencies.
- `Read_classification.txt`: A per-read breakdown of mutation types, useful for troubleshooting specific sequencing artifacts.

## Reference documentation
- [CRISPRLungo Main Documentation](./references/github_com_pinellolab_CRISPRLungo.md)
- [CRISPRlungo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_crisprlungo_overview.md)