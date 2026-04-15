---
name: msfragger
description: MSFragger is a high-performance database search engine used to identify peptides and proteins from mass spectrometry proteomics data. Use when user asks to perform fast database searches, conduct open searches for unknown modifications, or process large-scale datasets from instruments like the Bruker timsTOF.
homepage: https://github.com/Nesvilab/MSFragger
metadata:
  docker_image: "quay.io/biocontainers/msfragger:4.2--py311hdfd78af_0"
---

# msfragger

## Overview
MSFragger is a high-performance database search engine for proteomics data. It stands out for its extreme speed, achieved through a fragment ion indexing strategy. This efficiency makes it the preferred tool for "open" searches—where the precursor mass tolerance is set very wide (hundreds of Daltons) to identify unknown modifications—as well as for processing massive datasets from modern instruments like the Bruker timsTOF. It integrates into larger workflows via FragPipe or can be used as a standalone command-line tool.

## Command Line Usage
MSFragger is distributed as a Java JAR file. The basic execution pattern follows standard Java CLI conventions.

### Basic Execution
```bash
java -Xmx16G -jar MSFragger.jar <parameter_file> <spectra_files>
```
- **-Xmx**: This flag is critical. MSFragger loads the fragment index into memory. For a human proteome search, 16GB is a standard starting point, but open searches or complex modification searches may require 32GB, 64GB, or more.
- **parameter_file**: A `.params` file containing search settings (enzyme, modifications, tolerances).
- **spectra_files**: One or more mass spectrometry files (.mzML, .mzXML, .raw, or .d).

### Input Formats
- **mzML/mzXML**: Standard open formats.
- **Thermo RAW**: Can be read directly (requires Mono on Linux).
- **Bruker timsTOF (.d)**: Supported directly; requires the Visual C++ Redistributable on Windows.

## Search Configurations
MSFragger behavior is primarily dictated by the parameter file. Common search modes include:

1. **Closed Search**: Standard search with narrow precursor mass tolerance (e.g., 20 ppm). Used for identifying known peptides with specific modifications.
2. **Open Search**: Wide precursor tolerance (e.g., 500 Da). Used to identify peptides with unexpected or mass-shifting modifications.
3. **Non-specific/Peptidome**: Search without enzyme constraints. Requires significant memory and time compared to tryptic searches.
4. **Labile/Glyco**: Specialized modes for PTMs that fragment easily, such as phosphorylation or glycosylation.

## Expert Tips and Best Practices
- **Memory Scaling**: If the tool crashes with an `OutOfMemoryError`, increase the `-Xmx` value. The memory requirement scales with the size of the protein database and the number of variable modifications.
- **Thread Utilization**: MSFragger automatically utilizes available CPU cores. Ensure the environment has sufficient threads allocated to maximize the indexing speed.
- **Output Compatibility**: MSFragger produces `.pepXML` and tabular files. These are natively compatible with downstream tools like Philosopher, Percolator, and the Trans-Proteomic Pipeline (TPP).
- **Database Preparation**: Always use a "decoy" database (reversed or shuffled sequences) to enable False Discovery Rate (FDR) estimation in downstream tools.
- **Direct RAW Access**: Whenever possible, use `.raw` or `.d` files directly to avoid the overhead and potential data loss of converting to mzML.

## Reference documentation
- [MSFragger GitHub Repository](./references/github_com_Nesvilab_MSFragger.md)
- [MSFragger Wiki](./references/github_com_Nesvilab_MSFragger_wiki.md)
- [MSFragger Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_msfragger_overview.md)