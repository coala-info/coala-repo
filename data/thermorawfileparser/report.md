# thermorawfileparser CWL Generation Report

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

