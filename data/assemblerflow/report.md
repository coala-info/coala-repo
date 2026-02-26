# assemblerflow CWL Generation Report

## assemblerflow_build

### Tool Description
Build a pipeline for assemblerflow.

### Metadata
- **Docker Image**: quay.io/biocontainers/assemblerflow:1.1.0.post3--py35_1
- **Homepage**: https://github.com/ODiogoSilva/assemblerflow
- **Package**: https://anaconda.org/channels/bioconda/packages/assemblerflow/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/assemblerflow/overview
- **Total Downloads**: 18.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ODiogoSilva/assemblerflow
- **Stars**: N/A
### Original Help Text
```text
usage: assemblerflow build [-h] [-t TASKS] [-r RECIPE] [-o OUTPUT_NF]
                           [-n PIPELINE_NAME] [--pipeline-only] [-nd] [-c]
                           [-L | -l]

optional arguments:
  -h, --help            show this help message and exit
  -t TASKS, --tasks TASKS
                        Space separated tasks of the pipeline
  -r RECIPE, --recipe RECIPE
                        Use one of the available recipes
  -o OUTPUT_NF          Name of the pipeline file
  -n PIPELINE_NAME      Provide a name for your pipeline.
  --pipeline-only       Write only the pipeline files and not the templates,
                        bin, and lib folders.
  -nd, --no-dependecy   Do not automatically add dependencies to the pipeline.
  -c, --check-pipeline  Check only the validity of the pipeline string and
                        exit.
  -L, --detailed-list   Print a detailed description for all the currently
                        available processes
  -l, --short-list      Print a short list of the currently available
                        processes
```

