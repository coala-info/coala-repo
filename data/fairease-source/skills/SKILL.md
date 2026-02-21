---
name: fairease-source
description: The Sea Observations Utility for Reprocessing, Calibration and Evaluation (SOURCE) is a specialized tool for managing oceanographic datasets.
homepage: https://github.com/fair-ease/Source
---

# fairease-source

## Overview
The Sea Observations Utility for Reprocessing, Calibration and Evaluation (SOURCE) is a specialized tool for managing oceanographic datasets. It is designed to bridge the gap between raw in situ sea observations and model data from Ocean General Circulation Models. Use this skill to automate quality control (spike removal, range checks), generate optimized time series for Essential Ocean Variables (EOV), and evaluate model accuracy by comparing OGCM outputs against real-world observations.

## Installation and Setup
The tool is available via Bioconda or direct source installation.

```bash
# Installation via Conda
conda install bioconda::fairease-source

# Installation from source
git clone https://github.com/fair-ease/Source.git
cd Source
python3 setup.py install
```

## Command Line Usage
SOURCE is organized into functional sub-modules. You can execute these directly as Python scripts.

### Core Execution Pattern
To run a specific component, navigate to the module directory and execute the corresponding Python file. Running a script without arguments will display its specific help text and mandatory parameters.

```bash
# General pattern
python3 ${SOURCE_DIR}/[module]/[sub-module].py [arguments]

# Example: In situ pre-processing
python3 ${SOURCE_DIR}/obs_postpro/insitu_tac_pre_processing.py --verbose False
```

### Execution Modes
SOURCE operates in two primary modes:
- **Creation (Default):** Generates a new database from scratch for observations, models, or Cal/Val results.
- **Update:** Uses an existing historical database and appends new data to enlarge the collection.

## Functional Modules
- **Observations (`obs_postpro`):** Handles pre- and post-processing of in situ data and builds relational metadata databases.
- **Model Post-Processing:** Manages the aggregation and interpolation of model data at specific platform locations defined in the observation module.
- **Calibration/Validation (Cal/Val):** Performs the statistical comparison between OGCMs and processed observations to assess model accuracy.

## Expert Tips and Best Practices
- **Quality Control Workflow:** SOURCE applies a specific sequence for observation quality: Global Range Check -> Spike Removal -> Stuck Value Test -> Recursive Statistic Quality Check.
- **Data Prerequisites:** Before running CMEMS (Copernicus Marine) related procedures, ensure the data products are already downloaded and stored locally (or on a reachable NFS). SOURCE does not handle the CMEMS login/download handshake automatically; it expects local file access.
- **Verbosity:** Most modules have a `verbose` parameter. Set it to `False` in automated pipelines to reduce log noise, though it is `True` by default to assist in debugging.
- **Help System:** Use the native Python `help()` function for deep inspection of sub-modules:
  ```python
  import SOURCE.obs_postpro.insitu_tac_pre_processing
  help(SOURCE.obs_postpro.insitu_tac_pre_processing)
  ```
- **Standardization:** SOURCE is basin-independent but requires input data to follow specific standard formats (NetCDF-4/HDF-5). Ensure your input files meet these standards before processing.

## Reference documentation
- [Sea Observations Utility for Reprocessing, Calibration and Evaluation (SOURCE)](./references/github_com_fair-ease_Source.md)
- [fairease-source - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_fairease-source_overview.md)