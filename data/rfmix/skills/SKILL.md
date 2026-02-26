---
name: rfmix
description: "RFMix performs local ancestry deconvolution to identify the ancestral background of genomic segments in admixed individuals. Use when user asks to infer local ancestry, perform ancestry deconvolution, or assign ancestral origins to chromosomal segments using phased VCF data."
homepage: https://github.com/slowkoni/rfmix
---


# rfmix

## Overview
RFMix (Version 2) is a powerful tool for local ancestry deconvolution, which identifies the specific ancestral background of every segment along a chromosome in an admixed individual. It utilizes a discriminative approach, combining Random Forest classifiers with a Conditional Random Field to provide high-resolution ancestry assignments. It is the standard choice for researchers working with human or non-human populations where individuals have inherited DNA from two or more distinct ancestral groups.

## Core CLI Usage

The primary command for running the inference is `rfmix`.

### Basic Command Pattern
```bash
rfmix -f query.vcf -r reference.vcf -m sample_map.txt -g genetic_map.txt -o output_basename --chromosome=22
```

### Required Inputs
*   **-f (Query VCF):** Phased VCF file containing the admixed individuals.
*   **-r (Reference VCF):** Phased VCF file containing the reference panel individuals.
*   **-m (Sample Map):** A tab-separated file with two columns: [Sample Name] and [Population Name]. This defines which samples in the reference VCF belong to which ancestral group.
*   **-g (Genetic Map):** A file defining the genetic distance (cM) for positions on the chromosome.
*   **-o (Output):** The prefix for all generated output files.

### Key Parameters and Tuning
*   **-e (EM Iterations):** Number of Expectation-Maximization iterations (e.g., `-e 2`). Increasing this can improve accuracy by refining the model based on the query samples themselves.
*   **-n (Terminal Nodes):** Minimum number of samples in a Random Forest leaf node.
*   **--chromosome:** Specify the chromosome being analyzed (must match the VCF headers).
*   **--reanalyze-reference:** Includes reference samples in the output to check for consistency or "purity" of the reference panel.

## Data Preparation Best Practices

1.  **Phasing is Mandatory:** RFMix requires phased haplotypes. Use tools like SHAPEIT or Beagle to phase your data before running RFMix. Unphased data will lead to incorrect ancestry assignments.
2.  **SNP Intersection:** Ensure that the query VCF and reference VCF contain the same set of SNPs. It is often best to filter both files to their intersection before running the tool.
3.  **Genetic Map Format:** The genetic map should typically have three columns: physical position (bp), genetic position (cM), and chromosome. Ensure the physical positions match the coordinate system (e.g., GRCh37 vs. GRCh38) used in your VCFs.
4.  **Reference Panel Balance:** While RFMix is robust, extremely unbalanced reference panels (e.g., 1000 samples for Pop A and 10 samples for Pop B) can bias results. Try to use representative and relatively balanced panels where possible.

## Interpreting Outputs

RFMix generates several files based on the output basename:

*   **[basename].fb.tsv (Forward-Backward):** Contains the posterior probabilities for each ancestry at each genomic window (CRF point). This is the most detailed output.
    *   The first line specifies the order of subpopulations.
    *   Each genotype has two haplotypes; the number of probability columns is `2 * (number of populations) * (number of genotypes)`.
*   **[basename].msp.tsv (Most Specific Path):** Provides the most likely ancestry assignment for each segment. This is easier to use for visualization (e.g., karyogram plotting).
*   **[basename].sis.tsv (Sister Haplotypes):** Information regarding the specific haplotypes.

## Expert Tips
*   **Memory Management:** For large datasets or high-density SNP arrays, RFMix can be memory-intensive. Process one chromosome at a time to stay within typical HPC memory limits.
*   **CRF Weight Tuning:** If the ancestry assignments look too "choppy" (too many switches) or too "smooth" (missing real switches), consider adjusting the CRF weight (`-c`).
*   **Missing Data:** RFMix handles some missing data, but high rates of missingness in the reference panel can degrade performance. Impute missing genotypes if possible before phasing.

## Reference documentation
- [RFMix GitHub Repository](./references/github_com_slowkoni_rfmix.md)
- [Bioconda RFMix Overview](./references/anaconda_org_channels_bioconda_packages_rfmix_overview.md)