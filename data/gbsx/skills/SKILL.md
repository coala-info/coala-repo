---
name: gbsx
description: GBSX (Genotyping By Sequencing demultipleXing toolkit) is a suite of tools designed to bridge the gap between experimental design and initial data processing in GBS workflows.
homepage: https://github.com/GenomicsCoreLeuven/GBSX
---

# gbsx

## Overview
GBSX (Genotyping By Sequencing demultipleXing toolkit) is a suite of tools designed to bridge the gap between experimental design and initial data processing in GBS workflows. Unlike standard demultiplexers that expect separate index reads, GBSX is specifically built to handle "inline" barcodes—sequences located at the start of the genomic read. It supports single-end and paired-end data, handles various restriction enzyme cut sites, and assists in selecting the best enzyme combinations for a specific genome.

## Installation
The most reliable way to install GBSX is via Bioconda:
```bash
conda install bioconda::gbsx
```

## Demultiplexing Workflow
The demultiplexer is the core tool for splitting raw sequencing data into sample-specific fastq files.

### 1. Prepare the Info File
GBSX requires a tab-delimited "info file" (no header) to map barcodes to samples.
**Format:** `SampleName` [tab] `Barcode` [tab] `Enzyme1` [tab] `Enzyme2` [tab] `Barcode2` [tab] `Mismatches`

*   **Enzyme2/Barcode2:** Leave as empty strings if not using dual barcodes or double digestion.
*   **Mismatches:** Optional; specifies allowed errors for that specific barcode.

### 2. Run the Demultiplexer
**Basic Command (Single-end):**
```bash
gbsx --tool Demultiplexer -f1 input.fastq -i info.txt -o output_dir/
```

**Paired-end with Gzip output:**
```bash
gbsx --tool Demultiplexer -f1 R1.fastq.gz -f2 R2.fastq.gz -i info.txt -gzip true -t 8 -o output_dir/
```

### Key Parameters
- `-rad`: Set to `true` for RAD-seq data (standard is `false` for GBS).
- `-s`: Start distance. Use if the barcode does not start at the very first base (default `0`).
- `-mb` / `-me`: Global mismatch allowance for barcodes and enzymes respectively.
- `-kc`: Keep enzyme cut-site remains in the output reads (default `true`).

## Experimental Design Tools

### Restriction Enzyme Predictor
Use this to estimate fragment distributions before sequencing. It requires a file containing paths to reference FASTA files.
```bash
gbsx --tool RestrictionEnzymePredictor -d <digest_sequence> -l <read_length> -f fasta_list.txt
```
- `-n` / `-m`: Minimum and maximum fragment sizes to include in the report.

### Barcode Generator
Generates a set of barcodes optimized for the specific enzyme and base distribution.
```bash
gbsx --tool BarcodeGenerator -b <number_of_barcodes> -e <enzyme_name>
```

## Best Practices and Expert Tips
- **Memory Management:** For very large fastq files, ensure you allocate sufficient heap space if running the underlying JAR directly, though the conda wrapper usually handles this.
- **N-Nucleotides:** By default, GBSX keeps sequences containing "N". If your downstream pipeline is sensitive to Ns, use `-n false`.
- **Common Adaptors:** If your library prep uses a specific common adaptor, provide it with `-ca <sequence>` (minimum 10bp) to improve trimming and identification.
- **Thread Scaling:** Use the `-t` parameter to speed up demultiplexing on multi-core systems; however, the bottleneck is often I/O (disk speed) rather than CPU.
- **Validation:** Always check the `rejected.count` column in the generated statistics file to ensure your mismatch settings aren't too stringent.

## Reference documentation
- [GBSX Overview](./references/anaconda_org_channels_bioconda_packages_gbsx_overview.md)
- [GBSX GitHub Repository](./references/github_com_GenomicsCoreLeuven_GBSX.md)
- [GBSX Wiki](./references/github_com_GenomicsCoreLeuven_GBSX_wiki.md)