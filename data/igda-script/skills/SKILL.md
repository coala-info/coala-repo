---
name: igda-script
description: The `igda-script` package is a collection of shell wrappers for the iGDA (integrated Genetic Data Analysis) toolkit.
homepage: https://github.com/zhixingfeng/shell
---

# igda-script

## Overview
The `igda-script` package is a collection of shell wrappers for the iGDA (integrated Genetic Data Analysis) toolkit. It is specifically designed for high-sensitivity detection and phasing of minor variants—those occurring at low frequencies—within long-read sequencing datasets. It streamlines complex bioinformatics workflows, including genome alignment, variant calling, and haplotype phasing for both haploid and diploid samples.

## Core Workflows

### Variant Detection
Use the detection pipelines to identify minor SNVs. The tool supports platform-specific error models for PacBio and Oxford Nanopore Technology (ONT).

*   **General Detection**: `igda_pipe_detect`
*   **PacBio Specific**: `igda_pipe_detect_pb`
*   **ONT Specific**: `igda_pipe_detect_ont`

**Key Parameters:**
*   `--outdir`: Specify the output directory. The script checks for the existence of this directory before execution.
*   `--isfast`: Use this flag in platform-specific scripts to prioritize speed during the detection process.
*   `dforest_r`: This parameter is often auto-selected by the script (calculated as `0.00125 * median_coverage`). You can manually override this if you have specific sensitivity requirements.

### Variant Phasing
Once variants are detected, use the phasing pipelines to determine the chromosomal context (haplotypes) of the SNVs.

*   **Standard Phasing**: `igda_pipe_phase`
*   **PacBio Specific**: `igda_pipe_phase_pb`
*   **ONT Specific**: `igda_pipe_phase_ont`
*   **Diploid Samples**: Use `igda_pipe_phase_diploid` or `igda_pipe_phase_pb_diploid` for samples with two sets of chromosomes.

**Best Practices for Phasing:**
*   **Parameter Selection**: For PacBio data, the `bf` (Bayes Factor) parameter defaults to optimized values for minor variant resolution.
*   **Contig Organization**: The pipeline automatically reorganizes contigs during the phasing process to ensure consistency in the output.

## Utility and Post-Processing

### VCF Refinement
After generating a VCF file, you may need to add Genotype Quality (GQ) scores for downstream filtering.
*   **Command**: `add_gq_to_vcf <input.vcf> > <output.vcf>`

### Data Preparation
*   **Splitting Ranges**: Use `split_range` to divide genomic regions for parallel processing.
*   **BAM Manipulation**: Use `getbambyregion` or `getbambyregion_dir` to extract specific genomic coordinates from alignment files for localized analysis.
*   **Format Conversion**: 
    *   `fa2table`: Convert FASTA files to tabular format.
    *   `fastq2fasta`: Convert FASTQ sequences to FASTA.

## Expert Tips
*   **Auto-Parameter Selection**: By default, `igda_pipe_detect` attempts to select optimal parameters based on data depth. If you need full manual control, look for the option to turn off auto-selection in the script help menu.
*   **Memory Management**: If running on a system with limited resources, note that recent updates to the `igda polish` step (invoked within the pipes) have been optimized to reduce RAM consumption.
*   **Coverage Estimation**: Use `est_depth` or `est_depth_dir` before running the main pipelines to understand your data's median coverage, which informs the `dforest_r` parameter.

## Reference documentation
- [igda-script Overview](./references/anaconda_org_channels_bioconda_packages_igda-script_overview.md)
- [Shell Script Repository](./references/github_com_zhixingfeng_shell.md)
- [Commit History and Updates](./references/github_com_zhixingfeng_shell_commits_master.md)