---
name: sentieon
description: Sentieon provides a suite of highly optimized bioinformatics tools for accelerated and accurate genomic data processing, including variant calling and sequence alignment. Use when user asks to estimate memory requirements, perform germline or somatic variant calling, process UMI-tagged reads, or analyze LongRead data.
homepage: https://github.com/Sentieon/sentieon-scripts
---


# sentieon

## Overview
Sentieon provides a suite of highly optimized bioinformatics tools designed for speed and accuracy, serving as a computationally efficient alternative to standard pipelines like BWA-MEM and GATK. This skill focuses on the practical application of Sentieon's toolset, including the use of DNAscope for germline analysis, TNscope for somatic calling, and specialized helper scripts for processing unique data types like ctDNA, UMI-tagged reads, and LongRead (HiFi) data.

## Core Workflows and CLI Patterns

### 1. Memory Management
Before running large-scale variant calling, use the `memest` utility to estimate memory requirements based on your BAM header and index. This prevents out-of-memory (OOM) errors in HPC environments.

```bash
python memest.py -b input.bam -i input.bam.bai
```

### 2. Germline Variant Calling (DNAscope)
DNAscope is the preferred tool for germline calling, offering improved accuracy over traditional HaplotypeCaller-based methods.

*   **WGS/WES Pipeline**: Utilize the scripts in `example_pipelines/` to structure your driver commands.
*   **LongRead (HiFi)**: For PacBio HiFi data, use the specialized DNAscope LongRead logic.
    ```bash
    # General pattern for DNAscope LongRead
    sentieon driver -r reference.fa -i input.bam --algo DNAscope --model <model_file> output.vcf.gz
    ```

### 3. Somatic Variant Calling (TNscope)
TNscope is used for tumor-normal or tumor-only somatic variant calling.

*   **Filtering**: Raw TNscope outputs often require filtering to remove artifacts.
    ```bash
    python tnscope_filter.py -v raw.vcf.gz --filter_type <type> filtered.vcf.gz
    ```
*   **MNP Merging**: For somatic calls, neighboring variants along the same haplotype should be merged into Multi-Nucleotide Polymorphisms (MNPs).
    ```bash
    python merge_mnp.py -v input.vcf.gz -r reference.fa > merged_mnps.vcf
    ```

### 4. Specialized Panels (ctDNA and UMI)
Sentieon provides specific logic for high-sensitivity applications like liquid biopsies.
*   **UMI Consensus**: Use the `Somatic_ctDNA_with_UMI.sh` pattern to process UMI-tagged data, which involves consensus read generation before variant calling.
*   **Panel Data**: For targeted sequencing, ensure the use of the `--interval` flag in the driver to restrict analysis to the capture regions (WES/Panel).

## Expert Tips
*   **Drop-in Compatibility**: Sentieon tools are designed to be command-line compatible with standard tools; however, always wrap commands in the `sentieon driver` to leverage multi-threading and pipe-free execution.
*   **Model Selection**: When using DNAscope, ensure the `--model` parameter matches your sequencing technology (e.g., Illumina vs. HiFi) for optimal machine learning-based genotyping.
*   **Performance**: Sentieon's performance scales linearly with core count. For maximum throughput, ensure your license server is reachable and your environment variables (like `SENTIEON_LICENSE`) are correctly exported.
*   **Avoid BQSR on TNscope**: Recent Sentieon somatic pipelines often omit Base Quality Score Recalibration (BQSR) as TNscope's internal models handle quality variations effectively, saving significant compute time.

## Reference documentation
- [Sentieon Scripts Overview](./references/github_com_Sentieon_sentieon-scripts.md)
- [DNAscope LongRead Documentation](./references/github_com_Sentieon_sentieon-scripts_tree_master_dnascope_LongRead.md)
- [Bioconda Sentieon Package](./references/anaconda_org_channels_bioconda_packages_sentieon_overview.md)