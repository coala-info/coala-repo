---
name: bctools
description: bctools is a specialized suite of Python and Perl scripts designed to handle the complexities of barcode-aware NGS workflows.
homepage: https://github.com/dmaticzka/bctools
---

# bctools

## Overview

bctools is a specialized suite of Python and Perl scripts designed to handle the complexities of barcode-aware NGS workflows. It is particularly useful for researchers working with protocols like iCLIP, uvCLAP, or FLASH, where precise barcode extraction and UMI-based deduplication are critical for downstream analysis. The toolkit focuses on transforming raw or aligned data into high-quality, deduplicated sets by accounting for PCR bias and sequencing errors within the barcodes themselves.

## Core Toolset and CLI Usage

### Barcode Extraction
Use `extract_bcs.py` to pull barcodes from arbitrary positions relative to the start of the read. This is typically the first step after receiving raw FASTQ data.

*   **Key Feature**: Supports flexible positioning, allowing for barcodes that are not strictly at the beginning of the read.
*   **Expert Tip**: Use the `--extract-crosslinked-nt` option if your protocol (like iCLIP) requires identifying the nucleotide directly adjacent to the barcode as the crosslink site.

### PCR Duplicate Merging
Use `merge_pcr_duplicates.py` to collapse reads that share the same mapping coordinates and UMI.

*   **Input Requirement**: This tool typically operates on BAM files. Ensure your reads are aligned and the barcode/UMI information is present in the read header or a specific tag.
*   **Workflow**: Run this after alignment to ensure that quantitative measurements (like transcript counts) are not inflated by PCR amplification.

### Filtering Erroneous UMIs
Use `rm_spurious_events.py` to remove reads associated with barcodes that likely arose from sequencing errors or PCR artifacts.

*   **Mechanism**: It identifies low-frequency UMIs that are highly similar (e.g., Hamming distance of 1) to high-frequency UMIs at the same position and filters them out.
*   **Implementation**: Note that this functionality may be implemented via `rm_spurious_events.pl`.

### Paired-End Cleanup
Use `remove_tail.py` when working with paired-end sequencing where the second read might "read through" the insert into the UMI or adapter sequence of the first read.

*   **Use Case**: Essential for maintaining high mapping rates and preventing false mismatches at the 3' ends of reads.

### RY-Space Conversion
For specific protocols like uvCLAP or FLASH that use binary RY-space barcodes (Purine/Pyrimidine), use `convert_bc_to_binary_RY.py`.

## Installation and Environment

The most reliable way to deploy bctools is via Bioconda:

```bash
conda install -c bioconda -c conda-forge bctools
```

## Best Practices

1.  **Header Formatting**: Many bctools scripts expect the barcode to be appended to the read name in the FASTQ/BAM file. Ensure your extraction step formats the headers correctly (e.g., `ReadName#BARCODE`).
2.  **Memory Management**: When merging duplicates in large BAM files, ensure you have sufficient temporary disk space, as the tool may create intermediate files during the sorting and merging process.
3.  **Python Compatibility**: While the tool has been updated for Python 3 compatibility, ensure your environment uses the version specified in your specific bctools installation (v0.2.2+ supports Python 3).

## Reference documentation
- [github_com_dmaticzka_bctools.md](./references/github_com_dmaticzka_bctools.md)
- [anaconda_org_channels_bioconda_packages_bctools_overview.md](./references/anaconda_org_channels_bioconda_packages_bctools_overview.md)