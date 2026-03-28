# rsrq CWL Generation Report

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


## rsrq_snakemake

### Tool Description
Commands that can be issued by Snakemake for cluster execution

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Commands that can be issued by Snakemake for cluster execution

Usage: rsrq snakemake
       rsrq snakemake <COMMAND>

Commands:
  submit  Submit a Snakemake job
  status  Check the status of a Snakemake job
  cancel  Cancel a Snakemake job
  config  Write the Snakemake cluster profile to the target directory
  help    Print this message or the help of the given subcommand(s)

Options:
  -h, --help  Print help
```


## rsrq_purge

### Tool Description
Removes all data from Redis

### Metadata
- **Docker Image**: quay.io/biocontainers/rsrq:1.1.0--h4349ce8_0
- **Homepage**: https://github.com/aaronmussig/rsrq
- **Package**: https://anaconda.org/channels/bioconda/packages/rsrq/overview
- **Validation**: PASS

### Original Help Text
```text
Commands for removing data from Redis

Usage: rsrq purge
       rsrq purge <COMMAND>

Commands:
  all       Removes all data from Redis
  failed    Removes all failed jobs
  finished  Removes all finished jobs
  queued    Removes all queued jobs
  help      Print this message or the help of the given subcommand(s)

Options:
  -h, --help  Print help
```


## Metadata
- **Skill**: generated
