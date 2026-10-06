# perl-biox-workflow-command CWL Generation Report

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

