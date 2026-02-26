---
name: seqprep
description: SeqPrep removes adapter contamination from Illumina paired-end reads and merges overlapping forward and reverse reads into a single consensus sequence. Use when user asks to trim adapter sequences, merge overlapping paired-end reads, or mask adapter sequences with Ns.
homepage: https://github.com/jstjohn/SeqPrep
---


# seqprep

## Overview
SeqPrep is a specialized utility for Illumina paired-end read processing. It performs two primary functions: removing adapter contamination from the ends of reads and merging overlapping forward and reverse reads into a single consensus sequence. This tool is most effective for improving read length and quality in libraries where the insert size is shorter than twice the read length, though it can also be used strictly for adapter trimming without merging.

## Command Line Usage

### Basic Adapter Trimming
To trim adapters without merging reads, provide the input and output filenames for both pairs.
```bash
SeqPrep -f input_R1.fastq.gz -r input_R2.fastq.gz -1 output_R1.fastq.gz -2 output_R2.fastq.gz
```

### Trimming and Merging
To merge overlapping reads into a single file while keeping unmerged reads separate, use the `-s` flag.
```bash
SeqPrep -f R1.fq.gz -r R2.fq.gz -1 R1_unmerged.fq.gz -2 R2_unmerged.fq.gz -s merged.fq.gz
```

### Custom Adapter Sequences
If your library uses non-standard adapters, specify them with `-A` (forward) and `-B` (reverse). It is recommended to provide about 20bp of the adapter sequence.
```bash
SeqPrep -f R1.fq.gz -r R2.fq.gz -1 R1.out.gz -2 R2.out.gz -A GATCGGAAGAGCACACG -B AGATCGGAAGAGCGTCGT
```

## Expert Tips and Best Practices

### 1. Pre-run Adapter Validation
Before running SeqPrep, verify your adapter sequences using `grep` to ensure they appear in your data.
```bash
zcat input_R1.fastq.gz | head -n 1000000 | grep "YOUR_ADAPTER_SEQUENCE" | wc -l
```
The `-A` and `-B` arguments should be provided exactly as they appear in the data; SeqPrep does not perform reverse complementing on these strings during the search.

### 2. Quality Score Encoding
SeqPrep defaults to Phred+33 (Sanger/Illumina 1.8+). If your input data uses older Phred+64 encoding, you must use the `-6` flag. Note that the output will always be converted to Phred+33.

### 3. Handling Different Read Lengths
If your forward and reverse reads have different lengths, use the `-g` flag to print the overhang when adapters are present and stripped.

### 4. Masking vs. Clipping
By default, SeqPrep clips (removes) adapter sequences. If you prefer to keep the read length constant and simply mask the adapter sequences with 'N' characters, use the `-z` flag.

### 5. Merging Specificity
The default parameters are tuned for high specificity. If you have prior knowledge that a significant portion of your library overlaps, you can adjust the following:
- `-o`: Minimum overall base pair overlap to merge (default: 15).
- `-m`: Maximum fraction of mismatching bases allowed in the overlap (default: 0.02).
- `-n`: Minimum fraction of matching bases required (default: 0.90).

### 6. Output Compression
SeqPrep automatically gzip-compresses all output files. Ensure your output filenames end in `.gz` for clarity.

## Reference documentation
- [SeqPrep GitHub Repository](./references/github_com_jstjohn_SeqPrep.md)
- [Bioconda SeqPrep Overview](./references/anaconda_org_channels_bioconda_packages_seqprep_overview.md)