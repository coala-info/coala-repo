---
name: ngs-chew
description: ngs-chew performs quality control and sample integrity checks on sequencing data by generating and comparing compact variant fingerprints. Use when user asks to identify sample swaps, detect cryptic relationships, estimate contamination, or verify biological sex from BAM or VCF files.
homepage: https://github.com/bihealth/ngs-chew
metadata:
  docker_image: "quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0"
---

# ngs-chew

## Overview

ngs-chew is a specialized toolbox for performing quality control and sanity checks on Next-Generation Sequencing (NGS) data. It functions by generating compact variant "fingerprints" (stored as compressed numpy arrays) from BAM or VCF/BCF files. These fingerprints allow for efficient large-scale comparisons to identify sample swaps, cryptic relationships, and contamination. It is particularly useful in clinical or large-scale research pipelines where sample tracking and data integrity are paramount.

## Core Workflows and CLI Patterns

### 1. Generating Fingerprints
The primary entry point is creating a fingerprint from alignment data. This requires a reference FASTA and a genome release specification (e.g., GRCh37 or GRCh38).

```bash
ngs-chew fingerprint \
    --reference /path/to/ref.fasta \
    --genome-release GRCh37 \
    --input-bam input.bam \
    --output-fingerprint sample_id.npz
```

**Expert Tips:**
* **Allele Balance:** Use flags to store allele balance information if you plan to perform downstream contamination detection.
* **VCF Output:** You can optionally write out a VCF file during the fingerprinting process for manual inspection of the sites used.

### 2. Sample Comparison and Relationship Detection
Once fingerprints (.npz files) are generated, they can be compared to detect relatedness or swaps.

* **Relatedness:** Analyzes fingerprints to determine if samples are from the same individual, siblings, or unrelated.
* **IBS0 Checks:** Specifically looks for "Identity By State 0" (where two samples share no alleles at a site) to flag potential swaps.

### 3. Quality Control and Visualization
ngs-chew provides several plotting commands to visualize QC metrics:

* **B-Allele Frequency:** Use `plot_aab` to visualize allele fractions from VCF files, which is helpful for detecting aneuploidy or contamination.
* **Comparison Plots:** Use `plot_compare` to visualize the results of sample-to-sample comparisons.
* **Heterozygosity:** Use `plot_var_het` to analyze variant heterozygosity patterns.

### 4. Advanced Analysis
* **Sex Identification:** The tool collects chrX SNP information and interprets `samtools idxstats` to verify the biological sex of a sample against metadata.
* **ROH Calling:** Integrates with `bcftools roh` to call Runs of Homozygosity, useful for identifying consanguinity or uniparental disomy.
* **Contamination Detection:** Uses balance-enhanced fingerprints to detect if a sample is contaminated with DNA from another source.

## Best Practices
* **Dependencies:** Ensure `samtools` and `bcftools` are in your PATH, as ngs-chew relies on them for data processing.
* **Genome Release:** Always match the `--genome-release` to the reference used for alignment to ensure the correct SNP sites are queried.
* **Efficiency:** Fingerprint files are stored as compressed `numpy` arrays (`.npz`), making them much faster to share and compare than raw BAM or VCF files.



## Subcommands

| Command | Description |
|---------|-------------|
| ngs-chew compare | Perform fingeprint comparison. |
| ngs-chew fingerprint | Compute fingerprint to numpy .npz files. |
| ngs-chew plot-compare | Plot result of 'ngs-chew compare'. |
| ngs-chew plot-var-het | Plot var(het) metric from .npz files. |
| ngs-chew stats | Compute statistics from fingerprint .npz files. |

## Reference documentation
- [NGS Chew README](./references/github_com_bihealth_ngs-chew_blob_main_README.md)
- [Changelog and Feature History](./references/github_com_bihealth_ngs-chew_blob_main_CHANGELOG.md)