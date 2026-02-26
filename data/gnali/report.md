# gnali CWL Generation Report

## gnali

### Tool Description
Given a list of genes to test, gNALI finds all potential loss of function variants of those genes.

### Metadata
- **Docker Image**: quay.io/biocontainers/gnali:1.1.0--pyhdfd78af_0
- **Homepage**: https://github.com/phac-nml/gnali
- **Package**: https://anaconda.org/channels/bioconda/packages/gnali/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gnali/overview
- **Total Downloads**: 26.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/gnali
- **Stars**: N/A
### Original Help Text
```text
usage: gNALI [-h] [-i INPUT_FILE] [-o OUTPUT_DIR] [-f] [-d DATABASE] [--vcf]
             [-v] [-p [PREDEFINED_FILTERS [PREDEFINED_FILTERS ...]]]
             [-a [ADDITIONAL_FILTERS [ADDITIONAL_FILTERS ...]]] [-V] [-P]
             [-c CONFIG] [--config_template_grch37] [--config_template_grch38]

Given a list of genes to test, gNALI finds all potential loss of function
variants of those genes.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input_file INPUT_FILE
                        File of genes to test. Accepted formats: csv, txt
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Name of output directory. Default: results-ID/
  -f, --force           Force existing output folder to be overwritten
  -d DATABASE, --database DATABASE
                        Database to query. Default: gnomadv2.1.1 Options:
                        ['gnomadv2.1.1', 'gnomadv3.1.1']
  --vcf                 Generate vcf file for filtered variants
  -v, --verbose         increase verbosity
  -p [PREDEFINED_FILTERS [PREDEFINED_FILTERS ...]], --predefined_filters [PREDEFINED_FILTERS [PREDEFINED_FILTERS ...]]
                        Predefined filters. To use multiple, separate them by
                        spaces. Options: {'gnomadv2.1.1': {'homozygous-
                        controls': 'controls_nhomalt>0', 'heterozygous-
                        controls': 'controls_nhomalt=0', 'homozygous':
                        'nhomalt>0'}, 'gnomadv3.1.1': {'homozygous':
                        'nhomalt>0'}}
  -a [ADDITIONAL_FILTERS [ADDITIONAL_FILTERS ...]], --additional_filters [ADDITIONAL_FILTERS [ADDITIONAL_FILTERS ...]]
                        Additional filters. To use multiple, separate them by
                        spaces. Please enclose each in quotes (ex. "AC>3")
  -V, --version         show program's version number and exit
  -P, --pop_freqs       Get population frequencies (in detailed output file)
  -c CONFIG, --config CONFIG
                        Use a custom config file. To get started, check out
                        the --config_template commands
  --config_template_grch37
                        Create a fillable template for a config for a database
                        using the GRCh37 assembly
  --config_template_grch38
                        Create a fillable template for a config for a database
                        using the GRCh38 assembly
```

