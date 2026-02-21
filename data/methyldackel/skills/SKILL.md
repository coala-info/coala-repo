---
name: methyldackel
description: MethylDackel is a high-performance tool designed to extract methylation information from aligned BS-seq data.
homepage: https://github.com/dpryan79/MethylDackel
---

# methyldackel

## Overview
MethylDackel is a high-performance tool designed to extract methylation information from aligned BS-seq data. It identifies cytosine methylation states across different sequence contexts (CpG, CHG, CHH) and produces bedGraph files that quantify methylated and unmethylated counts at each position. It is particularly useful for researchers needing a "universal" extractor that accounts for technical biases like M-bias and overlapping read pairs.

## Installation
Install via Bioconda for the most stable environment:
```bash
conda install -c bioconda methyldackel
```

## Core CLI Patterns

### Basic CpG Extraction
Extract CpG methylation metrics using a reference genome and a sorted, indexed BAM file:
```bash
MethylDackel extract reference.fa alignments.bam
```
This produces `alignments_CpG.bedGraph`. Column 4 contains methylated counts; column 5 contains unmethylated counts.

### Extracting Multiple Contexts
To include CHG and CHH contexts in the output:
```bash
MethylDackel extract reference.fa alignments.bam --CHG --CHH
```
This will generate three separate files: `_CpG.bedGraph`, `_CHG.bedGraph`, and `_CHH.bedGraph`.

### Filtering by Quality
Adjust the stringency of the extraction by setting minimum Mapping Quality (MAPQ) and base Phred scores:
```bash
MethylDackel extract reference.fa alignments.bam -q 20 -p 15
```
*   `-q`: Minimum MAPQ (default: 10).
*   `-p`: Minimum Phred score (default: 5).

### Handling Methylation Bias (M-Bias)
BS-seq libraries often show biased methylation calls at the ends of reads. Use the bias options to ignore a specific number of bases from the ends of reads:
```bash
MethylDackel extract reference.fa alignments.bam --OT 5,5,5,5
```
The four values represent the number of bases to ignore from the 5' and 3' ends of both the original top (OT) and original bottom (OB) strands.

### Mappability Filtering
Filter out reads in regions with low mappability to reduce false positives, using either a bigWig or a BBM (Binary BisMap) file:
```bash
# Using a bigWig file
MethylDackel extract reference.fa alignments.bam -M mappability.bw

# Using a BBM file (faster)
MethylDackel extract reference.fa alignments.bam -B mappability.bbm
```

## Expert Tips and Best Practices

*   **Input Preparation**: Always ensure your BAM/CRAM file is coordinate-sorted and indexed (`samtools index`). The reference FASTA must also be indexed (`samtools faidx`).
*   **Overlapping Reads**: MethylDackel automatically handles overlapping paired-end reads to prevent double-counting methylation states. It uses a logic similar to `samtools mpileup`, where the base with the higher quality score is kept and adjusted if the mates agree.
*   **Output Prefixing**: Use the `-o` flag to specify a custom output prefix if you are processing multiple samples in the same directory to avoid overwriting default filenames.
*   **Memory Efficiency**: For very large genomes or high-coverage data, MethylDackel is generally more memory-efficient than older tools like Bismark's extractor because it uses a pileup-based approach.
*   **Non-CpG Conversion**: Use `--minConversionEfficiency` to filter out reads that do not meet a minimum threshold of non-CpG cytosine conversion, which helps filter out poorly bisulfite-converted reads.

## Reference documentation
- [MethylDackel GitHub Repository](./references/github_com_dpryan79_MethylDackel.md)
- [MethylDackel Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_methyldackel_overview.md)