# noise2read CWL Generation Report

## noise2read

### Tool Description
Noise2Read is a tool for denoising sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/noise2read:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Jappy0/noise2read
- **Package**: https://anaconda.org/channels/bioconda/packages/noise2read/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/noise2read/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Jappy0/noise2read
- **Stars**: N/A
### Original Help Text
```text
noise2read Usage:
   Mandatory:
     -m|--module                   module selection
   Modules: [correction, amplicon_correction, umi_correction, mimic_umi, real_umi, evaluation, simulation]
1. Using config file
     noise2read -m|--module <module_name> -c <path_configuration_file>
   Mandatory:
     -c|--config                   input configuration file
2. Using command line with the default parameters
     noise2read -m|--module <module_name> -i <path_raw_data.fastq|fasta|fa|fq>
   Mandatory:
     -i|--input                    input raw data to be corrected
   Options:
     -d|--directory                set output directory
     -a|--high_ambiguous           predict high ambiguous errors using machine learning when set true, defaut true
     -t|--true                     input ground truth data if you have
     -r|--rectification            input corrected data when using module evaluation
     -p|--parallel                 use multiple cpu cores, default total cpu cores - 2
     -g|--tree_method              use gpu for training and prediction, default auto, (options gpu_hist, hist, auto)
     -h|--help                     show this help
```

