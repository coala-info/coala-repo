---
name: smcpp
description: SMC++ is a powerful tool for inferring population history from whole-genome sequence data.
homepage: https://github.com/popgenmethods/smcpp
---

# smcpp

## Overview
SMC++ is a powerful tool for inferring population history from whole-genome sequence data. It uniquely combines the Sequentially Markovian Coalescent (SMC) with information from the site frequency spectrum (SFS), allowing it to scale to much larger sample sizes than previous methods like PSMC. The tool is primarily used to estimate how a population's size has changed over thousands of generations and to determine when two populations diverged.

## Core Workflow

### 1. Data Preparation (vcf2smc)
Convert VCF data into the SMC++ native format. This must be done for each contig (chromosome) independently.

```bash
smc++ vcf2smc input.vcf.gz output.chr1.smc.gz chr1 PopName:Sample1,Sample2,Sample3
```

**Key Parameters:**
- **Distinguished Lineages (`-d`)**: Crucial for the SMC++ model. It specifies the samples used to form the "distinguished pair." For unphased data, specify the same individual twice (e.g., `-d Sample1 Sample1`).
- **Masking (`--mask`)**: Use a BED file to mask regions with poor mappability or centromeres. This prevents long runs of missing data from being misinterpreted as population bottlenecks.
- **Missing Cutoff (`-c`)**: Automatically treats runs of homozygosity longer than the specified base pairs as missing data.

### 2. Parameter Estimation (estimate)
Fit the demographic model to the prepared SMC files.

```bash
smc++ estimate -o analysis_dir/ 1.25e-8 output.chr*.smc.gz
```

- **Mutation Rate**: The first positional argument (e.g., `1.25e-8`) is the per-generation mutation rate.
- **Input Files**: Pass all contig files generated in the previous step to get a genome-wide estimate.
- **Output**: The primary result is `model.final.json`.

### 3. Visualization (plot)
Generate a plot of the effective population size ($N_e$) over time.

```bash
smc++ plot plot.pdf analysis_dir/model.final.json
```

- Use the `-g` flag to specify generation time in years if you want the x-axis in years instead of generations.
- Use `-c` to add a CSV output of the plotted data for custom graphing.

### 4. Population Splits (split)
To estimate the divergence time between two populations, use the `split` command after running `estimate` on each population individually.

```bash
smc++ split -o split_dir/ pop1_model.json pop2_model.json output.joint.chr*.smc.gz
```

## Expert Tips and Best Practices

- **Docker Usage**: Since Anaconda support is discontinued, use the official Docker image for the most stable environment: `docker run --rm -v $PWD:/mnt terhorst/smcpp:latest [command]`.
- **Sample Size**: While SMC++ can handle many samples, the "distinguished lineages" provide most of the information about deep time, while the remaining samples (the "SFS" component) provide information about recent history.
- **Unphased Data**: SMC++ is robust to unphased data. When using unphased data, ensure you specify a single individual for the distinguished lineage (`-d Sample1 Sample1`) to avoid phase-switch errors.
- **Memory Management**: For very large datasets, processing contigs in parallel during the `vcf2smc` stage is highly recommended.
- **Missing Data**: Always provide a mask file if possible. Without it, SMC++ cannot distinguish between a true lack of variation (homozygosity) and regions where no SNPs were called (missing data), which can severely bias $N_e$ estimates.

## Reference documentation
- [SMC++ GitHub Repository](./references/github_com_popgenmethods_smcpp.md)
- [SMC++ Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_smcpp_overview.md)