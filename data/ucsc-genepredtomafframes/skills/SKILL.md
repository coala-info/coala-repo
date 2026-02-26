---
name: ucsc-genepredtomafframes
description: This tool calculates the reading frame for each exon in a gene prediction relative to a MAF alignment. Use when user asks to calculate reading frames for gene exons, verify if alignments preserve open reading frames, or generate mafFrames tables.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---


# ucsc-genepredtomafframes

## Overview
The `genePredToMafFrames` utility is a specialized tool within the UCSC Kent toolkit designed to bridge gene models and multiple sequence alignments. It calculates the reading frame for each exon in a gene prediction relative to a MAF alignment. This is essential for comparative genomics workflows where you need to verify if alignments preserve the open reading frame (ORF) across different species or to generate the `mafFrames` table required for certain UCSC Genome Browser track types.

## Usage Patterns

### Basic Command Structure
The tool follows the standard UCSC binary convention. If no arguments are provided, it will display its help text.

```bash
genePredToMafFrames [database] [genePredFile] [mafFramesOutput]
```

### Common Workflow
1.  **Prepare Input**: Ensure your gene predictions are in `genePred` format (not GTF/GFF3, though you can use `gtfToGenePred` to convert them first).
2.  **Identify Database**: The `database` argument usually refers to the UCSC assembly ID (e.g., hg38, mm10) associated with the gene predictions.
3.  **Execution**:
    ```bash
    genePredToMafFrames hg38 myGenes.gp myGenes.mafFrames
    ```

## Expert Tips and Best Practices
*   **Format Conversion**: If your data is in BED format, use `bedToGenePred` before running this tool. If it is in GTF format, use `gtfToGenePred`.
*   **Database Context**: While the `database` parameter is often required by the tool's internal logic to resolve coordinate systems, if you are working with custom alignments outside of the UCSC ecosystem, ensure your `genePred` coordinates strictly match the reference sequence used in your MAF file.
*   **MAF Alignment Compatibility**: This tool is specifically designed to work in conjunction with MAF files. The resulting `mafFrames` table is typically loaded into a database to support the "Frames" display in the Genome Browser, allowing users to see where codons are interrupted by gaps or shifted in different species.
*   **Permissions**: If you have just downloaded the binary from the UCSC servers, remember to set execution permissions:
    ```bash
    chmod +x genePredToMafFrames
    ```

## Reference documentation
- [UCSC Genome Browser Admin Binaries](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-genepredtomafframes_overview.md)
- [Linux x86_64 Binary Index](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)