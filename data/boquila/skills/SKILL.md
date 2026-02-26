---
name: boquila
description: "Boquila generates synthetic sequencing reads that preserve the nucleotide profile and k-mer frequencies of a provided model input file. Use when user asks to generate synthetic sequencing reads, create control datasets, simulate sequence-specific biases, or match k-mer frequencies from a model file."
homepage: https://github.com/CompGenomeLab/boquila
---


# boquila

## Overview
boquila is a specialized tool for generating synthetic sequencing reads that preserve the nucleotide profile of a provided input file. By matching the k-mer frequencies of model reads, it allows researchers to create control datasets or simulations that account for the inherent biases found in specific sequencing runs or protocols. It supports both FASTA and FASTQ formats and can output read locations in BED format for downstream verification.

## Usage Instructions

### Basic Command Structure
The tool requires a model file (the source of the nucleotide distribution) and either a reference genome with defined regions or an input sequencing file.

```bash
# Standard usage with a reference genome
boquila input_reads.fq --ref ref_genome.fa --regions GRCh38.ron > simulated_reads.fq

# Usage with input sequencing reads (no reference genome needed)
boquila input_reads.fq --inseq inputseq_reads.fq > simulated_reads.fq
```

### Key Parameters and Flags
- `--kmer <INT>`: Sets the k-mer size for frequency calculations (default: 1). Increasing this captures more complex sequence biases.
- `--sens <INT>`: Sensitivity of selection (10-100, default: 20). Higher values improve the similarity of simulated reads to input reads at the cost of linear runtime increases.
- `--seed <INT>`: Sets a random number seed for deterministic, reproducible simulations.
- `--fasta`: Switches both input and output formats to FASTA.
- `--bed <FILE>`: Saves the genomic coordinates of simulated reads in BED6 format to the specified file.
- `--setQual` and `--qual <QUAL>`: Used together to apply a fixed quality score to all simulated reads (e.g., `--setQual --qual I`).

### Common Workflow Patterns

**Simulating from Specific Genomic Regions**
When using a reference genome, you must provide a `.ron` file defining the regions from which reads should be sampled.
```bash
boquila model.fq --ref hg38.fa --regions GRCh38.ron > output.fq
```

**Handling FASTA Input Sequencing**
If your input sequencing reads (used as the source for simulation) are in FASTA format while the model is FASTQ:
```bash
boquila model.fq --inseq input.fa --inseqFasta > output.fq
```

**Generating Reproducible Control Sets**
Always use a seed when generating data for publications or comparative benchmarks.
```bash
boquila model.fq --ref ref.fa --regions regions.ron --seed 42 --sens 50 > control_reads.fq
```

## Expert Tips
- **Sensitivity Tuning**: If your model reads have highly skewed nucleotide distributions at specific positions, increase `--sens` to 50 or higher to ensure the simulator can find matching sequences in the reference.
- **K-mer Selection**: While the default k-mer size is 1, using `--kmer 2` or `--kmer 3` is often more effective for capturing sequence-specific biases related to library preparation or motif-specific sequencing errors.
- **Output Redirection**: boquila writes reads to `stdout`. Always redirect to a file or pipe into a compressor (e.g., `| gzip > out.fq.gz`) to save disk space.
- **Quality Scores**: By default, boquila attempts to preserve quality scores if the input is FASTQ. If you need a "clean" run with uniform quality, use the `--setQual` flag.

## Reference documentation
- [boquila Overview](./references/anaconda_org_channels_bioconda_packages_boquila_overview.md)
- [boquila GitHub Repository](./references/github_com_CompGenomeLab_boquila.md)