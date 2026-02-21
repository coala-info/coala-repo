---
name: thermorawfileparser
description: The `thermorawfileparser` is a cross-platform utility designed to liberate proprietary mass spectrometry data from Thermo RAW files.
homepage: https://github.com/compomics/ThermoRawFileParser
---

# thermorawfileparser

## Overview
The `thermorawfileparser` is a cross-platform utility designed to liberate proprietary mass spectrometry data from Thermo RAW files. It enables researchers to convert raw instrument data into standardized formats like mzML (for general proteomics workflows), MGF (for database searching), or Apache Parquet (for big data analytics). Beyond simple conversion, it provides subcommands for targeted data retrieval, such as extracting Extracted Ion Chromatograms (XIC) or querying specific spectra via scan numbers.

## Core CLI Usage

### Basic Conversion
The most common use case is converting a single RAW file or a directory of files to indexed mzML (the default format).

```bash
# Convert a single file to indexed mzML (default)
ThermoRawFileParser -i=/path/to/input.raw -o=/path/to/output/

# Convert a directory of RAW files
ThermoRawFileParser -d=/path/to/raw_directory/ -o=/path/to/output/
```

### Format Selection
Use the `-f` (or `--format`) flag to specify the output. You can use either the numeric ID or the string name.

| Format | Numeric ID | String Value |
| :--- | :--- | :--- |
| MGF | 0 | mgf |
| mzML | 1 | mzml |
| Indexed mzML | 2 | indexedmzml |
| Parquet | 3 | parquet |
| None | 4 | none |

```bash
# Convert to MGF for database searching
ThermoRawFileParser -i=data.raw -f=0

# Convert to gzipped mzML
ThermoRawFileParser -i=data.raw -f=mzml -g
```

### Metadata Extraction
To extract instrument metadata without converting the full spectral data, set the format to `none` and specify a metadata format.

```bash
# Extract metadata as JSON
ThermoRawFileParser -i=data.raw -f=4 -m=0

# Extract metadata as TXT
ThermoRawFileParser -i=data.raw -f=4 -m=1
```

## Advanced Operations

### Peak Picking and Filtering
By default, the tool uses native Thermo peak picking. You can disable this or filter by MS level.

```bash
# Disable native peak picking
ThermoRawFileParser -i=data.raw -p

# Disable peak picking only for MS2 and MS3
ThermoRawFileParser -i=data.raw -p=2,3

# Only include MS1 and MS2 scans in the output
ThermoRawFileParser -i=data.raw -L=1,2
```

### Querying Specific Scans
Use the `query` subcommand to retrieve specific spectra in PROXI JSON format.

```bash
# Extract scans 1 through 5 and scan 20
ThermoRawFileParser query -i=data.raw -n="1-5, 20" -o=output.json
```

### XIC Extraction
The `xic` subcommand extracts chromatogram data based on a JSON input filter.

```bash
# Extract XIC based on a filter file
ThermoRawFileParser xic -i=data.raw -f=filter.json
```

## Expert Tips
- **Performance**: When processing large batches, use the `-d` directory input rather than calling the tool repeatedly for individual files to reduce overhead.
- **STDOUT**: Use `-s` to pipe output directly to another tool. This automatically disables indexing for mzML to ensure compatibility with streaming.
- **S3 Integration**: The tool natively supports writing to S3 buckets using the `-u` (URL), `-k` (Access Key), and `-t` (Secret Key) flags.
- **Error Handling**: Use `-w` (warningsAreErrors) in CI/CD pipelines to ensure that any data inconsistencies result in a non-zero exit code.
- **Memory/Runtime**: For .NET 8 versions (v2.0.0+), the `mono` prefix is no longer required. Use `dotnet ThermoRawFileParser.dll` or the self-contained executable.

## Reference documentation
- [ThermoRawFileParser Main Documentation](./references/github_com_compomics_ThermoRawFileParser.md)
- [Release Notes and Version History](./references/github_com_compomics_ThermoRawFileParser_wiki_ReleaseNotes.md)