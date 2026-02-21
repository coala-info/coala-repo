---
name: retropath2_wrapper
description: The `retropath2_wrapper` is a Python-based interface for the RetroPath2.0 retrosynthesis engine.
homepage: https://github.com/brsynth/retropath2-wrapper
---

# retropath2_wrapper

## Overview

The `retropath2_wrapper` is a Python-based interface for the RetroPath2.0 retrosynthesis engine. It automates the execution of complex KNIME workflows to find chemical transformation paths from a target "source" molecule to a set of "sink" molecules (typically metabolites already present in a host organism). It utilizes reaction rules (often from RetroRules) to explore the metabolic space and identify viable biosynthetic pathways.

## Core Functionality

The tool requires three primary input files in CSV format:
1.  **Source**: The target molecule to be synthesized.
2.  **Sink**: The collection of available compounds (e.g., the chassis metabolome).
3.  **Rules**: The reaction rules defining possible chemical transformations.

### Command Line Interface (CLI)

The most direct way to run the retrosynthesis is via the Python module:

```bash
python -m retropath2_wrapper <sink_file> <rules_file> <out_dir> --source_file <source_file>
```

### Python API Usage

For integration into larger scripts, use the `retropath2` function:

```python
from retropath2_wrapper import retropath2

results = retropath2(
    sink_file='/path/to/sink.csv',
    source_file='/path/to/source.csv',
    rules_file='/path/to/rules.csv',
    outdir='/path/to/output',
    max_steps=3,
    dmin=0,
    dmax=100,
    topx=100
)
```

## Expert Tips and Best Practices

### Path Management
*   **Use Absolute Paths**: The underlying KNIME execution is sensitive to relative paths. Always provide absolute paths for input files and output directories to prevent execution failures.

### Parameter Tuning
*   **Diameter (dmin/dmax)**: These define the level of specificity for reaction rules. A larger `dmax` allows for more generalized rules, while a smaller `dmin` ensures the core reaction center is preserved.
*   **Max Steps**: Increasing `max_steps` exponentially increases the search space and computation time. Start with 2 or 3 steps before attempting deeper searches.
*   **MW Max Source**: Use `mwmax_source` to filter out excessively large molecules that may be irrelevant to your metabolic context.

### KNIME Environment
The wrapper requires a KNIME installation. You can manage this through the `knime` submodule:
*   **Auto-installation**: The tool can download and install KNIME (v4.6.4 or v4.7.0) automatically if not found.
*   **Manual Path**: If KNIME is already installed, specify the path to avoid redundant downloads:
    ```python
    from retropath2_wrapper.knime import Knime
    knime_inst = Knime(kinstall="/path/to/knime_folder")
    ```

### Handling Return Codes
Always check the return code of the `retropath2()` function to diagnose issues:
*   **0**: Success.
*   **1**: File not found.
*   **3/4**: Malformed InChI or Sink file.
*   **10**: Warning—Source molecule was already found in the sink.
*   **11**: Warning—No solution found within the given parameters.

## Reference documentation
- [RetroPath2.0 Python wrapper](./references/github_com_brsynth_retropath2-wrapper.md)