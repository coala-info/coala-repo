---
name: cellprofiler
description: "CellProfiler automates the quantitative analysis of biological images. Use when user asks to analyze biological images, extract measurements from microscopy data, or process large batches of images."
homepage: https://github.com/CellProfiler/CellProfiler
---


# cellprofiler

CellProfiler is a free, open-source software for quantitative analysis of biological images.
  Use this skill when Claude needs to perform automated analysis of biological images,
  extract quantitative measurements from microscopy data, or process large batches of images
  without requiring programming expertise. This skill is suitable for tasks involving
  object identification, feature measurement, and image segmentation in biological contexts.
body: |
  ## Overview
  CellProfiler is a powerful, user-friendly tool designed for the quantitative analysis of biological images. It allows users to automate complex image processing and analysis workflows, enabling the extraction of meaningful data from microscopy and other biological imaging experiments. CellProfiler is particularly useful for researchers who need to analyze large datasets of images and require consistent, reproducible results without needing to write custom code.

  ## Usage Instructions

  CellProfiler is primarily used via its graphical user interface (GUI) or its command-line interface (CLI) for batch processing and integration into automated pipelines.

  ### Command-Line Interface (CLI) Usage

  The CLI is essential for automating analyses and running CellProfiler on multiple image sets or within larger workflows.

  **Basic Command Structure:**

  ```bash
  cellprofiler -c -p <pipeline_file.cppipe> -i <input_directory> -o <output_directory>
  ```

  *   `-c`: Runs CellProfiler in command-line mode (non-interactive).
  -   `-p <pipeline_file.cppipe>`: Specifies the CellProfiler pipeline file (`.cppipe`) to execute. This file contains all the image processing and analysis steps.
  *   `-i <input_directory>`: (Optional) Specifies the directory containing the input images. If not provided, the input directory defined within the pipeline will be used.
  *   `-o <output_directory>`: (Optional) Specifies the directory where output files (e.g., measurements, images) will be saved. If not provided, the output directory defined within the pipeline will be used.

  **Key CLI Options and Best Practices:**

  *   **Running a Pipeline:**
      ```bash
      cellprofiler -c -p /path/to/your/pipeline.cppipe
      ```
      This command will execute the specified pipeline using the input and output settings defined within the `.cppipe` file.

  *   **Specifying Input and Output Directories:**
      ```bash
      cellprofiler -c -p my_pipeline.cppipe -i /data/images -o /results/analysis_run_1
      ```
      This is useful for running the same pipeline on different datasets or saving results to specific locations.

  *   **Batch Processing with Different Parameters:**
      For more advanced batch processing where you might want to vary parameters or input/output locations for each run, you would typically create multiple pipeline files or use scripting (e.g., Bash, Python) to generate and execute CellProfiler commands iteratively.

      **Example using a loop in Bash:**
      ```bash
      for sample_dir in /data/samples/*/; do
          sample_name=$(basename "$sample_dir")
          cellprofiler -c -p my_pipeline.cppipe -i "$sample_dir" -o /results/"$sample_name"_output
      done
      ```
      This example iterates through subdirectories in `/data/samples/`, treating each as an input directory and creating a corresponding output directory for each sample.

  *   **Exporting Measurements:**
      Ensure your pipeline is configured to export the desired measurements. Common export modules include "ExportToSpreadsheet" and "ExportToImage". The CLI will save these outputs to the specified output directory.

  *   **Troubleshooting:**
      If CellProfiler encounters errors during CLI execution, check the pipeline file for correctness, ensure input/output paths are valid and accessible, and review any error messages printed to the console. The `cellprofiler.log` file in the output directory can also provide detailed error information.

  ### Expert Tips

  *   **Pipeline Creation:** Always create and test your pipeline thoroughly using the CellProfiler GUI before attempting to run it via the CLI. This allows for visual inspection and parameter tuning.
  *   **Reproducibility:** Save your pipeline (`.cppipe` file) and note the CellProfiler version used for analysis to ensure reproducibility.
  *   **Resource Management:** For very large datasets or computationally intensive pipelines, consider running CellProfiler on a machine with sufficient RAM and processing power, or explore distributed computing options if available.
  *   **Module Documentation:** Refer to the official CellProfiler documentation for detailed explanations of each module's functionality and parameters.

## Reference documentation
- [CellProfiler Documentation](https://cellprofiler-manual.s3.amazonaws.com/CellProfiler-4.2.8/index.html)