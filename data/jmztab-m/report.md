# jmztab-m CWL Generation Report

## jmztab-m

### Tool Description
Command-line interface for mzTab validation and conversion.

### Metadata
- **Docker Image**: quay.io/biocontainers/jmztab-m:1.0.6--hdfd78af_1
- **Homepage**: https://github.com/lifs-tools/jmztab-m
- **Package**: https://anaconda.org/channels/bioconda/packages/jmztab-m/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/jmztab-m/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lifs-tools/jmztab-m
- **Stars**: N/A
### Original Help Text
```text
usage: jmztabm-cli
 -c,--check <arg>           Example: -c /path/to/file.mztab. Check and
                            validate the provided a mzTab file.
    --fromJson              Example: --fromJson. Will parse inFile as JSON
                            and write mzTab representation to disk.
                            Requires validation to be successful!
 -h,--help                  Print help message.
 -l,--level <arg>           Choose validation level (Info, Warn, Error),
                            default level is Info!
 -m,--message               Example: -m 1002. Print validation message
                            detail information based on error code.
 -o,--outFile <arg>         Example: -o "output.txt". Record validation
                            messages into outfile. If not set, print
                            validation messages to stdout/stderr.
 -s,--checkSemantic <arg>   Example: -s /path/to/mappingFile.xml. Use the
                            provided mapping file for semantic validation.
                            If no mapping file is provided, the default
                            one will be used. Requires an active internet
                            connection!
    --toJson                Example: --toJson. Will write a json
                            representation of inFile to disk. Requires
                            validation to be successful!
 -v,--version               Print version information.
```

