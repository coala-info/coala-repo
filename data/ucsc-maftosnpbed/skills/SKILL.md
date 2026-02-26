---
name: ucsc-maftosnpbed
description: This tool extracts single nucleotide polymorphisms (SNPs) and their functional context from MAF files, outputting them in BED format. Use when user asks to extract SNPs from MAF files, identify variants from multiple sequence alignments, or convert MAF alignment data into a BED file with functional context.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-maftosnpbed

## Overview
The `mafToSnpBed` utility is a specialized tool from the UCSC Genome Browser "kent" source tree. It is designed for comparative genomics workflows where you need to extract variation data from large-scale multiple sequence alignments. By processing MAF files, the tool identifies positions where sequences differ (SNPs) and outputs a BED file that not only marks the genomic coordinates but also provides context regarding the functional impact of those variants.

## Usage Instructions

### Basic Command Pattern
The tool follows the standard UCSC command-line convention where running the binary without arguments displays the usage statement.

```bash
mafToSnpBed input.maf output.bed
```

### Common Workflow Patterns
1.  **Preparation**: Ensure the binary is executable after download.
    ```bash
    chmod +x mafToSnpBed
    ```
2.  **Database Connection**: Some UCSC utilities require a connection to the UCSC public MySQL server to fetch functional annotations. If the tool fails with a connection error, ensure you have an `.hg.conf` file in your home directory with the following minimal configuration:
    ```text
    db.host=genome-mysql.soe.ucsc.edu
    db.user=genomep
    db.password=password
    central.db=hgcentral
    ```
3.  **Filtering Input**: Since MAF files can be extremely large, it is often more efficient to use `mafSpeciesSubset` or `mafFilter` before running `mafToSnpBed` if you are only interested in specific organisms or high-quality alignment blocks.

### Expert Tips
*   **Functional Consequences**: The "functional consequence" column in the resulting BED file typically refers to whether the SNP is synonymous, non-synonymous, or located in non-coding regions, depending on the reference gene tracks available.
*   **Coordinate Systems**: Always verify if your MAF file uses 0-based or 1-based coordinates. UCSC BED files are strictly 0-based, half-open.
*   **Large Scale Processing**: For whole-genome alignments, consider splitting the MAF file by chromosome using `mafSplit` to parallelize the SNP extraction process.

## Reference documentation
- [ucsc-maftosnpbed - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_ucsc-maftosnpbed_overview.md)
- [Index of /admin/exe](./references/hgdownload_cse_ucsc_edu_admin_exe.md)