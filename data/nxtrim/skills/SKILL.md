---
name: nxtrim
description: NxTrim processes Nextera Mate Pair libraries by identifying junction adapters and categorizing reads into mate-pair, paired-end, and single-end virtual libraries. Use when user asks to trim Nextera Mate Pair adapters, separate mate pairs from paired-end contaminants, or prepare libraries for scaffolding and assembly.
homepage: https://github.com/sequencing/NxTrim
metadata:
  docker_image: "quay.io/biocontainers/nxtrim:0.4.3--he513fc3_0"
---

# nxtrim

## Overview
`nxtrim` optimizes the utility of Nextera Mate Pair libraries by accurately identifying the circularization junction adapter. It separates reads into distinct "virtual libraries" based on the adapter's position, ensuring that true mate pairs are correctly oriented (Forward-Reverse) while filtering out short-insert paired-end contaminants.

## Usage Patterns

### Basic Trimming
Process raw R1 and R2 files to generate the four standard output libraries (mp, pe, se, and unknown):
`nxtrim -1 sample_R1.fastq.gz -2 sample_R2.fastq.gz -O output_prefix`

### Generating Pure Mate Pairs
For scaffolding tasks where only long-insert reads are desired, use the `--justmp` flag to restrict output to the `mp` and `unknown` libraries:
`nxtrim -1 R1.fastq.gz -2 R2.fastq.gz --justmp -O sample_mp`

### Direct Alignment via Piping
Stream trimmed reads directly into an aligner like BWA to save disk space and I/O time:
`nxtrim --stdout -1 R1.fastq.gz -2 R2.fastq.gz | bwa mem reference.fasta -p - > aligned.sam`
*Note: Use `--stdout-mp` to pipe only the confirmed mate-pair reads.*

### Integration with Assemblers
- **SPAdes**: Concatenate `unknown` and `mp` libraries. SPAdes typically performs better with the combined set:
  `nxtrim -1 R1.fastq.gz -2 R2.fastq.gz --stdout | gzip -1 -c > sample.allmp.fastq.gz`
  `spades.py --hqmp1-12 sample.allmp.fastq.gz -o output_dir`
- **Velvet**: Provide the specific virtual libraries to the `-shortPaired` arguments (e.g., `-shortPaired2` for PE, `-shortPaired3` for MP).

## Expert Tips and Configuration

### Handling High Coverage
In datasets with very high coverage (>50X), the `unknown` library may contain enough PE contaminants to cause assembly issues. In these cases, discard the `unknown` library or treat it strictly as single-ended reads.

### Tuning Adapter Detection
- **Aggressive Search**: Use `--aggressive` to increase the sensitivity of junction adapter detection.
- **Similarity Threshold**: Adjust `--similarity` (default is 0.85) to change the proportion of allowed mismatches in the adapter sequence.
- **Minimum Overlap**: Use `--minoverlap` to set the minimum number of base pairs required for an adapter match at the ends of reads.

### Orientation Control
By default, `nxtrim` reverse-complements mate pairs to the Forward-Reverse (FR) orientation. If your downstream pipeline specifically requires the original Reverse-Forward (RF) orientation, use the `--rf` flag.

## Reference documentation
- [NxTrim GitHub Repository](./references/github_com_sequencing_NxTrim.md)
- [Bioconda nxtrim Overview](./references/anaconda_org_channels_bioconda_packages_nxtrim_overview.md)