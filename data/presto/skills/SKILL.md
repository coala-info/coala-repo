---
name: presto
description: The REpertoire Sequencing TOolkit (pRESTO) provides a standardized pipeline for the pre-processing of Adaptive Immune Receptor Repertoire sequencing (AIRR-seq) data.
homepage: http://presto.readthedocs.io
---

# presto

## Overview
The REpertoire Sequencing TOolkit (pRESTO) provides a standardized pipeline for the pre-processing of Adaptive Immune Receptor Repertoire sequencing (AIRR-seq) data. It is designed to transform raw FASTQ files into high-quality, annotated sequences ready for germline V(D)J assignment. This skill assists in navigating the suite's command-line utilities to handle complex tasks like molecular barcode (UMI) processing and multi-stage sequence filtering.

## Core Command Patterns

### 1. Quality Control and Filtering
Use `FilterSeq` to remove low-quality reads before downstream processing.
- **Quality filtering**: `FilterSeq.py quality -s <file>.fastq -q 20`
- **Length filtering**: `FilterSeq.py length -s <file>.fastq -n 100`

### 2. Primer and Barcode Masking
Use `MaskPrimers` to identify and remove primer sequences or extract UMIs.
- **Masking primers**: `MaskPrimers.py score -s <file>.fastq -p <primers>.fasta --start 0 --mode cut`
- **Extracting UMIs**: Use the `--barcode` flag to move sequence segments into the header for consensus building.

### 3. Paired-End Assembly
Use `AssemblePairs` to merge R1 and R2 reads.
- **Coordinate-based**: `AssemblePairs.py align -1 <R1>.fastq -2 <R2>.fastq --coord illumina`
- **Reference-based**: Useful when overlap is insufficient but a constant region is known.

### 4. UMI Consensus Generation
For libraries with Unique Molecular Identifiers, use `BuildConsensus` to collapse PCR duplicates.
- **Basic consensus**: `BuildConsensus.py -s <file>.fastq --bf BARCODE --maxerror 0.1 --prcons 0.6`
- This reduces sequencing error by creating a representative sequence for each UMI group.

### 5. Sequence Annotation and Conversion
- **Collapsing duplicates**: `CollapseSeq.py -s <file>.fastq -n 20` (collapses identical sequences and updates count metadata).
- **Parsing headers**: `ParseHeaders.py copy -s <file>.fastq -f BARCODE -t UMI` to manipulate metadata stored in FASTQ/FASTA headers.
- **Table conversion**: `ConvertHeaders.py table -s <file>.fastq` to export sequence metadata to a TSV for analysis in R (e.g., Change-O).

## Expert Tips
- **Header Metadata**: pRESTO relies heavily on the FASTQ header to pass information between tools. Always check that your headers contain the expected tags (e.g., `PRCONS`, `BARCODE`) after each step.
- **Log Files**: Every pRESTO command generates a `.log` file. Review these to check the "Pass" vs "Fail" rates to ensure your filtering thresholds aren't too aggressive.
- **Memory Management**: When running `BuildConsensus` or `CollapseSeq` on large datasets, ensure sufficient RAM is allocated as these tools load sequence groups into memory.

## Reference documentation
- [pRESTO Documentation Overview](./references/presto_readthedocs_io_en_stable.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_presto_overview.md)