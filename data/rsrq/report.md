# rsrq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rsrq_enqueue | PASS |  |
| rsrq_purge_all | PASS |  |
| rsrq_purge_failed | PASS |  |
| rsrq_purge_finished | PASS |  |
| rsrq_purge_queued | PASS |  |
| rsrq_snakemake_cancel | PASS |  |
| rsrq_snakemake_config | PASS |  |
| rsrq_snakemake_status | PASS |  |
| rsrq_snakemake_submit | PASS |  |
| rsrq_status | PASS |  |
| rsrq_worker | PASS |  |

## rsrq_enqueue

### Tool Description
Enqueue a batch of commands to be run

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aaronmussig/rsrq
- **Stars**: N/A
### Original Help Text
```text
Enqueue a batch of commands to be run

Usage: rsrq enqueue <QUEUE> <PATH>

Arguments:
  <QUEUE>  The target queue to add jobs to
  <PATH>   Path to the file containing one command per-line

Options:
  -h, --help  Print help
```


## rsrq_worker

### Tool Description
Spawns worker processes to consume jobs from a queue

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Spawns worker processes to consume jobs from a queue

Usage: rsrq worker [OPTIONS] <QUEUE>

Arguments:
  <QUEUE>  The target queue to process

Options:
      --workers <WORKERS>            The number of workers to spawn [default: 1]
      --max-duration <MAX_DURATION>  Stop processing after (h)ours (m)inutes (s)econds (eg: 1h30m, 30m, 1h5s)
      --max-jobs <MAX_JOBS>          Stop processing after this many jobs have finished
      --burst                        Stop processing once the queue is empty
      --poll <POLL>                  Interval to check for new jobs in milliseconds [default: 1000]
  -h, --help                         Print help
```


## rsrq_status

### Tool Description
Check the status of all objects in the Redis database

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Check the status of all objects in the Redis database

Usage: rsrq status [OPTIONS]

Options:
      --queue <QUEUE>  The target queue to check (default: all queues)
  -h, --help           Print help
```


## rsrq_purge_all

### Tool Description
Removes all data from Redis

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Removes all data from Redis

Usage: rsrq purge all

Options:
  -h, --help  Print help
```

## rsrq_purge_failed

### Tool Description
Removes all failed jobs

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Removes all failed jobs

Usage: rsrq purge failed [OPTIONS]

Options:
      --queue <QUEUE>  The target queue to purge (default: all queues)
  -h, --help           Print help
```

## rsrq_purge_finished

### Tool Description
Removes all finished jobs

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Removes all finished jobs

Usage: rsrq purge finished [OPTIONS]

Options:
      --queue <QUEUE>  The target queue to purge (default: all queues)
  -h, --help           Print help
```

## rsrq_purge_queued

### Tool Description
Removes all queued jobs

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Removes all queued jobs

Usage: rsrq purge queued [OPTIONS]

Options:
      --queue <QUEUE>  The target queue to purge (default: all queues)
  -h, --help           Print help
```

## rsrq_snakemake_submit

### Tool Description
Submit a Snakemake job

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Submit a Snakemake job

Usage: rsrq snakemake submit <JOB_SCRIPT>

Arguments:
  <JOB_SCRIPT>  The path to the job script

Options:
  -h, --help  Print help
```

## rsrq_snakemake_status

### Tool Description
Check the status of a Snakemake job

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Check the status of a Snakemake job

Usage: rsrq snakemake status <JOB_ID>

Arguments:
  <JOB_ID>  The Job ID to check

Options:
  -h, --help  Print help
```

## rsrq_snakemake_cancel

### Tool Description
Cancel a Snakemake job

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Cancel a Snakemake job

Usage: rsrq snakemake cancel [JOB_IDS]...

Arguments:
  [JOB_IDS]...  The Jobs ID to cancel

Options:
  -h, --help  Print help
```

## rsrq_snakemake_config

### Tool Description
Write the Snakemake cluster profile to the target directory

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Write the Snakemake cluster profile to the target directory

Usage: rsrq snakemake config <DIRECTORY>

Arguments:
  <DIRECTORY>  The target directory to write the profile to

Options:
  -h, --help  Print help
```

## Metadata
- **Skill**: generated
