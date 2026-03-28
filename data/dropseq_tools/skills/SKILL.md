---
name: dropseq_tools
description: The dropseq_tools suite provides command-line utilities for processing and analyzing single-cell RNA-seq data generated via the Drop-seq protocol. Use when user asks to process BAM files with cellular barcodes and UMIs, annotate reads with gene functions, or generate a digital expression matrix.
homepage: http://mccarrolllab.com/dropseq/
---


# dropseq_tools

## Overview
The `dropseq_tools` suite, developed by the Broad Institute, provides a comprehensive set of command-line utilities for the processing and analysis of single-cell RNA-seq data. It is designed to handle the specific requirements of the Drop-seq protocol, including the extraction and management of cellular barcodes and Unique Molecular Identifiers (UMIs). The tools primarily operate on BAM files, adding metadata tags that track the origin of each read, and ultimately quantifying gene expression across individual cells.

## Command Line Usage
Most tools are invoked through a central wrapper script or by calling the executable jar directly.

### General Syntax
```bash
dropseq <CommandName> [ARGUMENT=VALUE] ...
```
*Note: Arguments typically follow the `KEY=VALUE` format common in Picard-style tools.*

### Reference Preparation
Before alignment, genomic references must be processed into formats compatible with Drop-seq metadata tagging:
- **ReduceGtf**: Simplifies a GTF file to contain only essential features.
- **ConvertToRefFlat**: Converts a GTF/GenePred file to the refFlat format required for gene tagging.
- **CreateIntervalsFiles**: Generates ribosomal and other interval lists from a reference.

### BAM Tagging and Processing
The core of the pipeline involves adding metadata to aligned or unaligned reads:
- **TagBamWithReadSequenceExtended**: Extracts cell barcodes and UMIs from sequences and adds them as BAM tags (e.g., `XC` for cell barcode, `XM` for UMI).
- **FilterBam**: Removes reads based on quality or specific tag criteria.
- **PolyATrimmer**: Identifies and trims polyA tails from reads, which is critical for accurate alignment in Drop-seq.
- **TagReadWithGeneExonFunction**: Annotates reads with gene names and functional locations (intronic, exonic, etc.) using the processed refFlat file.

### Quantification and Analysis
- **DigitalExpression**: The primary tool for generating a digital expression matrix. It counts UMIs per gene per cell.
  - Use `SUMMARY=<file>` to get statistics on library complexity.
  - Use `CELL_BARCODE_TAG=XC` and `MOLECULAR_BARCODE_TAG=XM` as standard defaults.
- **BamTagHistogram**: Generates a distribution of reads per cell barcode, useful for identifying the "knee" in cell selection.
- **SelectCellsByNumTranscripts**: Filters the expression matrix to include only high-quality cells based on a transcript threshold.

## Expert Tips and Best Practices
- **Memory Management**: Since these tools are Java-based, ensure you provide sufficient heap space for large BAM files using environment variables or the wrapper script options (e.g., `-Xmx4g`).
- **Validation**: Always run `ValidateReference` before starting a large pipeline to ensure your FASTA, GTF, and refFlat files are perfectly synchronized.
- **Tagging Order**: Ensure cell barcodes are tagged and filtered (e.g., using `DetectBeadSynthesisErrors`) before running `DigitalExpression` to avoid inflated cell counts.
- **Standard Tags**: Stick to the standard tag nomenclature (`XC` for Cell Barcode, `XM` for UMI, `GE` for Gene Name) to ensure compatibility between different tools in the suite.



## Subcommands

| Command | Description |
|---------|-------------|
| DetectBeadSubstitutionErrors | Collapses umambiguously related small barcodes into larger neighbors. Unambiguously related barcodes are situations where a smaller barcode only has 1 neighbor within the edit distance threshold, so the barcode can not be collapsed to the wrong neighbor. These sorts of errors can be due to problems with barcode synthesis. Ambiguous barcodes are situations where a smaller neighbor has multiple larger neighbors. These barcodes can be optionally filtered. |
| DigitalExpression | Measures the digital expression of a library. Method: 1) For each gene, find the molecular barcodes on the exons of that gene. 2) Determine how many HQ mapped reads are assigned to each barcode. 3) Collapse barcodes by edit distance. 4) Throw away barcodes with less than threshold # of reads. 5) Count the number of remaining unique molecular barcodes for the gene.This program requires a tag for what gene a read is on, a molecular barcode tag, and a exon tag. The exon and gene tags may not be present on every read.When filtering the data for a set of barcodes to use, the data is filtered by ONE of the following methods (and if multiple params are filled in, the top one takes precedence):1) CELL_BC_FILE, to filter by the some fixed list of cell barcodes2) MIN_NUM_GENES_PER_CELL 3) MIN_NUM_TRANSCRIPTS_PER_CELL 4) NUM_CORE_BARCODES 5) MIN_NUM_READS_PER_CELL |
| PolyATrimmer | Trims poly-A tails from SAM/BAM files. |
| TagReadWithGeneFunction | Tags reads that are exonic for the gene name of the overlapping exon. This is done specifically to solve the case where a read may be tagged with a gene and an exon, but the read may not be exonic for all genes tagged. This limits the list of genes to only those where the read overlaps the exon and the gene.Reads that overlap multiple genes are assigned to the gene that shares the strand with the read. If that assignment is ambiguous (2 or more genes share the strand of the read), then the read is not assigned any genes. |
| TrimStartingSequence | Trim the given sequence from the beginning of reads |

## Reference documentation
- [Drop-seq GitHub README](./references/github_com_broadinstitute_Drop-seq_blob_master_README.md)
- [Drop-seq Build Configuration (Command List)](./references/github_com_broadinstitute_Drop-seq_blob_master_build.xml.md)