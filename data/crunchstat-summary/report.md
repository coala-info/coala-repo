# crunchstat-summary CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crunchstat-summary | Not completed | the tool connects to the Arvados API on every run, also for a local log file, so it needs an Arvados host and token. |

## crunchstat-summary

### Tool Description
Summarize Arvados crunchstat logs

### Metadata
- **Docker Image**: quay.io/biocontainers/crunchstat-summary:3.2.0--pyhdfd78af_0
- **Homepage**: https://arvados.org
- **Package**: https://anaconda.org/channels/bioconda/packages/crunchstat-summary/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crunchstat-summary/overview
- **Total Downloads**: 109
- **Last updated**: 2025-11-24
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: crunchstat-summary [-h] [--job UUID | --container UUID |
                          --log-file LOG_FILE] [--skip-child-jobs]
                          [--format {html,text}] [--threads THREADS]
                          [--verbose] [--version]

Summarize resource usage of an Arvados Crunch job

options:
  -h, --help            show this help message and exit
  --job, --container-request UUID
                        Look up the specified job or container request and
                        read its log data from Keep (or from the Arvados event
                        log, if the job is still running)
  --container UUID      [Deprecated] Look up the specified container find its
                        container request and read its log data from Keep (or
                        from the Arvados event log, if the job is still
                        running)
  --log-file LOG_FILE   Read log data from a regular file
  --skip-child-jobs     Do not include stats from child jobs/containers
  --format {html,text}  Report format
  --threads THREADS     Maximum worker threads to run
  --verbose, -v         Log more information (once for progress, twice for
                        debug)
  --version             Print version and exit.
```


## Metadata
- **Skill**: generated
