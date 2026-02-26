# minute CWL Generation Report

## minute_download

### Tool Description
Downloads libraries from a TSV file.

### Metadata
- **Docker Image**: quay.io/biocontainers/minute:0.12.1--pyhdfd78af_1
- **Homepage**: https://github.com/NBISweden/minute/
- **Package**: https://anaconda.org/channels/bioconda/packages/minute/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/minute/overview
- **Total Downloads**: 7.8K
- **Last updated**: 2025-08-08
- **GitHub**: https://github.com/NBISweden/minute
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/minute", line 9, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.12/site-packages/minute/__main__.py", line 39, in main
    module.main(args, arguments=remainder)
  File "/usr/local/lib/python3.12/site-packages/minute/cli/download.py", line 26, in main
    run_download(**vars(args))
  File "/usr/local/lib/python3.12/site-packages/minute/cli/download.py", line 32, in run_download
    for library in read_libraries("libraries.tsv"):
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/minute/__init__.py", line 104, in read_libraries
    for row in read_tsv(path, columns=4):
               ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.12/site-packages/minute/__init__.py", line 223, in read_tsv
    with open(path) as f:
         ^^^^^^^^^^
FileNotFoundError: [Errno 2] No such file or directory: 'libraries.tsv'
```


## minute_init

### Tool Description
Create and initialize a new pipeline directory

### Metadata
- **Docker Image**: quay.io/biocontainers/minute:0.12.1--pyhdfd78af_1
- **Homepage**: https://github.com/NBISweden/minute/
- **Package**: https://anaconda.org/channels/bioconda/packages/minute/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minute init [-h] [--reads READS] [--barcodes BARCODES] [--input INPUT]
                   [--config CONFIG]
                   directory

Create and initialize a new pipeline directory

positional arguments:
  directory            New pipeline directory to create

options:
  -h, --help           show this help message and exit
  --reads READS        Raw reads directory with paired-end FASTQ files.
  --barcodes BARCODES  Barcodes description file.
  --input INPUT        Name of the input sample (FASTQ name without _R1/_R2).
  --config CONFIG      Optional minute.yaml file to use as configuration. If
                       not provided, a template will be created.
```


## minute_run

### Tool Description
Run the Minute pipeline

Calls Snakemake to produce all the output files.

minute run will execute a default set of rules and produce a set of final bigWig
files and a MultiQC report.

Any further arguments that this wrapper script does not recognize are forwarded
to Snakemake. This can be used to provide file(s) to create, targets to run or
any other Snakemake options. For example, this runs the "full" target (including
fingerprinting) in dry-run mode:

    minute run --dryrun full

Alternative target rules:

    final (default) Default pipeline that does not include fingerprint plots.
                    It runs quicker than the full version.

    full            Runs the default pipeline plus deepTools fingerprint. This
                    is a computationally expensive step that can significantly
                    increase runtime on highly multiplexed minute runs.

    quick           Runs the default pipeline but reduces the amount of bigWig
                    files produced. Only scaled bigWig files will be generated
                    for treatments, and unscaled bigWig files will be generated
                    for controls.

    pooled_only     Runs the default pipeline, but only generates the bigWig
                    files corresponding to the pooled replicates.

    pooled_only_minimal Runs the default pipeline, but it only generates bigWig
                    files for the pools present in groups.tsv, scaled for
                    treatment libraries and unscaled for the controls.

    mapq_bigwigs    Generates an additional set of bigWig files where each final
                    BAM alignment is also filtered for mapping quality. This
                    requires a mapping_quality_bigwig parameter value higher
                    than zero in the minute.yaml configuration.

    no_bigwigs      Runs the default pipeline but skips the bigWig generation
                    entirely. This is useful for a quick check on QC metrics,
                    since the rest of the steps are significantly faster than
                    bigWig generation.

    no_scaling      Skips entirely the scaling statistics and bigWigs. Produces
                    only unscaled bigWigs and a MultiQC report with only
                    non-scaling QC metrics.

See minute documentation for a more detailed description of the available target
rules and their outputs.

Run 'snakemake --help' or see the Snakemake documentation to see valid snakemake
arguments.

### Metadata
- **Docker Image**: quay.io/biocontainers/minute:0.12.1--pyhdfd78af_1
- **Homepage**: https://github.com/NBISweden/minute/
- **Package**: https://anaconda.org/channels/bioconda/packages/minute/overview
- **Validation**: PASS

### Original Help Text
```text
usage: minute run [-h] [--cores N] [--dryrun]

Run the Minute pipeline

Calls Snakemake to produce all the output files.

minute run will execute a default set of rules and produce a set of final bigWig
files and a MultiQC report.

Any further arguments that this wrapper script does not recognize are forwarded
to Snakemake. This can be used to provide file(s) to create, targets to run or
any other Snakemake options. For example, this runs the "full" target (including
fingerprinting) in dry-run mode:

    minute run --dryrun full

Alternative target rules:

    final (default) Default pipeline that does not include fingerprint plots.
                    It runs quicker than the full version.

    full            Runs the default pipeline plus deepTools fingerprint. This
                    is a computationally expensive step that can significantly
                    increase runtime on highly multiplexed minute runs.

    quick           Runs the default pipeline but reduces the amount of bigWig
                    files produced. Only scaled bigWig files will be generated
                    for treatments, and unscaled bigWig files will be generated
                    for controls.

    pooled_only     Runs the default pipeline, but only generates the bigWig
                    files corresponding to the pooled replicates.

    pooled_only_minimal Runs the default pipeline, but it only generates bigWig
                    files for the pools present in groups.tsv, scaled for
                    treatment libraries and unscaled for the controls.

    mapq_bigwigs    Generates an additional set of bigWig files where each final
                    BAM alignment is also filtered for mapping quality. This
                    requires a mapping_quality_bigwig parameter value higher
                    than zero in the minute.yaml configuration.

    no_bigwigs      Runs the default pipeline but skips the bigWig generation
                    entirely. This is useful for a quick check on QC metrics,
                    since the rest of the steps are significantly faster than
                    bigWig generation.

    no_scaling      Skips entirely the scaling statistics and bigWigs. Produces
                    only unscaled bigWigs and a MultiQC report with only
                    non-scaling QC metrics.

See minute documentation for a more detailed description of the available target
rules and their outputs.

Run 'snakemake --help' or see the Snakemake documentation to see valid snakemake
arguments.

options:
  -h, --help       show this help message and exit
  --cores N, -c N  Run on at most N CPU cores in parallel. Default: Use as
                   many cores as available)
  --dryrun, -n     Do not execute anything
```


## Metadata
- **Skill**: generated
