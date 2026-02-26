# perl-hpc-runner-command CWL Generation Report

## perl-hpc-runner-command_hpcrunner.pl

### Tool Description
HPC::Runner::Command is a set of libraries for scaffolding data analysis projects, submitting and executing jobs on an HPC cluster or workstation, and obsessively logging results.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-hpc-runner-command:3.2.13--pl5.22.0_0
- **Homepage**: https://github.com/biosails/HPC-Runner-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-hpc-runner-command/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-hpc-runner-command/overview
- **Total Downloads**: 75.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biosails/HPC-Runner-Command
- **Stars**: N/A
### Original Help Text
```text
Missing command
usage:
    To create a new project
    
        hpcrunner.pl new MyNewProject
    
    To submit jobs to a cluster
    
        hpcrunner.pl submit_jobs --infile my_submission.sh
    
    To run jobs on an interactive queue or workstation
    
        hpcrunner.pl single_node --infile my_submission.sh

description:
    HPC::Runner::Command is a set of libraries for scaffolding data analysis
    projects, submitting and executing jobs on an HPC cluster or workstation,
    and obsessively logging results.
    
    Get help by heading on over to github and raising an issue. GitHub | https
    ://github.com/biosails/HPC-Runner-Command/issues.
    
    Please see the complete documentation at HPC::Runner::Command GitBooks |
    https://biosails.gitbooks.io/hpc-runner-command-docs/content/.

global options:
    --plugins_opts        Options for application plugins [Key-Value]
    --plugins             Load aplication plugins [Multiple; Split by ","]
    --config              Override the search paths and supply your own
                          config.
    --no_configs          --no_configs tells HPC::Runner not to load any
                          configs [Flag]
    --search              Search for config files in ~/.config.(ext) and in
                          your current working directory. [Flag]
    --search_path         Enable a search path for configs. Default is the
                          home dir and your cwd. [Multiple]
    --config_base         Basename of config files [Default:".hpcrunner"]
    --project --pr        Give your jobnames an additional project name. #HPC
                          jobname=gzip will be submitted as 001_project_gzip
    --no_log_json         Opt out of writing the tar archive of JSON stats.
                          This may be desirable for especially large
                          workflows. [Flag]
    --help -h --usage -?  Prints this usage information. [Flag]

available commands:
    archive        Create an archive of results.
    execute_array  Execute commands
    execute_job    Execute commands
    new            Create a new project
    single_node    Execute commands
    stats          Query submissions by project, or jobname
    submit_jobs    Submit jobs to the HPC system
    help           Prints this usage information
```

