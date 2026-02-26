---
name: motifraptor
description: MotifRaptor is a computational tool used to identify how genetic variants disrupt transcription factor binding and gene regulation across different cell types. Use when user asks to identify affected transcription factors, prioritize cell types for specific variants, index SNPs for motif scanning, or generate radar plots of SNP-motif interactions.
homepage: https://github.com/pinellolab/MotifRaptor
---


# motifraptor

## Overview

MotifRaptor is a transcription factor (TF)-centric computational tool used to investigate how genetic variants contribute to phenotypes by altering gene regulation. It bridges the gap between non-coding SNPs and functional mechanisms by identifying which TFs are affected by specific variants and in which cell types these effects are most prominent. Use this tool to move from GWAS associations to mechanistic hypotheses regarding regulatory disruption.

## Configuration and Setup

Before running analyses, you must configure the paths to the essential databases (DHS tracks, TF RNA-seq, motifs, and pre-calculated scores).

*   **Set database directory**: `MotifRaptor set -pn databasedir -pv /path/to/Database/hg19/`
*   **Set motif database directory**: `MotifRaptor set -pn motifdatabasedir -pv /path/to/Database/hg19/motifdatabase/`
*   **Verify configuration**: `MotifRaptor info`

Note: MotifRaptor currently supports the human genome **hg19**. Ensure your input coordinates and VCF files are consistent with this assembly.

## Common CLI Workflows

### 1. Data Preprocessing
Prepare GWAS summary statistics for analysis.
*   **Standard TSV**: `MotifRaptor preprocess --input <file> --output <dir>`
*   **UK Biobank v3**: `MotifRaptor preprocess_ukbb_v3 --input <file> --output <dir>`

### 2. Cell Type and TF Prioritization
Identify relevant tissues or cell types where the variants are likely active.
*   **Cell type analysis**: `MotifRaptor celltype --input <preprocessed_dir> --output <results_dir>`
*   **SNP-Motif testing**: `MotifRaptor snpmotif --input <preprocessed_dir> --output <results_dir>`

### 3. SNP Indexing and Scanning
To use custom SNP lists or build a complete motif database, you must index the SNPs with their flanking sequences.
*   **Index SNPs**: `MotifRaptor snpindex --vcf <input.vcf> --output <index_dir>`
    *   *VCF Requirement*: Must contain the first five columns: `CHR`, `POS`, `ID`, `REF`, `ALT`.
*   **Scan SNP database**: `MotifRaptor snpscan --index <index_dir> --motif <motif_file>`

### 4. Specific Analysis and Visualization
*   **TF-specific analysis**: `MotifRaptor motifspecific --motif <TF_name> --input <dir>`
*   **SNP-specific analysis**: `MotifRaptor snpspecific --rsid <rsID> --input <dir>`
*   **Radar plots**: Generate a visual representation of SNP-motif interactions using `MotifRaptor snpmotifradar`.

## Expert Tips and Best Practices

*   **Database Selection**: Start with the **Testing Database** to validate your pipeline. The **Complete Database** requires ~220GB of disk space and is recommended for execution on high-performance computing clusters.
*   **Motif Formats**: MotifRaptor expects TF motif matrices in **JASPAR PFM** format. If you have MEME or TRANSFAC files, convert them using Biopython's `Bio.motifs` parser before importing.
*   **Memory Management**: For large-scale GWAS datasets, use the `motiffilter` subcommand to narrow down the list of TFs to those expressed in your target tissues, significantly reducing computational overhead.
*   **Environment**: Always run within a dedicated Conda environment (`python=3.6`) to avoid dependency conflicts with `pyBigWig` or other genomic libraries.

## Reference documentation
- [MotifRaptor GitHub Repository](./references/github_com_pinellolab_MotifRaptor.md)
- [Bioconda MotifRaptor Overview](./references/anaconda_org_channels_bioconda_packages_motifraptor_overview.md)