# lirtmats CWL Generation Report

## lirtmats_cli

### Tool Description
Executing lirtmats version 1.0.0.

### Metadata
- **Docker Image**: quay.io/biocontainers/lirtmats:1.0.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/lirtmats/
- **Package**: https://anaconda.org/channels/bioconda/packages/lirtmats/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lirtmats/overview
- **Total Downloads**: 35
- **Last updated**: 2025-12-14
- **GitHub**: https://github.com/wanchanglin/lirtmats
- **Stars**: N/A
### Original Help Text
```text
Executing lirtmats version 1.0.0.
usage: lirtmats cli [-h] --input-data INPUT_DATA [--col-idx COL_IDX]
                    [--input-sep {tab,comma}] [--rt-path RT_PATH]
                    [--rt-sep {tab,comma}] [--rt-tol RT_TOL]
                    [--ion-mode {pos,neg}] [--save-db]
                    [--summ-type {xlsx,tsv,csv}]

options:
  -h, --help            show this help message and exit
  --input-data INPUT_DATA
                        Data set including peak-list.
  --col-idx COL_IDX     Column index of name, mz, rt and start of data
                        intensity
  --input-sep {tab,comma}
                        Values in input or output file are separated by this
                        character.
  --rt-path RT_PATH     Retention time reference file for matching.
  --rt-sep {tab,comma}  Delimiter in retention time reference file
  --rt-tol RT_TOL       Retention time tolerance in seconds.
  --ion-mode {pos,neg}  Ion mode of data set.
  --save-db             Save all results in a sql database.
  --summ-type {xlsx,tsv,csv}
                        Retention time matching result file format.
```


## lirtmats_gui

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/lirtmats:1.0.0--pyhdfd78af_0
- **Homepage**: https://pypi.org/project/lirtmats/
- **Package**: https://anaconda.org/channels/bioconda/packages/lirtmats/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Executing lirtmats version 1.0.0.
usage: lirtmats gui [-h]

options:
  -h, --help  show this help message and exit
```

