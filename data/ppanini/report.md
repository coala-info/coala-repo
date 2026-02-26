# ppanini CWL Generation Report

## ppanini

### Tool Description
ppanini

### Metadata
- **Docker Image**: quay.io/biocontainers/ppanini:0.7.4--py_0
- **Homepage**: http://huttenhower.sph.harvard.edu/ppanini
- **Package**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ppanini/overview
- **Total Downloads**: 15.1K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: ppanini [-h] -i INPUT_TABLE [-o OUTPUT_FOLDER] [--basename BASENAME]
               [--uniref2go UNIREF2GO] [--log-level LOG_LEVEL]
               [--abundance-detection-level ABUNDANCE_DETECTION_LEVEL]
               [--tshld-abund TSHLD_ABUND] [--tshld-prev TSHLD_PREV]
               [--beta BETA] [--version]

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_TABLE, --input_table INPUT_TABLE
                        REQUIRED: Gene abundance table with metadata
  -o OUTPUT_FOLDER, --output-folder OUTPUT_FOLDER
                        Folder containing results
  --basename BASENAME   BASENAME for all the output files
  --uniref2go UNIREF2GO
                        uniref to GO term mapping file
  --log-level LOG_LEVEL
                        Choices: [DEBUG, INFO, WARNING, ERROR, CRITICAL]
  --abundance-detection-level ABUNDANCE_DETECTION_LEVEL
                        Detection level of normalized relative abundance
  --tshld-abund TSHLD_ABUND
                        [X] Percentile Cutoff for Abundance; Default=75th
  --tshld-prev TSHLD_PREV
                        Percentile cutoff for Prevalence
  --beta BETA           Beta parameter for weights on percentiles
  --version             prints the version
```


## Metadata
- **Skill**: generated
