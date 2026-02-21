---
name: simple_sv_annotation
description: The `simple_sv_annotation` tool is a Python-based utility designed to streamline the interpretation of structural variants.
homepage: https://github.com/AstraZeneca-NGS/simple_sv_annotation
---

# simple_sv_annotation

## Overview

The `simple_sv_annotation` tool is a Python-based utility designed to streamline the interpretation of structural variants. Standard snpEff output for SVs can be difficult to parse due to its verbosity and complexity. This tool post-processes snpEff-annotated VCFs to extract "interesting" cases—such as fusions and exon deletions—and adds a simplified `SIMPLE_ANN` tag. This tag provides a concise, pipe-separated summary of the event type, affected genes, and priority levels, making it significantly easier to filter and prioritize variants in large datasets.

## Usage and Best Practices

### Core Command Line Usage
The tool requires a VCF file previously annotated with snpEff (v4.3 or higher) using the `ANN` field.

```bash
# Basic usage with output to file
python simple_sv_annotation.py input_annotated.vcf -o simplified_output.vcf

# Stream output to stdout
python simple_sv_annotation.py input_annotated.vcf -o -
```

### Prioritizing Variants
To focus on specific genomic regions or known pathogenic events, use the prioritization flags:

*   **Gene List**: Provide a text file of gene symbols (one per line) to mark variants in these genes as high priority.
    `--gene_list genes_of_interest.txt`
*   **Known Fusions**: Provide a comma-delimited file of gene pairs to specifically flag known fusion events.
    `--known_fusion_pairs fusions.csv`

### Handling Non-Standard Exon Numbering
snpEff sometimes defaults to sequential exon numbering that may not match clinical standards (e.g., BRCA1 missing exon 4). You can override this using a BED file:

```bash
# Use custom exon numbering
python simple_sv_annotation.py input.vcf --exonNums custom_exons.bed
```
**BED Format Requirement**: The 4th column must contain the transcript name and exon number separated by a pipe (e.g., `NM_007294|24`).

### Interpreting the SIMPLE_ANN Field
The tool adds a `SIMPLE_ANN` tag to the INFO column with the following structure:
`SV_Type | Annotation_Type | Gene_Name | Transcript_ID | Exon_Details_or_Fusion_Status | Priority`

*   **Annotation Types**: FUSION, EXON_DEL, INTERGENIC, INTRONIC.
*   **Priority Levels**: 1 (Highest) to 3 (Lowest).
*   **Fusion Status**: KNOWN_FUSION, ON_PRIORITY_LIST, or NOT_PRIORITISED.

### Supported SV Callers
While the tool is caller-agnostic if VCF standards are followed, it is explicitly tested and optimized for:
*   Lumpy-SV
*   Manta
*   Delly

## Expert Tips
*   **Input Versioning**: Ensure snpEff v4.3+ is used. Older versions using the `EFF` field instead of `ANN` are not supported.
*   **Memory Management**: Custom exon numbering lists are stored in memory. While standard gene panels are fine, extremely large custom annotation files may impact performance.
*   **Standard SV Fields**: For custom callers, ensure the VCF includes standard `SVTYPE`, `MATEID` (for breakends), and `END` (for deletions) INFO tags for the tool to correctly identify the variant geometry.

## Reference documentation
- [Main Repository and Usage Guide](./references/github_com_AstraZeneca-NGS_simple_sv_annotation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_simple_sv_annotation_overview.md)