---
name: heasoft
description: HEASoft is a software suite used for processing and analyzing data from X-ray and Gamma-ray observatories. Use when user asks to initialize the HEASoft environment, manipulate FITS files with FTOOLS, perform spectral modeling in XSPEC, or extract lightcurves and spectra using XSELECT.
homepage: https://heasarc.gsfc.nasa.gov/lheasoft/
---


# heasoft

## Overview
HEASoft is the standard software suite for processing and analyzing data from X-ray and Gamma-ray observatories (e.g., Swift, NuSTAR, NICER). It integrates FTOOLS for general FITS file handling with specialized packages like XSPEC for spectral modeling. This skill provides the essential environment configuration and command-line patterns required to execute these tools within a shell or Conda environment.

## Environment Initialization
Before running any HEASoft command (e.g., `xspec`, `fkeyprint`, `xselect`), the environment must be initialized. For Conda-based installations, use the following sequence:

```bash
# 1. Set the HEADAS directory (path varies by architecture)
export HEADAS=$(ls -d "${CONDA_PREFIX}/x86_64-pc-linux-gnu-libc"*/ | head -n 1)

# 2. Source the initialization script
source "${HEADAS}/headas-init.sh"

# 3. Point to the Conda Perl interpreter (Required for many FTOOLS)
export LHEAPERL="${CONDA_PREFIX}/bin/perl"
```

## Core Component Usage
- **FTOOLS**: Use for FITS header manipulation and data extraction.
  - `fkeyprint infile+1`: Display keywords of the first extension.
  - `fstruct infile`: Show the structure of a FITS file.
- **XSPEC**: Interactive X-ray spectral fitting.
  - Launch with `xspec`.
  - **Critical**: If XSPEC fails due to missing models, you must manually install the `modelData` directory (~5.9GB) from the HEASoft source tarball into `${CONDA_PREFIX}/spectral/`.
- **XSELECT**: Used for filtering event files and creating spectra/lightcurves.
  - Common workflow: `read events` -> `filter column` -> `extract spectrum`.

## Best Practices and Tips
- **Parameter Files (.par)**: HEASoft tools store state in `.par` files. If a tool behaves unexpectedly, check your `PFILES` environment variable or run `punlearn <toolname>` to reset defaults.
- **Mission Specifics**: While HEASoft provides the framework, specific missions (like NuSTAR or IXPE) often require additional calibration files (CALDB) to be indexed and pointed to via the `CALDB` environment variable.
- **Scripting**: Most HEASoft commands can be scripted by passing arguments directly or using "hidden" parameters (e.g., `toolname param1=value1 param2=value2`).

## Reference documentation
- [Bioconda HEAsoft Overview](./references/anaconda_org_channels_bioconda_packages_heasoft_overview.md)
- [HEASARC HEASoft Documentation](./references/heasarc_gsfc_nasa_gov_docs_software_lheasoft.md)