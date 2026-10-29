# ymp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ymp_env_activate | Not completed | needs network to create the conda environment first |
| ymp_env_clean | Failed | tool bug: ymp env clean crashes with TypeError (clean() got an unexpected keyword argument envnames) |
| ymp_env_export | Not completed | needs an installed conda environment to export; none can be installed offline |
| ymp_env_install | Not completed | real install needs conda downloads; only a dry run worked |
| ymp_env_list | PASS |  |
| ymp_env_prepare | Not completed | pipeline, skipped: builds conda environments for a Snakemake target |
| ymp_env_remove | Not completed | needs an installed conda environment to remove; none can be installed offline |
| ymp_env_run | Not completed | needs an installed conda environment, which needs network |
| ymp_env_update | Not completed | needs installed conda environments, which need network |
| ymp_init_cluster | Failed | image problem: ymp saves its config into the package folder inside the image, which is read-only |
| ymp_init_demo | PASS |  |
| ymp_init_project | Failed | image problem: ymp saves its config into the package folder inside the image, which is read-only |
| ymp_make | Not completed | pipeline, skipped: runs Snakemake workflow stages |
| ymp_scan | PASS | real demo reads, files renamed to the Illumina names that ymp scan expects |
| ymp_show | PASS |  |
| ymp_stage_list | PASS |  |
| ymp_submit | Not completed | pipeline, skipped: submits Snakemake jobs to a cluster |

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


## ymp_env_activate

### Tool Description
source activate environment

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env activate [OPTIONS] ENVNAME

  source activate environment

  Usage: $(ymp activate env [ENVNAME])

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help       Show this message and exit.
```

## ymp_env_clean

### Tool Description
Remove unused conda environments

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env clean [OPTIONS] [ENVNAMES]...

  Remove unused conda environments

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -a, --all        Delete all environments
  -h, --help       Show this message and exit.
```

## ymp_env_export

### Tool Description
Export conda environments

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env export [OPTIONS] [ENVNAMES]...

  Export conda environments

  Resolved package specifications for the selected conda environments can be
  exported either in YAML format suitable for use with ``conda env create -f
  FILE`` or in TXT format containing a list of URLs suitable for use with
  ``conda create --file FILE``. Please note that the TXT format is platform
  specific.

  If other formats are desired, use ``ymp env list`` to view the environments'
  installation path ("prefix" in conda lingo) and export the specification
  with the ``conda`` command line utlity directly.

  Note:
    Environments must be installed before they can be exported. This is due
    to limitations of the conda utilities.  Use the "--create" flag to
    automatically install missing environments.

Options:
  -P, --pdb                 Drop into debugger on uncaught exception
  -q, --quiet               Decrease log verbosity
  -v, --verbose             Increase log verbosity
  --log-file TEXT           Specify a log file
  -d, --dest FILE           Destination file or directory. If a directory,
                            file names will be derived from environment names
                            and selected export format. Default: print to
                            standard output.
  -f, --overwrite           Overwrite existing files
  -c, --create-missing      Create environments not yet installed
  -s, --skip-missing        Skip environments not yet installed
  -t, --filetype [yml|txt]  Select export format. Default: yml unless FILE
                            ends in '.txt'
  -h, --help                Show this message and exit.
```

## ymp_env_install

### Tool Description
Install conda software environments

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env install [OPTIONS] [ENVNAMES]...

  Install conda software environments

Options:
  -P, --pdb                  Drop into debugger on uncaught exception
  -q, --quiet                Decrease log verbosity
  -v, --verbose              Increase log verbosity
  --log-file TEXT            Specify a log file
  -p, --conda-prefix TEXT    Override location for conda environments
  -e, --conda-env-spec TEXT  Override conda env specs settings
  -n, --dry-run              Only show what would be done
  -r, --reinstall            Delete existing environment and reinstall
  --no-spec                  Don't use conda env spec even if present
  --no-archive               Delete existing archives before install
  --fresh                    Create fresh install. Implies reinstall, no-spec
                             and no-archve
  -h, --help                 Show this message and exit.
```

## ymp_env_list

### Tool Description
List conda environments

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env list [OPTIONS] [ENVNAMES]...

  List conda environments

Options:
  -P, --pdb                       Drop into debugger on uncaught exception
  -q, --quiet                     Decrease log verbosity
  -v, --verbose                   Increase log verbosity
  --log-file TEXT                 Specify a log file
  -s, --sort [label|hash|address|installed]
                                  Sort by column
  -r, --reverse                   Reverse sort order
  --installed / --not-installed   List only installed/not installed
                                  environments
  -e, --extra TEXT                Show additional fields (all: everything)
  --csv                           Output as machine readable CSV
  -h, --help                      Show this message and exit.
```

## ymp_env_prepare

### Tool Description
Create envs needed to build target

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env prepare [OPTIONS] TARGET_FILES

  Create envs needed to build target

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
  --reinstall                     Delete existing environment and reinstall
  --no-spec                       Don't use conda env spec even if present
  --no-archive                    Delete existing archives before install
  --fresh                         Create fresh install. Implies reinstall, no-
                                  spec and no-archve
  -h, --help                      Show this message and exit.
```

## ymp_env_remove

### Tool Description
Remove conda environments

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env remove [OPTIONS] [ENVNAMES]...

  Remove conda environments

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help       Show this message and exit.
```

## ymp_env_run

### Tool Description
Execute COMMAND with activated environment ENV

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env run [OPTIONS] ENVNAME [COMMAND]...

  Execute COMMAND with activated environment ENV

  Usage: ymp env run <ENV> [--] <COMMAND...>

  (Use the "--" if your command line contains option type parameters
  beginning with - or --)

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help       Show this message and exit.
```

## ymp_env_update

### Tool Description
Update conda environments

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp env update [OPTIONS] [ENVNAMES]...

  Update conda environments

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help       Show this message and exit.
```

## ymp_init_cluster

### Tool Description
Set up cluster

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp init cluster [OPTIONS]

  Set up cluster

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -y, --yes        Confirm every prompt
  -h, --help       Show this message and exit.
```

## ymp_init_demo

### Tool Description
Copies YMP tutorial data into the current working directory

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp init demo [OPTIONS]

  Copies YMP tutorial data into the current working directory

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -h, --help       Show this message and exit.
```

## ymp_init_project

### Tool Description
Options:

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp init project [OPTIONS] [NAME]

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -y, --yes        Confirm every prompt
  -h, --help       Show this message and exit.
```

## ymp_stage_list

### Tool Description
List available stages

### Metadata
- **Docker Image**: quay.io/biocontainers/ymp:0.3.2--pyhdfd78af_0
- **Homepage**: https://ymp.readthedocs.io
- **Package**: https://anaconda.org/channels/bioconda/packages/ymp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ymp stage list [OPTIONS] STAGE

  List available stages

Options:
  -P, --pdb        Drop into debugger on uncaught exception
  -q, --quiet      Decrease log verbosity
  -v, --verbose    Increase log verbosity
  --log-file TEXT  Specify a log file
  -l, --long       Show full stage descriptions
  -s, --short      Show only stage names
  -c, --code       Show definition file name and line number
  -t, --types      Show input/output types
  -p, --params     Show parameters
  -h, --help       Show this message and exit.
```

## Metadata
- **Skill**: generated
