---
name: hippunfold
description: Hippunfold is a neuroimaging pipeline that automates the topological modeling and unfolding of the human hippocampus into a standardized 2D space. Use when user asks to unfold the hippocampus, perform subfield parcellation, process BIDS-formatted neuroimaging data, or generate surface-based hippocampal outputs.
homepage: https://github.com/khanlab/hippunfold
---


# hippunfold

## Overview

Hippunfold is a sophisticated neuroimaging pipeline that automates the topological modeling of the human hippocampus. Unlike traditional volumetric methods, it treats the hippocampus as a folded sheet, computationally "unfolding" it into a standardized 2D space. This approach enables more accurate intersubject alignment, high-resolution subfield parcellation, and the extraction of laminar profiles or morphometric measures that respect the underlying hippocampal anatomy. Use this skill to generate commands for processing BIDS-formatted datasets, managing different image modalities, and configuring surface-based outputs.

## Usage and CLI Patterns

### Basic Command Structure
The tool follows the BIDS-App standard. The basic syntax is:
```bash
hippunfold <input_bids_dir> <output_dir> participant --modality <modality_type> [options]
```

### Common Modality Configurations
*   **T2-weighted (High-res):** The most common use case for subfield imaging.
    ```bash
    hippunfold bids_dir output_dir participant --modality T2w
    ```
*   **T1-weighted:** Used when high-res T2w is unavailable.
    ```bash
    hippunfold bids_dir output_dir participant --modality T1w
    ```
*   **Pre-segmented Data:** If you have existing segmentations and only need unfolding.
    ```bash
    hippunfold bids_dir output_dir participant --modality segT2w
    ```

### Hemisphere and Space Control
*   **Process a single hemisphere:** Use `--hemi L` or `--hemi R` to save time or focus on a specific side.
*   **Output Space:** To ensure outputs are registered to the subject's T1w space, use:
    ```bash
    hippunfold bids_dir output_dir participant --modality T2w --output_space T1w
    ```
*   **Template Registration:** Use `--t1_reg_template` to facilitate registration to a standard template.

### Working with Custom Segmentations
If using the `cropseg` modality (experimental/custom), you must provide the path pattern:
```bash
hippunfold . output_dir participant --modality cropseg --path_cropseg path/to/sub-{subject}_hemi-{hemi}_dseg.nii.gz
```

## Expert Tips and Best Practices

*   **Unfolded Registration (v1.3+):** By default, Hippunfold now performs unfolded space registration to a harmonized histology-based atlas. To revert to the legacy BigBrain-only workflow, use `--atlas bigbrain` or the `--no-unfolded-reg` flag.
*   **Dry Runs:** Since Hippunfold is powered by Snakemake, you can preview the steps without executing them by adding the `-n` flag.
*   **Resource Management:** Use the `-np` flag to see the command-line calls being made during the run, which is helpful for debugging.
*   **Model Caching:** Version 1.3+ downloads nnU-Net models on demand. If working in an environment without internet access, ensure the `HIPPUNFOLD_CACHE_DIR` environment variable is set and populated with the necessary models beforehand.
*   **Contrast-Agnostic Processing:** For non-standard contrasts, consider the experimental UNet model trained via `synthseg` by checking the latest model options in the documentation.



## Subcommands

| Command | Description |
|---------|-------------|
| hippunfold | Performs hippocampal unfolding and analysis. |
| hippunfold | Performs hippocampal unfolding analysis. |
| hippunfold | Performs hippocampal unfolding and analysis. |

## Reference documentation
- [Hippunfold README](./references/github_com_khanlab_hippunfold_blob_master_README.md)
- [CLI Test Examples](./references/github_com_khanlab_hippunfold_blob_master_.dryrun_test_all.sh.md)
- [CLI Usage Guide](./references/hippunfold_khanlab_ca_en_latest_usage_cli.html.md)