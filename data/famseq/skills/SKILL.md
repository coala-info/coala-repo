---
name: famseq
description: FamSeq improves variant calling accuracy by incorporating pedigree information and shared genetic data from family members. Use when user asks to refine VCF files using family relationships, calculate posterior probabilities for rare germline mutations, or perform likelihood-based variant calling for pedigrees.
homepage: http://bioinformatics.mdanderson.org/main/FamSeq
metadata:
  docker_image: "quay.io/biocontainers/famseq:1.0.3--h9948957_8"
---

# famseq

## Overview
The `famseq` tool enhances variant calling by leveraging the shared genetic information within a pedigree. While standard callers treat individuals independently, `famseq` uses the entire family's raw measurements to provide a more accurate posterior probability of a variant. It is particularly effective for identifying rare germline mutations and handles autosomes, chromosome X, and de novo mutation events.

## Core Workflows

### 1. VCF-based Variant Calling
The most common workflow involves refining an existing VCF file containing multiple family members.

```bash
FamSeq vcf -vcfFile input.vcf -pedFile input.ped -output output.vcf -v
```
*   **-v**: Recommended to output only non-reference genotypes (reduces file size).
*   **-a**: Use if you need to preserve all positions, including indels, to match the input VCF line-for-line.

### 2. Likelihood-based (LK) Calling
Use this when you have raw genotype likelihoods instead of a VCF.

```bash
FamSeq LK -lkFile lk.txt -pedFile input.ped -output output.txt -lkType PS
```
*   **-lkType**: Specify the scale of your input likelihoods: `n` (normal), `log10`, `ln`, or `PS` (Phred-scaled).

### 3. Pedigree (.ped) File Requirements
The `.ped` file must contain five columns:
1.  **Individual ID**: Unique integer > 0.
2.  **Mother's ID**: ID of mother (0 if founder).
3.  **Father's ID**: ID of father (0 if founder).
4.  **Gender**: 1 for male, 2 for female.
5.  **Sample Name**: Must match the sample name in the VCF header. Use `NA` for family members who were not sequenced but are needed to complete the pedigree structure.

## Expert Tips and Parameters

### Algorithm Selection (`-method`)
Choose the method based on the size and complexity of the family:
*   **Method 1 (Bayesian Network)**: Default. Best for small families (size < 7).
*   **Method 2 (Elston-Stewart)**: Best for large families (> 7 members) without loops.
*   **Method 3 (MCMC)**: Use for very large or complex pedigrees with loops.

### Tuning Sensitivity
*   **Mutation Rate (`-mRate`)**: Default is `1e-7`. Adjust this if you expect a higher rate of de novo mutations.
*   **Likelihood Ratio Cutoff (`-LRC`)**: Default is `1` (always use pedigree info). Set to a value between 0 and 1 to only apply pedigree-based calling when the single-individual likelihood is ambiguous.
*   **Population Priors**: You can adjust genotype probabilities for known dbSNP positions (`-genoProbK`) vs. novel positions (`-genoProbN`).

### GPU Acceleration
If the `FamSeqCuda` binary is available, replace `FamSeq` with `FamSeqCuda` in your commands to significantly speed up processing for large datasets.

## Reference documentation
- [FamSeq Overview and Documentation](./references/bioinformatics_mdanderson_org_public-software_famseq.md)
- [FamSeq Bioconda Package Info](./references/anaconda_org_channels_bioconda_packages_famseq_overview.md)