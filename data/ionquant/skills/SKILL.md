---
name: ionquant
description: IonQuant is a high-performance tool for mass spectrometry quantification that supports label-free and labeling-based experiments. Use when user asks to perform MS1 peak tracing, quantify precursors using Match-Between-Runs, or process isobaric labeling data like TMT and iTRAQ.
homepage: https://github.com/Nesvilab/IonQuant
metadata:
  docker_image: "quay.io/biocontainers/ionquant:1.11.9--py311hdfd78af_0"
---

# ionquant

## Overview
IonQuant is a high-performance Java-based tool for mass spectrometry quantification. It provides fast MS1 peak tracing and supports both label-free and labeling-based (SILAC, TMT, iTRAQ) experiments. Its standout feature is a false discovery rate (FDR) controlled Match-Between-Runs (MBR) algorithm, which significantly increases the number of quantified precursors across multiple runs while maintaining statistical rigor. It is typically used as part of the FragPipe ecosystem but functions effectively as a standalone command-line utility.

## Installation and Requirements
- **Environment**: Requires Java 11 or higher.
- **Dependencies**: Requires the `ext` folder from the latest MSFragger release to be present in the same directory or accessible to the tool.
- **Windows Note**: Bruker's native libraries for timsTOF data require the Visual C++ Redistributable for Visual Studio 2017.

## Common CLI Patterns

### Basic Label-Free Quantification (LFQ)
To perform standard MS1 quantification using a PSM list and spectral files:
```bash
java -jar IonQuant.jar --specdir /path/to/spectra --psm /path/to/psm.tsv
```

### Match-Between-Runs (MBR)
To enable MBR to transfer identifications across runs and reduce missing values:
```bash
java -jar IonQuant.jar --specdir /path/to/spectra --psm /path/to/psm.tsv --mbr 1
```

### Isobaric Labeling (e.g., TMT-10)
For TMT or iTRAQ experiments, specify the type and the annotation file mapping:
```bash
java -jar IonQuant.jar --perform-isoquant 1 --isotype TMT-10 --annotation psm.tsv=annotation.txt --psm psm.tsv
```

### Multi-Experimental Output
When processing multiple experiments, define a specific output directory for the combined results:
```bash
java -jar IonQuant.jar --specdir /dir1 --psm /dir1/psm.tsv --multidir /path/to/output
```

## Parameter Best Practices

### Performance Tuning
- **Threads**: Use `--threads 0` (default) to automatically utilize all available logical cores.
- **Memory**: Ensure the JVM has enough heap space for large datasets (e.g., `java -Xmx32g -jar IonQuant.jar ...`).

### Quantification Accuracy
- **MaxLFQ**: Enabled by default (`--maxlfq 1`). This is recommended for protein-level quantification across multiple samples.
- **Normalization**: Enabled by default (`--normalization 1`). Keep this on unless you have performed manual normalization of intensities.
- **Ion Mobility**: If working with timsTOF/PASEF data, ensure `--ionmobility 1` is set (though the tool often auto-detects this from the data format).

### Tolerance Settings
- **MS1 Tolerance**: Default is `10.0` ppm (`--mztol`). Adjust to `20.0` for older or lower-resolution instruments.
- **RT Tolerance**: Default is `0.4` minutes (`--rttol`). For MBR, the default RT window is wider (`--mbrrttol 1.0`).

### Filtering
- **Min Isotopes/Scans**: The defaults (`--minisotopes 2`, `--minscans 3`) are generally optimal for balancing sensitivity and precision.
- **Excluding Modifications**: Use `--excludemods "M15.9949;C57.0215"` to ignore specific modifications during protein-level quantification.

## Reference documentation
- [IonQuant GitHub Repository](./references/github_com_Nesvilab_IonQuant.md)
- [IonQuant Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ionquant_overview.md)