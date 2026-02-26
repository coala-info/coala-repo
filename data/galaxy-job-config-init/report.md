# galaxy-job-config-init CWL Generation Report

## galaxy-job-config-init

### Tool Description
Generate job configuration YAML.

### Metadata
- **Docker Image**: quay.io/biocontainers/galaxy-job-config-init:0.1.3--pyhdfd78af_0
- **Homepage**: https://github.com/galaxyproject/galaxy-job-config-init
- **Package**: https://anaconda.org/channels/bioconda/packages/galaxy-job-config-init/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/galaxy-job-config-init/overview
- **Total Downloads**: 292
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/galaxyproject/galaxy-job-config-init
- **Stars**: N/A
### Original Help Text
```text
usage: galaxy-job-config-init [-h] [--galaxy-version GALAXY_VERSION]
                              [--runner {local,slurm,drmaa,k8s,condor}]
                              [--tpv] [--docker] [--docker-cmd DOCKER_CMD]
                              [--docker-host DOCKER_HOST] [--docker-sudo]
                              [--docker-sudo-cmd DOCKER_SUDO_CMD]
                              [--docker-run-extra-arguments DOCKER_RUN_EXTRA_ARGUMENTS]
                              [--docker-extra-volume [DOCKER_EXTRA_VOLUME ...]]
                              [--singularity]
                              [--singularity-cmd SINGULARITY_CMD]
                              [--singularity-sudo]
                              [--singularity-sudo-cmd SINGULARITY_SUDO_CMD]
                              [--singularity-extra-volume [SINGULARITY_EXTRA_VOLUME ...]]
                              [--tmp-dir TMP_DIR] [--all-in-one-handling]

Generate job configuration YAML.

options:
  -h, --help            show this help message and exit
  --galaxy-version GALAXY_VERSION
                        Generate job config YAML for this version of Galaxy.
  --runner {local,slurm,drmaa,k8s,condor}
                        Galaxy runner (e.g. DRM) to target (defaults to
                        'local' requiring no external resource manager).
  --tpv                 Enable shared TPV database.
  --docker              Enable Docker.
  --docker-cmd DOCKER_CMD
                        Command used to launch docker (defaults to 'docker').
  --docker-host DOCKER_HOST
                        Docker host.
  --docker-sudo         Use sudo with Docker.
  --docker-sudo-cmd DOCKER_SUDO_CMD
                        Docker sudo command.
  --docker-run-extra-arguments DOCKER_RUN_EXTRA_ARGUMENTS
                        Extra arguments for Docker run.
  --docker-extra-volume [DOCKER_EXTRA_VOLUME ...]
                        Extra Docker volumes.
  --singularity         Enable Singularity.
  --singularity-cmd SINGULARITY_CMD
                        Command used to execute singularity (defaults to
                        'singularity').
  --singularity-sudo    Use sudo with Singularity.
  --singularity-sudo-cmd SINGULARITY_SUDO_CMD
                        Singularity sudo command.
  --singularity-extra-volume [SINGULARITY_EXTRA_VOLUME ...]
                        Extra Singularity volumes.
  --tmp-dir TMP_DIR     Configure temporary directory handling. Use 'true' for
                        Galaxy-managed temp dirs, or specify shell
                        commands/variables for custom temp directory
                        allocation (e.g., '$DRM_VAR' or '$(mktemp -d
                        /scratch/gxyXXXXXX)'). Defaults to true.
  --all-in-one-handling
                        Use all-in-one job handling configuration. No separate
                        processes are required to handle jobs or workflows.
                        Recommended for temporary or single user Galaxy
                        instances such as created by planemo.
```

