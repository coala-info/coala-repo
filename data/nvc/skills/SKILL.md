---
name: nvc
description: The Naive Variant Caller identifies genomic variants by processing aligned sequencing reads using simple nucleotide ratios and per-position counts. Use when user asks to call variants from BAM files, generate VCFs with granular nucleotide counts, or analyze strand-specific coverage.
homepage: https://github.com/blankenberg/nvc
---


# nvc

## Overview
The Naive Variant Caller (nvc) is a specialized tool for identifying genomic variants by processing aligned sequencing reads in BAM format. Unlike complex probabilistic callers, nvc uses simple nucleotide ratios and per-position counts to generate variant calls. It is highly effective for multi-sample analysis via read group information and provides granular per-base evidence through a custom VCF tag. Use this skill to determine optimal filtering thresholds and to understand the tool's unique strandedness and coverage reporting features.

## Usage Guidance

### Core Workflow
1.  **Input Requirements**: Provide one or more BAM files containing aligned reads. You must also provide a reference genome, either as a FASTA file or by selecting a built-in reference.
2.  **Sample Handling**: The tool automatically utilizes Read Group (RG) information within the BAM files to make individual calls for different samples.
3.  **Output**: The primary output is a VCF file. A key feature of nvc is the `NC` (Nucleotide Count) tag in the Genotype (GT) field, which lists counts in the format `<nucleotide>=<count>`.

### Parameter Optimization
*   **Quality Filtering**: 
    *   Set a **Minimum base quality** to exclude low-confidence sequencing calls from the counts.
    *   Set a **Minimum mapping quality** to ensure only uniquely or reliably mapped reads contribute to variant calling.
*   **Allele Discovery**: Use the **Minimum number of reads needed to consider a REF/ALT** to filter out background noise or sequencing errors. The default is 0, but increasing this is recommended for high-depth data.
*   **Ploidy**: Explicitly define the number of genotype calls to be made at each position based on the organism's biology (e.g., 2 for diploid humans).
*   **Region Restriction**: To save time and compute, restrict analysis to specific chromosomes or coordinates (e.g., `chr1` or `chr1:1000-2000`).

### Advanced Features
*   **Strand-Specific Reporting**: When "Report counts by strand" is enabled, the `NC` field prepends a `+` or `-` to the nucleotide (e.g., `+T=3972,-T=5657`). This is critical for identifying strand bias or analyzing stranded library preparations.
*   **Memory and Depth Management**: The tool allows you to choose the `dtype` for coverage information. 
    *   Use `uint8` (max 255) or `uint16` (max 65,535) for low-to-medium depth to save memory.
    *   Use `uint32` or `uint64` for extremely high-depth data (e.g., targeted amplicon sequencing) to prevent counter overflow.
*   **Sparse Output**: Enable "Only write out positions with possible alternate alleles" to significantly reduce VCF file size by skipping invariant (homozygous reference) positions.

## Expert Tips
*   **VCF Interpretation**: When reviewing the VCF, look for the `AC` (Allele Count) and `AF` (Allele Frequency) info fields. nvc reports these for every allele passing the filters, which may include multiple alternate alleles at a single site.
*   **Dependency Note**: Ensure `pyBamParser` is correctly installed in the environment, as it is a core dependency for BAM processing.
*   **Sorting**: Ensure BAM files are coordinate-sorted and indexed before processing to avoid "Reader Object" or indexing errors.

## Reference documentation
- [GitHub README](./references/github_com_blankenberg_nvc.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nvc_overview.md)