---
name: trust4
description: TRUST4 extracts and assembles immune repertoire sequences from standard RNA-seq data. Use when user asks to extract or assemble immune repertoire sequences, or process bulk, single-cell, or SMART-seq RNA-seq data.
homepage: https://github.com/liulab-dfci/TRUST4
---


# trust4

## Overview
TRUST4 (T-cell Receptor Universal Statistical Classifier 4) is a computational tool designed to extract and assemble immune repertoire sequences from unselected RNA-seq data. Unlike specialized TCR-seq, TRUST4 works on standard RNA-seq profiles from fluid or solid tissues (including tumors) by performing de novo assembly on V, J, and C genes. It is highly effective for characterizing the immune microenvironment when specific enrichment protocols were not used.

## Installation and Setup
The most efficient way to install TRUST4 is via Bioconda:
```bash
conda install -c bioconda trust4
```
Alternatively, you can build from source by running `make` in the cloned repository. Ensure `pthreads` and `zlib` are available on your system.

## Common CLI Patterns

### 1. Processing Bulk RNA-seq (BAM input)
When you have aligned BAM files, TRUST4 can extract relevant reads and assemble them.
```bash
run-trust4 -b sample_aligned.bam -f hg38_bcrtcr.fa --ref human_IMGT+C.fa -t 8 -o output_prefix
```
*   `-f`: Path to the genomic coordinate/sequence file for V/D/J/C genes.
*   `--ref`: Path to the detailed IMGT reference (highly recommended for accurate annotation).

### 2. Processing Single-Cell RNA-seq (10x Genomics)
For 10x Genomics data, you must specify the barcode and UMI information.
```bash
run-trust4 -1 R1.fastq.gz -2 R2.fastq.gz \
           -f hg38_bcrtcr.fa \
           --barcode R1.fastq.gz \
           --readFormat r1:0:-1,r2:0:-1,bc:0:15,um:16:-1 \
           -t 16 -o sc_sample
```
*   `--readFormat`: Defines the structure of the reads. In the example above, the barcode is in the first 16bp of R1 and the UMI follows.

### 3. Processing SMART-seq Data
SMART-seq typically requires skipping mate extension due to the nature of the library prep.
```bash
run-trust4 -1 R1.fq -2 R2.fq -f hg38_bcrtcr.fa --skipMateExtension -o smart_sample
```

## Expert Tips and Best Practices
*   **Reference Files**: Always use the `--ref` option with an IMGT-formatted reference file. While `-f` is required for coordinates, `--ref` provides the sequence details necessary for high-quality V(D)J assignment.
*   **Performance**: Use the `-t` flag to match the number of available CPU cores. The assembly and annotation stages are multi-threaded.
*   **Memory Management**: If processing very large BAM files, ensure you have sufficient RAM, as TRUST4 loads candidate reads into memory for assembly.
*   **Output Interpretation**:
    *   `trust_report.tsv`: The primary file for downstream analysis (compatible with VDJTools).
    *   `trust_cdr3.out`: Contains detailed CDR1, 2, and 3 information.
    *   `trust_annot.fa`: The assembled contigs with gene annotations in the header.
*   **Resuming Jobs**: Use the `--stage` parameter to restart a failed run. For example, `--stage 2` starts directly at the annotation phase if the assembly is already complete.
*   **Cleanup**: Use `--clean 1` to remove intermediate files (like extracted candidate reads) after a successful run to save disk space.

## Reference documentation
- [TRUST4 GitHub README](./references/github_com_liulab-dfci_TRUST4.md)
- [TRUST4 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_trust4_overview.md)