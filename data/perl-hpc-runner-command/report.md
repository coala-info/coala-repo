# perl-hpc-runner-command CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| perl-hpc-runner-command_archive | Failed | image problem: archive runs tar -zcvf but the image has only busybox tar, which rejects -z |
| perl-hpc-runner-command_execute_array | Not completed | needs a scheduler array job id; run alone it executed no commands (command index -1) |
| perl-hpc-runner-command_execute_job | PASS |  |
| perl-hpc-runner-command_new | PASS |  |
| perl-hpc-runner-command_single_node | PASS |  |
| perl-hpc-runner-command_stats | Not completed | needs submissions recorded by submit_jobs on a scheduler; local runs leave nothing to query |

## perl-hpc-runner-command_single_node

### Tool Description
Take the parsed files from hpcrunner.pl submit_jobs and executes the code on a single node or workstation

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
- **Homepage**: https://github.com/biosails/HPC-Runner-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-hpc-runner-command/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    hpcrunner.pl single_node [long options...]
    hpcrunner.pl help
    hpcrunner.pl single_node --help

description:
    Take the parsed files from hpcrunner.pl submit_jobs and executes the code

options:
    --plugins_opts        Options for application plugins [Key-Value]
    --plugins             Load aplication plugins [Multiple; Split by ","]
    --search              Search for config files in ~/.config.(ext) and in
                          your current working directory. [Flag]
    --config_base         Basename of config files [Default:".hpcrunner"]
    --no_configs          --no_configs tells HPC::Runner not to load any
                          configs [Flag]
    --config              Override the search paths and supply your own
                          config.
    --search_path         Enable a search path for configs. Default is the
                          home dir and your cwd. [Multiple]
    --project --pr        Give your jobnames an additional project name. #HPC
                          jobname=gzip will be submitted as 001_project_gzip
    --no_log_json         Opt out of writing the tar archive of JSON stats.
                          This may be desirable for especially large
                          workflows. [Flag]
    --data_dir            Data directory for hpcrunner
    --outdir              Directory to write out files.
    --basedir             Base directory to write out files.
    --poll_time --pt      Time in seconds to poll the process for memory
                          profiling. [Default:"5"; Number]
    --procs               Total number of concurrently running jobs allowed
                          at any time. [Default:"1"; Integer]
    --memory_diff --md    Difference from last memory profile in order to
                          record. [Default:"0.1"; Number]
    --infile -i           File of commands separated by newline. The command
                          'wait' indicates all previous commands should
                          finish before starting the next one. [Required]
    --metastr             Meta str passed from HPC::Runner::Command::
                          Scheduler
    --logdir              Directory where logfiles are written. Defaults to
                          current_working_directory/prunner_current_date_time
                          /log1 .. log2 .. log3
    --logname             [Default:"000_hpcrunner_logs"]
    --show_processid      Show the process ID per logging message. This is
                          useful when aggregating logs. [Flag]
    --process_table       
    --tags -t             Annotate with tags. [Multiple; Split by ","]
    --autocommit          Always commit files. [Flag]
    --message -m          Message to use for git commit [Default:"hpcrunner
                          commit"]
    --version             Submission version. Each version has a
                          corresponding git tag. See the difference between
                          tags with `git diff tag1 tag2`. Tags are always
                          version numbers, starting with 0.01.
    --job_plugins_opts    Options for job_plugins [Key-Value]
    --commands            [Default:"1"; Number]
    --jobname             Specify a job name, each job will be appended with
                          its batch order
    --single_node         Run a job from a single node or workstation. [Flag]
    --job_plugins         Load job execution plugins [Multiple; Split by ","]
    --batch_index_start   Counter to tell execute_array where to start
                          reading in the infile. Omit this option in order to
                          run in single node. [Number]
    --help -h --usage -?  Prints this usage information. [Flag]

available subcommands:
    help  Prints this usage information
```

## perl-hpc-runner-command_execute_job

### Tool Description
Take the parsed files from hpcrunner.pl submit_jobs and executes the code

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
- **Homepage**: https://github.com/biosails/HPC-Runner-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-hpc-runner-command/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    hpcrunner.pl execute_job [long options...]
    hpcrunner.pl help
    hpcrunner.pl execute_job --help

description:
    Take the parsed files from hpcrunner.pl submit_jobs and executes the code

options:
    --plugins             Load aplication plugins [Multiple; Split by ","]
    --plugins_opts        Options for application plugins [Key-Value]
    --config              Override the search paths and supply your own
                          config.
    --config_base         Basename of config files [Default:".hpcrunner"]
    --search_path         Enable a search path for configs. Default is the
                          home dir and your cwd. [Multiple]
    --no_configs          --no_configs tells HPC::Runner not to load any
                          configs [Flag]
    --search              Search for config files in ~/.config.(ext) and in
                          your current working directory. [Flag]
    --project --pr        Give your jobnames an additional project name. #HPC
                          jobname=gzip will be submitted as 001_project_gzip
    --no_log_json         Opt out of writing the tar archive of JSON stats.
                          This may be desirable for especially large
                          workflows. [Flag]
    --data_dir            Data directory for hpcrunner
    --outdir              Directory to write out files.
    --procs               Total number of concurrently running jobs allowed
                          at any time. [Default:"1"; Integer]
    --infile -i           File of commands separated by newline. The command
                          'wait' indicates all previous commands should
                          finish before starting the next one. [Required]
    --memory_diff --md    Difference from last memory profile in order to
                          record. [Default:"0.1"; Number]
    --poll_time --pt      Time in seconds to poll the process for memory
                          profiling. [Default:"5"; Number]
    --basedir             Base directory to write out files.
    --logdir              Directory where logfiles are written. Defaults to
                          current_working_directory/prunner_current_date_time
                          /log1 .. log2 .. log3
    --process_table       
    --show_processid      Show the process ID per logging message. This is
                          useful when aggregating logs. [Flag]
    --metastr             Meta str passed from HPC::Runner::Command::
                          Scheduler
    --logname             [Default:"000_hpcrunner_logs"]
    --version             Submission version. Each version has a
                          corresponding git tag. See the difference between
                          tags with `git diff tag1 tag2`. Tags are always
                          version numbers, starting with 0.01.
    --autocommit          Always commit files. [Flag]
    --message -m          Message to use for git commit [Default:"hpcrunner
                          commit"]
    --tags -t             Annotate with tags. [Multiple; Split by ","]
    --jobname             Specify a job name, each job will be appended with
                          its batch order
    --commands            [Default:"1"; Number]
    --job_plugins         Load job execution plugins [Multiple; Split by ","]
    --single_node         Run a job from a single node or workstation. [Flag]
    --job_plugins_opts    Options for job_plugins [Key-Value]
    --batch_index_start   Counter to tell execute_array where to start
                          reading in the infile. Omit this option in order to
                          run in single node. [Number]
    --help -h --usage -?  Prints this usage information. [Flag]

available subcommands:
    help  Prints this usage information
```

## perl-hpc-runner-command_execute_array

### Tool Description
Take the parsed files from hpcrunner.pl submit_jobs and executes the code as an array job

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
- **Homepage**: https://github.com/biosails/HPC-Runner-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-hpc-runner-command/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    hpcrunner.pl execute_array [long options...]
    hpcrunner.pl help
    hpcrunner.pl execute_array --help

description:
    Take the parsed files from hpcrunner.pl submit_jobs and executes the code

options:
    --plugins             Load aplication plugins [Multiple; Split by ","]
    --plugins_opts        Options for application plugins [Key-Value]
    --config              Override the search paths and supply your own
                          config.
    --search_path         Enable a search path for configs. Default is the
                          home dir and your cwd. [Multiple]
    --config_base         Basename of config files [Default:".hpcrunner"]
    --no_configs          --no_configs tells HPC::Runner not to load any
                          configs [Flag]
    --search              Search for config files in ~/.config.(ext) and in
                          your current working directory. [Flag]
    --project --pr        Give your jobnames an additional project name. #HPC
                          jobname=gzip will be submitted as 001_project_gzip
    --no_log_json         Opt out of writing the tar archive of JSON stats.
                          This may be desirable for especially large
                          workflows. [Flag]
    --data_dir            Data directory for hpcrunner
    --procs               Total number of concurrently running jobs allowed
                          at any time. [Default:"1"; Integer]
    --basedir             Base directory to write out files.
    --infile -i           File of commands separated by newline. The command
                          'wait' indicates all previous commands should
                          finish before starting the next one. [Required]
    --memory_diff --md    Difference from last memory profile in order to
                          record. [Default:"0.1"; Number]
    --poll_time --pt      Time in seconds to poll the process for memory
                          profiling. [Default:"5"; Number]
    --outdir              Directory to write out files.
    --process_table       
    --show_processid      Show the process ID per logging message. This is
                          useful when aggregating logs. [Flag]
    --logname             [Default:"000_hpcrunner_logs"]
    --logdir              Directory where logfiles are written. Defaults to
                          current_working_directory/prunner_current_date_time
                          /log1 .. log2 .. log3
    --metastr             Meta str passed from HPC::Runner::Command::
                          Scheduler
    --tags -t             Annotate with tags. [Multiple; Split by ","]
    --message -m          Message to use for git commit [Default:"hpcrunner
                          commit"]
    --version             Submission version. Each version has a
                          corresponding git tag. See the difference between
                          tags with `git diff tag1 tag2`. Tags are always
                          version numbers, starting with 0.01.
    --autocommit          Always commit files. [Flag]
    --jobname             Specify a job name, each job will be appended with
                          its batch order
    --job_plugins_opts    Options for job_plugins [Key-Value]
    --single_node         Run a job from a single node or workstation. [Flag]
    --job_plugins         Load job execution plugins [Multiple; Split by ","]
    --commands            [Default:"1"; Number]
    --batch_index_start   Counter to tell execute_array where to start
                          reading in the infile [Required; Number]
    --help -h --usage -?  Prints this usage information. [Flag]

available subcommands:
    help  Prints this usage information
```

## perl-hpc-runner-command_new

### Tool Description
This creates a new project, initializes git and directory structure

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
- **Homepage**: https://github.com/biosails/HPC-Runner-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-hpc-runner-command/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    hpcrunner.pl new [long options...]
    hpcrunner.pl help
    hpcrunner.pl new --help

description:
    This creates a new project, initializes git and directory structure.

options:
    --plugins_opts        Options for application plugins [Key-Value]
    --plugins             Load aplication plugins [Multiple; Split by ","]
    --search_path         Enable a search path for configs. Default is the
                          home dir and your cwd. [Multiple]
    --search              Search for config files in ~/.config.(ext) and in
                          your current working directory. [Flag]
    --no_configs          --no_configs tells HPC::Runner not to load any
                          configs [Flag]
    --config              Override the search paths and supply your own
                          config.
    --config_base         Basename of config files [Default:".hpcrunner"]
    --no_log_json         Opt out of writing the tar archive of JSON stats.
                          This may be desirable for especially large
                          workflows. [Flag]
    --quiet               Turn off log messages written to STDOUT [Flag]
    --log                 Path to file used for logging  [Default:""]
    --debug               Turn on debug mode [Flag]
    --project -p          Project name for your analysis project. [Required]
    --help -h --usage -?  Prints this usage information. [Flag]

available subcommands:
    help  Prints this usage information
```

## perl-hpc-runner-command_stats

### Tool Description
Query submissions by project, or jobname

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
- **Homepage**: https://github.com/biosails/HPC-Runner-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-hpc-runner-command/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    hpcrunner.pl stats [stats_type] [long options...]
    hpcrunner.pl help
    hpcrunner.pl stats --help

description:
    Query submissions by project, or jobname. This
    searches through the tars created during execution. If you have a large
    number
    of submissions you may want to specify a project, or supply the desired
    submission with --data_tar.

parameters:
    stats_type  hpcrunner.pl stats JSON/Sqlite/Elasticsearch . [Default:"JSON
                "]

options:
    --plugins_opts        Options for application plugins [Key-Value]
    --plugins             Load aplication plugins [Multiple; Split by ","]
    --config              Override the search paths and supply your own
                          config.
    --search              Search for config files in ~/.config.(ext) and in
                          your current working directory. [Flag]
    --config_base         Basename of config files [Default:".hpcrunner"]
    --search_path         Enable a search path for configs. Default is the
                          home dir and your cwd. [Multiple]
    --no_configs          --no_configs tells HPC::Runner not to load any
                          configs [Flag]
    --project --pr        Query by project.
    --no_log_json         Opt out of writing the tar archive of JSON stats.
                          This may be desirable for especially large
                          workflows. [Flag]
    --data_dir            Data directory for hpcrunner
    --most_recent         Show only the most recent submission. [Flag]
    --all -a              Show all submissions. [Flag]
    --jobname             Query by jobname
    --summary             Summary view of your jobs - Number of running,
                          completed, failed, successful. [Flag]
    --long -l             Long view. More detailed report - Task tags, exit
                          codes, duration, etc. [Flag]
    --json -j             Output data in json instead of a table. This option
                          suppresses logging output. [Flag]
    --help -h --usage -?  Prints this usage information. [Flag]

available subcommands:
    help  Prints this usage information
```

## perl-hpc-runner-command_archive

### Tool Description
Create an archive of results

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
- **Homepage**: https://github.com/biosails/HPC-Runner-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-hpc-runner-command/overview
- **Validation**: PASS

### Original Help Text
```text
usage:
    hpcrunner.pl archive [long options...]
    hpcrunner.pl help
    hpcrunner.pl archive --help

description:
    Create an archive of results. Default is to add all files in your current
    working directory.Include or exclude with --include_paths and --exclude_
    paths. This requires tar to be installed

options:
    --include_paths --ip  Include files or directories [Multiple]
    --exclude_paths --ep  Files or directories to exclude [Multiple]
    --archive             
    --help -h --usage -?  Prints this usage information. [Flag]

available subcommands:
    help  Prints this usage information
```
