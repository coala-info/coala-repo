# curare CWL Generation Report

## curare

### Tool Description
Customizable and Reproducible Analysis Pipeline for RNA-Seq Experiments (Curare).

### Metadata
- **Docker Image**: quay.io/biocontainers/curare:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/pblumenkamp/Curare
- **Package**: https://anaconda.org/channels/bioconda/packages/curare/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/curare/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pblumenkamp/Curare
- **Stars**: N/A
### Original Help Text
```text
Customizable and Reproducible Analysis Pipeline for RNA-Seq Experiments (Curare).

Usage:
    curare.py --samples <samples_file> --pipeline <pipeline_file> --output <output_folder> --cores <cores>
                 [--use-conda | --no-conda] [--conda-frontend <frontend>] [--conda-prefix <conda_prefix>] [--keep-going] [--latency-wait <seconds>] [--verbose]
    curare.py --samples <samples_file> --pipeline <pipeline_file> --output <output_folder> --create-conda-envs-only [--conda-frontend <frontend>] [--conda-prefix <conda_prefix>] [--verbose]
    curare.py (--version | --help)

Options:
    -h --help               Show this help message and exit
    --version               Show version and exit

    --samples <samples_file>                        File containing information about each sample
    --pipeline <pipeline_file>                      File containing information about the RNA-seq pipeline
    --output <output_folder>                        Output folder (will be created if not existing)

    --use-conda                                     DEPRECATED, BY DEFAULT ON - Install and use separate conda environments for pipeline modules
    --no-conda                                      Don't use Conda/Mamba for the installation of module tools. (All tools necessary must be installed manually in advance) 
    --conda-frontend <frontend>                     Choose conda frontend for creating and installing conda environments (conda, mamba) [Default: mamba]
    --conda-prefix <conda_prefix>                   The directory in which conda environments will be created. Relative paths will be relative to output folder! (Default: Output_folder)
    --create-conda-envs-only                        Only download and create conda environments.
    -t <cores> --cores <cores>                      Number of threads/cores.
    --keep-going                                    Keep going with individual jobs if a job fails.
    --latency-wait <seconds>                        Seconds to wait before checking if all files of a rule were created. [Default: 5]
    -v --verbose                                    Print additional information
```

