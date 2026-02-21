---
name: rawtools
description: RawTools is a high-performance utility designed to process Thermo Orbitrap mass spectrometer data.
homepage: https://github.com/kevinkovalchik/RawTools
---

# rawtools

## Overview

RawTools is a high-performance utility designed to process Thermo Orbitrap mass spectrometer data. It transforms proprietary .raw files into accessible formats for downstream proteomics analysis. The tool excels at parsing scan metadata, performing quantification for multiplexed experiments (like TMT 16-plex and 18-plex), and generating comprehensive quality control metrics. It is a cross-platform solution, running natively on Windows and via Mono on Linux and MacOS.

## Common CLI Patterns

### Getting Help
To see all available commands and flags:
```bash
RawTools.exe -commands
```

### Basic Parsing and Quantification
In version 2.0.0+, parsing and QC can be performed simultaneously. Use the `-d` flag for a directory or `-f` for a specific file.
```bash
# Parse a directory of raw files
RawTools.exe -d C:\Data\Project1 -p

# Parse and include TMT 16-plex quantification
RawTools.exe -f sample.raw -p -tmt16
```

### Generating MGF Files
RawTools can generate Mascot Generic Format (MGF) files for search engines.
```bash
# Create MGF files for all MS2 scans
RawTools.exe -f sample.raw -mgf

# Create MGF files for specific MS levels
RawTools.exe -f sample.raw -mgfLevels 2,3
```

### Working with FAIMS Data
For High-Field Asymmetric Waveform Ion Mobility Spectrometry (FAIMS) data:
```bash
# Create separate MGF files for each Compensation Voltage (CV)
RawTools.exe -f faims_sample.raw -faimsMgf
```

### Extracted Ion Chromatograms (XIC)
Extract chromatogram data based on specific mass and tolerance settings:
```bash
RawTools.exe -f sample.raw -xic [mass] [tolerance]
```

### MS1 Data Extraction
For files containing only MS1 scans or when specific MS1 metadata is required:
```bash
# Output MS1 scan data to a text file
RawTools.exe -f sample.raw -asd

# Parse chromatograms from MS1-only files
RawTools.exe -f sample.raw -ms1
```

## Expert Tips and Best Practices

*   **Memory Management**: RawTools loads significant portions of raw files into memory to increase speed. For files larger than 2GB, ensure your system has ample RAM. If processing files >5GB on Linux/MacOS, you may need to increase swap space to avoid crashes.
*   **Search Engine Integration**: While RawTools previously supported multiple engines, it is now optimized for use with **X! Tandem** as it has no external dependencies like Python.
*   **OS Specifics**: 
    *   **Windows**: Requires .NET 4.6.2 or greater.
    *   **Linux/MacOS**: Requires the **Mono** framework. Use `mono RawTools.exe [flags]` if the executable is not directly in your path.
*   **Visualization**: Use the companion `RawToolsViz.exe` for local visualization of QC and parse data. The older R Shiny application is deprecated in favor of this local tool.
*   **Automatic Detection**: Modern versions of RawTools automatically detect MS1-only files; you no longer need to manually invoke a specific "mode" for these files unless you need specific MS1 chromatogram parsing (`-ms1`).

## Reference documentation
- [RawTools GitHub Overview](./references/github_com_kevinkovalchik_RawTools.md)
- [RawTools Wiki and Installation](./references/github_com_kevinkovalchik_RawTools_wiki.md)
- [Bioconda RawTools Package](./references/anaconda_org_channels_bioconda_packages_rawtools_overview.md)