---
name: smncopynumbercaller
description: This tool determines the copy number of SMN1 and SMN2 genes from whole-genome sequencing data to identify Spinal Muscular Atrophy carriers and affected individuals. Use when user asks to call SMN1 and SMN2 copy numbers, identify SMA carriers, or generate diagnostic visualizations for SMN gene analysis.
homepage: https://github.com/Illumina/SMNCopyNumberCaller
metadata:
  docker_image: "quay.io/biocontainers/smncopynumbercaller:1.1.2--py312h7e72e81_1"
---

# smncopynumbercaller

## Overview
The `smncopynumbercaller` is a specialized bioinformatics tool designed to resolve the copy number of the highly homologous SMN1 and SMN2 genes. It utilizes WGS data (typically >=30X coverage) to differentiate between full-length genes and the SMN2Δ7–8 deletion. Use this skill to automate the execution of the caller, manage input manifests, and generate diagnostic visualizations for SMA screening.

## Installation and Setup
Install the tool via Bioconda for the most stable environment:
```bash
conda install -c bioconda smncopynumbercaller
```

## Execution Workflow

### 1. Prepare the Manifest
The tool requires a manifest file where each line is the absolute path to an input BAM or CRAM file.
```bash
# Example manifest creation
ls -d $PWD/*.bam > manifest.txt
```

### 2. Run the Copy Number Caller
Execute the primary analysis using `smn_caller.py`. Ensure the `--genome` version matches your alignment reference (19, 37, or 38).

```bash
smn_caller.py \
    --manifest manifest.txt \
    --genome 38 \
    --prefix study_results \
    --outDir ./results \
    --threads 8
```

**Key Arguments:**
*   `--genome`: Supports 19, 37, or 38.
*   `--reference`: Required if using CRAM input; provide the path to the reference FASTA.
*   `--outDir`: Directory where the `.tsv` and `.json` outputs will be saved.

### 3. Visualize Results
Generate PDF charts for debugging or clinical review using the `.json` file produced in the previous step.

```bash
smn_charts.py \
    -s ./results/study_results.json \
    -o ./charts_output
```

## Interpreting Outputs

### TSV Results
Focus on these primary fields for SMA screening:
*   `isSMA`: Boolean indicating zero copies of SMN1.
*   `isCarrier`: Boolean indicating exactly one copy of SMN1.
*   `SMN1_CN`: Final integer copy number call for SMN1.
*   `g.27134T>G_CN`: Copy number of the SNP associated with "2+0" silent carriers.

### JSON Debugging
Use the JSON output to check `Coverage_MAD` (Median Absolute Deviation). High MAD values may indicate poor sample quality that could lead to unreliable copy number calls.

## Best Practices and Expert Tips
*   **Sequencing Depth**: Ensure WGS data has at least 30X coverage. The tool is validated for standard WGS and may produce "no-calls" (None) on low-depth samples.
*   **Aligner Neutrality**: The tool is compatible with both BWA and Isaac aligners.
*   **CRAM Files**: Always provide the `--reference` FASTA when working with CRAM to avoid decompression errors.
*   **Silent Carrier Detection**: Pay close attention to the `g.27134T>G_CN` field. A value of 1 or higher in a sample with `SMN1_CN` of 2 suggests a "2+0" genotype, which is a silent carrier.

## Reference documentation
- [Bioconda smncopynumbercaller Overview](./references/anaconda_org_channels_bioconda_packages_smncopynumbercaller_overview.md)
- [Illumina SMNCopyNumberCaller GitHub Repository](./references/github_com_Illumina_SMNCopyNumberCaller.md)