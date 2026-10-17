# prophane CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| prophane_init | PASS |  |
| prophane_prepare-dbs | Not completed | downloads large public databases (and conda environments); too heavy |
| prophane_run | Not completed | needs conda environment downloads from repo.anaconda.com, which is unreachable here (connection reset) |

## prophane_init

### Tool Description
Write DB_DIR path for storing prophane databases to general config file.

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: prophane init [OPTIONS] DB_DIR

  Write DB_DIR path for storing prophane databases to general config file.

Options:
  --help  Show this message and exit.
```

## prophane_prepare-dbs

### Tool Description
download the databases required to execute the tasks in the provided CONFIGFILE

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: prophane prepare-dbs [OPTIONS] CONFIGFILE [SNAKEMAKE_ARGS]...

  download the databases required to execute the tasks in the provided
  CONFIGFILE

Options:
  --verbose
  --help     Show this message and exit.
```

## prophane_run

### Tool Description
execute prophane workflow (using snakemake underneath)

### Metadata
- **Docker Image**: quay.io/biocontainers/prophane:6.2.6--hdfd78af_0
- **Homepage**: https://gitlab.com/s.fuchs/prophane/
- **Package**: https://anaconda.org/channels/bioconda/packages/prophane/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: prophane run [OPTIONS] CONFIGFILE [SNAKEMAKE_ARGS]...

  execute prophane workflow (using snakemake underneath)

Options:
  --verbose
  --help     Show this message and exit.
```

## Metadata
- **Skill**: generated
