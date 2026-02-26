---
name: epigrass
description: Epigrass is a Python-based system for simulating and analyzing metapopulation epidemiological models across geo-referenced networks. Use when user asks to run disease spread simulations, create epidemiological models using a GUI, or execute metapopulation simulations from configuration files.
homepage: https://github.com/fccoelho/epigrass
---


# epigrass

## Overview
Epigrass is a Python-based Epidemiological Geo-referenced Analysis and Simulation system. It is designed to facilitate the creation and execution of metapopulation models, where disease dynamics are simulated across multiple interconnected locations. By integrating spatial data (such as shapefiles and coordinate-based networks) with epidemiological parameters, it allows for complex simulations of disease spread through human or animal movement.

## Core Components and Setup
Before running simulations, ensure the environment is properly configured:

- **Redis Server**: Epigrass requires a running Redis server to manage simulation states and data.
- **Installation**: Can be installed via PyPI or managed through `uv` for development environments.
- **Simulation Files**: Uses `.epg` files to define simulation parameters and network structures.

## Command Line Usage

### Running Simulations
The primary tool for executing simulations is `epirunner`. It takes a simulation configuration file as input.

```bash
# Standard execution
epirunner model_name.epg

# If using the repository with uv
uv run epirunner demos/rio.epg
```

### Launching the Simulation Builder
Epigrass includes a modern, web-based GUI built with Gradio for creating and editing models without writing code manually.

```bash
# Launch the Gradio interface
epigrass

# If using uv
uv run epigrass
```
Once launched, the interface is typically accessible at `http://127.0.0.1:7860`.

## Best Practices
- **Data Preparation**: Ensure that site data (nodes) and edge data (connections) are formatted correctly in CSV or Shapefile formats. Common files include `sites.csv` and `edges.csv`.
- **Model Testing**: Use the provided demos (`rio.epg`, `flu.epg`, `sars.epg`) to verify the installation and Redis connectivity before running custom models.
- **Custom Logic**: For advanced users, custom epidemiological logic can be implemented by modifying or referencing `CustomModel.py`.
- **Visualization**: Use the Gradio dashboard for real-time visualization of simulation results and final epidemic states.

## Reference documentation
- [Epigrass Repository Overview](./references/github_com_fccoelho_epigrass.md)
- [Commit History and Versioning](./references/github_com_fccoelho_epigrass_commits_master.md)