---
name: nanopolish
description: Nanopolish is a specialized suite of algorithms designed to analyze the raw ionic current signal (the "squiggles") produced by Oxford Nanopore Technologies (ONT) sequencers.
homepage: https://github.com/jts/nanopolish
---

# nanopolish

## Overview

Nanopolish is a specialized suite of algorithms designed to analyze the raw ionic current signal (the "squiggles") produced by Oxford Nanopore Technologies (ONT) sequencers. While standard basecallers convert signal to text, nanopolish goes back to the original signal data to resolve ambiguities, call base modifications, and improve the accuracy of draft genome assemblies. It is particularly effective for polishing assemblies produced by long-read assemblers like Canu or Flye and for detecting 5mC methylation in a genomic context.

## Core CLI Workflows

### 1. Data Indexing (Required First Step)
Before running any analysis, you must link your basecalled FASTQ reads to the raw signal files (FAST5 or SLOW5).

**For FAST5 input:**
```bash
nanopolish index -d /path/to/raw_fast5s/ -s sequencing_summary.txt basecalled_reads.fastq
```
*   **Tip**: Always provide the `-s` (sequencing_summary.txt) file if available; it makes indexing significantly faster by avoiding a full scan of the FAST5 directory.

**For SLOW5 input:**
```bash
nanopolish index basecalled_reads.fastq --slow5 signals.blow5
```
*   **Note**: SLOW5/BLOW5 is generally faster and more efficient for large-scale signal analysis than FAST5.

### 2. Consensus Polishing
To improve a draft assembly, align your reads to the draft and then run the `variants` module in consensus mode.

**Step A: Alignment**
```bash
bwa mem -x ont2d -t 8 draft.fa reads.fastq | samtools sort -o reads.sorted.bam -
samtools index reads.sorted.bam
```

**Step B: Polishing (Parallelized)**
Nanopolish is computationally intensive. Use the helper script to split the genome into ranges and process in parallel:
```bash
python3 nanopolish_makerange.py draft.fa | parallel --results nanopolish.results -P 8 \
    nanopolish variants --consensus -o polished.{1}.vcf -w {1} -r reads.fastq -b reads.sorted.bam -g draft.fa
```

**Step C: Generate Polished Fasta**
```bash
nanopolish vcf2fasta -g draft.fa polished.*.vcf > polished_genome.fa
```

### 3. Calling Methylation
Detect 5mC at CpG sites by comparing the observed signal to a model of unmethylated DNA.
```bash
nanopolish call-methylation -t 8 -r reads.fastq -b reads.sorted.bam -g draft.fa > methylation_calls.tsv
```
*   **Post-processing**: Use `scripts/calculate_methylation_frequency.py` to aggregate site-level calls into genomic frequencies.

### 4. Poly-A Tail Estimation
For direct RNA sequencing, estimate the length of the poly-A tail for each transcript.
```bash
nanopolish polya -t 8 -r rna_reads.fastq -b rna_aligned.sorted.bam -g transcript_ref.fa > polya_results.tsv
```

## Expert Tips and Best Practices

*   **R10 Support**: As of version 0.14.x, nanopolish does not support R10.4 flow cells for variant or methylation calling, as the basecallers for those chemistries are generally accurate enough to negate the need for signal-level polishing. Use it primarily for R9.4.1 data.
*   **Memory Management**: If you encounter memory leaks or high usage, ensure you are using version 0.13.2 or later.
*   **Parallelization**: Always use `nanopolish_makerange.py` for large genomes. Running nanopolish on a whole human genome without splitting into windows is not feasible.
*   **Signal Alignment**: Use `nanopolish eventalign` if you need to extract the raw signal levels aligned to specific k-mers for custom machine learning or visualization.

## Reference documentation
- [Nanopolish GitHub Repository](./references/github_com_jts_nanopolish.md)
- [Bioconda Nanopolish Overview](./references/anaconda_org_channels_bioconda_packages_nanopolish_overview.md)