# perl-biox-workflow-command CWL Generation Report

## perl-biox-workflow-command

### Tool Description
A tool for managing bioinformatics workflows (Note: The provided text is an error log and does not contain help documentation for arguments).

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-biox-workflow-command:2.4.1--pl5.22.0_0
- **Homepage**: https://github.com/biosails/BioX-Workflow-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-biox-workflow-command/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-biox-workflow-command/overview
- **Total Downloads**: 26.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/biosails/BioX-Workflow-Command
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 08:17:28  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "perl-biox-workflow-command": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## perl-biox-workflow-command_biox

### Tool Description
BioX::Workflow::Command is a templating system for creating Bioinformatics Workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-biox-workflow-command:2.4.1--pl5.22.0_0
- **Homepage**: https://github.com/biosails/BioX-Workflow-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-biox-workflow-command/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
Missing command
usage:
      biox run -w workflow.yml
      biox -h

description:
    BioX::Workflow::Command is a templating system for creating Bioinformatics
    Workflows.

global options:
    --plugins             Load aplication plugins [Multiple; Split by ","]
    --plugins_opts        Options for application plugins [Key-Value]
    --config_base         Basename of config files [Default:".bioxworkflow"]
    --config              Override the search paths and supply your own
                          config.
    --no_configs          --no_configs tells HPC::Runner not to load any
                          configs [Flag]
    --search_path         Enable a search path for configs. Default is the
                          home dir and your cwd. [Multiple]
    --search              Search for config files in ~/.config.(ext) and in
                          your current working directory. [Flag]
    --help -h --usage -?  Prints this usage information. [Flag]

available commands:
    add       Add rules to an existing workflow.
    inspect   Inspect your workflow
    new       Create a new workflow.
    run       Run your workflow.
    stats     Get the status of INPUT/OUTPUT for your workflow
    validate  Validate your workflow.
    help      Prints this usage information
```

## perl-biox-workflow-command_biox-workflow.pl

### Tool Description
BioX::Workflow::Command is a templating system for creating Bioinformatics Workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-biox-workflow-command:2.4.1--pl5.22.0_0
- **Homepage**: https://github.com/biosails/BioX-Workflow-Command
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-biox-workflow-command/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
	LANGUAGE = (unset),
	LC_ALL = (unset),
	LANG = "en_US.UTF-8"
    are supported and installed on your system.
perl: warning: Falling back to the standard locale ("C").
Missing command
usage:
      biox run -w workflow.yml
      biox -h

description:
    BioX::Workflow::Command is a templating system for creating Bioinformatics
    Workflows.

global options:
    --plugins_opts        Options for application plugins [Key-Value]
    --plugins             Load aplication plugins [Multiple; Split by ","]
    --search              Search for config files in ~/.config.(ext) and in
                          your current working directory. [Flag]
    --config_base         Basename of config files [Default:".bioxworkflow"]
    --config              Override the search paths and supply your own
                          config.
    --search_path         Enable a search path for configs. Default is the
                          home dir and your cwd. [Multiple]
    --no_configs          --no_configs tells HPC::Runner not to load any
                          configs [Flag]
    --help -h --usage -?  Prints this usage information. [Flag]

available commands:
    add       Add rules to an existing workflow.
    inspect   Inspect your workflow
    new       Create a new workflow.
    run       Run your workflow.
    stats     Get the status of INPUT/OUTPUT for your workflow
    validate  Validate your workflow.
    help      Prints this usage information
```

