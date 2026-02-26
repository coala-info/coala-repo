---
name: pyseer
description: pyseer is a Python framework for performing microbial genome-wide association studies using k-mers, unitigs, or SNPs to identify genetic variants associated with phenotypes. Use when user asks to perform bacterial GWAS, account for population structure in microbial associations, run linear mixed models on pangenomes, or identify predictive features using elastic net.
homepage: https://github.com/mgalardini/pyseer
---


# pyseer

## Overview

`pyseer` is a comprehensive Python-based framework for microbial pangenome-wide association studies. It is specifically optimized for bacterial samples, which often exhibit high genetic variability and strong population structure. By using k-mers or unitigs as genetic variants, `pyseer` can identify associations without being restricted to a reference genome's SNP calls. It provides multiple statistical models—including fixed effects, Linear Mixed Models (LMM), and Elastic Net—to balance discovery power with the need to minimize false positives caused by clonal descent.

## Installation

The recommended installation method is via bioconda:

```bash
conda install bioconda::pyseer
```

## Common CLI Patterns

### Basic K-mer Association (Fixed Effects)
Use this for initial discovery when you have a distance matrix to account for population structure.

```bash
pyseer --phenotypes phenotypes.tsv \
       --kmers kmers.gz \
       --distances structure.tsv \
       --min-af 0.01 \
       --max-af 0.99 \
       --cpu 16 \
       --filter-pvalue 1E-8 > output_hits.txt
```

### Linear Mixed Model (LMM)
Use the LMM approach for more robust control of population structure. This requires a kinship matrix (similarity matrix) instead of a distance matrix.

```bash
# First, generate a similarity matrix if you only have distances
python similarity-runner.py distances.tsv > kinship.tsv

# Run pyseer with LMM
pyseer --lmm --phenotypes phenotypes.tsv \
       --kmers kmers.gz \
       --similarity kinship.tsv \
       --cpu 16 > lmm_results.txt
```

### Elastic Net (Whole-Genome Regression)
Use Elastic Net for predicting phenotypes or when you want to identify a sparse set of predictive features across the entire pangenome.

```bash
pyseer --wg enet --phenotypes phenotypes.tsv \
       --kmers kmers.gz \
       --folds 10 \
       --cpu 16 > enet_results.txt
```

### Post-processing: Annotating Hits
Significant k-mers need to be mapped back to a reference genome or assembly to understand their biological context.

```bash
python annotate_hits_pyseer-runner.py output_hits.txt \
                                      reference_genome.fasta \
                                      annotations.gff \
                                      annotated_output.txt
```

## Expert Tips and Best Practices

- **Variant Filtering**: Always use `--min-af` (minimum allele frequency) and `--max-af` (maximum allele frequency) to filter out variants that lack statistical power or are nearly fixed, which reduces the multiple testing burden.
- **Population Structure**: For bacterial GWAS, accounting for population structure is mandatory. If your QQ-plot shows significant inflation, switch from the fixed-effects model (`--distances`) to the LMM (`--lmm`) or increase the number of dimensions used in the distance matrix.
- **Performance**: `pyseer` is computationally intensive. Always utilize the `--cpu` flag to enable multithreading, especially when processing millions of k-mers.
- **Input Formats**: While k-mers are the default, `pyseer` also supports unitigs (from BCALM2) and VCF files for SNP-based analysis. Unitigs are often preferred over raw k-mers as they reduce redundancy while maintaining the ability to capture structural variants.
- **Visualizing Results**: Use the `scree_plot_pyseer` script to determine the appropriate number of MDS components to include when using a distance matrix for population control.

## Reference documentation

- [pyseer GitHub Repository](./references/github_com_mgalardini_pyseer.md)
- [pyseer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pyseer_overview.md)