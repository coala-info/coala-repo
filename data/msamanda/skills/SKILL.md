---
name: msamanda
description: MS Amanda is a high-performance scoring system that identifies peptides from tandem mass spectrometry data by searching against protein databases. Use when user asks to identify peptides, search mass spectrometry spectra against a database, or run MS Amanda via the command line.
homepage: https://github.com/hgb-bin-proteomics/MSAmanda
---


# msamanda

## Overview

MS Amanda is a high-performance scoring system designed to identify peptides from tandem mass spectrometry data by searching against known protein databases. It is optimized for high-resolution and high-accuracy spectra, offering performance comparable to gold-standard algorithms like Mascot and SEQUEST. This skill focuses on the standalone version of MS Amanda 3.0, which can be integrated into automated proteomics pipelines or used directly via the command line on Windows, Linux, and macOS.

## Command Line Usage

The standalone version of MS Amanda is executed by providing a spectrum file, a protein database (FASTA), and a settings XML file.

### Basic Syntax

**Windows:**
```cmd
MSAmanda.exe -s <spectrum_file> -d <protein_database> -e <settings_xml> [-f <file_format>] [-o <output_filename>]
```

**Linux and macOS:**
```bash
./MSAmanda -s <spectrum_file> -d <protein_database> -e <settings_xml> [-f <file_format>] [-o <output_filename>]
```

### Arguments
- `-s`: Path to the tandem mass spectrometry spectrum file (e.g., .mgf, .mzML).
- `-d`: Path to the protein database file in FASTA format.
- `-e`: Path to the XML file containing search settings and parameters.
- `-f` (Optional): Specification of the output file format.
- `-o` (Optional): Custom name for the resulting output file.

## Best Practices and Expert Tips

### Environment Preparation
- **Permissions**: On Linux and macOS, ensure the binary has execution permissions before running: `chmod +x MSAmanda`.
- **Clean Workspace**: Before starting a new analysis with MS Amanda 3.0, delete all subfolders within the MSAmanda3.0 application folder to prevent configuration conflicts.
  - **Windows**: Located in `C:\ProgramData\MSAmanda3.0` (Note: ProgramData is a hidden folder).
  - **Linux/macOS**: Typically located in the user's home directory.
- **Dependencies**: MS Amanda 3.0 is standalone and no longer requires the Mono framework for Linux or macOS environments.

### Configuration Management
- **Settings XML**: The `settings.xml` file is the most critical component for search accuracy. It defines enzyme cleavage patterns, static and variable modifications, and mass tolerances.
- **High Resolution**: Ensure your mass tolerances in the settings file reflect the high-resolution nature of the data (e.g., using ppm for precursor tolerances).

### Integration
- MS Amanda can be called programmatically within larger pipelines. It is natively supported by tools like **SearchGUI** and **PeptideShaker**, which can simplify the management of the command-line arguments and settings files.

## Troubleshooting
- **Windows Execution**: If the executable fails to run after downloading, right-click the .zip file, go to **Properties**, and select **Unblock** before extracting.
- **Path Specification**: If the tool fails to find modifications or enzymes, ensure the paths in your settings XML are absolute or correctly relative to the executable.

## Reference documentation
- [MS Amanda Main Repository](./references/github_com_hgb-bin-proteomics_MSAmanda.md)