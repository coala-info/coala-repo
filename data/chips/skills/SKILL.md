---
name: chips
description: ChIPs is a toolkit designed to model and simulate realistic ChIP-sequencing data based on experimental parameters. Use when user asks to learn model parameters from existing datasets or generate synthetic reads from a reference genome.
homepage: https://github.com/gymreklab/chips
---

# chips

## Overview

ChIPs is a specialized toolkit designed to model and simulate ChIP-sequencing data. It enables the creation of realistic synthetic datasets by capturing the nuances of real experiments, such as fragment length distributions, PCR duplication rates, and signal-to-noise ratios (SPOT scores). The tool operates through two primary modules: `learn`, which extracts parameters from existing datasets to create a model, and `simreads`, which uses those models to generate simulated reads from a reference genome.

## Command Line Usage

The `chips` tool is executed as a single binary with subcommands for learning and simulation.

### Learning Model Parameters

Use the `learn` module to analyze existing data and generate a JSON model file.

```bash
chips learn -b <reads.bam> -p <peaks.bed> -t bed -c <score_column> -o <output_prefix>
```

**Key Considerations:**
- **Input Requirements**: The BAM file must be sorted and indexed. To accurately estimate PCR duplication rates, duplicates should be flagged (e.g., using Picard).
- **Peak Scoring**: Use `-c` to specify the 1-based index of the column in your BED/Homer file that contains peak scores.
- **Outlier Handling**: Use `--scale-outliers` when working with real data to set peaks with scores >3x the median to a binding probability of 1, preventing extreme values from skewing the model.
- **Single-End Data**: If using single-end reads, use `--est <int>` to provide a loose upper-bound estimate of fragment length to guide the inference process.

### Simulating Reads

Use the `simreads` module to generate FASTQ files based on a peak set and a model.

```bash
chips simreads -p <peaks.bed> -f <ref.fa> -t bed --model <model.json> -o <output_prefix>
```

**Common Patterns:**
- **Paired-End Simulation**: Add the `--paired` flag to generate `_1.fastq` and `_2.fastq` files.
- **Control Data (WCE)**: To simulate Whole Cell Extract control data, use `-t wce` and omit the peaks input file.
- **Adjusting Depth**: Control the output volume using `--numreads <int>` (total reads/pairs) and `--numcopies <int>` (number of genome copies to simulate).
- **Parameter Overrides**: You can override specific JSON model parameters directly via the CLI using flags like `--spot <float>` (fraction of reads in peaks) or `--readlen <int>`.

## Expert Tips and Best Practices

- **Fragment Lengths**: For single-end data, the `--est` parameter is critical for robust estimation. Set this to the expected maximum fragment size (e.g., 300-500bp).
- **Binding Probability**: If your input BED file already contains binding probabilities (0 to 1) rather than raw scores, use the `--noscale` flag.
- **Genome Consistency**: When using a model learned from one dataset to simulate another with a different peak set, always include `--recomputeF` to ensure the "fraction of genome bound" parameter is updated for the new peaks.
- **Reference Indexing**: Ensure the reference FASTA file is indexed using `samtools faidx` before running `simreads`.



## Subcommands

| Command | Description |
|---------|-------------|
| chips learn | Learn parameters from a ChIP dataset. |
| chips simreads | Simulate ChIP-seq reads for a set of peaks. |

## Reference documentation
- [ChIPs Main Documentation](./references/github_com_gymreklab_chips.md)