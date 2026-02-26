# viramp-hub CWL Generation Report

## viramp-hub_scheme-convert

### Tool Description
Converts scheme files between different formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/viramp-hub:0.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/wm75/viramp-hub
- **Package**: https://anaconda.org/channels/bioconda/packages/viramp-hub/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/viramp-hub/overview
- **Total Downloads**: 1.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/wm75/viramp-hub
- **Stars**: N/A
### Original Help Text
```text
usage: scheme-convert [-h] -o OUTPUT [-a AMPLICON_INFO] -t {bed,amplicon-info}
                      [-b {ivar,cojac}] [-r {full,inner,outer}] [-f {bed}]
                      input

positional arguments:
  input                 Input file

options:
  -h, --help            show this help message and exit
  -o OUTPUT, --output OUTPUT
                        Name of the output file
  -a AMPLICON_INFO, --amplicon-info AMPLICON_INFO
                        Amplicon info file for inputs from which primer
                        groupings cannot be infered.
  -t {bed,amplicon-info}, --to {bed,amplicon-info}
                        Type of output to be generated
  -b {ivar,cojac}, --bed-type {ivar,cojac}
                        For "bed" output, the type of bed to be written;
                        Currently, you can specify "ivar" to produce primer
                        bed output compatible with the ivar suite of tools, or
                        "cojac" to generate the amplicon insert bed expected
                        by cojac.
  -r {full,inner,outer}, --report-nested {full,inner,outer}
                        For amplicons formed by nested primers, report all
                        primers, or just inner or outer ones. Applied only
                        when writing amplicon info files (default: "full").
  -f {bed}, --from {bed}
                        Format of the input file (only "bed" is supported in
                        this version)
```

