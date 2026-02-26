---
name: indelfixer
description: InDelFixer is a Java-based tool designed for the sensitive alignment and refinement of NGS data, particularly for viral or highly variable populations. Use when user asks to align reads to a reference, perform iterative refinement against a consensus sequence, or correct frame-shift mutations and deletions.
homepage: https://github.com/cbg-ethz/InDelFixer
---


# indelfixer

## Overview
InDelFixer is a Java-based tool designed for highly sensitive alignment of Next-Generation Sequencing (NGS) data. It is particularly effective for viral or highly variable populations where frame-shift mutations and large deletions are common. It employs a full Smith-Waterman algorithm and allows for iterative refinement of alignments against a generated consensus sequence to improve quality.

## Core CLI Usage

The basic syntax for running InDelFixer is:
`java -jar InDelFixer.jar -i <input_file> -g <reference_fasta> [options]`

### Common Execution Patterns

*   **Illumina Paired-End:**
    `java -jar InDelFixer.jar -i reads_R1.fastq -ir reads_R2.fastq -g ref.fasta`
*   **PacBio (High Error Rate):**
    Always use `-noHashing` for PacBio data as the error rate is too high for reliable k-mer matching.
    `java -jar InDelFixer.jar -i reads.fasta -g ref.fasta -noHashing`
*   **454/Roche:**
    While `.sff` is supported, it is recommended to convert to fastq first using `sff2fastq`.
    `java -jar InDelFixer.jar -i reads.fastq -g ref.fasta`

## Advanced Alignment & Refinement

*   **Sensitive Mode:** Use `-sensitive` to test multiple affine gap costs for each read, keeping only the best alignment.
*   **Iterative Refinement:** Use `-refine <INT>` (e.g., `-refine 3`) to align reads against the consensus sequence iteratively. This is only supported when aligning against a single reference genome.
*   **Frame-shift Correction:** Use `-fix` to replace deletions that cause frame-shifts with the corresponding consensus sequence.
*   **Conserved Deletions:** Use `-rmDel` during iterative refinement to remove deletions that are conserved across the population.

## Filtering and Region Extraction

*   **Region Extraction:** Extract a specific gene or coordinate range using `-r begin-end`.
    `java -jar InDelFixer.jar -i reads.fastq -g ref.fasta -r 342-944`
*   **Quality Filtering:**
    *   `-l <INT>`: Minimum read length before alignment.
    *   `-la <INT>`: Minimum read length after alignment.
    *   `-ins <DOUBLE>`: Max insertion percentage allowed (0.0 - 1.0).
    *   `-del <DOUBLE>`: Max deletion percentage allowed (0.0 - 1.0).
    *   `-sub <DOUBLE>`: Max substitution percentage allowed (0.0 - 1.0).
    *   `-maxDel <INT>`: Maximum number of allowed consecutive deletions.

## Expert Tips

*   **Gap Costs:** Default costs are 10 (open) and 3 (extend). Adjust these using `-gop` and `-gex` if your specific sequencing technology or organism requires different penalties.
*   **Line Breaks:** If your FASTQ files have sequences or quality strings spanning multiple lines, use the `-flat` flag to parse them correctly.
*   **BAM Conversion:** InDelFixer outputs SAM files. To convert to BAM for downstream analysis:
    `samtools view -bS reads.sam | samtools sort -o sorted_reads.bam`
    `samtools index sorted_reads.bam`

## Reference documentation
- [InDelFixer GitHub Repository](./references/github_com_cbg-ethz_InDelFixer.md)
- [Bioconda indelfixer Overview](./references/anaconda_org_channels_bioconda_packages_indelfixer_overview.md)