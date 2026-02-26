---
name: transindel
description: transIndel is a specialized tool for discovering indels and structural variations using chimeric alignments, outputting results in a VCF file. Use when user asks to discover indels, call structural variations, analyze chimeric alignments, or detect indels in RNA-seq data.
homepage: https://github.com/cauyrd/transIndel
---


# transindel

## Overview
transIndel is a specialized tool for indel discovery that leverages chimeric alignments—reads that map to non-contiguous portions of the genome—to pinpoint structural variations. The workflow consists of two primary phases: a "build" phase that redefines CIGAR strings to clarify indel evidence, and a "call" phase that generates a VCF file. It is highly effective for RNA-seq data as it can distinguish between true indels and splicing events using gene annotation (GTF) files.

## Installation and Prerequisites
The tool requires Python 3.6+, Samtools 1.0+, and the Python packages `pysam` and `HTSeq`.
The easiest way to install transIndel is via Bioconda:
```bash
conda install bioconda::transindel
```

## Workflow Instructions

### 1. Input Preparation
Input BAM files must meet the following criteria:
*   Aligned using **BWA-MEM**.
*   Sorted by coordinate.
*   Indexed (generating a `.bai` file).

### 2. Step 1: Redefining CIGAR Strings (Build Phase)
This step processes the chimeric alignments to create a modified BAM file used for calling.

**For DNA-seq (WGS/Exome/Targeted):**
```bash
python transIndel_build_DNA.py -i input.bam -o build.bam
```

**For RNA-seq:**
Requires the reference genome and a gene annotation file to handle splice junctions.
```bash
python transIndel_build_RNA.py -i input.bam -r reference.fasta -g annotation.gtf -o build.bam
```

**Key Build Options:**
*   `-m <int>`: Minimum MAPQ of reads to support an indel (default: 15).
*   `-l <int>`: Maximum deletion length to detect (default: 1,000,000).
*   `-s <int>`: (RNA only) Splice site half bin size (default: 20).

### 3. Step 2: Indel Calling
Generate the final VCF output from the BAM produced in Step 1.
```bash
python transIndel_call.py -i build.bam -o output_prefix
```

**Key Calling Options:**
*   `-c <int>`: Minimum observation count (reads) for an indel (default: 4).
*   `-d <int>`: Minimum total depth at the site to call an indel (default: 10).
*   `-f <float>`: Minimum variant allele frequency (VAF) (default: 0.1).
*   `-l <int>`: Minimum indel length to report (default: 10).
*   `-t <string>`: Limit analysis to a specific region (Samtools string) or BED file.

## Expert Tips and Best Practices
*   **Chimeric Alignment Importance**: transIndel relies on the `SA` tag produced by BWA-MEM. If your alignments were produced by a different aligner or BWA-MEM settings that suppress chimeric output, the tool will not find variants.
*   **RNA-seq Precision**: When running the RNA build script, ensure your GTF file matches the chromosome naming convention (e.g., "chr1" vs "1") used in your reference FASTA.
*   **Filtering**: If you are getting too many false positives in low-complexity regions, increase the `-m` (MAPQ) and `-c` (observation count) parameters during the calling phase.
*   **Alternative Callers**: The BAM file generated in Step 1 (`build.bam`) contains redefined CIGAR strings that make indels "visible" to standard callers. You can optionally use this BAM as input for GATK, FreeBayes, or VarDict if you prefer their statistical models.

## Reference documentation
- [transIndel README](./references/github_com_cauyrd_transIndel_blob_master_README.md)
- [Bioconda transIndel Overview](./references/anaconda_org_channels_bioconda_packages_transindel_overview.md)