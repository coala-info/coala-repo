---
name: plantcv
description: PlantCV is a modular library designed to simplify the creation of reproducible image analysis workflows.
homepage: https://plantcv.danforthcenter.org
---

# plantcv

## Overview
PlantCV is a modular library designed to simplify the creation of reproducible image analysis workflows. It provides a suite of tools to preprocess images, isolate plant material from backgrounds, and quantify traits such as leaf area, height, and color distribution. It is particularly effective for processing large datasets from automated phenotyping platforms.

## Core Workflow Patterns
Most PlantCV workflows follow a standardized sequence. Use these patterns to structure scripts:

1.  **Initialization**: Always import `plantcv` and configure the runtime environment.
    ```python
    from plantcv import plantcv as pcv
    pcv.params.debug = "print"  # Options: None, "print", or "plot"
    ```
2.  **Object Segmentation**:
    *   Use `pcv.threshold.binary` or `pcv.threshold.gaussian` for simple backgrounds.
    *   Use `pcv.naive_bayes_classifier` for complex backgrounds where color-based separation is required.
    *   Clean masks using `pcv.fill` and `pcv.erode`/`pcv.dilate`.
3.  **Trait Extraction**:
    *   `pcv.analyze_object`: Measures size, shape, and position.
    *   `pcv.analyze_color`: Extracts color histograms and statistics (RGB, HSV, LAB).
    *   `pcv.analyze_bound_horizontal` / `pcv.analyze_bound_vertical`: Useful for height and width measurements.
4.  **Data Export**:
    *   Use `pcv.outputs.save_results(filename="results.json")` to aggregate all measurements into a structured format.

## Expert Tips
*   **Parallelization**: For large datasets, use the `plantcv-workflow.py` CLI tool to distribute individual image workflows across multiple CPU cores.
*   **Color Calibration**: If using images from different lighting conditions, use the `pcv.transform.correct_color` function with a color checker (e.g., X-Rite Passport) to normalize data.
*   **ROI Management**: Define Regions of Interest (ROIs) using `pcv.roi.rectangle` or `pcv.roi.circle` to filter out non-plant objects like pots or hardware before analysis.
*   **Debugging**: Set `pcv.params.debug = "plot"` when working in Jupyter notebooks to visualize every step of the pipeline immediately.

## Reference documentation
- [PlantCV Overview](./references/anaconda_org_channels_bioconda_packages_plantcv_overview.md)
- [PlantCV Project Home](./references/plantcv_danforthcenter_org_index.md)