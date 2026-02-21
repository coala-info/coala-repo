---
name: memote
description: Memote is the community-standard test suite for genome-scale metabolic models.
homepage: https://memote.readthedocs.io/
---

# memote

## Overview
Memote is the community-standard test suite for genome-scale metabolic models. It ensures that models are stoichiometrically consistent, properly annotated, and biologically functional. This skill provides the procedural knowledge to execute model benchmarks, compare different model versions, and set up a version-controlled reconstruction repository.

## Core Workflows

### 1. Model Benchmarking (Snapshot)
Use this to generate a one-time quality report for a single SBML model.
- **Basic Report**: `memote report snapshot path/to/model.xml`
- **Custom Filename**: `memote report snapshot --filename "results.html" path/to/model.xml`
- **Console Summary**: `memote run path/to/model.xml` (Quick check without HTML generation)

### 2. Model Comparison (Diff)
Use this to compare two or more models side-by-side to evaluate improvements or differences.
- **Command**: `memote report diff model_v1.xml model_v2.xml`
- **Output**: Generates an `index.html` showing comparative metrics and score changes.

### 3. Version-Controlled Reconstruction
Use this to initialize a new model project with built-in testing.
- **Initialize**: `memote new` (Follow prompts to set up a git repository structure).
- **Online Sync**: `memote online` (Connects the local repo to GitHub and sets up Continuous Integration).
- **Manual History**: If not using CI, run `memote report history` from the deployment branch (e.g., `gh-pages`) to update the progress report.

## Advanced Usage

### Experimental Data Integration
To validate models against experimental phenotypes, organize data in a `data/` directory and configure `experiments.yml`:
- **Media**: Define uptake limits in `.csv` or `.tsv` files.
- **Growth**: Provide binary growth/no-growth data to validate carbon source utilization.
- **Essentiality**: Provide gene knockout data to validate lethality predictions.
- **Configuration**: Ensure `experiments.yml` points to the correct paths for `medium`, `essentiality`, and `growth`.

### Custom Test Suites
Extend memote with project-specific constraints:
- **Setup**: Create a python module (e.g., `test_my_constraints.py`) using the `@annotate` decorator.
- **Execution**: `memote report snapshot --custom-tests path/to/tests/ model.xml`
- **Pytest Arguments**: Pass specific flags to the underlying engine using `-a`. Example for slow tests: `memote run -a "--durations=10" model.xml`.

## Expert Tips
- **SBML Compliance**: Memote requires SBML Level 3 Version 2 with the FBC (Flux Balance Constraints) package. If a model fails to load, check SBML validation errors first.
- **Namespace Agnostic**: When writing custom tests, use `memote.support.helpers.find_biomass_reaction` instead of searching for specific IDs like "BIOMASS_Ecoli", as IDs vary across models.
- **Minimal Growth Rate**: By default, memote assumes 10% of the theoretical maximum biomass is "growth". Adjust this in `experiments.yml` using the `minimal_growth_rate` key if your model has specific maintenance requirements.

## Reference documentation
- [Getting Started](./references/memote_readthedocs_io_en_latest_getting_started.html.md)
- [Custom Tests](./references/memote_readthedocs_io_en_latest_custom_tests.html.md)
- [Experimental Data](./references/memote_readthedocs_io_en_latest_experimental_data.html.md)
- [Understanding Reports](./references/memote_readthedocs_io_en_latest_understanding_reports.html.md)