# radtk CWL Generation Report

## radtk_cat

### Tool Description
concatenate the records in a sequence of RAD files

### Metadata
- **Docker Image**: quay.io/biocontainers/radtk:0.2.0--ha6fb395_1
- **Homepage**: https://github.com/COMBINE-lab/radtk
- **Package**: https://anaconda.org/channels/bioconda/packages/radtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/radtk/overview
- **Total Downloads**: 911
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/COMBINE-lab/radtk
- **Stars**: N/A
### Original Help Text
```text
concatenate the records in a sequence of RAD files

Usage: radtk cat --inputs <INPUTS> --output <OUTPUT>

Options:
  -i, --inputs <INPUTS>  ',' separated list of input RAD files
  -o, --output <OUTPUT>  output RAD file
  -h, --help             Print help
  -V, --version          Print version
```


## radtk_view

### Tool Description
view a text representation of the RAD file

### Metadata
- **Docker Image**: quay.io/biocontainers/radtk:0.2.0--ha6fb395_1
- **Homepage**: https://github.com/COMBINE-lab/radtk
- **Package**: https://anaconda.org/channels/bioconda/packages/radtk/overview
- **Validation**: PASS

### Original Help Text
```text
view a text representation of the RAD file

Usage: radtk view [OPTIONS] --input <INPUT> --rad-type <RAD_TYPE>

Options:
  -i, --input <INPUT>            the input RAD file to print
  -o, --output <OUTPUT>          output file where the JSON format RAD file will be written; if not provided, the output will be written to standard out
  -r, --rad-type <RAD_TYPE>      the type of input RAD file [possible values: bulk, single-cell, unknown]
      --use-ref-name             use the reference name rather than ID in the mapped records
      --no-header                skip printing the header and file-level tags (i.e. only print the mapping reacords)
      --max-chunks <MAX_CHUNKS>  print the records from at most this many chunks
  -h, --help                     Print help
  -V, --version                  Print version
```


## radtk_split

### Tool Description
split an input RAD file into multiple output files

### Metadata
- **Docker Image**: quay.io/biocontainers/radtk:0.2.0--ha6fb395_1
- **Homepage**: https://github.com/COMBINE-lab/radtk
- **Package**: https://anaconda.org/channels/bioconda/packages/radtk/overview
- **Validation**: PASS

### Original Help Text
```text
split an input RAD file into multiple output files

Usage: radtk split [OPTIONS] --input <INPUT> --num-reads <NUM_READS> --output-prefix <OUTPUT_PREFIX>

Options:
  -i, --input <INPUT>                  input RAD file to split
  -n, --num-reads <NUM_READS>          approximate number of reads in each sub-RAD file (Note: This is approximate because file chunks will not be split and input chunks will reside entirely within a single output file)
  -o, --output-prefix <OUTPUT_PREFIX>  output prefix
  -q, --quiet                          be quiet (no progress bar or standard output messages)
  -h, --help                           Print help
  -V, --version                        Print version
```

