# nextstrain-cli CWL Generation Report

## nextstrain-cli_nextstrain

### Tool Description
Nextstrain command-line interface (CLI)

The `nextstrain` program and its subcommands aim to provide a consistent way
to run and visualize pathogen builds and access Nextstrain components like
Augur and Auspice across computing platforms such as Docker, Conda,
Singularity, and AWS Batch.

### Metadata
- **Docker Image**: quay.io/biocontainers/nextstrain-cli:10.4.2--pyhdfd78af_0
- **Homepage**: https://docs.nextstrain.org/projects/cli/
- **Package**: https://anaconda.org/channels/bioconda/packages/nextstrain-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nextstrain-cli/overview
- **Total Downloads**: 101.3K
- **Last updated**: 2026-01-10
- **GitHub**: https://github.com/nextstrain/cli
- **Stars**: N/A
### Original Help Text
```text
usage: nextstrain [-h]
                  {run,build,view,deploy,remote,shell,update,setup,check-setup,login,logout,whoami,version,init-shell,authorization,debugger} ...

Nextstrain command-line interface (CLI)

The `nextstrain` program and its subcommands aim to provide a consistent way
to run and visualize pathogen builds and access Nextstrain components like
Augur and Auspice across computing platforms such as Docker, Conda,
Singularity, and AWS Batch.

Run `nextstrain <command> --help` for usage information about each command.
See <https://docs.nextstrain.org/projects/cli/en/10.4.2/> for more
documentation.

options:
  -h, --help            show this help message and exit
 

commands:
  {run,build,view,deploy,remote,shell,update,setup,check-setup,login,logout,whoami,version,init-shell,authorization,debugger}
    run                 Run pathogen workflow
    build               Run pathogen build
    view                View pathogen builds and narratives
    deploy              Deploy pathogen build
    remote              Upload, download, and manage remote datasets and
                        narratives.
    shell               Start a new shell in a runtime
    update              Update a pathogen or runtime (or this program)
    setup               Set up a pathogen or runtime
    check-setup         Check runtime setups
    login               Log into Nextstrain.org (and other remotes)
    logout              Log out of Nextstrain.org (and other remotes)
    whoami              Show information about the logged-in user
    version             Show version information
    init-shell          Print shell init script
    authorization       Print an HTTP Authorization header
    debugger            Start a debugger
```

