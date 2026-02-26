# seqerakit CWL Generation Report

## seqerakit

### Tool Description
Create resources on Seqera Platform using a YAML configuration file.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqerakit:0.5.6--pyhdfd78af_0
- **Homepage**: https://github.com/seqeralabs/seqera-kit
- **Package**: https://anaconda.org/channels/bioconda/packages/seqerakit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqerakit/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/seqeralabs/seqera-kit
- **Stars**: N/A
### Original Help Text
```text
usage: seqerakit [-h] [-l {CRITICAL,ERROR,WARNING,INFO,DEBUG}] [--info] [-j]
                 [--dryrun] [--version] [--delete] [--cli CLI_ARGS]
                 [--targets TARGETS] [--env-file ENV_FILE]
                 [--on-exists {fail,ignore,overwrite}] [--overwrite]
                 [--verbose]
                 [yaml ...]

Create resources on Seqera Platform using a YAML configuration file.

options:
  -h, --help            show this help message and exit

General Options:
  -l, --log_level {CRITICAL,ERROR,WARNING,INFO,DEBUG}
                        Set the logging level.
  --info, -i            Display Seqera Platform information and exit.
  -j, --json            Output JSON format in stdout.
  --dryrun, -d          Print the commands that would be executed.
  --version, -v         Show version number and exit.

YAML Processing Options:
  yaml                  One or more YAML files with Seqera Platform resource
                        definitions.
  --delete              Recursively delete resources defined in the YAML
                        files.
  --cli CLI_ARGS        Additional Seqera Platform CLI specific options to be
                        passed, enclosed in double quotes (e.g. '--cli="--
                        insecure"'). Can be specified multiple times.
  --targets TARGETS     Specify the resources to be targeted for creation in a
                        YAML file through a comma-separated list (e.g. '--
                        targets=teams,participants').
  --env-file ENV_FILE   Path to a YAML file containing environment variables
                        for configuration.
  --on-exists {fail,ignore,overwrite}
                        Globally specifies the action to take if a resource
                        already exists.
  --overwrite           Globally enable overwrite for all resources defined in
                        YAML input(s). Deprecated: Please use '--on-
                        exists=overwrite' instead.
  --verbose             Enable verbose output for Seqera Platform CLI.
```

