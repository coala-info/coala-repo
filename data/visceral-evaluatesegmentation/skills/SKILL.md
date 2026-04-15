---
name: visceral-evaluatesegmentation
description: The visceral-evaluatesegmentation tool assesses the quality of volumetric segmentations by comparing a test segmentation against a ground truth reference using various metrics. Use when user asks to evaluate segmentation quality, compare segmentations, save evaluation results to XML, select specific metrics, evaluate fuzzy segmentations, or specify distance units.
homepage: https://github.com/Visceral-Project/EvaluateSegmentation
metadata:
  docker_image: "quay.io/biocontainers/visceral-evaluatesegmentation:2021.03.25--h287ed61_0"
---

# visceral-evaluatesegmentation

## Overview
The `EvaluateSegmentation` tool is a specialized utility designed for the medical imaging community to assess the quality of volumetric segmentations. It compares a "test" segmentation against a "ground truth" reference using over 20 different metrics, including similarity coefficients, distance-based measures, and classic statistical indicators. Built on the ITK library, it supports standard medical imaging formats (e.g., .nii, .mha) and can handle both binary and fuzzy/probabilistic segmentation maps.

## Command Line Usage

The basic syntax for the tool is:
`EvaluateSegmentation truthPath segmentPath [options]`

### Common CLI Patterns

*   **Basic Comparison**: Compare two NIfTI volumes using all default metrics.
    `EvaluateSegmentation ground_truth.nii.gz test_segmentation.nii.gz`

*   **Save Results to XML**: Export the evaluation metrics to a structured XML file for downstream analysis.
    `EvaluateSegmentation truth.nii segment.nii -xml results.xml`

*   **Specific Metric Selection**: Use the `-use` flag followed by a comma-separated list of metric codes.
    `EvaluateSegmentation truth.nii segment.nii -use DICE,JACRD,SNSVTY,SPCFTY`

*   **Handling Fuzzy/Probabilistic Images**: Convert probability maps to binary segmentations using a specific threshold before evaluation.
    `EvaluateSegmentation truth.nii fuzzy_segment.nii -thd 0.5`

*   **Distance Units**: Specify whether distance metrics (like Hausdorff) and volumes should be reported in voxels or millimeters.
    `EvaluateSegmentation truth.nii segment.nii -unit millimeter`

### Metric-Specific Parameters
Some metrics allow for specific parameters using the `@` notation:
*   **95th Percentile Hausdorff Distance**: Use `@0.95@` to calculate the 95% quantile, which is more robust to outliers than the maximum distance.
    `-use HDRFDST@0.95@`
*   **F-Measure Beta**: Adjust the beta parameter for the F-Measure (e.g., 0.5).
    `-use FMEASR@0.5@`

## Expert Tips and Best Practices

*   **Performance for Small Volumes**: For images smaller than 200x200x200 voxels, use the `-nostreaming` flag. This disables the streaming filter used for large datasets, reducing the overhead and time associated with memory management.
*   **Grid Consistency**: Ensure that the two input volumes have the exact same grid size (dimensions). The tool requires matching image geometries to perform voxel-wise comparisons.
*   **Balanced Average Hausdorff Distance (bAVD)**: When ranking segmentation performance, consider using the `bAVD` metric (added in 2021) to avoid the hidden biases often found in standard Average Hausdorff Distance.
*   **Metric Codes**:
    *   `DICE`: Dice Coefficient
    *   `JACRD`: Jaccard Coefficient
    *   `HDRFDST`: Hausdorff Distance
    *   `AVGDIST`: Average Hausdorff Distance
    *   `SNSVTY`: Sensitivity / Recall
    *   `PRCISON`: Precision
    *   `VOLSMTY`: Volumetric Similarity Coefficient

## Reference documentation
- [EvaluateSegmentation Main Documentation](./references/github_com_Visceral-Project_EvaluateSegmentation.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_visceral-evaluatesegmentation_overview.md)