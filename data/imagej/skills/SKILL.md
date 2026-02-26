---
name: imagej
description: "ImageJ is a powerful open-source image processing program for scientific data analysis. Use when user asks to analyze, manipulate, or process scientific images, especially multidimensional ones."
homepage: https://github.com/imagej/imagej2
---


# imagej

ImageJ is a powerful, open-source image processing program widely used in scientific research.
  It is particularly adept at handling N-dimensional scientific image data.
  Use this skill when Claude needs to perform image analysis, manipulation, or processing tasks,
  especially those involving multidimensional scientific images. This includes tasks such as:
  - Applying filters and transformations to images.
  - Analyzing image data (e.g., measurements, segmentation).
  - Working with various image formats common in scientific imaging.
  - Integrating with other scientific software and workflows.
  - Leveraging its extensibility through plugins and scripting.
body: |
  ## Overview
  ImageJ is a versatile, open-source platform for scientific image analysis. It excels at processing multidimensional image data, offering a wide array of tools for manipulation, analysis, and visualization. ImageJ can be used as a standalone application or integrated into larger workflows, including those involving Python and other scientific tools.

  ## Usage Instructions

  ImageJ's core functionality can be accessed through its command-line interface (CLI) or via scripting. While the provided documentation focuses on the ImageJ2 project, which is a rewrite of the original ImageJ, it highlights its extensibility and integration capabilities.

  ### Core Concepts and Access

  *   **N-dimensional Data Model**: ImageJ2 is built upon the ImgLib2 library, enabling it to handle N-dimensional image data efficiently.
  *   **Extensibility**: ImageJ supports a vast ecosystem of plugins and scripts for specialized tasks.
  *   **Integration**: ImageJ2 can be used as a library from Java, Python (via PyImageJ), and other languages, or accessed via a RESTful API (ImageJ Server).

  ### Command-Line and Scripting (General Approach)

  While direct CLI commands for ImageJ itself are not explicitly detailed in the provided documentation, its nature as a scientific processing tool suggests the following common patterns for interacting with such software:

  1.  **Script Execution**: ImageJ supports scripting in languages like Jython, JavaScript, and Groovy. You can typically execute a script file using a command that specifies the script and any input/output files.
      *   **Example Pattern (Conceptual)**: `imagej --run /path/to/your/script.py --input /path/to/your/image.tif --output /path/to/output/image.tif`
      *   **Note**: The exact command-line invocation will depend on how ImageJ is installed and configured on the system.

  2.  **Plugin Invocation**: Many ImageJ functionalities are exposed as plugins. These can often be called programmatically or via specific CLI arguments if the plugin supports it.

  3.  **Batch Processing**: For applying operations to multiple images, ImageJ is designed for batch processing. This usually involves writing a script that iterates over a directory of images and applies a specific set of operations.

  ### Expert Tips

  *   **Leverage PyImageJ for Python Integration**: If working within a Python environment, the PyImageJ module allows in-process calls to ImageJ2. This is a highly efficient way to combine Python's data science ecosystem with ImageJ's image processing capabilities.
  *   **Explore the ImageJ Wiki and SciJava Website**: For detailed information on specific commands, plugins, and advanced usage, refer to the official ImageJ wiki and the SciJava website. These resources are invaluable for understanding the full scope of ImageJ's capabilities.
  *   **Understand the N-dimensional Data Model**: Be aware that ImageJ2's strength lies in handling multidimensional data (e.g., time-series, Z-stacks). When processing images, consider their dimensionality and how operations will apply across these dimensions.

  ## Reference documentation
  - [ImageJ2 GitHub Repository Overview](./references/github_com_imagej_imagej2.md)