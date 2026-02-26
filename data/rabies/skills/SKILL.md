---
name: rabies
description: RABIES is an automated framework for standardizing the processing and analysis of rodent fMRI data. Use when user asks to preprocess rodent fMRI scans, perform confound correction, conduct functional connectivity analysis, or run group-level statistics.
homepage: https://github.com/CoBrALab/RABIES
---


# rabies

## Overview
RABIES is a specialized framework designed to standardize the processing of rodent fMRI data. It addresses the unique challenges of rodent imaging—such as high variability in species, field strengths, and coil configurations—by providing an automated, Nipype-based workflow. The tool transforms raw data into analysis-ready outputs through three distinct stages: preprocessing, confound correction, and functional connectivity analysis. It is built to ensure reproducibility by supporting BIDS-formatted inputs and providing containerized execution.

## Core Workflow Stages
The RABIES pipeline is executed via three primary subcommands. Each stage typically consumes the output directory of the preceding stage.

### 1. Preprocessing
This stage focuses on spatial normalization and initial signal cleaning.
- **Key Operations**: Head motion correction (HMC), susceptibility distortion correction (SDC), slice timing correction, and registration to a common template or native space.
- **Registration**: Features a robust registration workflow that automatically adapts parameters based on the acquisition type.
- **Quality Control**: Generates visual assessments of registration and motion parameters.

### 2. Confound Correction
Following preprocessing, this stage removes non-neural noise and artifacts.
- **Nuisance Removal**: Supports linear detrending and confound regression with various nuisance regressor options.
- **Temporal Filtering**: Highpass, lowpass, and bandpass filtering options.
- **Motion Scrubbing**: Frame censoring based on motion thresholds.
- **Advanced Denoising**: Includes ICA-AROMA for automated motion artifact identification.

### 3. Analysis
The final stage generates functional connectivity metrics and group-level statistics.
- **Connectivity**: Seed-based functional connectivity and whole-brain connectivity matrices.
- **Group Analysis**: Group-ICA and dual regression.
- **Data Diagnosis**: A specialized workflow that generates indices of data quality and confound impact to ensure transparency in results.

## CLI Best Practices and Expert Tips
- **BIDS Input**: Input data must be in BIDS format. RABIES uses the BIDS structure to automate the selection of processing parameters.
- **Thread Management**: 
    - Use `--local_threads` to control the number of parallel nodes/subjects processed by Nipype.
    - Use `--num_ITK_threads` to control the internal threading of registration tasks (ANTs/ITK). 
    - Balancing these two is critical to avoid CPU over-subscription on HPC clusters.
- **Flexible Parcellation**: Use the `--ROI_labels_file` argument at the **analysis** stage. This allows you to apply different brain atlases or label sets without having to rerun the time-consuming preprocessing stage.
- **Native Space Analysis**: If your research requires avoiding the interpolation artifacts of template normalization, use the `--bold_nativespace` flag during resampling.
- **Motion Correction Control**: If you need to disable the application of head motion correction during the resampling step (e.g., for specific diagnostic purposes), use the `--no_HMC` flag.
- **Log Transformation**: When using log transformations, RABIES adds +1 to the data before transformation to ensure that zero values remain zero and to handle negative values post-transformation.
- **Parallel Execution**: For large datasets, the pipeline can take several hours to a day. Always utilize the `-p MultiProc` plugin for parallel execution when computational resources allow.

## Reference documentation
- [RABIES GitHub Repository](./references/github_com_CoBrALab_RABIES.md)
- [RABIES Recent Commits and CLI Updates](./references/github_com_CoBrALab_RABIES_commits_master.md)