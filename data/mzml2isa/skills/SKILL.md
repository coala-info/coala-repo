---
name: mzml2isa
description: The mzml2isa tool automates the generation of ISA-Tab metadata files from raw mass spectrometry data in mzML or imzML formats. Use when user asks to convert mzML files to ISA-Tab format, extract technical metadata from mass spectrometry files, or generate structured metadata for metabolomics studies.
homepage: https://github.com/ISA-tools/mzml2isa
---


# mzml2isa

## Overview
The `mzml2isa` tool is a specialized parser designed to automate the generation of ISA-Tab (Investigation/Study/Assay) metadata files from raw mass spectrometry data. By processing mzML or imzML files, it extracts technical metadata—such as instrument settings, software versions, and data processing parameters—and organizes them into the structured format required by the ISA framework. This tool is a critical component in metabolomics workflows, reducing the manual effort needed to document experimental runs and ensuring consistency between the raw data and the study metadata.

## Installation
The tool is primarily distributed via Bioconda:
```bash
conda install bioconda::mzml2isa
```

## Command Line Usage
The core functionality is accessed through a straightforward CLI. The tool requires an input directory containing your data files and an output directory for the generated ISA-Tab files.

### Basic Conversion
To convert a directory of mzML files into an ISA-Tab structure:
```bash
mzml2isa -i /path/to/mzml_files/ -o /path/to/out_folder/ -s <study_identifier>
```

### Key Arguments
- `-i, --input`: Path to the directory containing the source mzML or imzML files.
- `-o, --out`: Path to the directory where the ISA-Tab files (i_*.txt, s_*.txt, a_*.txt) will be created.
- `-s, --study`: A unique name or identifier for the study being processed.

## Best Practices and Expert Tips
- **Directory Organization**: Ensure all mzML files for a single study are grouped in one directory. `mzml2isa` processes the directory as a batch to build the study and assay files.
- **Supplemental Metadata**: Since mzML files do not contain biological context (e.g., species, sample treatment, or factor values), use the tool's ability to ingest supplemental JSON or XLS files to fill in these gaps during the conversion process.
- **Downstream Editing**: The output of `mzml2isa` provides the technical backbone of an ISA-Tab document. For complex studies, use the **ISAcreator** tool to refine the biological metadata after the initial extraction.
- **Data Validation**: After generation, verify that the `a_*.txt` (Assay) files correctly map the raw data files to the extracted instrument parameters.
- **Large Datasets**: For studies with hundreds of files, monitor memory usage, as the tool builds a metadata dictionary in memory before serializing to the ISA-Tab format.

## Reference documentation
- [mzml2isa - mzML to ISA-tab parsing tool](./references/github_com_ISA-tools_mzml2isa.md)
- [mzml2isa - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mzml2isa_overview.md)