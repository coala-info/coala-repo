---
name: hypo
description: HyPo is a hybrid polishing tool that improves the consensus accuracy of long-read genome assemblies using high-accuracy short reads or PacBio HiFi reads. Use when user asks to polish a draft assembly, correct errors in genomic contigs, or improve assembly accuracy using hybrid or high-accuracy sequencing data.
homepage: https://github.com/kensung-lab/hypo
metadata:
  docker_image: "quay.io/biocontainers/hypo:1.0.3--h9a82719_1"
---

# hypo

## Overview
HyPo (Hybrid Polisher) is a tool designed to improve the consensus accuracy of long-read genome assemblies. It utilizes high-accuracy reads—either traditional short reads or PacBio HiFi (CCS) reads—to identify and correct errors in a draft assembly. By leveraging unique genomic k-mers to distinguish between "strong" (correct) and "weak" (erroneous) regions, HyPo applies Partial Order Alignment (POA) selectively. This targeted approach allows it to achieve high accuracy with significantly lower memory and time requirements compared to global polishers like Racon.

## Mandatory Arguments
To run a basic polishing task, the following parameters are required:
- `-r, --reads-short`: Input short reads or HiFi reads (FASTA/FASTQ, can be gzipped).
- `-d, --draft`: The draft assembly contigs to be polished.
- `-b, --bam-sr`: BAM/SAM file of short/HiFi reads aligned against the draft (must contain CIGAR strings).
- `-c, --coverage-short`: The approximate mean coverage of the short/HiFi reads.
- `-s, --size-ref`: Approximate genome size (e.g., `3g` for human, `10m` for microbes).

## Common CLI Patterns

### Hybrid Polishing (Short Reads + Long Reads)
When you have both Illumina short reads and the original noisy long reads, use the `-B` flag to include the long-read alignments for maximum accuracy.
```bash
hypo -r short_reads.fastq.gz -d draft.fasta -b short_vs_draft.bam -B long_vs_draft.bam -c 50 -s 3g -t 16 -o polished_assembly.fasta
```

### Polishing with PacBio HiFi/CCS
If using high-accuracy long reads (CCS) instead of NGS short reads, specify the read type using `-k ccs`.
```bash
hypo -r hifi_reads.fastq.gz -d draft.fasta -b hifi_vs_draft.bam -c 30 -s 100m -k ccs -t 8
```

### Short-Read Only Polishing
If long-read alignments are unavailable or not desired, omit the `-B` argument. HyPo will polish the assembly using only the high-accuracy short-read data.
```bash
hypo -r reads.fastq -d draft.fasta -b sr_vs_draft.bam -c 40 -s 500k -t 4
```

## Expert Tips and Best Practices

### Memory Management
For large genomes or systems with limited RAM, use the `-p, --processing-size` flag. This controls the number of contigs processed in a single batch. A lower value reduces memory overhead at the cost of some execution speed.

### Handling Multiple Input Files
If your short-read data is spread across multiple files, you do not need to merge them manually. Create a text file containing the path to each read file (one per line) and pass it to `-r` using the `@` prefix:
```bash
# reads_list.txt contains:
# /path/to/lane1.fq
# /path/to/lane2.fq

hypo -r @reads_list.txt [other_args]
```

### Alignment Requirements
HyPo is sensitive to the quality of the input BAM files. Ensure that:
1. The BAM files are sorted.
2. The alignments contain valid CIGAR strings.
3. The short reads were mapped to the *exact* draft assembly file provided to the `-d` argument.

### Parameter Tuning
- **Match Scores**: If working with specific sequencing technologies where the default match score is suboptimal, adjust it using `-m` (default is 5).
- **Thread Scaling**: HyPo scales well with threads (`-t`). For human-sized genomes, 24–32 threads are recommended for optimal throughput.

## Reference documentation
- [HyPo GitHub Repository](./references/github_com_kensung-lab_hypo.md)
- [Bioconda Hypo Package](./references/anaconda_org_channels_bioconda_packages_hypo_overview.md)