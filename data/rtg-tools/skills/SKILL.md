---
name: rtg-tools
description: RTG Tools is a high-performance suite for the accurate analysis, comparison, and benchmarking of genomic variants using haplotype-level matching. Use when user asks to format reference genomes into SDF, compare VCF files against truth sets, generate precision-recall metrics, or filter variants.
homepage: https://github.com/RealTimeGenomics/rtg-tools
---


# rtg-tools

## Overview
RTG Tools is a high-performance suite designed for the accurate analysis and comparison of genomic variants. Its core strength lies in the `vcfeval` engine, which performs haplotype-level comparisons to determine if different VCF representations describe the same underlying genomic sequence. This makes it the gold standard for benchmarking variant callers against truth sets, as it avoids the pitfalls of simple coordinate-based matching. Use this skill to manage reference formatting, execute benchmarking pipelines, and generate precision-recall metrics.

## Core Workflows

### 1. Reference Preparation (SDF Formatting)
RTG commands require the reference genome to be in a specialized Sequence Data File (SDF) format. This must be done once per reference.
```bash
rtg format -o reference.sdf reference.fasta
```

### 2. VCF Benchmarking (vcfeval)
To compare a "call" VCF against a "baseline" (truth) set, use the `vcfeval` command. This produces files for true positives (tp.vcf.gz), false positives (fp.vcf.gz), and false negatives (fn.vcf.gz).
```bash
rtg vcfeval -b baseline.vcf.gz -c calls.vcf.gz -t reference.sdf -o output_dir
```
*   **-b (Baseline):** The truth set VCF.
*   **-c (Calls):** The VCF being evaluated.
*   **-t (Template):** The path to the SDF formatted reference.
*   **-o (Output):** The directory for results.

### 3. Generating ROC Curves
To evaluate the trade-off between precision and recall based on a quality score (e.g., QUAL or GQ), specify the scoring field during evaluation.
```bash
rtg vcfeval -b truth.vcf.gz -c test.vcf.gz -t ref.sdf -o eval_out --vcf-score-field=GQ
```
After the run, you can use `rocplot` to visualize the results or inspect the `weighted_roc.tsv.gz` file in the output directory.

### 4. VCF Manipulation and Filtering
RTG includes utilities for pre-processing VCFs, such as filtering by quality or region.
```bash
rtg vcffilter -i input.vcf.gz -o filtered.vcf.gz --min-quality 30 --include-bed regions.bed
```

## Expert Tips & Best Practices

*   **Haplotype Awareness:** Unlike tools that rely on variant normalization (like `bcftools norm`), `vcfeval` understands that different combinations of alleles can result in the same haplotype. It is the preferred tool for complex regions or when comparing different variant calling technologies.
*   **Input Requirements:** All input VCF files must be block-compressed with `bgzip` and indexed with `tabix`.
*   **Memory Allocation:** For large genomes or high-density VCFs, increase the memory available to the Java runtime by setting the `RTG_MEM` environment variable (e.g., `export RTG_MEM=16G`).
*   **Evaluation Regions:** Use the `--bed-regions` flag to restrict benchmarking to specific areas, such as high-confidence regions provided by Genome in a Bottle (GIAB).
*   **Structural Variants:** For CNVs or large rearrangements, use `cnveval` or `bndeval` respectively. These tools apply similar sophisticated matching logic to structural variants.
*   **Sample Selection:** If a VCF contains multiple samples, use `--sample` to specify which one to evaluate (e.g., `--sample NA12878`).

## Reference documentation
- [GitHub Repository Overview](./references/github_com_RealTimeGenomics_rtg-tools.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_rtg-tools_overview.md)