---
name: symbiontscreener
description: Symbiont-Screener is a specialized bioinformatics tool designed for reference-free sequence separation.
homepage: https://github.com/BGI-Qingdao/Symbiont-Screener
---

# symbiontscreener

## Overview

Symbiont-Screener is a specialized bioinformatics tool designed for reference-free sequence separation. It utilizes a trio-based screening model to distinguish high-confidence host long reads from non-host DNA, such as symbionts or environmental contaminants. By analyzing k-mer or strobemer frequencies across a family trio, the tool overcomes the challenges of low sequencing accuracy in long-read data, making it ideal for studying non-model organisms where reference genomes are unavailable.

## Core Workflows

The tool provides four primary "easy-to-use" pipelines located in the `easy-to-use_pipelines/` directory.

### Recommended Mode: Strobemer with Clustering
This mode is generally recommended for the best balance of sensitivity and specificity in long-read data.
```bash
./Symbiont-Screener/easy-to-use_pipelines/sysc_strobmercluster_mode.sh \
  --maternal maternal_reads.fasta.gz \
  --paternal paternal_reads.fasta.gz \
  --offspring offspring_long_reads.fasta.gz
```

### Alternative Modes
- **Strobemer (No Clustering):** `sysc_strobmer_mode.sh` (Faster, less refined)
- **K-mer with Clustering:** `sysc_kmercluster_mode.sh` (Traditional k-mer approach)
- **K-mer (No Clustering):** `sysc_kmer_mode.sh` (Basic k-mer filtering)

## Advanced Usage with `sysc`

For granular control, use the `sysc` main entry point. The process is divided into three main stages:

1.  **Build (`build_s40` / `build_k21`):** Constructs the frequency tables from parental NGS data.
2.  **Density & Trio Result (`density_s40` / `trio_result_s40`):** Calculates read density and performs the initial trio-based screening.
3.  **Clustering (`cluster_s40` / `consensus_cluster_s40`):** Refines the separation using unsupervised clustering.

### Key Parameters for `build`
- `--auto_bounds (0/1)`: Automatically calculates lower and upper frequency bounds (Default: 1).
- `--m-lower` / `--p-lower`: Manually assign lower bounds to ignore low-frequency k-mers (noise).
- `--m-upper` / `--p-upper`: Manually assign upper bounds to ignore high-frequency k-mers (repeats).
- `--thread`: Set the number of CPU threads (Default: 8).

## Expert Tips and Best Practices

- **Input Formats:** The tool accepts FASTA/FASTQ formats. Gzip files are supported but must end in `.gz`.
- **Strobemer vs. K-mer:** Use strobemer modes (`s40`) for long reads with higher error rates, as they are more robust to substitutions and indels than traditional k-mers.
- **Memory Management:** Use the `--size` parameter in the build step to initialize the Jellyfish hash table (e.g., `--size 10GB`) if working with large genomes to prevent mid-run allocation issues.
- **Custom Pipelines:** If the standard pipelines are too rigid, chain the `sysc` actions manually. This allows you to adjust parameters like clustering epsilon or k-mer length that are hard-coded in the shell scripts.
- **Environment:** Ensure `numpy`, `pandas`, `sklearn`, and `plotly` are installed in your Python environment, as the clustering and visualization components depend on them.

## Reference documentation
- [Symbiont-Screener Main Documentation](./references/github_com_BGI-Qingdao_Symbiont-Screener.md)
- [Pipeline Workflow Details](./references/github_com_BGI-Qingdao_Symbiont-Screener_tree_master_easy-to-use_pipelines.md)