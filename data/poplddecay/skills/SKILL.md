---
name: poplddecay
description: PopLDdecay is a high-performance tool designed for rapid linkage disequilibrium (LD) decay analysis.
homepage: https://github.com/BGI-shenzhen/PopLDdecay
---

# poplddecay

## Overview
PopLDdecay is a high-performance tool designed for rapid linkage disequilibrium (LD) decay analysis. It processes Variant Call Format (VCF) files or genotype data to produce LD statistics and high-quality decay plots. Unlike legacy tools, it is optimized for speed and memory efficiency, supporting compressed data formats to handle the massive datasets typical of modern population studies.

## Core CLI Usage

### Basic LD Calculation
The primary command calculates LD statistics from a VCF file.
```bash
PopLDdecay -InVCF SNP.vcf.gz -OutStat LDdecay.stat.gz
```

### Subpopulation Analysis
To calculate LD decay for a specific group within a larger VCF, provide a text file containing the sample names (one per line).
```bash
PopLDdecay -InVCF SNP.vcf.gz -OutStat GroupA.stat.gz -SubPop GroupA_sample.list
```

### Working with Plink Files
PopLDdecay requires a genotype format for Plink data. Convert the files first using the included utility script.
```bash
# 1. Convert Plink to Genotype format
perl bin/mis/plink2genotype.pl -inPED in.ped -inMAP in.map -outGenotype out.genotype

# 2. Run LD analysis
PopLDdecay -InGenotype out.genotype -OutStat LDdecay.stat.gz
```

## Filtering and Parameters
Fine-tune the analysis using these common filters:
*   `-MaxDist <int>`: Maximum distance between two SNPs in kb (Default: 300).
*   `-MAF <float>`: Minimum minor allele frequency (Default: 0.005).
*   `-Miss <float>`: Maximum ratio of missing alleles (Default: 0.25).
*   `-Het <float>`: Maximum ratio of heterozygous alleles (Default: 0.88).
*   `-OutType <int>`: 
    *   `1`: $r^2$ result (Default).
    *   `2`: $r^2$ and $D'$ results.
    *   `3`: Pairwise LD output.

## Visualization

### Single Population Plot
Generate a decay curve for one population.
```bash
perl bin/Plot_OnePop.pl -inFile LDdecay.stat.gz -output FigPrefix
```

### Multiple Population Comparison
To compare multiple populations on a single graph, create a list file where each line contains the path to the result file and the population ID: `[Path] [ID]`.
```bash
perl bin/Plot_MutiPop.pl -inList Pop.ResultPath.list -output ComparisonFig
```

### Multi-Chromosome Analysis
If you have separate results for different chromosomes, use a list file containing the paths to all chromosome result files.
```bash
perl bin/Plot_OnePop.pl -inList Chr.ResultPath.List -output MultiChrFig
```

## Expert Tips
*   **Storage Efficiency**: Always use `.gz` extensions for input and output. PopLDdecay handles Gzip compression natively, which is critical for large-scale VCF files.
*   **Performance**: If the tool fails to link during a manual build, ensure the `zlib` development libraries are installed on your system.
*   **EHH Analysis**: Use the `-EHH <str>` flag to run Extended Haplotype Homozygosity (EHH) region decay by specifying the start site.
*   **SNP Verification**: Use `-OutFilterSNP` to output the final list of SNPs that passed all filters and were used in the calculation for downstream validation.

## Reference documentation
- [PopLDdecay GitHub Repository](./references/github_com_BGI-shenzhen_PopLDdecay.md)
- [PopLDdecay Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_poplddecay_overview.md)