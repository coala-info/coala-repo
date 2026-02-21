---
name: phylowgs
description: PhyloWGS is a computational tool designed to analyze the clonal structure of tumors.
homepage: https://github.com/morrislab/phylowgs
---

# phylowgs

## Overview
PhyloWGS is a computational tool designed to analyze the clonal structure of tumors. By integrating point mutations and copy number changes, it estimates the number of subclones, their cellular prevalence, and the evolutionary relationships between them. This skill provides the procedural knowledge required to run the Python/C++ implementation, including data formatting, running multiple MCMC chains for better posterior approximation, and generating standardized JSON outputs for downstream analysis.

## Installation and Setup
PhyloWGS requires Python 2.7 and a compiled C++ component.
1. **Dependencies**: Ensure `numpy`, `scipy`, and `ete2` are installed for Python 2.
2. **Compilation**: Compile the Metropolis-Hastings module:
   ```bash
   g++ -o mh.o -O3 mh.cpp util.cpp `gsl-config --cflags --libs`
   ```

## Input Data Preparation
PhyloWGS requires two tab-delimited files. If no CNVs are present, the CNV file must exist but be empty.

### SSM Data (`ssm_data.txt`)
| Column | Description |
| :--- | :--- |
| `id` | Identifier starting at `s0`, `s1`, etc. |
| `gene` | Variant identifier (e.g., `chr_pos`). |
| `a` | Number of reference-allele reads. |
| `d` | Total number of reads at the locus. |
| `mu_r` | Expected reference allele frequency in reference population (typically `0.999`). |
| `mu_v` | Expected reference allele frequency in variant population (typically `0.499` for diploid). |

### CNV Data (`cnv_data.txt`)
| Column | Description |
| :--- | :--- |
| `cnv` | Identifier starting at `c0`, `c1`, etc. |
| `a` | Reference reads covering the CNV. |
| `d` | Total reads covering the CNV. |
| `ssms` | Semicolon-separated triplets: `SSM_ID,maternal_CN,paternal_CN`. |

## Execution Patterns

### Recommended: Multi-chain MCMC
Running multiple chains improves the approximation of the posterior distribution. Set `--num-chains` to match available CPU cores.
```bash
python2 multievolve.py --num-chains 4 --ssms ssm_data.txt --cnvs cnv_data.txt
```

### Fast Testing
To verify the pipeline without waiting for full convergence, reduce samples:
```bash
python2 multievolve.py --num-chains 4 --ssms ssm_data.txt --cnvs cnv_data.txt --burnin-samples 1 --mcmc-samples 1
```

### Deterministic Runs
PhyloWGS writes the seed to `random_seed.txt`. To replicate a specific run:
```bash
python2 evolve.py --random-seed <integer> ssm_data.txt cnv_data.txt
```

## Processing Results
After evolution, use `write_results.py` to generate files for the PhyloWGS visualizer.
```bash
python2 write_results.py <dataset_name> ./trees.zip <output_summ.json.gz> <output_muts.json.gz> <output_mutass.zip>
```

## Expert Tips
- **Memory Management**: For datasets with an excessive number of mutations, execution speed will decrease significantly. Consider filtering mutations to high-confidence or driver variants if the run exceeds 3 days.
- **Tumor Purity**: If you have independent tumor purity estimates, ensure they are reflected in the `mu_v` calculations or used to validate the cellular prevalence of the trunk (clonal) node.
- **WES Data**: While designed for WGS, PhyloWGS can be used for Whole Exome Sequencing (WES) data, provided that CNV calls are adjusted for the decreased genomic coverage.

## Reference documentation
- [PhyloWGS GitHub Repository](./references/github_com_morrislab_phylowgs.md)
- [Bioconda PhyloWGS Package](./references/anaconda_org_channels_bioconda_packages_phylowgs_overview.md)