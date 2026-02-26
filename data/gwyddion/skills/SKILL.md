---
name: gwyddion
description: Gwyddion is a tool for visualization and analysis of scanning probe microscopy (SPM) data. Use when user asks to process, analyze, or visualize SPM data files, perform operations like leveling, filtering, feature extraction, or generate reports from SPM datasets.
homepage: https://github.com/christian-sahlmann/gwyddion
---


# gwyddion

gwyddion/SKILL.md
name: gwyddion
description: A tool for visualization and analysis of scanning probe microscopy (SPM) data. Use when Claude needs to process, analyze, or visualize SPM data files, perform operations like leveling, filtering, feature extraction, or generate reports from SPM datasets.
---
## Overview
Gwyddion is a powerful open-source software suite designed for the analysis and visualization of data from scanning probe microscopy (SPM) techniques. It supports a wide range of SPM data formats and offers a comprehensive set of tools for data manipulation, quantitative analysis, and presentation. This skill enables Claude to leverage Gwyddion's capabilities for tasks such as data import, processing, measurement, and visualization of SPM datasets.

## Usage Instructions

Gwyddion is primarily a GUI application, but it also offers command-line utilities for batch processing and scripting. This skill focuses on the command-line aspects for integration with AI workflows.

### Core Command-Line Tool: `gwyddion-cli`

The `gwyddion-cli` tool allows for batch processing of data files. It can apply a sequence of operations to one or more input files and save the results.

#### Basic Syntax

```bash
gwyddion-cli [OPTIONS] <input_file> [<input_file>...]
```

#### Key Options and Concepts

*   **Applying Presets/Macros:** Gwyddion allows you to save sequences of operations as "presets" or "macros." These can be applied via the command line.
    *   To apply a preset named "MyLeveling" to a file:
        ```bash
        gwyddion-cli --preset MyLeveling input.dat output.dat
        ```
    *   Presets are typically stored in `~/.config/gwyddion/presets/`.

*   **Processing Modules:** Gwyddion has various processing modules that can be invoked. The exact command-line interface for individual modules might be complex and often best managed through presets. However, some common operations can be targeted.

*   **Leveling:** A fundamental operation for SPM data.
    *   Example: Applying a polynomial leveling (e.g., 2nd order) to a file. This is often done via a preset.

*   **Filtering:** Applying filters like Gaussian or median.
    *   Example: Applying a Gaussian filter with a specific radius. Again, presets are the most robust way.

*   **Measurements:** Extracting quantitative data (e.g., roughness, height statistics).
    *   Gwyddion's analysis tools can be scripted, but direct CLI access to all measurement functions is less common than using presets that perform analysis and export results.

*   **Exporting Data:** Saving processed data or analysis results.
    *   The `--export` option can be used to specify output formats and parameters.
    *   Example: Exporting processed data to a different format.
        ```bash
        gwyddion-cli --preset MyProcessing --export format=xyz input.dat output.xyz
        ```

#### Expert Tips

*   **Create Presets for Repetitive Tasks:** The most efficient way to use Gwyddion from the command line is to define and save your common processing workflows as presets within the Gwyddion GUI. Then, call these presets using `gwyddion-cli --preset <preset_name>`.
*   **Consult Gwyddion Documentation for Specific Modules:** For detailed information on specific processing modules and their parameters, refer to the official Gwyddion documentation. The command-line interface often mirrors the GUI's functionality, but direct module invocation can be intricate.
*   **Understand Data Formats:** Gwyddion supports numerous SPM data formats. Ensure your input files are in a format Gwyddion can read. Common formats include `.dat`, `.txt`, `.asc`, and proprietary formats.
*   **Output File Naming:** When processing multiple files, ensure your output naming strategy prevents overwriting or manage it carefully. Using shell scripting to iterate through files and generate unique output names is recommended.

### Example Workflow (Conceptual)

1.  **Define a processing workflow in Gwyddion GUI:** For example, load a `.dat` file, apply leveling (e.g., `plane leveling`), apply a median filter, and then perform a roughness measurement.
2.  **Save this workflow as a preset:** Name it something descriptive, like `process_and_measure_roughness`.
3.  **Use `gwyddion-cli` to apply the preset to multiple files:**
    ```bash
    for file in *.dat; do
        output_file="${file%.dat}_processed.dat"
        gwyddion-cli --preset process_and_measure_roughness "$file" "$output_file"
        # To also extract measurements, you might need a more complex preset or a separate analysis step.
    done
    ```

*   **Note:** Direct command-line access to specific analysis functions (like calculating RMS roughness) without a preset might require deeper scripting or custom module development, which is beyond the scope of typical CLI usage. Presets are the idiomatic way to achieve complex, multi-step analyses.

## Reference documentation
- [Gwyddion README](./references/github_com_christian-sahlmann_gwyddion.md)
- [Gwyddion License](./references/github_com_christian-sahlmann_gwyddion_blob_master_COPYING.md)