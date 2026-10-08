# epicore CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| epicore_generate-epicore-csv | Not completed | rewrote the file with the real subcommand; it runs, but the epitope groups differ from the repository's expected result file, which may be from a newer version |
| epicore_plot-landscape | PASS | Rewrote the file with the real subcommand; drew a landscape plot (SVG and PDF) from the result of the test evidence file. |

## epicore_generate-epicore-csv

### Tool Description
epicore

### Metadata
- **Docker Image**: quay.io/biocontainers/epicore:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/AG-Walz/epicore
- **Package**: https://anaconda.org/channels/bioconda/packages/epicore/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/epicore/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-10-17
- **GitHub**: https://github.com/AG-Walz/epicore
- **Stars**: N/A
### Original Help Text
```text
Usage: epicore generate-epicore-csv [OPTIONS]

Options:
  --evidence_file PATH      [required]
  --html
  --report
  --end_column TEXT
  --start_column TEXT
  --prot_accession TEXT
  --mod_pattern TEXT
  --delimiter TEXT          [required]
  --intensity_column TEXT
  --protacc_column TEXT     [required]
  --seq_column TEXT         [required]
  --max_step_size INTEGER   [required]
  --min_overlap INTEGER
  --min_epi_length INTEGER
  --help                    Show this message and exit.
```


## epicore_plot-landscape

### Tool Description
Epicore is a tool for analyzing and visualizing genomic data.

### Metadata
- **Docker Image**: quay.io/biocontainers/epicore:0.1.7--pyhdfd78af_0
- **Homepage**: https://github.com/AG-Walz/epicore
- **Package**: https://anaconda.org/channels/bioconda/packages/epicore/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: epicore plot-landscape [OPTIONS]

Options:
  --epicore_csv PATH  [required]
  --protacc TEXT      [required]
  --help              Show this message and exit.
```


## Metadata
- **Skill**: generated
