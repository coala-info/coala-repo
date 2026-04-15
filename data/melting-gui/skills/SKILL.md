---
name: melting-gui
description: The melting-gui tool calculates the precise temperature and pressure coordinates of the inflection point on a substance's melting curve using automated filtering and mathematical fitting. Use when user asks to calculate thermodynamic inflection points, identify melting behavior transitions, or analyze melting curve data for plateau regions.
homepage: https://github.com/GokalpKoreken/Auto-Thermodynamic-Point-of-Inflection-on-Melting-Curve-Calculator-GUI-
metadata:
  docker_image: "biocontainers/melting-gui:v4.3.1dfsg-2-deb_cv1"
---

# melting-gui

## Overview
The `melting-gui` tool provides an automated workflow for calculating the precise temperature and pressure coordinates where a substance's melting behavior shifts. By processing raw melting data through a sequence of filters and mathematical fits, the tool identifies the inflection point—the transition between regions where a substance melts at lower versus higher temperatures as pressure increases. This is particularly useful for identifying critical points and transitions in substances that exhibit non-linear melting curves.

## Usage Instructions

### Data Preparation
*   **Input Format**: Ensure your melting curve data is stored in an Excel file named `veri.xlsx` within the tool's directory.
*   **Data Quality**: The tool uses a moving average filter for smoothing, but high-quality, low-noise data in the input spreadsheet will yield more reliable inflection points.

### Execution Workflow
To run the analysis, execute the primary MATLAB script:
```matlab
inflectionpointcalc
```

### Algorithmic Process
The tool follows a specific 10-step procedure to isolate the inflection point:
1.  **Smoothing**: Applies a moving average filter to the raw data.
2.  **Slope Analysis**: Determines the maximum slope difference on the curve.
3.  **Curve Segmentation**: Cuts the curve at the point of maximum slope difference.
4.  **Polynomial Fitting**: Fits a 10th-order polynomial to determine initial inflection points.
5.  **Plateau Isolation**: Cuts the curve again from the second-to-last inflection point to focus on the plateau region.
6.  **Fourier Refinement**: Fits a Fourier Series function to the remaining curve (which is typically near-linear) for the highest possible fit accuracy.
7.  **Derivation**: Calculates the first and second derivatives of the Fourier-fitted function.
8.  **Zero-Crossing Detection**: Identifies where the second derivative crosses zero.
9.  **Visualization**: Generates plots of the results for manual verification.

### Expert Tips and Best Practices
*   **Identify the Desired Point**: The tool may find multiple inflection points. The "desired" thermodynamic point is typically the one where the second derivative exhibits a clear zero-crossing behavior corresponding to the plateau of the melting curve.
*   **Plateau Behavior**: This tool is optimized for substances where the desired inflection point resides on a plateau. If your substance does not exhibit a plateau, the Fourier Series fitting (Step 6) may require manual adjustment in the `.m` file.
*   **Manual Verification**: Always inspect the output plots. The transition from concave upward (melting at lower temperatures as pressure increases) to concave downward (melting at higher temperatures as pressure increases) should be visually distinct in the final plot.

## Reference documentation
- [README](./references/github_com_GokalpKoreken_Auto-Thermodynamic-Point-of-Inflection-on-Melting-Curve-Calculator-GUI-_blob_master_README.md)