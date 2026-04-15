---
name: bioconductor-polyester
description: Bioconductor-polyester simulates RNA-seq experiments by generating synthetic reads with controlled differential transcript expression. Use when user asks to generate synthetic RNA-seq reads, simulate differential expression experiments, or create ground truth datasets for benchmarking bioinformatics pipelines.
homepage: https://bioconductor.org/packages/3.8/bioc/html/polyester.html
---

# bioconductor-polyester

name: bioconductor-polyester
description: Simulate RNA-seq experiments with differential transcript expression. Use this skill when you need to generate synthetic RNA-seq reads (FASTA files) for benchmarking differential expression methods, testing bioinformatics pipelines, or simulating specific experimental designs (case/control, timecourse, or empirical-based).

# bioconductor-polyester

## Overview
The `polyester` package is designed to simulate RNA-seq experiments by mimicking the biological and technical steps of sequencing: fragmentation, reverse-complementing, and error introduction. It allows for precise control over differential expression (DE) at the transcript level, enabling the creation of "ground truth" datasets where the exact fold changes are known.

## Core Workflows

### 1. Basic Case/Control Simulation
Use `simulate_experiment` for standard group comparisons. You must provide a FASTA file of transcript sequences and a fold change matrix.

```r
library(polyester)
library(Biostrings)

# Load transcript sequences
fasta_file = system.file('extdata', 'chr22.fa', package='polyester')
fasta = readDNAStringSet(fasta_file)
small_fasta = fasta[1:20]
writeXStringSet(small_fasta, 'transcripts.fa')

# Define fold changes: 2 groups, 20 transcripts
# Rows = transcripts, Columns = groups
# Example: Transcripts 1-2 are 4x higher in Group A; 3-4 are 4x higher in Group B
fold_changes = matrix(c(4,4, rep(1,18),  # Group A
                        1,1, 4,4, rep(1,16)), # Group B
                      nrow=20)

# Simulate 10 replicates per group
simulate_experiment('transcripts.fa', 
                    num_reps=c(10, 10), 
                    fold_changes=fold_changes, 
                    outdir='sim_results')
```

### 2. Custom Count Matrix (Timecourse/Complex Designs)
Use `simulate_experiment_countmat` to bypass the fold-change logic and specify exact read counts per transcript per sample.

```r
# 12 samples (e.g., timepoints), 20 transcripts
countmat = matrix(300, nrow=20, ncol=12)

# Manually inject signal into specific cells
countmat[1, 2] = 900 # Spike at timepoint 2 for transcript 1

simulate_experiment_countmat('transcripts.fa', 
                             readmat=countmat, 
                             outdir='timecourse_sim')
```

### 3. Empirical Simulation
Use `simulate_experiment_empirical` to base simulations on real data (e.g., from a `ballgown` object). This ensures the synthetic data has realistic abundance distributions.

```r
# Requires ballgown object 'bg' and corresponding GTF/Sequence
simulate_experiment_empirical(bg, 
                              grouplabels=pData(bg)$group, 
                              gtf=gtf_data,
                              seqpath='/path/to/chromosomes', 
                              outdir='empirical_sim')
```

## Key Parameters and Tuning

| Parameter | Description | Default |
| :--- | :--- | :--- |
| `reads_per_transcript` | Baseline mean reads. Can be a single value or a vector. | 300 |
| `size` | Controls variance (Negative Binomial). `mean + (mean^2)/size`. Smaller = more noise. | `mean/3` |
| `readlen` | Length of generated reads. | 100 |
| `paired` | Generate paired-end reads (TRUE) or single-end (FALSE). | TRUE |
| `error_model` | Sequencing error profile (`'uniform'`, `'illumina4'`, `'illumina5'`). | `'uniform'` |
| `bias` | Positional bias (`'none'`, `'rnaf'`, `'cdnaf'`). | `'none'` |
| `strand_specific` | Whether reads are strand-specific. | FALSE |

## Output Files
The simulation generates the following in the `outdir`:
- `sample_XX_1.fasta` and `sample_XX_2.fasta`: The simulated reads.
- `sim_tx_info.txt`: Metadata containing transcript IDs, fold changes, and DE status (the "ground truth").
- `sim_rep_info.txt`: Metadata containing sample IDs and group assignments.

## Tips for Success
- **Transcript Length**: By default, `polyester` assigns 300 reads regardless of length. To simulate realistic FPKM where longer transcripts have more reads, calculate `reads_per_transcript` as: `round(coverage * width(fasta) / readlen)`.
- **Memory Management**: For large genomes, subset your FASTA to only the transcripts of interest to save time and disk space.
- **Reproducibility**: Always set a seed using `set.seed()` before running simulations to ensure the random sampling of fragments and errors is reproducible.

## Reference documentation
- [polyester](./references/polyester.md)