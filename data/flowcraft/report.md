# flowcraft CWL Generation Report

## flowcraft_build

### Tool Description
Build a pipeline using flowcraft.

### Metadata
- **Docker Image**: quay.io/biocontainers/flowcraft:1.4.1--py_1
- **Homepage**: https://github.com/assemblerflow/flowcraft
- **Package**: https://anaconda.org/channels/bioconda/packages/flowcraft/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flowcraft/overview
- **Total Downloads**: 43.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/assemblerflow/flowcraft
- **Stars**: N/A
### Original Help Text
```text
usage: flowcraft build [-h] [-t TASKS] [-r RECIPE] [-o OUTPUT_NF]
                       [-n PIPELINE_NAME] [--merge-params] [--pipeline-only]
                       [-nd] [-c]
                       [-L | -l | --recipe-list | --recipe-list-short] [-cr]
                       [--export-params] [--export-directives] [-ft]

optional arguments:
  -h, --help            show this help message and exit
  -t TASKS, --tasks TASKS
                        Space separated tasks of the pipeline
  -r RECIPE, --recipe RECIPE
                        Use one of the available recipes
  -o OUTPUT_NF          Name of the pipeline file
  -n PIPELINE_NAME      Provide a name for your pipeline.
  --merge-params        Merges identical parameters from multiple components
                        into the same one. Otherwise, the parameters will be
                        separated and unique to each component.
  --pipeline-only       Write only the pipeline files and not the templates,
                        bin, and lib folders.
  -nd, --no-dependecy   Do not automatically add dependencies to the pipeline.
  -c, --check-pipeline  Check only the validity of the pipeline string and
                        exit.
  -L, --component-list  Print a detailed description for all the currently
                        available processes.
  -l, --component-list-short
                        Print a short list of the currently available
                        processes.
  --recipe-list         Print a short list of the currently available recipes.
  --recipe-list-short   Print a condensed list of the currently available
                        recipes
  -cr, --check-recipe   Check tasks that the recipe contain and their flow.
                        This option might be useful if a user wants to change
                        some components of a given recipe, by using the -t
                        option.
  --export-params       Only export the parameters for the provided components
                        (via -t option) in JSON format to stdout. No pipeline
                        will be generated with this option.
  --export-directives   Only export the directives for the provided components
                        (via -t option) in JSON format to stdout. No pipeline
                        will be generated with this option.
  -ft, --fetch-tags     Allows to fetch all docker tags for the components
                        listed with the -t flag.
```


## flowcraft_inspect

### Tool Description
Inspect Nextflow runs

### Metadata
- **Docker Image**: quay.io/biocontainers/flowcraft:1.4.1--py_1
- **Homepage**: https://github.com/assemblerflow/flowcraft
- **Package**: https://anaconda.org/channels/bioconda/packages/flowcraft/overview
- **Validation**: PASS

### Original Help Text
```text
usage: flowcraft inspect [-h] [-i TRACE_FILE] [-r REFRESH_RATE]
                         [-m {overview,broadcast}] [-u URL] [--pretty]

optional arguments:
  -h, --help            show this help message and exit
  -i TRACE_FILE         Specify the nextflow trace file.
  -r REFRESH_RATE       Set the refresh frequency for the continuous inspect
                        functions
  -m {overview,broadcast}, --mode {overview,broadcast}
                        Specify the inspection run mode.
  -u URL, --url URL     Specify the URL to where the data should be broadcast
  --pretty              Pretty inspection mode that removes usual reporting
                        processes.
```


## flowcraft_report

### Tool Description
Generate a report from pipeline execution data.

### Metadata
- **Docker Image**: quay.io/biocontainers/flowcraft:1.4.1--py_1
- **Homepage**: https://github.com/assemblerflow/flowcraft
- **Package**: https://anaconda.org/channels/bioconda/packages/flowcraft/overview
- **Validation**: PASS

### Original Help Text
```text
usage: flowcraft report [-h] [-i REPORT_FILE] [-u URL]
                        [--trace-file TRACE_FILE] [--log-file LOG_FILE] [-w]

optional arguments:
  -h, --help            show this help message and exit
  -i REPORT_FILE        Specify the path to the pipeline report JSON file.
  -u URL, --url URL     Specify the URL to where the data should be broadcast
  --trace-file TRACE_FILE
                        Specify the nextflow trace file. Only applicable in
                        combination with --watch option.
  --log-file LOG_FILE   Specify the nextflow log file. Only applicable in
                        combination with --watch option.
  -w, --watch           Run the report in watch mode. This option will track
                        the generation of reports during the execution of the
                        pipeline, allowing for the visualization of the
                        reports in real-time
```


## Metadata
- **Skill**: generated
