---
name: dropseq_tools
description: The dropseq_tools suite provides command-line utilities for processing single-cell RNA-seq data from raw reads to gene expression matrices. Use when user asks to extract cell barcodes and UMIs, trim adapter sequences, correct bead synthesis errors, or generate digital gene expression counts.
homepage: http://mccarrolllab.com/dropseq/
---


# dropseq_tools

## Overview
The `dropseq_tools` suite provides a comprehensive set of Java-based command-line utilities designed to handle the unique requirements of Drop-seq data. It manages the transition from raw unmapped reads to high-quality expression counts by performing critical tasks such as barcode extraction, UMI tagging, adapter trimming, and bead-synthesis error correction. This skill assists in constructing robust pipelines for single-cell transcriptomics, ensuring data integrity from the initial bead-capture through to the final count matrix.

## Core Workflow Patterns

### 1. Initial Processing and Tagging
The first stage involves extracting metadata from reads and storing them in BAM tags.
- **TagCellBarcode**: Extracts the cell barcode (typically bases 1-12 of Read 1) and adds the `XC` tag.
- **TagMolecularBarcode**: Extracts the UMI (typically bases 13-20 of Read 1) and adds the `XM` tag.
- **FilterBAM**: Removes reads with low-quality barcodes to reduce noise early in the pipeline.

### 2. Cleaning and Alignment Preparation
Before alignment, reads must be cleaned of technical sequences.
- **TrimStartingSequence**: Removes the fixed adapter sequence (e.g., TSO) from the start of reads.
- **PolyATrimmer**: Removes polyA tails that can interfere with accurate mapping.
- **SamToFastq**: Converts the tagged, trimmed BAM into FASTQ format for alignment with STAR or BWA.

### 3. Post-Alignment Processing
After mapping reads to the genome, use these tools to associate alignments with genes.
- **TagReadWithGeneFunction**: Annotates reads with gene names (`GN`) and functional categories (intergenic, intronic, exonic) using a reference GTF/Refflat file.
- **DetectBeadSubstitutionErrors**: Identifies and corrects cell barcodes that differ by a single base due to bead synthesis errors.

### 4. Expression Quantification
The final step generates the Digital Gene Expression (DGE) matrix.
- **DigitalExpression**: Aggregates UMIs per gene per cell.
  - Use `READ_MQ=10` (default) to ensure only high-quality mappings are counted.
  - Use `EDIT_DISTANCE=1` to collapse UMIs that are likely PCR errors.
  - Specify `MIN_NUM_GENES_PER_CELL` to filter out low-quality droplets.

## Expert Tips
- **Memory Management**: Since these are Java tools, always specify the heap size via the `-Xmx` flag (e.g., `java -Xmx4g -jar dropseq.jar ...`) to prevent OutOfMemory errors during large BAM processing.
- **Tagging Order**: Always run `TagCellBarcode` before `TagMolecularBarcode` to maintain consistent metadata structure.
- **Validation**: Use `ValidateSamFile` from the Picard suite (often bundled or used alongside dropseq_tools) to ensure BAM files remain compliant after heavy tagging and trimming.
- **Bead Synthesis Errors**: If you notice an unexpectedly high number of cells with very low counts, check for bead synthesis errors using `DetectBeadSynthesisErrors`.

## Reference documentation
- [dropseq_tools Overview](./references/anaconda_org_channels_bioconda_packages_dropseq_tools_overview.md)