---
name: kin
description: kin is a Hidden-Markov-Model based toolset designed for kinship inference and relatedness estimation in ancient DNA data. Use when user asks to estimate degrees of relatedness, perform contamination-corrected kinship analysis, or process paleogenomic BAM files for IBD sharing.
homepage: https://github.com/DivyaratanPopli/Kinship_Inference
metadata:
  docker_image: "quay.io/biocontainers/kin:3.1.4--pyhdfd78af_0"
---

# kin

## Overview
kin is a Hidden-Markov-Model (HMM) based toolset optimized for kinship inference in paleogenomics. It addresses the unique technical challenges of ancient DNA, such as high contamination levels and ascertainment bias. The tool operates in two stages: KINgaroo handles the preprocessing of BAM files and contamination adjustment, while the core kin tool performs the statistical estimation of relatedness degrees (up to the 3rd degree) and IBD sharing.

## Installation and Setup
The tool is available via Bioconda and requires Python 3.8+.
```bash
conda install bioconda::kin
```
Alternatively, install the components via pip from the source directories:
```bash
pip3 install ./pypackage/kingaroo
pip3 install ./pypackage/kin
```

## Preprocessing with KINgaroo
Before running the inference, use KINgaroo to generate the necessary input files from your BAM data.

### Critical Input Requirements
- **Filtered BAMs**: Input BAM files must be sorted, indexed, and filtered for duplicates and quality. Unfiltered duplicates significantly bias kinship estimates.
- **BED File**: A tab-separated file containing chromosome, position, and position+1, along with reference and alternate alleles.
- **Sample List (-T)**: A text file listing the names of the BAM files (excluding the .bam extension) to be analyzed.

### Contamination Correction (-cnt)
KINgaroo offers three modes for handling contamination:
1. **0**: No correction.
2. **1**: Correction using divergence. Requires a compressed/indexed VCF (-d), target individual name (-tar), contaminating individual name (-cont), and a contamination estimates file (-cest).
3. **Value (0 < cnt < 1)**: Manual divergence value. Requires a contamination estimates file (-cest).

### Common CLI Pattern
```bash
KINgaroo -bam ./bam_dir -bed alleles.bed -T samples.txt -cnt 0.02 -cest contamination_estimates.tsv -r 1
```

## Kinship Inference with KIN
Once KINgaroo completes, run the kin command to perform the HMM-based analysis.

### Common CLI Pattern
```bash
KIN -I ./kingaroo_output -O ./kin_results -T samples.txt -c 8
```

### Key Parameters
- **-I**: The directory containing the output from the KINgaroo run.
- **-r**: Location of ROH estimates (defaults to the KINgaroo output folder).
- **-p**: Optional user-provided p_0 estimate; if omitted, the tool estimates it from the data.

## Interpreting Results
The primary output is `KIN_results.csv`. Use the following thresholds for reliable interpretation:

- **Log Likelihood Ratio (LLR)**: Only consider results with LLR > 1.0 as reliable.
- **Within Degree LLR**: When distinguishing between siblings and parent-child (both 1st-degree), ensure the Within Degree LLR is > 1.0.
- **IBD Columns**:
    - **k0**: Proportion of genome with no IBD sharing.
    - **k1**: Proportion with one chromosome in IBD.
    - **k2**: Proportion with both chromosomes in IBD (indicates parent-child or high ROH).

## Expert Tips
- **Window Size**: The default genomic window size is 10Mb (-i 10000000). For higher coverage data, you can reduce this to 1Mb (-i 1000000) in KINgaroo for finer resolution.
- **ROH Estimation**: Always keep ROH estimation enabled (-r 1) unless you have a specific reason to skip it, as ROH can mimic kinship signals and lead to overestimation of relatedness.
- **Noisy Windows**: If you identify specific genomic regions with mapping issues, provide a list of 0-based window indexes to the -n flag to filter them out.

## Reference documentation
- [Kinship Inference GitHub Repository](./references/github_com_DivyaratanPopli_Kinship_Inference.md)
- [Bioconda Kin Overview](./references/anaconda_org_channels_bioconda_packages_kin_overview.md)