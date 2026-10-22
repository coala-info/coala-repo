# thermorawfileparser CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| thermorawfileparser | PASS |  |
| thermorawfileparser_query | PASS |  |
| thermorawfileparser_xic | PASS |  |

## thermorawfileparser_xic

### Tool Description
Parses Thermo Fisher Scientific raw files to extract XIC data.

### Metadata
- **Docker Image**: quay.io/biocontainers/thermorawfileparser:2.0.0.dev--h9ee0642_0
- **Homepage**: https://github.com/compomics/ThermoRawFileParser
- **Package**: https://anaconda.org/channels/bioconda/packages/thermorawfileparser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/thermorawfileparser/overview
- **Total Downloads**: 88.3K
- **Last updated**: 2026-02-20
- **GitHub**: https://github.com/compomics/ThermoRawFileParser
- **Stars**: N/A
### Original Help Text
```text
-j, --json: specify an json input file. If you are not sure about the structure of the json file, use -p for printing an examplarily json input file
Error - usage is:
  -h, --help                 Prints out the options.
  -i, --input=VALUE          The raw file input (Required). Specify this or an
                               input directory -d
  -d, --input_directory=VALUE
                             The directory containing the raw files (Required).
                               Specify this or an input file -i.
  -j, --json=VALUE           The json input file (Required).
  -p, --print_example        Show a json input file example.
  -b, --output=VALUE         The output file. Specify this or an output
                               directory. Specifying neither writes to the
                               input directory.
  -o, --output_directory=VALUE
                             The output directory. Specify this or an output
                               file. Specifying neither writes to the input
                               directory.
  -6, --base64               Encodes the content of the xic vectors as base 64
                               encoded string.
  -s, --stdout               Pipes the output into standard output. Logging is
                               being turned off.
  -w, --warningsAreErrors    Return non-zero exit code for warnings; default
                               only for errors
  -l, --logging=VALUE        Optional logging level: 0 for silent, 1 for
                               verbose, 2 for default, 3 for warning, 4 for
                               error; both numeric and text (case insensitive)
                               value recognized.
```


## thermorawfileparser_query

### Tool Description
Parses Thermo raw files and queries scan information.

### Metadata
- **Docker Image**: quay.io/biocontainers/thermorawfileparser:2.0.0.dev--h9ee0642_0
- **Homepage**: https://github.com/compomics/ThermoRawFileParser
- **Package**: https://anaconda.org/channels/bioconda/packages/thermorawfileparser/overview
- **Validation**: PASS

### Original Help Text
```text
Exception of type 'Mono.Options.OptionException' was thrown.
usage is:
  -h, --help                 Prints out the options.
  -i, --input=VALUE          The raw file input (Required).
  -n, --scans=VALUE          The scan numbers. e.g. "1-5, 20, 25-30"
  -b, --output=VALUE         The output file. Specifying none writes the output
                               file to the input file parent directory.
  -p, --noPeakPicking        Don't use the peak picking provided by the native
                               Thermo library. By default peak picking is
                               enabled.
  -s, --stdout               Pipes the output into standard output. Logging is
                               being turned off
  -w, --warningsAreErrors    Return non-zero exit code for warnings; default
                               only for errors
  -l, --logging=VALUE        Optional logging level: 0 for silent, 1 for
                               verbose, 2 for default, 3 for warning, 4 for
                               error; both numeric and text (case insensitive)
                               value recognized.
```


## thermorawfileparser

### Tool Description
Convert Thermo RAW mass spectrometry files to open formats (MGF, mzML, indexed mzML, Parquet) and write metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/thermorawfileparser:2.0.0.dev--h9ee0642_0
- **Homepage**: https://github.com/CompOmics/ThermoRawFileParser
- **Package**: https://anaconda.org/channels/bioconda/packages/thermorawfileparser/overview
- **Validation**: PASS

### Original Help Text
```text
Usage is ThermoRawFileParser.exe [subcommand] [options]
optional subcommands are xic|query (use [subcommand] -h for more info]):
  -h, --help                 Prints out the options.
  -v, --version              Prints out the version of the executable.
  -i, --input=VALUE          The raw file input (Required). Specify this or an
                               input directory -d.
  -d, --input_directory=VALUE
                             The directory containing the raw files (Required).
                               Specify this or an input raw file -i.
  -b, --output=VALUE         The output file. Specify this or an output
                               directory -o. Specifying neither writes to the
                               input directory.
  -o, --output_directory=VALUE
                             The output directory. Specify this or an output
                               file -b. Specifying neither writes to the input
                               directory.
  -s, --stdout               Write to standard output. Cannot be combined with
                               file or directory output. Implies silent logging,
                                i.e. logging level 0
  -f, --format=VALUE         The spectra output format: 0 for MGF, 1 for mzML,
                               2 for indexed mzML, 3 for Parquet, 4 for None (
                               no output); both numeric and text (case
                               insensitive) value recognized. Defaults to
                               indexed mzML if no format is specified.
  -m, --metadata=VALUE       The metadata output format: 0 for JSON, 1 for TXT,
                               2 for None (no output); both numeric and text (
                               case insensitive) value recognized. Defaults to
                               None
  -c, --metadata_output_file=VALUE
                             The metadata output file. By default the metadata
                               file is written to the output directory.
  -g, --gzip                 GZip the output file.
  -p, --noPeakPicking[=VALUE]
                             Don't use the peak picking provided by the native
                               Thermo library. By default peak picking is
                               enabled. Optional argument allows disabling peak
                               peaking only for selected MS levels and should
                               be a comma-separated list of integers (1,2,3)
                               and/or intervals (1-3), open-end intervals (1-)
                               are allowed
  -z, --noZlibCompression    Don't use zlib compression for the m/z ratios and
                               intensities. By default zlib compression is
                               enabled.
  -a, --allDetectors         Extract additional detector data: UV/PDA etc
  -l, --logging=VALUE        Optional logging level: 0 for silent, 1 for
                               verbose, 2 for default, 3 for warning, 4 for
                               error; both numeric and text (case insensitive)
                               value recognized.
  -e, --ignoreInstrumentErrors
                             Ignore missing properties by the instrument.
  -x, --excludeExceptionData Exclude reference and exception data
  -L, --msLevel=VALUE        Select MS levels (MS1, MS2, etc) included in the
                               output, should be a comma-separated list of
                               integers (1,2,3) and/or intervals (1-3), open-
                               end intervals (1-) are allowed
  -P, --mgfPrecursor         Include precursor scan number in MGF file TITLE
  -N, --noiseData            Include noise data in mzML output
  -C, --chargeData           Include instrument detected charge states in mzML
                               output (only for high resolution centroided data)
  -w, --warningsAreErrors    Return non-zero exit code for warnings; default
                               only for errors
  -u, --s3_url[=VALUE]       Optional property to write directly the data into
                               S3 Storage.
  -k, --s3_accesskeyid[=VALUE]
                             Optional key for the S3 bucket to write the file
                               output.
  -t, --s3_secretaccesskey[=VALUE]
                             Optional key for the S3 bucket to write the file
                               output.
  -n, --s3_bucketName[=VALUE]
                             S3 bucket name
```

## Metadata
- **Skill**: generated
