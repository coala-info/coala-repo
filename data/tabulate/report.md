# tabulate CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tabulate | PASS | real KIR genotype table printed as pipe table and html; -o is used because the tool's --output option takes no value |

## tabulate

### Tool Description
Pretty-print tabular data.

### Metadata
- **Docker Image**: quay.io/biocontainers/tabulate:0.7.5--py36_0
- **Homepage**: https://github.com/astanin/python-tabulate
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tabulate/overview
- **Total Downloads**: 8.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/astanin/python-tabulate
- **Stars**: N/A
### Original Help Text
```text
option --h not a unique prefix
Usage: tabulate [options] [FILE ...]

Pretty-print tabular data.
See also https://bitbucket.org/astanin/python-tabulate

FILE                      a filename of the file with tabular data;
                          if "-" or missing, read data from stdin.

Options:

-h, --help                show this message
-1, --header              use the first row of data as a table header
-o FILE, --output FILE    print table to FILE (default: stdout)
-s REGEXP, --sep REGEXP   use a custom column separator (default: whitespace)
-F FPFMT, --float FPFMT   floating point number format (default: g)
-f FMT, --format FMT      set output table format; supported formats:
                          plain, simple, grid, fancy_grid, pipe, orgtbl,
                          rst, mediawiki, html, latex, latex_booktabs, tsv
                          (default: simple)
```

