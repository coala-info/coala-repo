---
name: xtandem
description: Performs tandem mass spectrometry analysis to identify peptides and proteins from mass spectrometry data. Use when Claude needs to analyze raw mass spectrometry data to identify peptides and proteins, or when performing de novo sequencing.
homepage: https://github.com/bspratt/xtandem-g
metadata:
  docker_image: "quay.io/biocontainers/xtandem:15.12.15.2--0"
---

# xtandem

Performs tandem mass spectrometry analysis to identify peptides and proteins from mass spectrometry data.
  Use when Claude needs to analyze raw mass spectrometry data (e.g., mzML, mzXML) to identify peptides and proteins,
  or when performing de novo sequencing. This tool is particularly useful for researchers in proteomics and
  biinformatics.
---
## Overview

The xtandem skill is designed to facilitate the analysis of tandem mass spectrometry data for peptide and protein identification. It takes raw mass spectrometry files as input and outputs identified peptides and their associated proteins, along with confidence scores. This tool is a core component in many proteomics workflows.

## Usage Instructions

X!Tandem is a command-line tool. The primary executable is `tandem`. It requires an input XML parameter file and one or more input spectrum files.

### Basic Usage

The most common way to run X!Tandem is by providing a parameter file and a spectrum file:

```bash
tandem parameter_file.xml spectrum_file.mzML
```

### Parameter File Configuration

The behavior of X!Tandem is controlled by an XML parameter file. This file specifies search parameters, scoring algorithms, and output formats.

**Key parameters to consider:**

*   **`//input/@clean`**: Controls whether to remove duplicate precursor masses. Set to `T` for cleaning.
*   **`//input/@skip`**: Controls whether to skip spectra that have already been processed. Set to `T` to skip.
*   **`//input/@noisy`**: Controls whether to use noisy spectra. Set to `T` to include noisy spectra.
*   **`//search_engine/@maximum_time`**: The maximum time (in seconds) to spend on a single spectrum.
*   **`//scoring/@model`**: The scoring model to use (e.g., `peptide-prophet`, `k-score`).
*   **`//output/@prefix`**: A prefix for output files.
*   **`//output/@path`**: The directory where output files will be saved.

**Example of a minimal parameter file (`params.xml`):**

```xml
<?xml version="1.0" ?>
<parameters>
    <input>
        <search_model>peptide</search_model>
        <protein>
            <database>your_protein_database.fasta</database>
        </protein>
    </input>
    <output>
        <path>./</path>
        <prefix>xtandem_output</prefix>
    </output>
    <search_engine>
        <maximum_time>3600</maximum_time>
    </search_engine>
    <scoring>
        <model>peptide-prophet</model>
    </scoring>
</parameters>
```

### Input Spectrum Files

X!Tandem supports various spectrum file formats, including:

*   mzML (`.mzML`)
*   mzXML (`.mzXML`)
*   MGF (`.mgf`)

### Output Files

X!Tandem generates several output files, typically including:

*   `xtandem_output.pep.xml`: Peptide-level identification results in XML format.
*   `xtandem_output.prot.xml`: Protein-level identification results in XML format.
*   `xtandem_output.tandem.txt`: A tab-delimited summary of results.

### Expert Tips

*   **Database preparation**: Ensure your protein sequence database (`.fasta` file) is properly formatted and contains only the sequences relevant to your experiment.
*   **Parameter tuning**: Experiment with different scoring models and search parameters to optimize results for your specific dataset. The `//scoring/@model` parameter is crucial for downstream analysis.
*   **Resource management**: For large datasets, consider adjusting parameters related to memory usage and processing time. The `//search_engine/@maximum_time` can be adjusted to balance speed and thoroughness.
*   **GPU acceleration**: While the `xtandem-g` repository explores GPU acceleration, the standard `tandem` executable does not inherently utilize GPUs. For GPU-accelerated analysis, a specialized build or tool might be required.

## Reference documentation

*   [X!Tandem Overview](https://thegpm.org/xtandem/) (External documentation, not directly linked as a reference file)
*   [GitHub Repository for GPU-enabled X!Tandem](https://github.com/bspratt/xtandem-g) (For context on potential GPU acceleration, but not for direct CLI usage instructions)