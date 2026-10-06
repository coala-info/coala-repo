# neurodocker CWL Generation Report

## neurodocker_reprozip

### Tool Description
Neurodocker is a command-line interface to generate custom Dockerfiles and Singularity recipes.

### Metadata
- **Docker Image**: quay.io/biocontainers/neurodocker:0.5.0--py_0
- **Homepage**: https://github.com/kaczmarj/neurodocker
- **Package**: https://anaconda.org/channels/bioconda/packages/neurodocker/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neurodocker [-h] [-v {debug,info,warning,error,critical}] [-V]
                   {generate,reprozip} ...

Neurodocker is a command-line interface to generate custom Dockerfiles and
Singularity recipes.

For help generating Dockerfiles and Singularity recipes, run

$ neurodocker generate docker --help
$ neurodocker generate singularity --help

optional arguments:
  -h, --help            show this help message and exit
  -v {debug,info,warning,error,critical}, --verbosity {debug,info,warning,error,critical}
  -V, --version         show program's version number and exit

subcommands:
  valid subcommands

  {generate,reprozip}
    generate            generate recipes
    reprozip
```

## Metadata
- **Skill**: generated
