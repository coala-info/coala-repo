# flumut CWL Generation Report

## flumut

### Tool Description
Flumut is a tool for the detection of mutations in influenza viruses.

### Metadata
- **Docker Image**: quay.io/biocontainers/flumut:0.6.4--pyhdfd78af_0
- **Homepage**: https://github.com/izsvenezie-virology/FluMut
- **Package**: https://anaconda.org/channels/bioconda/packages/flumut/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flumut/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/izsvenezie-virology/FluMut
- **Stars**: N/A
### Original Help Text
```text
Usage: flumut [OPTIONS] FASTA_FILE

Options:
  -h, --help                      Show this message and exit.
  -v, --version                   Show the version and exit.
  -V, --all-versions              Prints all versions and exit.
  --update                        Update the database to the latest version
                                  and exit.
  -n, --name-regex TEXT           Set regular expression to parse sequence
                                  name.  [default:
                                  (?P<sample>.+)_(?P<segment>.+)]
  --skip-unmatch-names            Skip sequences with name that does not match
                                  the regular expression pattern.
  --skip-unknown-segments         Skip sequences with segment not present in
                                  the database.
  -r, --relaxed                   Report markers of which at least one
                                  mutation is found.
  -D, --db-file TEXT              Set source database.
  -m, --markers-output FILENAME   TSV markers output file.
  -M, --mutations-output FILENAME
                                  TSV mutations output file.
  -l, --literature-output FILENAME
                                  TSV literature output file.
  -x, --excel-output TEXT         Excel complete report.
```

