# cmappy CWL Generation Report

## cmappy_python -m cmapPy.pandasGEXpress.gct2gctx

### Tool Description
Command-line script to convert a .gct file to .gctx. Main method takes in a .gct file path (and, optionally, an out path and/or name to which to save the equivalent .gctx) and saves the enclosed content to a .gctx file. Note: Only supports v1.3 .gct files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmappy:4.0.1--py39h2de1943_8
- **Homepage**: https://github.com/cmap/cmapPy
- **Package**: https://anaconda.org/channels/bioconda/packages/cmappy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cmappy/overview
- **Total Downloads**: 113.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cmap/cmapPy
- **Stars**: N/A
### Original Help Text
```text
usage: gct2gctx.py [-h] -filename FILENAME [-output_filepath OUTPUT_FILEPATH]
                   [-verbose] [-row_annot_path ROW_ANNOT_PATH]
                   [-col_annot_path COL_ANNOT_PATH]

Command-line script to convert a .gct file to .gctx. Main method takes in a
.gct file path (and, optionally, an out path and/or name to which to save the
equivalent .gctx) and saves the enclosed content to a .gctx file. Note: Only
supports v1.3 .gct files.

optional arguments:
  -h, --help            show this help message and exit
  -filename FILENAME, -f FILENAME
                        .gct file that you would like to convert to .gctx
                        (default: None)
  -output_filepath OUTPUT_FILEPATH, -o OUTPUT_FILEPATH
                        out path/name for output gctx file. Default is just to
                        modify the extension (default: None)
  -verbose, -v          Whether to print a bunch of output. (default: False)
  -row_annot_path ROW_ANNOT_PATH
                        Path to annotations file for rows (default: None)
  -col_annot_path COL_ANNOT_PATH
                        Path to annotations file for columns (default: None)
```


## cmappy_python -m cmapPy.pandasGEXpress.subset_gct

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/cmappy:4.0.1--py39h2de1943_8
- **Homepage**: https://github.com/cmap/cmapPy
- **Package**: https://anaconda.org/channels/bioconda/packages/cmappy/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
/usr/local/bin/python: No module named cmapPy.pandasGEXpress.subset_gct
```

