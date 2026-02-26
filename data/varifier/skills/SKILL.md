---
name: varifier
description: Varifier evaluates the accuracy of variant calls by comparing predicted variants against a truth genome. Use when user asks to evaluate variant call accuracy, compare variant calls to a truth assembly, or calculate variant call metrics.
homepage: https://github.com/iqbal-lab-org/varifier
---


# varifier

## Overview

`varifier` is a specialized bioinformatics tool used to evaluate the accuracy of variant calls. It works by taking a set of predicted variants (VCF), a reference genome, and a "truth" genome (a high-quality assembly of the same sample). Instead of simply comparing VCF coordinates, which can be ambiguous due to different representations of the same variant, `varifier` maps the variants to the truth genome to determine if the predicted sequence change actually exists in the truth.

## Core Workflow: VCF Evaluation

The primary command for assessing variant call quality is `vcf_eval`. This command compares a test VCF against a truth assembly.

### Basic Usage

```bash
varifier vcf_eval <truth.fasta> <ref.fasta> <test.vcf> <out_dir>
```

*   **truth.fasta**: The gold-standard assembly of the sample being tested.
*   **ref.fasta**: The reference genome used to generate the `test.vcf`.
*   **test.vcf**: The VCF file containing the variant calls you want to verify.
*   **out_dir**: The directory where results will be stored.

### Key Outputs

The most important file generated in the `out_dir` is `summary_stats.json`. This file contains metrics including:
*   **TP (True Positives)**: Variants in the VCF that are confirmed in the truth genome.
*   **FP (False Positives)**: Variants in the VCF that are not found in the truth genome.
*   **FN (False Negatives)**: Variants present in the truth genome that were missed by the VCF.
*   **Precision and Recall**: Calculated based on the above counts.

## Expert Tips and Best Practices

### Handling Complex Alignments
`varifier` relies on `mummer` and `minimap2` (via `paftools.js`) for alignments. For more accurate verification in complex regions or when dealing with larger indels, ensure `mafft` is installed and use the `--use_mafft` flag if available in your version (v0.4.0+).

### Filtering and Normalization
While `varifier` handles many representation issues, it is often good practice to normalize your VCF (e.g., using `bcftools norm -m -any`) before running evaluation to ensure multi-allelic sites are handled consistently.

### Resource Management
For large genomes or VCFs with a very high density of variants, `varifier` can be memory-intensive. Monitor RAM usage if the process fails without a clear error message.

### Troubleshooting Dependencies
`varifier` requires several external tools to be in your `$PATH`:
*   `mummer` (specifically `nucmer` and `show-coords`)
*   `k8` (Javascript runtime for `paftools.js`)
*   `minimap2` (specifically the `paftools.js` script)

If you encounter "command not found" errors, verify these are accessible in your environment.

## Reference documentation
- [varifier GitHub Repository](./references/github_com_iqbal-lab-org_varifier.md)
- [Bioconda varifier Package](./references/anaconda_org_channels_bioconda_packages_varifier_overview.md)