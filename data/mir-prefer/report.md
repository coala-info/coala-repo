# mir-prefer CWL Generation Report

## mir-prefer_miR_PREFeR.py

### Tool Description
miR-PREFeR is a tool for predicting miRNAs.

### Metadata
- **Docker Image**: quay.io/biocontainers/mir-prefer:0.24--py27_0
- **Homepage**: https://github.com/hangelwen/miR-PREFeR
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mir-prefer/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hangelwen/miR-PREFeR
- **Stars**: N/A
### Original Help Text
```text
Usage: python mir_PREFeR.py [options] command configfile

    command could be one of the following:
    check = Check the dependency and the config file only (default).
    prepare = Prepare data.
    candidate = Generate candidate regions.
    fold = Fold the candidate regions.
    predict = Predict miRNAs.
    pipeline = Run the whole pipeline. This is the same as running 'check', 'prepare', 'candidate', 'fold', and 'predict' sequentially.
    recover = Recover a unfinished job. By default, miR-PREFeR makes checkpoint of the results of each stage. Thus, an unfinished job can be started from where it was checkpointed to save time.

configfile: configuration file

Options:
  -h, --help            show this help message and exit
  -L, --log             Generate a log file.
  -k, --keep-tmp        After finish the whole pipeline, do not remove the
                        temporary folder that contains the intermidate files.
  -d, --output-detail-for-debug
```

