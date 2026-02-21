---
name: ucsc-maffrags
description: The `mafFrags` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed for high-performance extraction of alignment data.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-maffrags

## Overview
The `mafFrags` utility is a specialized tool from the UCSC Genome Browser "Kent" suite designed for high-performance extraction of alignment data. It processes a 6-column BED file to identify specific genomic intervals and retrieves the corresponding alignment blocks from a MAF file. This is particularly useful for comparative genomics workflows where you need to analyze conservation or sequence variation across multiple species for a discrete set of genomic features without loading entire chromosome-scale alignment files.

## Usage Instructions

### Basic Command Pattern
The tool typically requires the target MAF file and the BED file containing the regions of interest.
```bash
mafFrags [options] database bedFile out.maf
```

### Input Requirements
- **BED File**: Must be a 6-column BED format (`chrom`, `chromStart`, `chromEnd`, `name`, `score`, `strand`). The strand information is often critical for correctly orienting the extracted MAF blocks.
- **MAF File**: The source alignment file. For large-scale extractions, ensure the MAF is indexed if the specific version of the tool supports it, though `mafFrags` is often used in pipelines where the MAF is streamed or read sequentially.

### Common Workflow Patterns
1. **Extracting Exonic Alignments**:
   First, generate a BED file of exons (e.g., using `genePredToBed`), then use `mafFrags` to pull the alignments for just those regions.
   
2. **Filtering by Species**:
   `mafFrags` extracts the blocks as they exist in the source. If you need to restrict the output to specific species, you may need to pipe the output to `mafSpeciesSubset`.

### Best Practices
- **Memory Management**: When working with whole-genome alignments, ensure your BED regions are sorted by chromosome and position to optimize file pointer movement.
- **Permissions**: If you have downloaded the binary directly from the UCSC servers, remember to set execution permissions:
  ```bash
  chmod +x mafFrags
  ```
- **Database Parameter**: In the UCSC context, the `database` argument often refers to the assembly name (e.g., `hg38` or `mm39`) that matches the coordinates in your BED file.

## Reference documentation
- [ucsc-maffrags overview](./references/anaconda_org_channels_bioconda_packages_ucsc-maffrags_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)