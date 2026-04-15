---
name: jupyter
description: Jupyter provides an interactive computing environment for integrating live code, equations, visualizations, and explanatory text. Use when user asks to launch a notebook or lab interface, execute magic commands, profile code, debug exceptions, or manage kernels and extensions.
homepage: https://github.com/jakevdp/PythonDataScienceHandbook
metadata:
  docker_image: "biocontainers/jupyter:phenomenal-v387f29b6ca83_cv0.4.12"
---

# jupyter

## Overview
Jupyter is a powerful ecosystem for interactive computing that allows for the integration of live code, equations, computational output, and explanatory text. This skill enables efficient use of the Jupyter interface and the underlying IPython kernel to accelerate data exploration, debugging, and visualization. It focuses on leveraging built-in magic commands, shell integrations, and best practices for managing notebook environments.

## Core CLI and Interface Usage

### Starting the Environment
- Launch the notebook server: `jupyter notebook`
- Launch the modern lab interface: `jupyter lab`
- Specify a port if the default is busy: `jupyter notebook --port 8889`
- Start without opening a browser: `jupyter notebook --no-browser`

### IPython Magic Commands
Magic commands are specialized shortcuts within cells (line magics start with `%`, cell magics with `%%`):
- `%magic`: List all available magic commands.
- `%timeit`: Time the execution of a single line (runs multiple loops for accuracy).
- `%%timeit`: Time the execution of an entire cell.
- `%run`: Execute an external Python script within the notebook session: `%run myscript.py`.
- `%prun`: Profile code execution to find bottlenecks.
- `%debug`: Open an interactive debugger after an exception occurs.
- `%who`: List all variables in the current global scope.
- `%history`: Print input history.

### Shell Integration
- Execute shell commands directly by prefixing with `!`: `!ls`, `!pip install pandas`.
- Pass Python variables to the shell:
  ```python
  directory = "data_folder"
  !mkdir {directory}
  ```

## Best Practices for Data Science

### Help and Documentation
- Use `?` for object documentation: `len?`
- Use `??` to view the source code of an object (if available): `pd.DataFrame??`
- Use Tab-completion for exploring attributes and methods: `np.<TAB>`
- Use wildcard matching: `*Error?` to list all objects ending in "Error".

### Environment Management
- Always use a requirements file or environment YAML to ensure reproducibility.
- Install requirements from within a notebook: `!pip install -r requirements.txt`.
- Use `conda` to manage complex dependencies (like C-extensions for NumPy/Pandas):
  - `conda install --file requirements.txt`
  - `conda create -n my_env python=3.9`

### Visualization
- Ensure plots render inline (standard in modern Jupyter, but useful to know): `%matplotlib inline`.
- Use `%matplotlib notebook` for interactive (zoomable/resizable) plots in some environments.



## Subcommands

| Command | Description |
|---------|-------------|
| jupyter nbextension | Work with Jupyter notebook extensions |
| jupyter serverextension | Work with Jupyter server extensions |
| jupyter_console | The Jupyter terminal-based Console. |
| jupyter_kernelspec | Manage Jupyter kernel specifications. |
| jupyter_migrate | Migrate configuration and data from .ipython prior to 4.0 to Jupyter locations. |
| jupyter_nbconvert | This application is used to convert notebook files (*.ipynb) to various other formats. |
| jupyter_notebook | The Jupyter HTML Notebook. |
| jupyter_troubleshoot | Troubleshoot Jupyter installation and environment. |
| jupyter_trust | Trust or untrust a notebook. |

## Reference documentation
- [IPython: Beyond Normal Python](./references/jakevdp_github_io_PythonDataScienceHandbook_01.00-ipython-beyond-normal-python.html.md)
- [Help and Documentation](./references/jakevdp_github_io_PythonDataScienceHandbook_01.01-help-and-documentation.html.md)
- [Magic Commands](./references/jakevdp_github_io_PythonDataScienceHandbook_01.03-magic-commands.html.md)
- [Errors and Debugging](./references/jakevdp_github_io_PythonDataScienceHandbook_01.06-errors-and-debugging.html.md)
- [Timing and Profiling](./references/jakevdp_github_io_PythonDataScienceHandbook_01.07-timing-and-profiling.html.md)
- [Python Data Science Handbook README](./references/github_com_jakevdp_PythonDataScienceHandbook_blob_master_README.md)