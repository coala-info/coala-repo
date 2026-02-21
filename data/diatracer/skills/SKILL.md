---
name: diatracer
description: diaTracer is a specialized tool designed to handle the complexity of Bruker diaPASEF mass spectrometry data.
homepage: https://diatracer.nesvilab.org/
---

# diatracer

## Overview

diaTracer is a specialized tool designed to handle the complexity of Bruker diaPASEF mass spectrometry data. It performs three-dimensional peak tracing across m/z, retention time, and ion mobility dimensions to group precursor and fragment signals. By generating "pseudo-MS/MS" spectra in mzML format, it allows DIA data to be searched using standard DDA-style search engines like MSFragger. Use this skill to configure extraction parameters, optimize processing speed, and prepare data for downstream spectral library generation or open searches.

## Environment Requirements

- **Java Runtime**: Requires Java 11 or higher.
- **Dependencies**: Ensure the `ext` folder from the latest MSFragger release is present in the same directory as the diaTracer JAR file for proper raw data access.

## Command Line Usage

The basic syntax for running diaTracer is:

`java -jar diaTracer.jar --dFilePath <path_to_data.d> --threadNum <number_of_threads> [options]`

### Common Execution Patterns

**Standard Extraction**
Run a basic conversion with default settings for high-resolution HeLa or similar complex samples:
`java -jar diaTracer.jar -d ./sample.d -t 12 -w ./output_dir`

**Optimizing for Speed and Memory**
As of version 2.2.1, diaTracer has a significantly reduced memory footprint. Use the `-t` flag to match the available physical cores for maximum throughput.

**Tuning Feature Matching**
If the alignment between MS1 and MS2 signals is poor, adjust the delta ranges:
- Increase `-dR` (Retention Time delta) if there is significant chromatographic shifting.
- Adjust `-dI` (Ion Mobility delta) to tighten or loosen the 1/K0 matching window.

**Filtering Redundant Signals**
To reduce the size of the resulting mzML and improve search speed, ensure the mass defect filter is active:
`java -jar diaTracer.jar -d ./sample.d -mF 1 -mO 0.1`

## Parameter Reference

| Flag | Parameter | Description | Default |
|------|-----------|-------------|---------|
| `-d` | `--dFilePath` | Path to the Bruker .d folder. | Required |
| `-t` | `--threadNum` | Number of CPU threads to utilize. | Required |
| `-w` | `--workDir` | Directory for output files. | Current Dir |
| `-dI`| `--deltaApexIM`| Ion mobility delta range for MS1/MS2 matching. | 0.01 |
| `-dR`| `--deltaApexRT`| Apex scan delta range for MS1/MS2 matching. | 3 |
| `-mC`| `--ms1MS2Corr`| Correlation threshold between MS1 and MS2. | 0.3 |
| `-mF`| `--massDefectFilter`| Apply mass defect filter (1: Yes, 0: No). | 1 |
| `-rM`| `--RFMax` | Maximum number of peaks to keep per spectrum. | 500 |

## Expert Tips

- **Library-Free Workflows**: Use the generated mzML files directly in FragPipe/MSFragger to build a spectral library from the DIA data itself, which is particularly useful for non-model organisms or PTM-heavy samples.
- **Isotope Filtering**: Version 1.2.5+ includes an optimized isotope-filtering process. If you are using an older version, upgrade to significantly reduce the output mzML file size.
- **Specialized Formats**: Version 2.2.1+ supports Synchro-PASEF and Slice-PASEF formats. Ensure you are using the latest JAR when working with these newer acquisition modes.
- **Intermediate Files**: Use `-r 1` only for debugging. It writes intermediate files that can consume significant disk space during large batch runs.

## Reference documentation

- [diaTracer Overview](./references/diatracer_nesvilab_org_index.md)
- [Changelog and Version Requirements](./references/diatracer_nesvilab_org_CHANGELOG.html.md)