---
name: mquad
description: MQuad (Mitochondrial Mutation Mixture Model) is a specialized tool designed to identify high-quality mitochondrial variants that are informative for clonal substructure analysis.
homepage: https://github.com/aaronkwc/MQuad
---

# mquad

## Overview
MQuad (Mitochondrial Mutation Mixture Model) is a specialized tool designed to identify high-quality mitochondrial variants that are informative for clonal substructure analysis. It uses a binomial mixture model to evaluate the heteroplasmy of mtDNA variants across a population of single cells. By calculating a "deltaBIC" score for each variant, MQuad helps researchers filter out noisy background mutations and retain only those that provide meaningful signal for downstream tools like vireoSNP.

## Installation
MQuad can be installed via pip or conda:

```bash
# Via Pip
pip install -U mquad

# Via Conda
conda install bioconda::mquad
```

## Common CLI Patterns

### 1. Processing cellSNP Output (Recommended)
If you have already run `cellSNP` or `cellsnp-lite`, point MQuad to the output directory containing the AD and DP sparse matrices.
```bash
mquad -c /path/to/cellsnp_output -o /path/to/mquad_output -p 20
```

### 2. Processing VCF Files
Use this mode if your variants are stored in a VCF format.
```bash
mquad --vcfData input_variants.vcf.gz -o /path/to/mquad_output -p 10
```

### 3. Direct Matrix Input
If you have standalone Allelic Depth (AD) and Total Depth (DP) matrices:
```bash
mquad -m cellSNP.tag.AD.mtx,cellSNP.tag.DP.mtx -o /path/to/mquad_output
```

### 4. Batch Mode for Large Datasets
For large-scale binomial modeling, use batch mode to optimize performance:
```bash
mquad --vcfData input.vcf.gz -o output_dir --batchFit 1 --batchSize 5
```

## Expert Tips and Best Practices

### Adjusting Depth Thresholds
The default minimum depth (`--minDP`) is 10, which is optimized for Smart-seq2. 
- **For Droplet-based data (10x Chromium, scATAC-seq):** Lower the threshold to `--minDP 5` or lower to avoid errors during model fitting due to lower sequencing depth per cell.

### Interpreting Results
- **deltaBIC:** This is the primary metric for informativeness. A higher deltaBIC indicates a variant is more likely to be a true biological signal rather than noise.
- **BIC_params.csv:** This is the main output file. Sort by `deltaBIC` to find the most informative variants.
- **passed_ad.mtx / passed_dp.mtx:** These filtered matrices contain only the variants that passed MQuad's internal thresholds and should be used for downstream clonal assignment.

### Pipeline Integration
MQuad is typically the second step in a three-part workflow:
1. **Upstream:** `cellSNP-lite` (to pileup mtDNA variants from BAM files).
2. **Processing:** `MQuad` (to identify informative variants).
3. **Downstream:** `vireoSNP` (to assign cells to clones based on the MQuad-filtered variants).

## Reference documentation
- [MQuad GitHub Repository](./references/github_com_single-cell-genetics_MQuad.md)
- [Bioconda MQuad Overview](./references/anaconda_org_channels_bioconda_packages_mquad_overview.md)