# lmas CWL Generation Report

## lmas_LMAS

### Tool Description
Execute a pipeline project

### Metadata
- **Docker Image**: quay.io/biocontainers/lmas:2.0.8--hdfd78af_0
- **Homepage**: https://github.com/B-UMMI/LMAS
- **Package**: https://anaconda.org/channels/bioconda/packages/lmas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lmas/overview
- **Total Downloads**: 18.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/B-UMMI/LMAS
- **Stars**: N/A
### Original Help Text
```text
Execute a pipeline project
Usage: run [options] Project name or repository url
  Options:
    -E
       Exports all current system environment
       Default: false
    -ansi-log
       Enable/disable ANSI console logging
    -bucket-dir
       Remote bucket where intermediate result files are stored
    -cache
       Enable/disable processes caching
    -disable-jobs-cancellation
       Prevent the cancellation of child jobs on execution termination
    -dsl1
       Execute the workflow using DSL1 syntax
       Default: false
    -dsl2
       Execute the workflow using DSL2 syntax
       Default: false
    -dump-channels
       Dump channels for debugging purpose
    -dump-hashes
       Dump task hash keys for debugging purpose
       Default: false
    -e.
       Add the specified variable to execution environment
       Syntax: -e.key=value
       Default: {}
    -entry
       Entry workflow name to be executed
    -h, -help
       Print the command usage
       Default: false
    -hub
       Service hub where the project is hosted
    -latest
       Pull latest changes before run
       Default: false
    -lib
       Library extension path
    -main-script
       The script file to be executed when launching a project directory or
       repository
    -name
       Assign a mnemonic name to the a pipeline run
    -offline
       Do not check for remote project updates
       Default: false
    -params-file
       Load script parameters from a JSON/YAML file
    -plugins
       Specify the plugins to be applied for this run e.g. nf-amazon,nf-tower
    -process.
       Set process options
       Syntax: -process.key=value
       Default: {}
    -profile
       Choose a configuration profile
    -qs, -queue-size
       Max number of processes that can be executed in parallel by each executor
    -resume
       Execute the script using the cached results, useful to continue
       executions that was stopped by an error
    -r, -revision
       Revision of the project to run (either a git branch, tag or commit SHA
       number)
    -stub-run, -stub
       Execute the workflow replacing process scripts with command stubs
       Default: false
    -test
       Test a script function with the name specified
    -user
       Private repository user name
    -with-charliecloud
       Enable process execution in a Charliecloud container runtime
    -with-conda
       Use the specified Conda environment package or file (must end with
       .yml|.yaml suffix)
    -with-dag
       Create pipeline DAG file
    -with-docker
       Enable process execution in a Docker container
    -N, -with-notification
       Send a notification email on workflow completion to the specified
       recipients
    -with-podman
       Enable process execution in a Podman container
    -with-report
       Create processes execution html report
    -with-singularity
       Enable process execution in a Singularity container
    -with-timeline
       Create processes execution timeline file
    -with-tower
       Monitor workflow execution with Seqera Tower service
    -with-trace
       Create processes execution tracing file
    -with-weblog
       Send workflow status messages via HTTP to target URL
    -without-docker
       Disable process execution with Docker
       Default: false
    -without-podman
       Disable process execution in a Podman container
    -w, -work-dir
       Directory where intermediate result files are stored
```

