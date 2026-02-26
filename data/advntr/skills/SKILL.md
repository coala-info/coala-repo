---
name: advntr
description: "advntr genotypes Variable Number Tandem Repeats from sequencing data using Hidden Markov Models and neural networks. Use when user asks to genotype VNTRs, identify repeat counts in Illumina or PacBio reads, or detect frameshifts in tandem repeat regions."
homepage: https://github.com/mehrdadbakhtiari/adVNTR
---


# advntr

## Overview
advntr is a specialized tool for resolving Variable Number Tandem Repeats, which are often challenging for standard variant callers. It utilizes Hidden Markov Models (HMM) and neural networks to genotype VNTRs from mapped or unmapped reads. The tool is particularly useful for clinical and population genetics research involving disease-linked tandem repeats, providing diploid repeat counts and identifying small indel variants within motifs.

## Installation and Setup
The tool is primarily distributed via Bioconda.
```bash
conda install -c conda-forge -c bioconda advntr
```
**Critical Requirement**: You must download and extract pre-trained models (databases) for your reference genome (hg19 or GRCh38) into the project directory before running genotypes. Without these models (e.g., `vntr_data_recommended_loci.zip`), the tool cannot identify specific loci.

## Common CLI Patterns

### Genotyping Illumina Short-Reads
Standard usage for Illumina HiSeq data:
```bash
advntr genotype --alignment_file input.bam --working_directory ./output_dir/
```

### Genotyping PacBio Long-Reads
When working with SMRT sequencing data, the `--pacbio` flag is required to adjust the model for higher error rates and longer read lengths:
```bash
advntr genotype --alignment_file pacbio_aligned.bam --working_directory ./output_dir/ --pacbio
```

### Targeted Genotyping
To save time and resources, genotype a specific locus using its unique ID (found in the tool's database or wiki):
```bash
advntr genotype --alignment_file input.bam --vntr_id 1234 --working_directory ./output_dir/
```

### Detecting Frameshifts
For VNTRs in coding regions where repeat expansions or contractions might break the reading frame:
```bash
advntr genotype --alignment_file input.bam --frameshift --working_directory ./output_dir/
```

## Expert Tips and Best Practices
- **Reference Consistency**: Ensure the pre-trained model version matches your BAM file's reference (e.g., do not use hg19 models on GRCh38 alignments).
- **Speed Optimization**: For large-scale datasets, use the `adVNTR-NN` (Neural Network) models which significantly decrease processing time compared to the standard HMM approach.
- **Memory Management**: If processing many loci at once, ensure the `--working_directory` is on a disk with sufficient space for temporary log files and intermediate HMM states.
- **Coding Regions**: For high-precision indel detection within coding motifs, consider using the `code-adVNTR` variant of the tool if the standard genotype command yields ambiguous results.

## Reference documentation
- [adVNTR Main Repository](./references/github_com_mehrdadbakhtiari_adVNTR.md)
- [adVNTR Wiki and Disease-Linked Loci](./references/github_com_mehrdadbakhtiari_adVNTR_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_advntr_overview.md)