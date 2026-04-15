---
name: scitrack
description: scitrack is a logging library that captures scientific provenance by recording system metadata, software versions, and file checksums. Use when user asks to track computation state, log library versions, or record MD5 signatures for input and output files.
homepage: https://github.com/HuttleyLab/scitrack
metadata:
  docker_image: "quay.io/biocontainers/scitrack:2024.10.8--pyhdfd78af_0"
---

# scitrack

## Overview

scitrack is a specialized logging library designed to solve the "provenance" problem in scientific computing. Unlike standard logging, it focuses on capturing the exact state of a computation: the system metadata, the specific versions of software libraries used, the exact command-line string, and the cryptographic signatures (MD5 checksums) of data files. It uses a "caching" mechanism where log entries are stored in memory and only written to disk once a log file path is assigned, ensuring that the log itself can be part of the tracked output.

## Core Implementation Workflow

To integrate scitrack into a Python script or CLI application, follow this sequence:

1. **Initialize the Logger**: Create a `CachingLogger` instance. Use `create_dir=True` to ensure the output directory exists when the log is finally written.
2. **Capture Arguments**: Use `log_args()` to capture all local variables (arguments and options) at the start of your main function.
3. **Log Environment**: Record the versions of critical dependencies (e.g., numpy, pandas) using `log_versions()`.
4. **Track Data**: Register input and output files. scitrack automatically calculates MD5 checksums for these files.
5. **Commit the Log**: Set the `log_file_path` property. This action triggers the writing of all cached logs to the specified file.

## Usage Patterns and Best Practices

### Basic Integration
```python
from scitrack import CachingLogger

# 1. Setup
LOGGER = CachingLogger(create_dir=True)

def process_data(input_path, threshold=0.95):
    # 2. Capture arguments (including defaults)
    LOGGER.log_args()
    
    # 3. Log library versions
    LOGGER.log_versions(['numpy', 'scipy'])
    
    # 4. Track input file and its MD5
    LOGGER.input_file(input_path)
    
    # ... perform computation ...
    output_path = "results.tsv"
    
    # 5. Track output file
    LOGGER.output_file(output_path)
    
    # 6. Finalize and write log
    LOGGER.log_file_path = "run_log.log"
```

### Integration with Click
When using the `click` library for CLI tools, call `LOGGER.log_args()` immediately inside the command function to capture the state of all parameters passed by the user or filled by defaults.

### Handling Non-File Data
If data comes from a database or a stream rather than a file path, use `text_data()` or `get_text_hexdigest()` to log a signature of the raw data string.

## Expert Tips

* **Immutability**: Once `log_file_path` is set, it cannot be changed for that logger instance. Always perform this step last in your workflow.
* **Automatic Metadata**: scitrack automatically captures the system platform, Python version, user, and the full `command_string` (sys.argv) without manual configuration.
* **Checksum Utility**: You can use `scitrack.get_file_hexdigest(path)` as a standalone utility to get MD5 hashes for files without using the full logging object.
* **Naming Convention**: It is a best practice in scientific pipelines to name the log file similarly to the primary output file (e.g., `experiment_results.csv` and `experiment_results.log`) to keep provenance data adjacent to results.

## Reference documentation
- [scitrack GitHub Repository](./references/github_com_HuttleyLab_scitrack.md)
- [scitrack Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_scitrack_overview.md)