# monsda CWL Generation Report

## monsda

### Tool Description
Modular Organizer of Nextflow and Snakemake driven hts Data Analysis

### Metadata
- **Docker Image**: quay.io/biocontainers/monsda:1.2.8--pyhdfd78af_0
- **Homepage**: https://github.com/jfallmann/MONSDA
- **Package**: https://anaconda.org/channels/bioconda/packages/monsda/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/monsda/overview
- **Total Downloads**: 12.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jfallmann/MONSDA
- **Stars**: N/A
### Original Help Text
```text
usage: monsda [-h] [-c CONFIG [CONFIG ...]] [-d DIRECTORY] [-u] [-l]
              [-j PROCS] [--save] [-s] [--snakemake] [--nextflow] [--clean]
              [--loglevel {WARNING,ERROR,INFO,DEBUG}] [--version]

Modular Organizer of Nextflow and Snakemake driven hts Data Analysis

options:
  -h, --help            show this help message and exit
  -c CONFIG [CONFIG ...], --config CONFIG [CONFIG ...], --configfile CONFIG [CONFIG ...]
                        Configuration json to read and optional config for
                        nextflow
  -d DIRECTORY, --directory DIRECTORY
                        Working Directory
  -u, --use-conda       Should conda be used, default True
  -l, --unlock          If Snakemake directory is locked you can unlock before
                        processing
  -j PROCS, --procs PROCS
                        Number of parallel processes to start MONSDA with,
                        capped by MAXTHREADS in config!
  --save                Do not actually run jobs, create corresponding text
                        file containing CLI-calls and arguments for manual
                        running instead
  -s, --skeleton        Just create the minimal directory hierarchy as needed
  --snakemake           Wrap around Snakemake, default
  --nextflow            Wrap around Nextflow
  --clean               Cleanup workdir (Nextflow), append -n to see list of
                        files to clean or -f to actually remove those files
  --loglevel {WARNING,ERROR,INFO,DEBUG}
                        Set log level
  --version             Print version and exit
```

