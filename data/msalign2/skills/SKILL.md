---
name: msalign2
description: msalign2 is a specialized tool for aligning liquid chromatography-mass spectrometry (LC-MS) or capillary electrophoresis-mass spectrometry (CE-MS) data.
homepage: http://www.ms-utils.org/msalign2/index.html
---

# msalign2

## Overview
msalign2 is a specialized tool for aligning liquid chromatography-mass spectrometry (LC-MS) or capillary electrophoresis-mass spectrometry (CE-MS) data. It works by identifying common features (mass-to-charge ratios) across two datasets and calculating a temporal transformation curve. This is essential for comparative analysis where experimental drift has caused shifts in retention or migration times between runs.

## Command Line Usage

The core `msalign2` binary performs the alignment calculation. The basic syntax is:

```bash
msalign2 -1 <datafile> -2 <master_file> [options]
```

### Required Parameters
- `-1`: The "target" datafile you want to align.
- `-2`: The "master" or reference datafile to which the target is aligned.

### Alignment Tuning Parameters
- `-e`: **Mass Error (ppm)**. Maximum allowable mass deviation for matching features.
- `-l`: **Retention Time SD**. Typical standard deviation of the retention time (in scans).
- `-f`: **Feature Count**. Number of features to use for alignment (the tool uses a range of +/- 10% of this value). At least 100 features are recommended.
- `-c`: **Breakpoint Cost**. Determines the flexibility of the alignment curve. Lower values (e.g., 0.3) allow more breakpoints (more flexible); higher values (e.g., 0.5) make the curve more rigid.
- `-d`: **Fitness**. Weight given to points the curve passes through. Default is 1.

### Scan Range and Boundary Parameters
- `-R <start>,<end>`: Defines the MS scan range to process.
- `-X <value>`: Endpoint X value (typically `end_scan + 500` to `1000`).
- `-Y <value>`: Endpoint Y value (typically `end_scan + 500` to `1000`).

## Best Practices
- **Master Selection**: Choose the most representative or highest-quality run as the master file (`-2`) when aligning a large batch of samples.
- **Feature Density**: For complex samples (e.g., cell lysates), increase the number of features (`-f`) to ensure a robust fit across the entire gradient.
- **Boundary Conditions**: Always set `-X` and `-Y` values significantly beyond your last scan to ensure the piecewise curve-fitting algorithm has sufficient "room" to terminate correctly.
- **Workflow Integration**: While the binary performs the alignment calculation, the `wrap_mzXML.R` script is typically used in conjunction to apply the calculated transformation and generate the new, aligned `.mzXML` files.

## Reference documentation
- [msalign2 Overview](./references/www_ms-utils_org_msalign2_index.html.md)
- [Bioconda Package Info](./references/anaconda_org_channels_bioconda_packages_msalign2_overview.md)