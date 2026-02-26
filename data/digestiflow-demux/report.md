# digestiflow-demux CWL Generation Report

## digestiflow-demux

### Tool Description
Run demultiplexing for Digestiflow

### Metadata
- **Docker Image**: quay.io/biocontainers/digestiflow-demux:0.5.3--pyhdfd78af_0
- **Homepage**: https://github.com/bihealth/digestiflow-demux
- **Package**: https://anaconda.org/channels/bioconda/packages/digestiflow-demux/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/digestiflow-demux/overview
- **Total Downloads**: 30.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bihealth/digestiflow-demux
- **Stars**: N/A
### Original Help Text
```text
usage: digestiflow-demux [-h] [--config CONFIG]
                         [--demux-tool {bcl2fastq,picard}] [--version]
                         [--api-url API_URL] [--api-token API_TOKEN]
                         [--log-api-token] [--api-read-only]
                         [--only-post-message] [--force-demultiplexing]
                         [--filter-folder-names] [--drmaa DRMAA]
                         [--cluster-config CLUSTER_CONFIG]
                         [--project-uuid PROJECT_UUID] [--cores CORES]
                         [--verbose] [--quiet] [--keep-work-dir]
                         [--max-jobs-per-second MAX_JOBS_PER_SECOND]
                         [--work-dir WORK_DIR] [--jobscript JOBSCRIPT]
                         [--lane LANES | --tiles TILES]
                         OUT_DIR SEQ_DIR [SEQ_DIR ...]

Run demultiplexing for Digestiflow

positional arguments:
  OUT_DIR               Path to output directory
  SEQ_DIR               Path(s) to sequencer raw data directories

options:
  -h, --help            show this help message and exit
  --config CONFIG       Path to configuration TOML file to load.
  --demux-tool {bcl2fastq,picard}
                        Demultiplexing tool to use. Choices are Illumina's
                        bcl2fastq(2) and Picard
  --version             show program's version number and exit
  --api-url API_URL     URL to Digestiflow Web API
  --api-token API_TOKEN
                        API token to use for Digestiflow Web API
  --log-api-token       Create log entry with API token (debug level; use only
                        when debugging as this has security implications)
  --api-read-only       Do not write/update flowcell info to database
  --only-post-message   Only create the success message.
  --force-demultiplexing
                        Force demultiplexing even if flow cell not marked as
                        ready
  --filter-folder-names
                        Filter folder names to those containing the vendor ID
                        of a flow cell that has been marked as ready for
                        demultiplexing in the server.
  --drmaa DRMAA         Pass as --drmaa argument to snakemake call (make sure
                        to define environment variable DRMAA_LIBRARY_PATH).
  --cluster-config CLUSTER_CONFIG
                        Pass as --cluster-config to snakemake call.
  --project-uuid PROJECT_UUID
                        Project UUID to register flowcell for
  --cores CORES         Degree of parallelism to use
  --verbose             Increase verbosity
  --quiet               Decrease verbosity
  --keep-work-dir       Keep temporary working directory (useful only for
                        debugging)
  --max-jobs-per-second MAX_JOBS_PER_SECOND
                        Max jobs per second to submit, default is 10.
  --work-dir WORK_DIR   Specify working directory (instead of using temporary
                        one)
  --jobscript JOBSCRIPT
                        Optional path to the jobscript to use when using
                        DRMAA.

Lane/Tile Selection:
  --lane LANES          Select individual lanes for demultiplexing; default is
                        to use all for which the sample sheet provides
                        information; provide multiple times for selecting
                        multiple lanes.
  --tiles TILES         Select tile regex; provide multiple times for multiple
                        regexes with bcl2fastq. Picard will use the first
                        tile. Conflicts with --lane
```

