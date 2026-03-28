---
name: pindel
description: Pindel detects structural genomic variations such as deletions, insertions, and inversions by analyzing split-read alignments. Use when user asks to detect structural variants, identify genomic breakpoints, or convert Pindel output to VCF format.
homepage: http://gmt.genome.wustl.edu/packages/pindel/index.html
---


# pindel

## Overview
Pindel is a specialized bioinformatic tool used to uncover structural genomic variations that standard alignment tools often miss. By analyzing "split-reads" (where one end of a paired-read maps uniquely but the other does not), it precisely defines the boundaries of SVs. This skill provides the necessary command-line patterns to configure input files, run the detection algorithm, and process the resulting variant calls.

## Configuration and Input
Pindel requires a specific configuration file (often named `pindel_input.txt`) to define the BAM files and insert sizes.

**Input Configuration Format:**
Each line in the configuration file should follow this tab-delimited format:
`<path_to_bam> <insert_size> <sample_tag>`

Example:
```bash
/data/sample1.bam  300  Sample1
/data/sample2.bam  350  Sample2
```

## Common CLI Patterns

### 1. Basic SV Detection
To run Pindel on a specific chromosome (recommended for speed):
```bash
pindel -f reference.fa -i pindel_input.txt -c chr20 -o output_prefix
```

### 2. Whole Genome Analysis
To run on all chromosomes (ensure sufficient computational resources):
```bash
pindel -f reference.fa -i pindel_input.txt -o output_prefix
```

### 3. Detecting Specific Variant Sizes
Use the `-m` flag to define the minimum number of supporting reads required to report a variant (default is 3):
```bash
pindel -f reference.fa -i pindel_input.txt -m 5 -o output_prefix
```

## Output Processing
Pindel produces several output files based on variant type (e.g., `_D` for deletions, `_SI` for small insertions, `_INV` for inversions). To convert these into a standard VCF format, use the `pindel2vcf` utility:

```bash
pindel2vcf -p output_prefix_D -r reference.fa -R hg19 -d 20101123 -v output.vcf
```

## Expert Tips
- **Reference Indexing:** Ensure your reference genome is indexed with `samtools faidx`.
- **Memory Management:** Pindel can be memory-intensive. If processing large genomes, run chromosomes in parallel across different jobs to reduce the memory footprint per process.
- **Insert Size:** Accuracy depends heavily on the correct expected insert size provided in the configuration file. Use tools like `Picard CollectInsertSizeMetrics` to determine this value before running Pindel.
- **Filtering:** Raw Pindel output often contains many candidates. Always convert to VCF and apply quality filters (e.g., read depth, mapping quality) before downstream analysis.

## Reference documentation
- [Pindel Overview](./references/gmt_genome_wustl_edu_packages_pindel_index.html.md)