---
name: deltamsi
description: DeltaMSI uses machine learning to automate the screening of microsatellite instability in solid tumors from next-generation sequencing data. Use when user asks to train a new MSI detection model, predict MSI status for unknown samples, or evaluate microsatellite length profiles.
homepage: https://github.com/RADar-AZDelta/DeltaMSI
---


# deltamsi

## Overview

DeltaMSI is a specialized bioinformatics tool that leverages machine learning—specifically Logistic Regression and Support Vector Machines (SVM)—to automate the screening of microsatellite instability in solid tumors. It analyzes microsatellite length profiles from Next-Generation Sequencing (NGS) data to provide a scoring mechanism that distinguishes between Microsatellite Stable (MSS) and Microsatellite Instable (MSI) samples. This skill should be used to guide the execution of its three primary modes: training new models on characterized datasets, predicting status for unknown samples, and evaluating results.

## Command Line Usage

### Training a New Model
Use the `train` module to create a custom model based on your specific NGS panel and validated samples.

```bash
DeltaMSI train -bed regions.bed -ihc ground_truth.csv -bamf bam_list.txt -o ./output_model -v
```

**Key Requirements for Training:**
- **BED File (`-bed`)**: Must contain columns for `chr`, `start`, `end`, and `name`.
- **IHC File (`-ihc`)**: A CSV/TSV where the first column is the `sample_name` and the second is the ground truth (pMMR/dMMR, 0/1, or MSS/MSI).
- **BAM List (`-bamf`)**: A text file containing absolute paths to BAM files, one per line.
- **BAM Naming**: BAM files must be named `sample_name.bam` to match the IHC file entries and must be indexed (`.bai`).

### Predicting MSI Status
Use the `predict` module to apply a trained model to new samples.

```bash
# Predict using a list of BAM files
DeltaMSI predict -m ./output_model/ -o ./predictions -bamf new_samples.txt -v

# Predict a single specific BAM
DeltaMSI predict -m ./output_model/aimodel.deltamsi -o ./predictions --bam sample1.bam -v
```

**Note**: The `-m` flag can point to either the full model directory or the specific `aimodel.deltamsi` file.

## Expert Tips and Best Practices

- **Flanking Regions**: The default flanking region is 5bp (`-f 5`). Adjust this if your alignment strategy or specific microsatellite loci are prone to mapping shifts.
- **Depth Thresholds**: By default, regions require a minimum depth of 30 (`-d 30`). For low-input or low-coverage samples, you may need to lower this, though it may impact model balanced accuracy.
- **Interpreting the "Gray Zone"**: DeltaMSI generates two cut-offs. The first ensures 90% precision for MSS, and the second ensures 90% precision for MSI. Samples falling between these values are in the "gray zone" and should be prioritized for clinical validation using secondary methods (e.g., PCR or IHC).
- **Scaling Logic**: DeltaMSI automatically scales depth by dividing the depth of each possible length by the depth of the most frequent length. This normalization allows the models to focus on the distribution shape rather than absolute read counts.
- **Model Selection**: The tool produces a "Voting/Combination" model. This is generally the most robust as it only predicts "instable" if both the Logistic Regression and SVM models agree on instability.

## Reference documentation
- [DeltaMSI GitHub Repository](./references/github_com_RADar-AZDelta_DeltaMSI.md)
- [Bioconda DeltaMSI Overview](./references/anaconda_org_channels_bioconda_packages_deltamsi_overview.md)