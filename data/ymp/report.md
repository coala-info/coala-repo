# ymp CWL Generation Report

## ymp_env

### Tool Description
Manipulate conda software environments

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Total Downloads**: 6.8K
- **Last updated**: 2025-10-16
- **GitHub**: https://github.com/epruesse/ymp
- **Stars**: N/A
### Original Help Text
```text
Usage: ymp env [OPTIONS] COMMAND [ARGS]...

  Manipulate conda software environments

  These commands allow accessing the conda software environments managed by
  YMP. Use e.g.

  >>> $(ymp env activate multiqc)

  to enter the software environment for ``multiqc``.

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help       Show this message and exit.

Commands:
  activate  source activate environment
  clean     Remove unused conda environments
  export    Export conda environments
  install   Install conda software environments
  list      List conda environments
  prepare   Create envs needed to build target
  remove    Remove conda environments
  run       Execute COMMAND with activated environment ENV
  update    Update conda environments
```


## ymp_init

### Tool Description
Initialize YMP workspace

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp init [OPTIONS] COMMAND [ARGS]...

  Initialize YMP workspace

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help       Show this message and exit.

Commands:
  cluster  Set up cluster
  demo     Copies YMP tutorial data into the current working directory
  project
```


## ymp_make

### Tool Description
Build target(s) locally

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp make [OPTIONS] TARGET_FILES

  Build target(s) locally

Options:
  -P, --pdb                       Drop into debugger on uncaught exception
  -q, --quiet                     Decrease log verbosity
  -v, --verbose                   Increase log verbosity
  --log-file TEXT                 Specify a log file
  -n, --dryrun                    Only show what would be done
  -p, --printshellcmds            Print shell commands to be executed on shell
  -k, --keepgoing                 Don't stop after failed job
  --lock / --no-lock              Use/don't use locking to prevent clobbering
                                  of files by parallel instances of YMP
                                  running
  --rerun-incomplete, --ri        Re-run jobs left incomplete in last run
  --rerun-triggers [mtime|params|input|software-env|code]
                                  Select reasons for reruns. Default changed
                                  from Snakemake toonly mtime for performance
                                  reasons.
  --scheduler TEXT                ILP or greedy
  -F, --forceall                  Force rebuilding of all stages leading to
                                  target
  -f, --force                     Force rebuilding of target
  --notemp                        Do not remove temporary files
  -t, --touch                     Only touch files, faking update
  --shadow-prefix TEXT            Directory to place data for shadowed rules
  -r, --reason                    Print reason for executing rule
  -N, --nohup                     Don't die once the terminal goes away.
  -j, --cores N                   The number of parallel threads used for
                                  scheduling jobs
  --dag                           Print the Snakemake execution DAG and exit
  --rulegraph                     Print the Snakemake rule graph and exit
  --debug-dag                     Show candidates and selections made while
                                  the rule execution graph is being built
  --debug                         Set the Snakemake debug flag
  -h, --help                      Show this message and exit.
```


## ymp_scan

### Tool Description
Scan folders for YMP files

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp scan [OPTIONS] [FOLDERS]...

Options:
  --out FILENAME
  --sample-re TEXT
  --folder-re TEXT
  -s, --export-slot
  -l, --export-lane
  -v, --verbose
  -h, --help         Show this message and exit.
```


## ymp_show

### Tool Description
Show configuration properties

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp show [OPTIONS] PROPERTY

  Show configuration properties

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help
  -s, --source     Show source

Properties available:
  absdir: Dictionary of absolute paths of named YMP directories
  cluster: The YMP cluster configuration.
  dir: Dictionary of relative paths of named YMP directories
  directories: Alias for `dir()`
  ensuredir: Dictionary of absolute paths of named YMP directories
  overrides: Job overrides
  pipeline: Configure pipelines
  platform: Name of current platform (macos or linux)
  ref: Configure references
  resource_limits: Global job resource adjustments
  shell: The shell used by YMP
  snakefiles: Snakefiles used under this config in parsing order
  userdata: User data (pipeline configurations) stored in ymp config object
```


## ymp_stage

### Tool Description
Manipulate YMP stages

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp stage [OPTIONS] COMMAND [ARGS]...

  Manipulate YMP stages

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help       Show this message and exit.

Commands:
  list  List available stages
```


## ymp_submit

### Tool Description
Build target(s) on cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp submit [OPTIONS] TARGET_FILES

  Build target(s) on cluster

  The parameters for cluster execution are drawn from layered profiles. YMP
  includes base profiles for the "torque" and "slurm" cluster engines.

Options:
  -P, --pdb                       Drop into debugger on uncaught exception
  -q, --quiet                     Decrease log verbosity
  -v, --verbose                   Increase log verbosity
  --log-file TEXT                 Specify a log file
  -n, --dryrun                    Only show what would be done
  -p, --printshellcmds            Print shell commands to be executed on shell
  -k, --keepgoing                 Don't stop after failed job
  --lock / --no-lock              Use/don't use locking to prevent clobbering
                                  of files by parallel instances of YMP
                                  running
  --rerun-incomplete, --ri        Re-run jobs left incomplete in last run
  --rerun-triggers [mtime|params|input|software-env|code]
                                  Select reasons for reruns. Default changed
                                  from Snakemake toonly mtime for performance
                                  reasons.
  --scheduler TEXT                ILP or greedy
  -F, --forceall                  Force rebuilding of all stages leading to
                                  target
  -f, --force                     Force rebuilding of target
  --notemp                        Do not remove temporary files
  -t, --touch                     Only touch files, faking update
  --shadow-prefix TEXT            Directory to place data for shadowed rules
  -r, --reason                    Print reason for executing rule
  -N, --nohup                     Don't die once the terminal goes away.
  -P, --profile NAME              Select cluster config profile to use.
                                  Overrides cluster.profile setting from
                                  config.
  -c, --snake-config FILE         Provide snakemake cluster config file
  -d, --drmaa                     Use DRMAA to submit jobs to cluster. Note:
                                  Make sure you have a working DRMAA library.
                                  Set DRMAA_LIBRAY_PATH if necessary.
  -s, --sync                      Use synchronous cluster submission, keeping
                                  the submit command running until the job has
                                  completed. Adds qsub_sync_arg to cluster
                                  command
  -i, --immediate                 Use immediate submission, submitting all
                                  jobs to the cluster at once.
  --command CMD                   Use CMD to submit job script to the cluster
  --wrapper CMD                   Use CMD as script submitted to the cluster.
                                  See Snakemake documentation for more
                                  information.
  --max-jobs-per-second N         Limit the number of jobs submitted per
                                  second
  -l, --latency-wait T            Time in seconds to wait after job completed
                                  until files are expected to have appeared in
                                  local file system view. On NFS, this time is
                                  governed by the acdirmax mount option, which
                                  defaults to 60 seconds.
  -J, --nodes N                   Limit the maximum number of jobs submitted
                                  at a time. Note that this does not imply a
                                  maximum core count or running job count, but
                                  simply limits the number of queued jobs.
  -c, --cores N                   Maximum number of cluster cores to use
  -j, --local-cores N             Number of local threads to use
  --args ARGS                     Additional arguments passed to cluster
                                  submission command. Note: Make sure the
                                  first character of the argument is not '-',
                                  prefix with ' ' as necessary.
  --scriptname NAME               Set the name template used for submitted
                                  jobs
  -h, --help                      Show this message and exit.
```


## Metadata
- **Skill**: generated
