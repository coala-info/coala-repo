---
name: probabilistic2020
description: Probabilistic 20/20 identifies cancer driver genes by performing gene-specific Monte Carlo simulations to distinguish oncogenic patterns from background mutations. Use when user asks to identify driver genes, distinguish passenger mutations, or find significant codon-level clustering in mutation data.
homepage: https://github.com/KarchinLab/probabilistic2020
---

# probabilistic2020

## Overview
Probabilistic 20/20 is a bioinformatics tool used to distinguish cancer driver genes from passenger mutations through a randomization-based statistical test. It employs Monte Carlo simulations that are performed within each individual gene, rather than against a global background mutation rate. This gene-specific approach accounts for factors such as gene length, mutation context, and codon bias. It is highly effective for both whole-exome sequencing (WES) and targeted sequencing panels, providing a robust method for identifying genes with significant oncogenic or tumor-suppressive mutational patterns.

## Installation and Setup
The tool can be installed via Conda or pip. It is recommended to use a Python 3.6+ environment.

```bash
# Via Conda
conda install -c bioconda probabilistic2020

# Via pip
pip install probabilistic2020
```

## Common CLI Patterns
The primary interface is the `probabilistic2020` command. For specific codon-level clustering analysis, the `hotmaps1d` command is used.

### Identifying Driver Genes
To run the main statistical test for oncogenes (OG) and tumor suppressor genes (TSG):
```bash
probabilistic2020 [options] -i <mutations.maf> -r <reference_genome.fa>
```

### Codon Clustering with HotMAPS 1D
To find specific codons where missense mutations are significantly clustered:
```bash
hotmaps1d [options] -i <mutations.maf>
```

## Tool-Specific Best Practices
- **Handle Missing Silent Mutations**: If your input mutation data (e.g., a MAF file) does not include silent mutations, you must use the `--drop-silent` flag during simulations. Failing to do so will bias the background distribution and lead to inaccurate p-values.
- **Targeted Sequencing Panels**: When analyzing data from targeted panels rather than whole exomes, use the option to restrict simulated indels and mutations only to the genes included in your panel. This ensures the null distribution is representative of the targeted regions.
- **Context-Specific Simulations**: The tool's strength lies in its Monte Carlo approach. Ensure your reference genome and mutation context (e.g., trinucleotide context) are correctly specified to allow the tool to accurately simulate the expected mutational burden.
- **Inactivating Mutations**: For TSG discovery, the tool looks for an abnormally high proportion of nonsense, frameshift, and splice-site mutations. Ensure these are correctly annotated in your input file.
- **Clustering Significance**: When using `hotmaps1d`, note that it ignores frameshift mutations by default to focus on the spatial clustering of missense variants in the protein sequence.

## Expert Tips
- **Gene-Level Independence**: Because simulations are performed per gene, you can parallelize tasks across different gene sets if processing extremely large cohorts, though the tool is generally optimized for standard exome sizes.
- **Version Compatibility**: If you encounter installation issues on newer systems (e.g., macOS Mojave or later), ensure `pysam` is updated to version `0.9.0` or higher.
- **Statistical Validity**: The randomization test avoids building a background distribution based on other genes, which makes it less susceptible to artifacts caused by highly mutated "passenger" genes (like TTN) that often plague other driver-calling methods.



## Subcommands

| Command | Description |
|---------|-------------|
| probabilistic2020 hotmaps1d | Find codons with significant clustering of missense mutations in sequence. Evaluates for a higher ammount of clustering of missense mutations. |
| probabilistic2020 oncogene | Find statsitically significant oncogene-like genes. Evaluates clustering of missense mutations and high in silico pathogenicity scores for missense mutations. |
| probabilistic2020 tsg | Find statistically significant Tumor Suppressor-like genes. Evaluates for a higher proportion of inactivating mutations than expected. |

## Reference documentation
- [Probabilistic 20/20 GitHub Repository](./references/github_com_KarchinLab_probabilistic2020.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_probabilistic2020_overview.md)