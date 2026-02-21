---
name: svanalyzer
description: SVanalyzer is a specialized suite of tools designed for the high-resolution analysis of structural variants.
homepage: http://svanalyzer.readthedocs.io/
---

# svanalyzer

## Overview

SVanalyzer is a specialized suite of tools designed for the high-resolution analysis of structural variants. Unlike simple overlap-based tools, SVanalyzer utilizes repeat-aware methods and sequence-level comparisons to refine and validate SV calls. It is particularly effective when working with sequence-resolved variants (where the actual inserted or deleted sequence is known) and assembly-based variant calling workflows.

## Command Line Usage and Best Practices

The SVanalyzer suite consists of several sub-commands. Each is tailored to a specific stage of the SV analysis pipeline.

### Benchmarking and Comparison
*   **SVbenchmark**: Use this to calculate sensitivity and specificity by comparing a "test" VCF against a "truth" VCF. This is the standard tool for evaluating the performance of new SV callers.
*   **SVcomp**: Use this for a direct, sequence-aware comparison between two sets of sequence-resolved SVs to identify identical or overlapping variants.

### Variant Processing and Merging
*   **SVmerge**: When combining callsets from different callers or samples, use `SVmerge` to collapse similar sequence-resolved variants into a single representative call. This prevents overcounting in multi-caller pipelines.
*   **SVrefine**: Use this tool to call or refine structural variants specifically from assembly consensus sequences, ensuring the breakpoints and sequences are highly accurate.

### Contextual Annotation
*   **SVwiden**: Use this to add genomic context to a VCF. It identifies and tags repetitive sequences surrounding the SV breakpoints, which is critical for understanding why certain variants are difficult to call or why they may be prone to false positives.

### Expert Tips
*   **Dependency Check**: Ensure `samtools`, `mummer`, `edlib`, and `bedtools` are in your PATH, as SVanalyzer relies on these for alignment and coordinate processing.
*   **Sequence Resolution**: These tools provide the most value when VCF files include the `ALT` sequence or `SVINSSEQ` tags. If your VCF only contains symbolic alleles (e.g., `<DEL>`), the sequence-aware refinement features will be limited.
*   **Repeat Awareness**: When working in complex regions, always run `SVwiden` to annotate the repetitive landscape, as structural variations are frequently mediated by repetitive elements.

## Reference documentation
- [SVanalyzer Documentation](./references/svanalyzer_readthedocs_io_en_latest.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_svanalyzer_overview.md)