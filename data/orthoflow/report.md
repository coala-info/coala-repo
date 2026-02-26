# orthoflow CWL Generation Report

## orthoflow

### Tool Description
All unrecognized arguments will be passed directly to Snakemake. Use `orthoflow --help-snakemake` to list all arguments accepted by Snakemake.

### Metadata
- **Docker Image**: quay.io/biocontainers/orthoflow:0.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/rbturnbull/orthoflow
- **Package**: https://anaconda.org/channels/bioconda/packages/orthoflow/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/orthoflow/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rbturnbull/orthoflow
- **Stars**: N/A
### Original Help Text
```text
Usage: orthoflow [OPTIONS]                                                     
                                                                                
                                                                                
   ___      _   _         __ _                                                  
  / _ \ _ _| |_| |_  ___ / _| |_____ __ __                                      
 | (_) | '_|  _| ' \/ _ \  _| / _ \ V  V /                                      
  \___/|_|  \__|_||_\___/_| |_\___/\_/\_/                                       
                                                                                
 All unrecognized arguments will be passed directly to Snakemake. Use           
 `orthoflow --help-snakemake` to list all                                       
 arguments accepted by Snakemake.                                               
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --files                               PATH       The input source files      │
│                                                  [default: None]             │
│ --target                              PATH       The target file to create   │
│                                                  [default: None]             │
│ --directory                           DIRECTORY  [default: .]                │
│ --cores               -c              INTEGER    Number of cores to request  │
│                                                  for the workflow. If not    │
│                                                  given then it will use all  │
│                                                  available available CPU     │
│                                                  cores.                      │
│                                                  [default: None]             │
│ --conda-prefix                        PATH       A directory to use for      │
│                                                  created conda environments. │
│                                                  If none given then it will  │
│                                                  use the user cache          │
│                                                  directory.                  │
│                                                  [env var:                   │
│                                                  ORTHOFLOW_CONDA_PREFIX]     │
│                                                  [default: None]             │
│ --hpc                     --no-hpc               Run on an HPC cluster (with │
│                                                  the SLURM scheduler)?       │
│                                                  [default: no-hpc]           │
│ --help-snakemake                                 Print the snakemake help    │
│ --install-completion                             Install completion for the  │
│                                                  current shell.              │
│ --show-completion                                Show completion for the     │
│                                                  current shell, to copy it   │
│                                                  or customize the            │
│                                                  installation.               │
│ --help                -h                         Show this message and exit. │
╰──────────────────────────────────────────────────────────────────────────────╯
```

