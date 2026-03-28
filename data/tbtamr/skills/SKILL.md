---
name: tbtamr
description: tbtamr infers drug susceptibility testing results for Mycobacterium tuberculosis by identifying antimicrobial resistance mutations from VCF files or raw sequencing reads. Use when user asks to predict drug resistance, analyze tuberculosis mutations, or process sequencing data using custom mutational catalogues and interpretative criteria.
homepage: https://github.com/MDU-PHL/tbtamr
---


# tbtamr

## Overview

tbtamr is a specialized bioinformatics tool designed for clinical and public health laboratories to infer drug susceptibility testing (DST) results for *M. tuberculosis*. It identifies mutations linked to AMR mechanisms by processing VCF files (annotated with snpEff) or raw paired-end reads. The tool is built for flexibility, allowing users to supply their own mutational catalogues and interpretative criteria via CSV files, which facilitates rapid updates and re-verification in accredited laboratory settings without requiring code changes.

## Installation

The recommended method for installation is via Conda:

```bash
conda create -n tbtamr tbtamr
conda activate tbtamr
```

## Core Usage Patterns

### Basic Execution
tbtamr can process either pre-called variants or raw sequencing data.

**From VCF (Recommended):**
The VCF must be annotated with snpEff to be compatible with standard catalogues (like WHO version 2).
```bash
tbtamr run --vcf sample.vcf --output_dir results/
```

**From Paired-End Reads:**
```bash
tbtamr run --forward R1.fastq.gz --reverse R2.fastq.gz --output_dir results/
```

### Customizing Inputs
To use specific versions of the WHO catalogue or laboratory-specific criteria, provide the following CSV files:

*   **Catalogue (--catalogue):** Defines the mutations of interest (Drug, Gene, Variant, Confidence).
*   **Interpretation (--criteria):** Defines the logic for translating variants into results (e.g., "Resistant", "Not Resistant").
*   **Classification (--classification):** Defines the logic for overall sequence classification (e.g., MDR, XDR).

```bash
tbtamr run --vcf sample.vcf \
    --catalogue my_catalogue.csv \
    --criteria my_interpretative_criteria.csv \
    --classification my_classification.csv \
    --output_dir results/
```

## Expert Tips and Best Practices

### VCF Annotation Requirements
*   **snpEff Compatibility:** By default, tbtamr expects VCFs annotated by snpEff. If using a different annotator, ensure your custom catalogue matches that specific annotation format.
*   **Reference Genome:** Ensure the VCF was generated using a reference genome that matches the positions defined in your mutational catalogue. Using mismatched references will lead to silent errors or incorrect resistance calls.

### Rule Hierarchy in Interpretation
When designing custom `criteria.csv` files, remember that tbtamr evaluates rules hierarchically:
1.  **Default:** Categorical rules applied first (e.g., applying a result to all "High Confidence" variants).
2.  **Override Simple:** Modifies the default result based on a single specific condition.
3.  **Override Complex:** Modifies results based on multiple conditions (using `&` or `|` logic).

### Cascade Reporting
Use the "cascade report" feature in the configuration to control which drug results are visible to clients. This is useful for jurisdictions where certain drugs should only be reported if resistance to primary drugs is detected.

### Output Interpretation
tbtamr assumes **Susceptible** for all drugs by default. It will only report a different status if a specific mutation matches a provided criteria rule.



## Subcommands

| Command | Description |
|---------|-------------|
| tbtamr predict | Predict resistance profiles and lineages from VCF files. |
| tbtamr_annotate | Annotate a BAM file with sequence ID and VCF information. |
| tbtamr_fq2vcf | Generates a VCF file from FASTQ reads using mutAMR. |
| tbtamr_full | Runs the full tbtamr pipeline, including mutAMR for VCF generation and BWA MEM for alignment. |
| tbtamr_search | Search for variants in a catalog. |

## Reference documentation
- [Customising your inputs](./references/github_com_MDU-PHL_tbtamr_wiki_Customising-your-inputs.md)
- [How to run](./references/github_com_MDU-PHL_tbtamr_wiki_How-to-run.md)
- [Installation](./references/github_com_MDU-PHL_tbtamr_wiki_Installation.md)
- [Cascade reporting](./references/github_com_MDU-PHL_tbtamr_wiki_Cascade-reporting.md)