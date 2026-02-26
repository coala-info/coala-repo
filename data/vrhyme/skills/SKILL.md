---
name: vrhyme
description: vRhyme reconstructs viral metagenome-assembled genomes (vMAGs) by analyzing sequence features and coverage variance. Use when user asks to reconstruct viral metagenome-assembled genomes, bin viral sequences, or dereplicate scaffolds.
homepage: https://github.com/AnantharamanLab/vRhyme
---


# vrhyme

## Overview

vRhyme is a specialized binning tool designed specifically for viruses rather than microbes. It reconstructs viral metagenome-assembled genomes (vMAGs) by analyzing two primary signals: sequence feature similarities (like tetranucleotide frequencies and codon usage) and coverage variance across multiple metagenomic samples. By "rhyming" sequences that share similar nucleotide signatures and using coverage data to separate distinct populations that might otherwise look similar, it provides a robust method for viral genome reconstruction.

## Core CLI Usage

### Basic Binning Patterns

The most efficient way to run vRhyme is by providing pre-calculated coverage values or BAM files.

**Using a coverage table:**
```bash
vRhyme -i scaffolds.fasta -c coverage_values.tsv -t 8 -o vrhyme_out
```

**Using BAM files directly:**
```bash
vRhyme -i scaffolds.fasta -b /path/to/bams/*.bam -t 8 -o vrhyme_out
```

**Full input (recommended for speed):**
Providing gene and protein files (e.g., from Prodigal) prevents vRhyme from having to re-run ORF prediction.
```bash
vRhyme -i scaffolds.fasta -g genes.ffn -p proteins.faa -b *.bam -t 12 -o vrhyme_out
```

### Advanced Workflows

**Dereplication:**
To handle redundant scaffolds or perform dereplication as part of the binning process:
```bash
vRhyme -i scaffolds.fasta -b *.bam --method longest -o vrhyme_derep
```

**Processing Raw Reads:**
If BAM files are not available, vRhyme can perform the alignment using Bowtie2 or BWA:
```bash
vRhyme -i scaffolds.fasta -r /path/to/reads/paired_*.fastq -t 16 --aligner bowtie2 -o vrhyme_reads_out
```

## Expert Tips and Best Practices

1.  **Input Pre-filtering:** vRhyme is optimized for viral sequences. Always run a viral prediction tool (VIBRANT, VirSorter2, or CheckV) first and use the predicted viral scaffolds as input. Running vRhyme on a raw, whole metagenome is not recommended.
2.  **Coverage Variance:** The tool's power increases with the number of samples. Using coverage data from multiple related metagenomic samples (e.g., a time series or related sites) significantly improves binning accuracy.
3.  **Circular Scaffolds:** vRhyme v1.1.0+ includes logic to handle circular scaffolds (complete genomes). Use the auxiliary scripts if you need to identify these specifically before or after binning.
4.  **Memory Management:** For very large datasets, ensure you have sufficient RAM for the machine learning models and the `networkx` refinement step.
5.  **Dependency Check:** Use the built-in test script to verify your environment before starting a long run:
    ```bash
    test_vRhyme.py
    ```

## Reference documentation
- [vRhyme GitHub Repository](./references/github_com_AnantharamanLab_vRhyme.md)
- [vRhyme Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_vrhyme_overview.md)