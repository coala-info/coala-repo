# isa2w4m CWL Generation Report

## isa2w4m

### Tool Description
Script for extracting assays from ISATab data and outputing in W4M format.

### Metadata
- **Docker Image**: biocontainers/isa2w4m:phenomenal-v1.1.0_cv1.4.11
- **Homepage**: https://github.com/workflow4metabolomics/isa2w4m
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/isa2w4m/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/workflow4metabolomics/isa2w4m
- **Stars**: N/A
### Original Help Text
```text
usage: isa2w4m.py [-h] [-a ALL_ASSAYS] -i INPUT_DIR [-f ASSAY_FILENAME]
                  [-n STUDY_FILENAME] [-d OUTPUT_DIR] [-s SAMPLE_OUTPUT]
                  [-v VARIABLE_OUTPUT] [-m MATRIX_OUTPUT]
                  [-S SAMP_NA_FILTERING] [-V VAR_NA_FILTERING]

Script for extracting assays from ISATab data and outputing in W4M format.

optional arguments:
  -h, --help            show this help message and exit
  -a ALL_ASSAYS         Extract all assays.
  -i INPUT_DIR          Input directory containing the ISA-Tab files.
  -f ASSAY_FILENAME     Filename of the assay to extract. If unset, the first
                        assay of the chosen study will be used.
  -n STUDY_FILENAME     Filename of the study to extract. If unset, the first
                        study found will be used.
  -d OUTPUT_DIR         Set output directory. Default is ".".
  -s SAMPLE_OUTPUT      Output file for sample metadata. You can use it as a
                        template, where %s will be replaced by the study name
                        and %a by the assay filename. Default is
                        "%s-%a-sample-metadata.tsv".
  -v VARIABLE_OUTPUT    Output file for variable metadata. You can use it as a
                        template, where %s will be replaced by the study name
                        and %a by the assay filename. Default is
                        "%s-%a-variable-metadata.tsv".
  -m MATRIX_OUTPUT      Output file for sample x variable matrix. You can use
                        it as a template, where %s will be replaced by the
                        study name and %a by the assay filename. Default is
                        "%s-%a-sample-variable-matrix.tsv".
  -S SAMP_NA_FILTERING  Filter out NA values in the specified sample metadata
                        columns. The value is a comma separated list of column
                        names.
  -V VAR_NA_FILTERING   Filter out NA values in the specified variable
                        metadata columns. The value is a comma separated list
                        of column names.
```


## Metadata
- **Skill**: generated

## isa2w4m

### Tool Description
Script for extracting assays from ISATab data and outputing in W4M format.

### Metadata
- **Docker Image**: biocontainers/isa2w4m:phenomenal-v1.1.0_cv1.4.11
- **Homepage**: https://github.com/workflow4metabolomics/isa2w4m
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
usage: isa2w4m.py [-h] [-a ALL_ASSAYS] -i INPUT_DIR [-f ASSAY_FILENAME]
                  [-n STUDY_FILENAME] [-d OUTPUT_DIR] [-s SAMPLE_OUTPUT]
                  [-v VARIABLE_OUTPUT] [-m MATRIX_OUTPUT]
                  [-S SAMP_NA_FILTERING] [-V VAR_NA_FILTERING]

Script for extracting assays from ISATab data and outputing in W4M format.

optional arguments:
  -h, --help            show this help message and exit
  -a ALL_ASSAYS         Extract all assays.
  -i INPUT_DIR          Input directory containing the ISA-Tab files.
  -f ASSAY_FILENAME     Filename of the assay to extract. If unset, the first
                        assay of the chosen study will be used.
  -n STUDY_FILENAME     Filename of the study to extract. If unset, the first
                        study found will be used.
  -d OUTPUT_DIR         Set output directory. Default is ".".
  -s SAMPLE_OUTPUT      Output file for sample metadata. You can use it as a
                        template, where %s will be replaced by the study name
                        and %a by the assay filename. Default is
                        "%s-%a-sample-metadata.tsv".
  -v VARIABLE_OUTPUT    Output file for variable metadata. You can use it as a
                        template, where %s will be replaced by the study name
                        and %a by the assay filename. Default is
                        "%s-%a-variable-metadata.tsv".
  -m MATRIX_OUTPUT      Output file for sample x variable matrix. You can use
                        it as a template, where %s will be replaced by the
                        study name and %a by the assay filename. Default is
                        "%s-%a-sample-variable-matrix.tsv".
  -S SAMP_NA_FILTERING  Filter out NA values in the specified sample metadata
                        columns. The value is a comma separated list of column
                        names.
  -V VAR_NA_FILTERING   Filter out NA values in the specified variable
                        metadata columns. The value is a comma separated list
                        of column names.
```

