---
name: mia-tools
description: The MIA (Multi-patient Intracerebral data Analysis) toolbox is a specialized Matlab-based suite designed to aggregate and analyze electrophysiological data from cohorts of patients.
homepage: https://github.com/MIA-iEEG/mia
---

# mia-tools

## Overview
The MIA (Multi-patient Intracerebral data Analysis) toolbox is a specialized Matlab-based suite designed to aggregate and analyze electrophysiological data from cohorts of patients. It facilitates the transition from individual electrode recordings to group-level cognitive inference by providing standardized workflows for filtering localized channels, extracting time-frequency power, and performing permutation-based statistical testing on anatomical ROIs.

## Functional Guidance and Best Practices

### Core Workflow Integration
MIA is primarily used within the Matlab environment, often as a complement to the Brainstorm (BST) toolbox. 

1.  **Data Preparation**: Use the `bst_plugin` components to import SEEG data. Ensure electrode labels are consistent; MIA includes specific fixes for common data artifacts like backticks (`) in labels that can break standard parsing.
2.  **Channel Localization**: Use `mia_filter_localized_channels` to subset your data based on anatomical coordinates. This is critical before performing group-level ROI analysis.
3.  **Time-Frequency (TF) Analysis**: Use `process_mia_extract_tf.m` for standardized Morlet wavelet transformation. This process is optimized for the "MIA-style" normalization required for multi-patient comparisons.

### Common Matlab Command Patterns
*   **ROI Visualization**: To display group results on a template, use `mia_display_roi`. 
    *   *Tip*: This function can return a figure handle (e.g., `h = mia_display_roi(...)`), allowing for programmatic adjustment of the 3D view or export settings.
*   **Statistical Inference**: Use `mia_get_roi_permute` for non-parametric permutation testing across subjects within specific anatomical regions.
*   **MNI Transformation**: When mapping subject electrodes to a single template, ensure you are using the updated MNI conversion scripts (e.g., `BrainstormCoregisterChannels_asd.m`) to maintain spatial accuracy across the cohort.

### Expert Tips
*   **Brainstorm Integration**: If using the GUI, look for the "MIA integration" features which allow you to automatically populate a BST protocol with MIA-processed results.
*   **Data Cleaning**: Before running group statistics, use the `mia_filter_localized_channels` utility to debug and remove electrodes that are not properly localized within the targeted brain volumes.
*   **Sampling Rates**: When importing BrainVision data, verify the time vector transformation; MIA includes specific debugged routines to ensure sampling rates (`sFreq`) match Brainstorm's display standards.

## Reference documentation
- [MIA: A tool for Multi-patient Intracerebral data Analysis](./references/github_com_MIA-iEEG_mia.md)
- [MIA Commit History and Function Reference](./references/github_com_MIA-iEEG_mia_commits_master.md)