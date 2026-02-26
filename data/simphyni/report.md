# simphyni CWL Generation Report

## simphyni_version

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/simphyni:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/jpeyemi/SimPhyNI
- **Package**: https://anaconda.org/channels/bioconda/packages/simphyni/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/simphyni/overview
- **Total Downloads**: 116
- **Last updated**: 2026-01-24
- **GitHub**: https://github.com/jpeyemi/SimPhyNI
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: simphyni version [-h]

options:
  -h, --help  show this help message and exit
```


## simphyni_download-examples

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/simphyni:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/jpeyemi/SimPhyNI
- **Package**: https://anaconda.org/channels/bioconda/packages/simphyni/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: simphyni download-examples [-h]

options:
  -h, --help  show this help message and exit
```


## simphyni_download-cluster-profile

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/simphyni:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/jpeyemi/SimPhyNI
- **Package**: https://anaconda.org/channels/bioconda/packages/simphyni/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: simphyni download-cluster-profile [-h]

options:
  -h, --help  show this help message and exit
```


## simphyni_run

### Tool Description
Run the simphyni analysis pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/simphyni:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/jpeyemi/SimPhyNI
- **Package**: https://anaconda.org/channels/bioconda/packages/simphyni/overview
- **Validation**: PASS

### Original Help Text
```text
usage: simphyni run [-h] [--samples SAMPLES] [-T TRAITS] [-t TREE]
                    [-r RUN_TRAITS] [--sample-name SAMPLE_NAME]
                    [--min_prev MIN_PREV] [--max_prev MAX_PREV] [-o OUTDIR]
                    [--temp-dir TEMP_DIR] [-c CORES] [--plot | --no-plot]
                    [--dry-run] [--profile PROFILE]
                    [--save-object | --no-save-object]
                    ...

positional arguments:
  snakemake_args        Extra arguments passed directly to snakemake

options:
  -h, --help            show this help message and exit
  --samples SAMPLES, -S SAMPLES
                        Path to CSV file with columns: Sample, Traits, Tree,
                        RunType (batch mode)
  -T TRAITS, --traits TRAITS
                        Path to a single traits CSV file (single-run mode)
  -t TREE, --tree TREE  Path to a single tree file (single-run mode)
  -r RUN_TRAITS, --run-traits RUN_TRAITS
                        Comma-separated list of column indices (0 is first
                        trait) in traits CSV specifying traits for a traits
                        against all comparison (Default: 'ALL' for all agianst
                        all)
  --sample-name SAMPLE_NAME, -s SAMPLE_NAME
                        Sample name (single-run mode)
  --min_prev MIN_PREV   Minimum prevanece required by a trait to be analyzed
                        (recommended: 0.05)
  --max_prev MAX_PREV   Maximum prevanece allowed for a trait to be analyzed
                        (recommended: 0.95)
  -o OUTDIR, --outdir OUTDIR
                        Main output directory (Default: simphyni_outs)
  --temp-dir TEMP_DIR   Temporary directory for intermediate files (Default:
                        tmp)
  -c CORES, --cores CORES
                        Maximum cores for execution (Default: All when not
                        provided)
  --plot, --no-plot     Enable/disable plotting (Default: disabled)
  --dry-run             Perform a dry run without executing
  --profile PROFILE     Path to cluster profile folder for HPC usage
  --save-object, --no-save-object
                        Saves parsable python object containing the complete
                        analysis of each sample (Default: disabled)
```

