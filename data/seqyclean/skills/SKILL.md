---
name: seqyclean
description: seqyclean is a high-throughput pre-processing tool that removes sequencing adapters, primers, vectors, and biological contaminants from genomic reads. Use when user asks to clean raw sequencing data, perform quality trimming, filter biological contaminants, or merge overlapping paired-end reads.
homepage: https://github.com/ibest/seqyclean
metadata:
  docker_image: "quay.io/biocontainers/seqyclean:1.10.09--h5ca1c30_6"
---

# seqyclean

## Overview

seqyclean is a high-throughput pre-processing tool used to prepare raw genomic reads for downstream analysis. It effectively removes technical artifacts such as sequencing adapters, primers, and laboratory vectors, while also screening for biological contaminants. The tool supports automated quality trimming and can merge overlapping paired-end reads to improve data quality. It is a lightweight alternative to more complex pipelines, focusing on speed and efficiency for standard cleaning tasks.

## Common CLI Patterns

### Illumina Paired-End Cleaning
The most common use case involves cleaning paired-end Illumina reads with quality trimming enabled:
```bash
seqyclean -1 read_R1.fastq.gz -2 read_R2.fastq.gz -qual -o output_prefix
```

### Illumina Single-End with Contaminant Screening
To clean single-end reads while filtering against a database of known contaminants (e.g., PhiX or human sequences) and vectors:
```bash
seqyclean -U input.fastq.gz -v vectors.fasta -c contaminants.fasta -o output_prefix
```

### Roche 454 Processing
For 454 data, seqyclean can output in FASTQ format and perform vector trimming:
```bash
seqyclean -454 input.sff -fastq -v vectors.fasta -o output_prefix
```

### Merging Overlapping Reads
To merge overlapping paired-end reads (minimum overlap 16bp by default):
```bash
seqyclean -1 R1.fastq.gz -2 R2.fastq.gz -overlap 16 -o output_merged
```

## Expert Tips and Best Practices

- **Output Compression**: Always use the `-gz` flag to generate compressed output files, saving significant disk space without requiring a separate step.
- **Minimum Length**: The default `-minlen` is 100 bp. If you are working with shorter reads (e.g., ancient DNA or small RNA), ensure you lower this value (e.g., `-minlen 30`) to avoid losing valid data.
- **Quality Trimming Parameters**: The `-qual` flag uses default Phred thresholds of 20. You can customize this by providing two values: `max_average_error` and `max_error_at_ends`.
- **Poly A/T Trimming**: For RNA-seq data, use `-polyat` to remove poly-A tails. You can tune the sensitivity with `cdna` (max tail size), `cerr` (max G/C internal to tail), and `crng` (search range).
- **Adapter Similarity**: In paired-end mode, use `-at` to adjust the similarity threshold for adapter trimming (default is 0.75). Increasing this makes the tool more stringent.
- **Memory and Performance**: For 454 data, use the `-t` flag to specify the number of threads (default is 4). Note that multi-threading is currently optimized primarily for the 454 mode.
- **Fixing Read IDs**: If using older downstream tools that struggle with new Illumina FASTQ headers, use the `-new2old` switch to revert the header format.

## Reference documentation
- [SeqyClean GitHub Repository](./references/github_com_ibest_seqyclean.md)
- [Bioconda SeqyClean Package](./references/anaconda_org_channels_bioconda_packages_seqyclean_overview.md)