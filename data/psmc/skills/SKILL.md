---
name: psmc
description: PSMC reconstructs historical population size fluctuations by analyzing the density of heterozygous sites in a diploid genome. Use when user asks to estimate effective population size history, model demographic changes from a single genome, or perform Markovian coalescent inference.
homepage: https://github.com/lh3/psmc
---


# psmc

## Overview
The PSMC skill enables the reconstruction of a population's demographic history by analyzing the density of heterozygous sites across a diploid genome. By modeling the local time to the most recent common ancestor (TMRCA), the tool estimates how the effective population size has fluctuated over hundreds of thousands of years. The workflow typically involves converting a diploid consensus sequence into a binned format, running the Markovian coalescent inference, and scaling the results using specific mutation rates and generation times.

## Core Workflow

### 1. Input Preparation
PSMC requires a diploid consensus sequence in FASTQ format. This is typically generated from BAM files using `samtools` and `bcftools`.
```bash
# Example of generating the required diploid consensus
samtools mpileup -C50 -uf ref.fa aln.bam | bcftools view -c - | vcfutils.pl vcf2fq -d 10 -D 100 | gzip > diploid.fq.gz
```
*Note: Set `-d` (minimum depth) to ~1/3 of average depth and `-D` (maximum depth) to ~2x average depth.*

### 2. Format Conversion
Transform the FASTQ sequence into the `.psmcfa` format, which bins the genome (default bin size = 100bp).
```bash
utils/fq2psmcfa -q20 diploid.fq.gz > diploid.psmcfa
```

### 3. Population Size Inference
Run the main `psmc` program. The `-p` option is critical as it defines the distribution of free parameters across atomic time intervals.
```bash
psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o diploid.psmc diploid.psmcfa
```
*   `-p`: Pattern of parameters (e.g., `"4+25*2+4+6"` means 64 atomic intervals grouped into 28 parameters).
*   `-N`: Maximum number of iterations (default 25).
*   `-t`: Initial value of $\theta/\rho$ (default 15).

### 4. Visualization and Scaling
Convert the raw output into a readable history or plot.
```bash
# Generate plot (requires Perl and Gnuplot)
utils/psmc_plot.pl -u 2.5e-8 -g 25 output_prefix diploid.psmc
```
*   `-u`: Mutation rate per site per generation.
*   `-g`: Generation time in years.

## Expert Tips and Best Practices

### Parameter Tuning (`-p`)
The pattern provided to `-p` should be chosen so that at least ~10 recombinations occur within each parameter interval after 20 iterations. Using too many parameters on a small dataset or low-heterozygosity genome can lead to overfitting (jagged plots).

### Bootstrapping for Confidence Intervals
To assess the reliability of the $N_e$ estimates, perform bootstrapping by splitting the genome into segments:
1.  Split the input: `utils/splitfa diploid.psmcfa > split.psmcfa`
2.  Run multiple psmc instances with the `-b` flag.
3.  Combine results: `cat diploid.psmc round-*.psmc > combined.psmc`
4.  Plot: `utils/psmc_plot.pl combined combined.psmc`

### Handling Low Coverage
Low sequencing depth leads to the random loss of heterozygotes (False Negatives). This causes an artificial drop in inferred population size in recent time.
*   If the False Negative Rate (FNR) is known, use the `-M` flag in `psmc_plot.pl` to correct the visualization.
*   Example: `psmc_plot.pl -M "sample1=0.1" prefix sample1.psmc` (corrects for 10% missed hets).

### Scaling Math
If plotting manually, remember the output is scaled to $2N_0$:
*   $N_0 = \theta_0 / (4\mu s)$ (where $s$ is bin size, usually 100).
*   $T_k = 2N_0 \times t_k$ (Time in generations).
*   $N_k = N_0 \times \lambda_k$ (Effective population size).

## Reference documentation
- [GitHub Repository for PSMC](./references/github_com_lh3_psmc.md)
- [Bioconda PSMC Package Overview](./references/anaconda_org_channels_bioconda_packages_psmc_overview.md)