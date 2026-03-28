---
name: memote
description: Memote performs quality control and benchmarking for genome-scale metabolic models to ensure stoichiometric consistency and annotation completeness. Use when user asks to run metabolic model tests, generate quality reports, compare model versions, or initialize a new model repository.
homepage: https://memote.readthedocs.io/
---

# memote

## Overview

`memote` (metabolic model tests) is the community-standard tool for quality control and benchmarking of genome-scale metabolic models. It provides a comprehensive suite of tests that check for stoichiometric consistency, mass and charge balance, biomass formulation validity, and annotation completeness. By using `memote`, researchers can ensure their metabolic reconstructions are robust, reproducible, and compliant with the latest Systems Biology Markup Language (SBML) and Flux Balance Constraints (FBC) specifications.

## Core Workflows

### 1. Running the Test Suite
To run the default test suite on a single model file and see the results in the terminal:

```bash
memote run model.xml
```

### 2. Generating Reports
Reports are the primary way to visualize model quality.

- **Snapshot Report**: Generates a comprehensive HTML report for a single model.
  ```bash
  memote report snapshot model.xml --filename "report.html"
  ```
- **Diff Report**: Compares two or more models side-by-side to see improvements or regressions.
  ```bash
  memote report diff model_v1.xml model_v2.xml --filename "comparison.html"
  ```
- **History Report**: For models managed in a Git repository, this generates a report showing how model quality has evolved over time.
  ```bash
  memote report history
  ```

### 3. Initializing a New Model Repository
To set up a standardized, version-controlled environment for a new metabolic reconstruction:

```bash
memote new
```
This creates a skeleton directory structure optimized for continuous integration (CI) testing.

## Expert Tips and Best Practices

### Stoichiometric Consistency
Prioritize fixing "Stoichiometric Inconsistency" and "Mass/Charge Unbalance" before addressing other issues. An inconsistent model can produce mass from nothing, making Flux Balance Analysis (FBA) results unreliable.
- Use `memote run --exclusive test_stoichiometric_consistency` to focus solely on this check.

### Biomass Validation
Ensure your biomass reaction is correctly annotated with `SBO:0000629`. `memote` uses this term to identify the objective function.
- Check the "Biomass Consistency" test to ensure the molecular weight of the biomass sums to approximately 1 g/mmol.

### Improving Test Discovery
If `memote` fails to find certain components (like the Non-Growth Associated Maintenance/NGAM reaction), ensure your model uses standard buzzwords in IDs or names:
- **NGAM**: `atpm`, `maintenance`, `ngam`.
- **Biomass**: `biomass`, `growth`, `bof`.

### Performance Tuning
For large models, the stoichiometric consistency and blocked reaction tests can be computationally expensive.
- Use `--solver-timeout <seconds>` to prevent the optimization solver from hanging on difficult problems.
- Use `--skip <test_name>` to bypass specific tests during rapid iteration.



## Subcommands

| Command | Description |
|---------|-------------|
| memote history | Re-compute test results for the git branch history. |
| memote new | Create a suitable model repository structure from a template. |
| memote online | Upload the repository to GitHub and create a gh-pages branch. |
| memote report | Generate one of three different types of reports. |
| memote run | Run the test suite on a single model and collect results. |

## Reference documentation
- [Memote API Overview](./references/memote_readthedocs_io_en_latest_autoapi_memote_index.html.md)
- [Basic Model Tests](./references/memote_readthedocs_io_en_latest_autoapi_test_basic_index.html.md)
- [Biomass Formulation Tests](./references/memote_readthedocs_io_en_latest_autoapi_test_biomass_index.html.md)
- [Consistency and Stoichiometry Tests](./references/memote_readthedocs_io_en_latest_autoapi_test_consistency_index.html.md)
- [Matrix Property Tests](./references/memote_readthedocs_io_en_latest_autoapi_test_matrix_index.html.md)