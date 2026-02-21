# ped_parser CWL Generation Report

## ped_parser

### Tool Description
Tool for parsing ped files. Default is to prints the family file to in ped format to output.

### Metadata
- **Docker Image**: quay.io/biocontainers/ped_parser:1.6.6--py27_1
- **Homepage**: https://github.com/moonso/ped_parser
- **Package**: https://anaconda.org/channels/bioconda/packages/ped_parser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ped_parser/overview
- **Total Downloads**: 15.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/moonso/ped_parser
- **Stars**: N/A
### Original Help Text
```text
Usage: ped_parser [OPTIONS] <family_file> or -

  Tool for parsing ped files.

  Default is to prints the family file to in ped format to output.  For more
  information, please see github.com/moonso/ped_parser.

Options:
  -t, --family_type [ped|alt|cmms|mip]
                                  If the analysis use one of the known setups,
                                  please specify which one. Default is ped
  -o, --outfile FILENAME          Specify the path to a file where results
                                  should be stored.
  --cmms_check                    If the id is in cmms format.
  --to_json                       Print the ped file in json format.
  --to_madeline                   Print the ped file in madeline format.
  --to_ped                        Print the ped file in ped format with
                                  headers.
  --to_dict                       Print the ped file in ped format with
                                  headers.
  -v, --verbose                   Increase output verbosity.
  --version
  -l, --logfile PATH              Path to log file. If none logging is printed
                                  to stderr.
  --loglevel [DEBUG|INFO|WARNING|ERROR|CRITICAL]
                                  Set the level of log output.
  --help                          Show this message and exit.
```


## Metadata
- **Skill**: generated
