# cromwell CWL Generation Report

## cromwell_server

### Tool Description
Cromwell - Workflow Execution Engine

### Metadata
- **Docker Image**: quay.io/biocontainers/cromwell:0.40--1
- **Homepage**: https://github.com/broadinstitute/cromwell
- **Package**: https://anaconda.org/channels/bioconda/packages/cromwell/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cromwell/overview
- **Total Downloads**: 114.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/broadinstitute/cromwell
- **Stars**: N/A
### Original Help Text
```text
cromwell 40
Usage: java -jar /path/to/cromwell.jar [server|run|submit] [options] <args>...

  --help                   Cromwell - Workflow Execution Engine
  --version                
Command: server
Starts a web server on port 8000.  See the web server documentation for more details about the API endpoints.
Command: run [options] workflow-source
Run the workflow and print out the outputs in JSON format.
  workflow-source          Workflow source file or workflow url.
  --workflow-root <value>  Workflow root.
  -i, --inputs <value>     Workflow inputs file.
  -o, --options <value>    Workflow options file.
  -t, --type <value>       Workflow type.
  -v, --type-version <value>
                           Workflow type version.
  -l, --labels <value>     Workflow labels file.
  -p, --imports <value>    A directory or zipfile to search for workflow imports.
  -m, --metadata-output <value>
                           An optional directory path to output metadata.
Command: submit [options] workflow-source
Submit the workflow to a Cromwell server.
  workflow-source          Workflow source file or workflow url.
  --workflow-root <value>  Workflow root.
  -i, --inputs <value>     Workflow inputs file.
  -o, --options <value>    Workflow options file.
  -t, --type <value>       Workflow type.
  -v, --type-version <value>
                           Workflow type version.
  -l, --labels <value>     Workflow labels file.
  -p, --imports <value>    A directory or zipfile to search for workflow imports.
  -h, --host <value>       Cromwell server URL.
```

