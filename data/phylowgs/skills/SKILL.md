---
name: phylowgs
description: PhyloWGS reconstructs the clonal evolutionary structure of tumors by integrating mutation frequencies with copy number data. Use when user asks to infer tumor phylogeny, resolve intratumor heterogeneity, or model clonal architectures from genomic sequencing data.
homepage: https://github.com/morrislab/phylowgs
metadata:
  docker_image: "quay.io/biocontainers/phylowgs:20181105--py27ha7db03b_3"
---

# phylowgs

## Overview
PhyloWGS is a specialized genomic analysis tool designed to resolve the intratumor heterogeneity of cancer samples. It uses a Bayesian approach to integrate variant allele frequencies from mutations with local copy number data, allowing it to model the evolutionary "tree" of a tumor. By sampling various possible tree structures through Markov Chain Monte Carlo (MCMC) simulations, it provides a posterior distribution of clonal architectures, helping researchers understand how a tumor has progressed over time.

## Installation and Setup
Before running the Python scripts, the C++ MCMC kernels must be compiled:
```bash
g++ -o mh.o -O3 mh.cpp util.cpp `gsl-config --cflags --libs`
```
Ensure Python 2.7, NumPy, SciPy, ETE2, and the GNU Scientific Library (GSL) are available in the environment.

## Input Data Preparation
PhyloWGS requires two specific tab-delimited input files.

### 1. SSM Data (`ssm_data.txt`)
| Column | Description |
| :--- | :--- |
| **id** | Identifier starting at `s0`, `s1`, etc. |
| **gene** | String identifier (e.g., gene name or `chr_pos`). |
| **a** | Number of reference-allele reads. |
| **d** | Total number of reads at the locus. |
| **mu_r** | Expected reference allele fraction from reference population (typically `0.999`). |
| **mu_v** | Expected reference allele fraction from variant population (typically `0.499` for diploid). |

### 2. CNV Data (`cnv_data.txt`)
*   **Format**: `cnv_id`, `a` (ref reads), `d` (total reads), and `ssms`.
*   **SSMs Column**: Semicolon-separated triplets of `SSM_ID,maternal_CN,paternal_CN`.
*   **Note**: If no CNVs exist, create an empty file using `touch cnv_data.txt`.

## Execution Patterns

### Recommended: Multiple MCMC Chains
To ensure better convergence and a more accurate posterior distribution, always use `multievolve.py`. Set `--num-chains` to match the available CPU cores.

```bash
# Standard production run
python2 multievolve.py --num-chains 8 --ssms ssm_data.txt --cnvs cnv_data.txt

# Quick test run (low quality, for pipeline validation only)
python2 multievolve.py --num-chains 4 --ssms ssm_data.txt --cnvs cnv_data.txt --burnin-samples 1 --mcmc-samples 1
```

### Reproducibility
PhyloWGS writes the random seed to `random_seed.txt`. To replicate a specific run, use:
```bash
python2 multievolve.py --random-seed <integer> --ssms ssm_data.txt --cnvs cnv_data.txt
```

## Processing Results
After the inference completes, use `write_results.py` to convert the `trees.zip` output into JSON formats compatible with the PhyloWGS visualizer.

```bash
python2 write_results.py <dataset_name> ./trees.zip <summary_out.json.gz> <mutlist_out.json.gz> <mutass_out.zip>
```

## Expert Tips
*   **Chain Convergence**: For publication-quality results, use at least the default 1000 burn-in and 2500 MCMC samples.
*   **SSM Naming**: When running `write_results.py`, use the `--include-ssm-names` flag if you need the original gene/identifier strings to appear in the visualization, though this increases file size.
*   **Resource Management**: `multievolve.py` spawns separate processes for each chain. Ensure the system has sufficient memory (RAM) to support the number of chains specified, especially with high mutation counts.



## Subcommands

| Command | Description |
|---------|-------------|
| evolve.py | Run PhyloWGS to infer subclonal composition from SSMs and CNVs |
| write_results.py | Write JSON files describing trees |

## Reference documentation
- [PhyloWGS GitHub Repository](./references/github_com_morrislab_phylowgs.md)