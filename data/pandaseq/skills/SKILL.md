---
name: pandaseq
description: PANDAseq merges paired-end Illumina reads into a single consensus sequence by resolving overlaps using probabilistic models. Use when user asks to assemble paired-end reads, merge overlapping sequences, strip PCR primers, or filter assembled sequences by length.
homepage: https://github.com/neufeld/pandaseq
metadata:
  docker_image: "quay.io/biocontainers/pandaseq:2.11--1"
---

# pandaseq

## Overview

PANDAseq (PAired-eND Assembler) is a specialized tool for merging paired-end Illumina reads into a single consensus sequence. It is particularly effective for amplicon sequencing (such as 16S rRNA studies) where forward and reverse reads overlap. Unlike simple aligners, PANDAseq uses probabilistic models to resolve mismatches in the overlap region, calculating new quality scores for the merged bases. It can also identify and strip PCR primers during the assembly process.

## Common CLI Patterns

### Basic Assembly
The most common usage involves providing forward and reverse FASTQ files and specifying an output file for the assembled sequences.
```bash
pandaseq -f forward.fastq -r reverse.fastq -w assembled_output.fasta
```

### Primer Removal
To strip PCR primers during assembly, provide the primer sequences. PANDAseq will look for these at the beginning of the respective reads.
```bash
pandaseq -f R1.fastq -r R2.fastq -p AGAGTTTGATCCTGGCTCAG -q ATTACCGCGGCTGCTGG -w output.fasta
```

### Filtering by Length
Use length constraints to discard sequences that fall outside the expected size of your amplicon.
```bash
# Keep only assembled sequences between 200 and 300 base pairs
pandaseq -f R1.fastq -r R2.fastq -l 200 -L 300 -w filtered.fasta
```

### Selecting Assembly Algorithms
PANDAseq supports multiple algorithms. While the default is often sufficient, specific projects may benefit from others like `pear` or `flash`.
```bash
pandaseq -f R1.fastq -r R2.fastq -a pear -w output.fasta
```

### Handling Unassembled Reads
To capture reads that failed to merge (e.g., for troubleshooting or alternative processing), use the `-u` flag.
```bash
pandaseq -f R1.fastq -r R2.fastq -w assembled.fasta -u unassembled.fasta
```

## Expert Tips and Best Practices

- **Quality Score Interpretation**: The quality scores in PANDAseq output are recalculated based on the probability of the merged base being correct. They do not follow the standard PHRED scale used by Illumina sequencers. Avoid using these scores in downstream applications that expect raw Illumina PHRED scores.
- **Mismatches in Overlap**: PANDAseq is designed to resolve mismatches statistically. If both reads have high quality scores but different bases at a position, the resulting consensus base will have a low quality score because the conflict suggests a sequencing error.
- **Input Sorting**: If using SAM/BAM files as input (via `pandaseq-sam`), ensure the file is sorted by read name. PANDAseq requires paired reads to appear consecutively; otherwise, memory usage will increase significantly as the tool buffers reads while waiting for their mates.
- **Perfect Matches**: While the `completely_miss_the_point` plugin allows you to insist on perfect overlaps, it is generally discouraged as it ignores the statistical power of the tool to correct likely errors.
- **Log Analysis**: Always check the `INFO ARG` lines in the output or log file to verify the parameters used, especially when troubleshooting low assembly rates.

## Reference documentation
- [PANDAseq Assembler](./references/github_com_neufeld_pandaseq.md)
- [PANDAseq Wiki](./references/github_com_neufeld_pandaseq_wiki.md)