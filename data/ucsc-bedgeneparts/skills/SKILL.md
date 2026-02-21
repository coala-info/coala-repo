---
name: ucsc-bedgeneparts
description: The `bedGeneParts` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to decompose gene models stored in BED format into their constituent parts.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bedgeneparts

## Overview
The `bedGeneParts` utility is a specialized tool from the UCSC Genome Browser "kent" source suite designed to decompose gene models stored in BED format into their constituent parts. It is particularly useful for bioinformaticians who need to quickly generate coordinate files for specific genomic features without writing custom parsing scripts. By providing a standard BED file (typically BED12 format containing block information), you can "spit out" specific regions relative to the gene structure.

## Usage Patterns

### Basic Command Structure
The tool follows a standard UCSC utility pattern where the first argument is the input and the second is the output feature type.

```bash
bedGeneParts <input.bed> <feature-type> <output.bed>
```

### Supported Feature Types
When running the tool, you must specify one of the following keywords as the second argument:

*   **promoter**: Extracts the region upstream of the transcription start site (TSS).
*   **firstExon**: Extracts only the first exon of each record.
*   **introns**: Extracts all intronic regions (the gaps between exons).

### Common Workflows

**1. Extracting Promoters for Motif Analysis**
To get promoter regions for all genes in a BED file:
```bash
bedGeneParts genes.bed promoter promoters.bed
```
*Note: The default promoter size is often hardcoded or requires specific flags depending on the version; always verify the output coordinates.*

**2. Isolating Introns for Splicing Studies**
To generate a BED file containing only the coordinates of introns:
```bash
bedGeneParts genes.bed introns introns.bed
```

**3. Focusing on the First Exon**
Useful for studying 5' UTRs or translation initiation sites:
```bash
bedGeneParts genes.bed firstExon first_exons.bed
```

## Expert Tips
*   **Input Format**: This tool is most effective with BED12 files (also known as "blocked BED"). If your input BED file only has 3 or 6 columns, it lacks the exon/block information required to calculate introns or first exons.
*   **Strand Awareness**: The tool is strand-aware. For genes on the negative strand, the "first exon" will be the one with the highest genomic coordinates, and the "promoter" will be downstream of the genomic start.
*   **Permission Issues**: If running the binary directly from a download, ensure it is executable: `chmod +x bedGeneParts`.
*   **MySQL Integration**: Some UCSC tools can pull data directly from the UCSC public MySQL server. If you need to generate the input BED file first, consider using `mysql` with the `hg19` or `hg38` databases.

## Reference documentation
- [UCSC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bedgeneparts_overview.md)
- [UCSC Executable Directory Guide](./references/hgdownload_cse_ucsc_edu_admin_exe.md)