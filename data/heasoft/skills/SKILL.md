---
name: heasoft
description: HEASoft is a comprehensive software suite designed for the analysis of X-ray and Gamma-ray data from high-energy astrophysics observatories. Use when user asks to perform spectral fitting, manipulate FITS files, analyze timing and imaging data, or script astrophysical workflows using Python.
homepage: https://heasarc.gsfc.nasa.gov/lheasoft/
---


# heasoft

## Overview

HEASoft is the primary software environment used by the high-energy astrophysics community to analyze data from X-ray and Gamma-ray observatories. It integrates several specialized packages—Xspec (spectral fitting), Xronos (timing), Ximage (imaging), and XSTAR (photoionization)—with the FTOOLS library for general FITS file manipulation. The system is built on a robust parameter interface (PIL) that allows for consistent command-line behavior and easy scripting.

## Environment Initialization

Before running any HEASoft tools, the environment must be initialized. This sets up necessary environment variables like `$HEADAS` and updates the system `PATH`.

- **Linux (bash/zsh):** `source $HEADAS/headas-init.sh`
- **Linux (tcsh/csh):** `source $HEADAS/headas-init.csh`
- **Docker:** Containers typically initialize the environment automatically in a `tcsh` shell.

## Parameter Management (PIL)

HEASoft tasks use `.par` files to store and retrieve parameters. Understanding the Parameter Interface Library (PIL) is essential for automation.

- **View parameters:** `plist <taskname>` shows all parameters and their current values.
- **Reset parameters:** `punlearn <taskname>` resets parameters to their system defaults.
- **Get/Set values:** Use `pget <taskname> <parameter>` and `pset <taskname> <parameter>=<value>`.
- **Query Mode:** Most tasks have a `mode` parameter. Set `mode=h` (hidden) to suppress interactive prompts and use current or command-line values only.

## Common CLI Patterns

### FITS File Inspection (FTOOLS)
- **List Header:** `ftlist <filename> option=H` (Lists all HDU summaries).
- **List Keywords:** `ftlist <filename>+1 option=K` (Lists keywords for the first extension).
- **List Data:** `ftlist <filename> option=T` (Lists table data).
- **Copy File:** `fcopy <infile> <outfile>` (Useful for filtering extensions, e.g., `fcopy "in.fits[EVENTS]" out.fits`).

### Spectral Analysis (Xspec)
Xspec is often run interactively but can be scripted using command files (`.xcm`).
- **Run script:** `xspec - <script.xcm>`
- **Common commands:**
  - `data 1:1 spectrum.pha` (Load data)
  - `model phabs(powerlaw)` (Define model)
  - `fit` (Perform Levenberg-Marquardt optimization)
  - `plot ldata delchi` (Visualize data and residuals)

## HEASoftPy (Python Interface)

HEASoftPy provides a modern Python 3 wrapper for HEASoft tasks, allowing integration into Jupyter notebooks or data science pipelines.

```python
import heasoftpy as hsp

# Call a task directly
result = hsp.ftlist(infile='data.fits', option='H')

# Check status and output
if result.returncode == 0:
    print(result.stdout)
```

### Best Practices for Scripting
- **Parallelization:** When running tasks in parallel, ensure each process has its own `PFILES` directory to avoid parameter file corruption.
- **CALDB:** Use remote CALDB access if a local installation is too large. Set `CALDB=https://heasarc.gsfc.nasa.gov/FTP/caldb` in your environment.
- **Error Handling:** Always check the exit status of a task. In Python, check `result.returncode`.



## Subcommands

| Command | Description |
|---------|-------------|
| fkeyprint | Display the value of a keyword in a FITS file header. (Note: The provided help text contained a system error; parameters are based on standard tool documentation). |
| punlearn | Resets the parameter file for a specific HEASoft task to its system defaults. |

## Reference documentation

- [HEASoft Overview](./references/heasarc_gsfc_nasa_gov_docs_software_lheasoft.md)
- [HEASoftPy Guide](./references/heasarc_gsfc_nasa_gov_docs_software_lheasoft_heasoftpy.md)
- [PIL (Parameter Interface Library)](./references/heasarc_gsfc_nasa_gov_docs_software_lheasoft_headas_pil.md)
- [Docker Usage](./references/heasarc_gsfc_nasa_gov_docs_software_lheasoft_docker.html.md)