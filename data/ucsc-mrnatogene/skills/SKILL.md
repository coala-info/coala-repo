---
name: ucsc-mrnatogene
description: The `mrnaToGene` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to bridge the gap between raw sequence alignments and gene structure definitions.
homepage: http://hgdownload.cse.ucsc.edu/admin/exe/
---

# ucsc-mrnatogene

## Overview
The `mrnaToGene` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed to bridge the gap between raw sequence alignments and gene structure definitions. It processes mRNA-to-genome alignments stored in PSL format and outputs them in GenePred format, which defines the exon/intron boundaries, coding regions, and transcript metadata. This tool is essential for researchers building custom gene sets or validating transcript models against a reference genome.

## Command Line Usage

The basic syntax for the tool is:
`mrnaToGene [options] input.psl output.gp`

### Common CLI Patterns

1. **Basic Conversion**
   Convert a standard PSL alignment file to a GenePred file:
   `mrnaToGene alignments.psl annotations.gp`

2. **Handling CDS Information**
   If you have specific Coding Sequence (CDS) information (often in a tab-separated file), use the `-cds` flag to ensure the output GenePred correctly identifies the start and stop codons:
   `mrnaToGene -cds=cdsInfo.tab alignments.psl annotations.gp`

3. **Processing Headerless PSL Files**
   If your input PSL file does not contain the standard header lines (common in piped outputs), use the `-noHead` flag:
   `mrnaToGene -noHead alignments.psl annotations.gp`

4. **Filtering by Alignment Quality**
   To ensure only high-quality alignments are converted into gene models, you can specify requirements (though specific thresholds are often handled by `pslCDnaFilter` prior to this step, `mrnaToGene` maintains the integrity of the input provided).

### Expert Tips and Best Practices

*   **Pre-filtering is Key**: `mrnaToGene` performs a direct conversion. For the best results, pre-filter your PSL files using `pslCDnaFilter` to remove noise, low-identity alignments, or non-syntenic hits before generating gene annotations.
*   **GenePred Compatibility**: The output `.gp` (GenePred) format is the native format for UCSC Genome Browser gene tracks. You can easily convert this to other formats like BED using `genePredToBed` or to GTF using `genePredToGtf`.
*   **Binary Permissions**: If running the binary directly from a download, ensure it has execution permissions: `chmod +x mrnaToGene`.
*   **Architecture Matching**: Ensure you are using the binary that matches your system architecture (e.g., `linux.x86_64` or `macOSX.arm64`).

## Reference documentation
- [UCSC mrnaToGene Overview](./references/anaconda_org_channels_bioconda_packages_ucsc-mrnatogene_overview.md)
- [UCSC Binaries Index (Linux x86_64)](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)
- [UCSC Binaries Index (macOS ARM64)](./references/hgdownload_cse_ucsc_edu_admin_exe_macOSX.arm64.md)