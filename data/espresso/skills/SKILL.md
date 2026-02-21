---
name: espresso
description: ESPRESSO (Error Statistics PRomoted Evaluator of Splice Site Options) is a specialized tool for long-read RNA-seq analysis.
homepage: https://github.com/Xinglab/espresso
---

# espresso

## Overview
ESPRESSO (Error Statistics PRomoted Evaluator of Splice Site Options) is a specialized tool for long-read RNA-seq analysis. It addresses the inherent error rates in long-read sequencing by using a discovery-based approach to refine splice junctions and accurately quantify isoforms. The workflow consists of three primary Perl-based modules that must be executed in sequence: Pre-processing (S), Correction (C), and Quantification (Q).

## Core Workflow

### 1. Preparation
ESPRESSO requires a tab-separated `samples.tsv` file mapping file paths to sample names.
```bash
# Format: /path/to/alignment.sorted.sam  sample_name
echo -e "/data/sample1.sort.bam\tSample1" > samples.tsv
```
**Note**: Input SAM/BAM files must be sorted.

### 2. Pre-processing (ESPRESSO_S)
This step identifies high-confidence splice junctions and prepares the work directory.
```bash
perl ESPRESSO_S.pl -L samples.tsv -F reference.fasta -A annotation.gtf -O output_dir
```
- **Threads**: Limited to 1 thread per input alignment file.
- **Output**: Generates `output_dir/samples.tsv.updated`, which assigns a target ID (`-X`) to each input file.

### 3. Correction (ESPRESSO_C)
Corrects and recovers splice junctions for each read. This must be run for every target ID identified in the previous step.
```bash
# Run for the first input (ID 0)
perl ESPRESSO_C.pl -I output_dir -F reference.fasta -X 0 -T 8
```
- **Parallelization**: Run multiple instances of `ESPRESSO_C.pl` simultaneously for different `-X` values to save time.
- **Memory**: Approximately `num_threads * 6` GB.

### 4. Quantification (ESPRESSO_Q)
Finalizes isoform identification and calculates abundance.
```bash
perl ESPRESSO_Q.pl -L output_dir/samples.tsv.updated -A annotation.gtf -T 8
```
- **Threads**: Limited to 1 thread per chromosome.
- **Key Outputs**: 
  - `*_abundance.esp`: Isoform quantification results.
  - `*_updated.gtf`: Refined transcript annotations.

## Advanced Utilities

### Generating Corrected SAM Files
To obtain a SAM file with corrected alignments (useful for downstream visualization or analysis), use the provided Python script:
```bash
python3 snakemake/scripts/create_corrected_sam.py \
    --samples-tsv samples.tsv \
    --espresso-out-dir output_dir \
    --out-dir corrected_sam_dir \
    --fasta reference.fasta \
    --libparasail-so-path ./src/libparasail.so
```

### Visualization
Generate browser-compatible files for specific genes:
```bash
python3 visualization/visualize.py \
    --genome-fasta reference.fasta \
    --updated-gtf output_dir/samples_N2_R0_updated.gtf \
    --abundance-esp output_dir/samples_N2_R0_abundance.esp \
    --target-gene GENE_NAME \
    --output-dir viz_out
```

## Expert Tips & Best Practices
- **Memory Estimation**: For the Q step, use the formula: `num_threads * (1 + 8 * num_reads_in_group / 1,000,000)` GB.
- **Large Datasets**: If processing very large datasets, use `snakemake/scripts/split_espresso_s_output_for_c.py` to split reads into smaller groups for the C step to prevent memory bottlenecks.
- **Splice Site Discovery**: By default, ESPRESSO groups reads based on annotated gene coordinates. Use `--alignment_read_groups` if you want to group reads based on overlapping alignment coordinates instead (useful for novel gene discovery).
- **Dependency Check**: Ensure `hmmer` (>= 3.3.1), `BLAST` (>= 2.8.1), and `samtools` (>= 1.6) are in your `$PATH`.

## Reference documentation
- [ESPRESSO GitHub Repository](./references/github_com_Xinglab_espresso.md)
- [Bioconda ESPRESSO Overview](./references/anaconda_org_channels_bioconda_packages_espresso_overview.md)