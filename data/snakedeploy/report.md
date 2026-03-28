# snakedeploy CWL Generation Report

## snakedeploy_deploy-workflow

### Tool Description
Deploy a workflow from a git repository.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Total Downloads**: 59.7K
- **Last updated**: 2026-02-13
- **GitHub**: https://github.com/snakemake/snakedeploy
- **Stars**: N/A
### Original Help Text
```text
usage: snakedeploy deploy-workflow [-h] [--tag TAG] [--branch BRANCH]
                                   [--name NAME] [--force]
                                   repo dest

Deploy a workflow from a git repository.

positional arguments:
  repo             Workflow repository to use.
  dest             Path to create the deploying workflow in.

options:
  -h, --help       show this help message and exit
  --tag TAG        Git tag to deploy from (e.g. a certain release).
  --branch BRANCH  Git branch to deploy from.
  --force          Enforce overwriting of already present files.

DEPLOY:
  --name NAME      The name for the module in the resulting Snakefile
                   (default: repository name).
```


## snakedeploy_collect-files

### Tool Description
Collect files into a tabular structure, given input from STDIN formats glob patterns defined in a config sheet.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy collect-files [-h] config

Collect files into a tabular structure, given input from STDIN formats glob
patterns defined in a config sheet.

positional arguments:
  config      A TSV file containing two columns input_pattern and
              glob_pattern. The input pattern is a Python regular expression
              that selects lines from STDIN, and extracts values from it (as
              groups; example: 'S888_Nr(?P<nr>[0-9]+)'). If possible such
              extracted values are automatically converted to integers. The
              glob pattern is formatted (via the Python format minilanguage)
              with the values from the input pattern and used to glob files
              from the filesystem. The globbed files are printed as TSV next
              to the matching input value taken from STDIN. If the globbing
              does not return any files for one STDIN input, an error is
              thrown. If one STDIN input is not matched by any of the provided
              stdin patterns, an error is thrown. If one STDIN input is
              matched by multiple of the provided stdin patterns, an error is
              thrown.

options:
  -h, --help  show this help message and exit
```


## snakedeploy_from

### Tool Description
Deploy Snakemake workflows and manage their environments.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy [-h] [--version] [--quiet] [--verbose]
                   [--log-disable-color]
                   {deploy-workflow,collect-files,pin-conda-envs,update-conda-envs,update-snakemake-wrappers,scaffold-snakemake-plugin}
                   ...
snakedeploy: error: argument subcommand: invalid choice: 'from' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)
```


## snakedeploy_pin-conda-envs

### Tool Description
Pin/lock given conda environment definition files (in YAML format) into a list of explicit package URLs including checksums, stored in a file <prefix>.<platform>.pin.txt with prefix being the path to the original definition file and <platform> being the name of the platform the pinning was performed on (e.g. linux-64). The resulting file will be automatically used by Snakemake to restore exactly the pinned environment. Also you can use it manually, e.g. with 'conda create -f <path-to-pin-file> -n <env-name>'.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy pin-conda-envs [-h] [--conda-frontend {mamba,conda}]
                                  [--create-prs] [--entity-regex ENTITY_REGEX]
                                  [--pr-add-label] [--warn-on-error]
                                  envfiles [envfiles ...]

Pin/lock given conda environment definition files (in YAML format) into a list
of explicit package URLs including checksums, stored in a file
<prefix>.<platform>.pin.txt with prefix being the path to the original
definition file and <platform> being the name of the platform the pinning was
performed on (e.g. linux-64). The resulting file will be automatically used by
Snakemake to restore exactly the pinned environment. Also you can use it
manually, e.g. with 'conda create -f <path-to-pin-file> -n <env-name>'.

positional arguments:
  envfiles              Environment definition YAML files to pin.

options:
  -h, --help            show this help message and exit
  --conda-frontend {mamba,conda}
                        Conda frontend to use.
  --create-prs          Create pull request for each updated environment.
                        Requires GITHUB_TOKEN and GITHUB_REPOSITORY (the repo
                        name) and one of GITHUB_REF_NAME or GITHUB_BASE_REF
                        (preferring the latter, representing the target
                        branch, e.g. main or master) environment variables to
                        be set (the latter three are available when running as
                        github action). In order to enable further actions
                        (e.g. checks) to run on the generated PRs, the
                        provided GITHUB_TOKEN may not be the default github
                        actions token. See here for options:
                        https://github.com/peter-evans/create-pull-
                        request/blob/main/docs/concepts-
                        guidelines.md#triggering-further-workflow-runs.
  --entity-regex ENTITY_REGEX
                        Regular expression for deriving an entity name from
                        the environment file name (will be used for adding a
                        label and for title and description). Has to contain a
                        group 'entity' (e.g.
                        '(?P<entity>.+)/environment.yaml').
  --pr-add-label        Add a label to the PR. Has to be used in combination
                        with --entity-regex.
  --warn-on-error       Only warn if conda env evaluation fails and go on with
                        the other envs.
```


## snakedeploy_package

### Tool Description
snakedeploy: error: argument subcommand: invalid choice: 'package' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy [-h] [--version] [--quiet] [--verbose]
                   [--log-disable-color]
                   {deploy-workflow,collect-files,pin-conda-envs,update-conda-envs,update-snakemake-wrappers,scaffold-snakemake-plugin}
                   ...
snakedeploy: error: argument subcommand: invalid choice: 'package' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)
```


## snakedeploy_update-conda-envs

### Tool Description
Update given conda environment definition files (in YAML format) so that all contained packages are set to the latest feasible versions.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy update-conda-envs [-h] [--conda-frontend {mamba,conda}]
                                     [--pin-envs] [--create-prs]
                                     [--entity-regex ENTITY_REGEX]
                                     [--pr-add-label] [--warn-on-error]
                                     envfiles [envfiles ...]

Update given conda environment definition files (in YAML format) so that all
contained packages are set to the latest feasible versions.

positional arguments:
  envfiles              Environment definition YAML files to update.

options:
  -h, --help            show this help message and exit
  --conda-frontend {mamba,conda}
                        Conda frontend to use.
  --pin-envs            also pin the updated environments (see pin-conda-envs
                        subcommand).
  --create-prs          Create pull request for each updated environment.
                        Requires GITHUB_TOKEN and GITHUB_REPOSITORY (the repo
                        name) and one of GITHUB_REF_NAME or GITHUB_BASE_REF
                        (preferring the latter, representing the target
                        branch, e.g. main or master) environment variables to
                        be set (the latter three are available when running as
                        github action). In order to enable further actions
                        (e.g. checks) to run on the generated PRs, the
                        provided GITHUB_TOKEN may not be the default github
                        actions token. See here for options:
                        https://github.com/peter-evans/create-pull-
                        request/blob/main/docs/concepts-
                        guidelines.md#triggering-further-workflow-runs.
  --entity-regex ENTITY_REGEX
                        Regular expression for deriving an entity name from
                        the environment file name (will be used for adding a
                        label and for title and description). Has to contain a
                        group 'entity' (e.g.
                        '(?P<entity>.+)/environment.yaml').
  --pr-add-label        Add a label to the PR. Has to be used in combination
                        with --entity-regex.
  --warn-on-error       Only warn if conda env evaluation fails and go on with
                        the other envs.
```


## snakedeploy_YAML

### Tool Description
A tool for deploying and managing Snakemake workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy [-h] [--version] [--quiet] [--verbose]
                   [--log-disable-color]
                   {deploy-workflow,collect-files,pin-conda-envs,update-conda-envs,update-snakemake-wrappers,scaffold-snakemake-plugin}
                   ...
snakedeploy: error: argument subcommand: invalid choice: 'YAML' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)
```


## snakedeploy_the

### Tool Description
A tool for deploying and managing Snakemake workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy [-h] [--version] [--quiet] [--verbose]
                   [--log-disable-color]
                   {deploy-workflow,collect-files,pin-conda-envs,update-conda-envs,update-snakemake-wrappers,scaffold-snakemake-plugin}
                   ...
snakedeploy: error: argument subcommand: invalid choice: 'the' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)
```


## snakedeploy_update-snakemake-wrappers

### Tool Description
Update all snakemake wrappers in given Snakefiles to their latest versions.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy update-snakemake-wrappers [-h] [--create-prs]
                                             [--entity-regex ENTITY_REGEX]
                                             [--pr-add-label]
                                             [--per-snakefile-prs]
                                             snakefiles [snakefiles ...]

Update all snakemake wrappers in given Snakefiles to their latest versions.

positional arguments:
  snakefiles            Paths to Snakefiles which should be updated.

options:
  -h, --help            show this help message and exit
  --create-prs          Create pull request for each updated snakefile.
                        Requires GITHUB_TOKEN and GITHUB_REPOSITORY (the repo
                        name) and one of GITHUB_REF_NAME or GITHUB_BASE_REF
                        (preferring the latter, representing the target
                        branch, e.g. main or master) environment variables to
                        be set (the latter three are available when running as
                        github action). In order to enable further actions
                        (e.g. checks) to run on the generated PRs, the
                        provided GITHUB_TOKEN may not be the default github
                        actions token. See here for options:
                        https://github.com/peter-evans/create-pull-
                        request/blob/main/docs/concepts-
                        guidelines.md#triggering-further-workflow-runs.
  --entity-regex ENTITY_REGEX
                        Regular expression for deriving an entity name from
                        the snakefile file name (will be used for adding a
                        label and for title and description). Has to contain a
                        group 'entity' (e.g.
                        '(?P<entity>.+)/environment.yaml').
  --pr-add-label        Add a label to the PR. Has to be used in combination
                        with --entity-regex.
  --per-snakefile-prs   Create one PR per Snakefile instead of a single PR for
                        all.
```


## snakedeploy_Update

### Tool Description
A tool for deploying and managing Snakemake workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy [-h] [--version] [--quiet] [--verbose]
                   [--log-disable-color]
                   {deploy-workflow,collect-files,pin-conda-envs,update-conda-envs,update-snakemake-wrappers,scaffold-snakemake-plugin}
                   ...
snakedeploy: error: argument subcommand: invalid choice: 'Update' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)
```


## snakedeploy_their

### Tool Description
A tool for deploying and managing Snakemake workflows.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy [-h] [--version] [--quiet] [--verbose]
                   [--log-disable-color]
                   {deploy-workflow,collect-files,pin-conda-envs,update-conda-envs,update-snakemake-wrappers,scaffold-snakemake-plugin}
                   ...
snakedeploy: error: argument subcommand: invalid choice: 'their' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)
```


## snakedeploy_scaffold-snakemake-plugin

### Tool Description
Scaffold a snakemake plugin by adding recommended dependencies and code snippets.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy scaffold-snakemake-plugin [-h]
                                             {executor,report,scheduler,storage,software-deployment,logger}

Scaffold a snakemake plugin by adding recommended dependencies and code
snippets.

positional arguments:
  {executor,report,scheduler,storage,software-deployment,logger}
                        Type of the plugin to scaffold.

options:
  -h, --help            show this help message and exit
```


## snakedeploy_Scaffold

### Tool Description
A tool for managing Snakemake workflows and their dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy [-h] [--version] [--quiet] [--verbose]
                   [--log-disable-color]
                   {deploy-workflow,collect-files,pin-conda-envs,update-conda-envs,update-snakemake-wrappers,scaffold-snakemake-plugin}
                   ...
snakedeploy: error: argument subcommand: invalid choice: 'Scaffold' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)
```


## snakedeploy_dependencies

### Tool Description
A tool for deploying Snakemake workflows and managing their dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/snakedeploy:0.16.0--pyhdfd78af_0
- **Homepage**: https://github.com/snakemake/snakedeploy
- **Package**: https://anaconda.org/channels/bioconda/packages/snakedeploy/overview
- **Validation**: PASS

### Original Help Text
```text
usage: snakedeploy [-h] [--version] [--quiet] [--verbose]
                   [--log-disable-color]
                   {deploy-workflow,collect-files,pin-conda-envs,update-conda-envs,update-snakemake-wrappers,scaffold-snakemake-plugin}
                   ...
snakedeploy: error: argument subcommand: invalid choice: 'dependencies' (choose from deploy-workflow, collect-files, pin-conda-envs, update-conda-envs, update-snakemake-wrappers, scaffold-snakemake-plugin)
```


## Metadata
- **Skill**: generated
