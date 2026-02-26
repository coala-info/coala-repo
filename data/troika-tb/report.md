# troika-tb CWL Generation Report

## troika-tb_troika

### Tool Description
Troika - a pipeline for phylogenentic analysis, detection and reporting of genomic AST in Mtb If an arg is specified in more than one place, then commandline values override environment variables which override defaults.

### Metadata
- **Docker Image**: quay.io/biocontainers/troika-tb:0.0.5--py_0
- **Homepage**: https://github.com/kristyhoran/troika
- **Package**: https://anaconda.org/channels/bioconda/packages/troika-tb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/troika-tb/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/kristyhoran/troika
- **Stars**: N/A
### Original Help Text
```text
usage: troika [-h] [-v] [--input_file INPUT_FILE] [--detect_species]
              [--resistance_only] [--Singularity]
              [--profiler_singularity_path PROFILER_SINGULARITY_PATH]
              [--snippy_singularity_path SNIPPY_SINGULARITY_PATH]
              [--workdir WORKDIR] [--resources RESOURCES] [--jobs JOBS]
              [--profiler_threads PROFILER_THREADS]
              [--kraken_threads KRAKEN_THREADS] [--kraken_db KRAKEN_DB]
              [--snippy_threads SNIPPY_THREADS] [--mode {mdu,normal}]
              [--positive_control POSITIVE_CONTROL] [--db_version DB_VERSION]
              [--min_cov MIN_COV] [--min_aln MIN_ALN]

Troika - a pipeline for phylogenentic analysis, detection and reporting of
genomic AST in Mtb If an arg is specified in more than one place, then
commandline values override environment variables which override defaults.

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  --input_file INPUT_FILE, -i INPUT_FILE
                        Input file tab-delimited file 3 columns isolate_id
                        path_to_r1 path_to_r2 (default: )
  --detect_species, -d  Set if you would like to detect species - note if not
                        set troika may include non-tuberculosis species in the
                        analysis. (default: False)
  --resistance_only     If detection of resistance mutations only is needed.
                        Phylogeny will not be performed. (default: False)
  --Singularity, -S     If singularity is to be used for troika. (default:
                        False)
  --profiler_singularity_path PROFILER_SINGULARITY_PATH, -ps PROFILER_SINGULARITY_PATH
                        URL for TB-profiler singularity container. (default:
                        docker://mduphl/mtbtools)
  --snippy_singularity_path SNIPPY_SINGULARITY_PATH, -ss SNIPPY_SINGULARITY_PATH
                        URL for Snippy singularity container. (default:
                        docker://mduphl/snippy:v4.4.3)
  --workdir WORKDIR, -w WORKDIR
                        Working directory, default is current directory
                        (default: /)
  --resources RESOURCES, -r RESOURCES
                        Directory where templates are stored (default:
                        /usr/local/lib/python3.9/site-packages/troika_tb)
  --jobs JOBS, -j JOBS  Number of jobs to run in parallel. (default: 8)
  --profiler_threads PROFILER_THREADS, -t PROFILER_THREADS
                        Number of threads to run TB-profiler (default: 1)
  --kraken_threads KRAKEN_THREADS, -kt KRAKEN_THREADS
                        Number of threads for kraken (default: 4)
  --kraken_db KRAKEN_DB, -k KRAKEN_DB
                        Path to DB for use with kraken2, if no DB present
                        speciation will not be performed. [env var:
                        KRAKEN2_DEFAULT_DB] (default: None)
  --snippy_threads SNIPPY_THREADS, -st SNIPPY_THREADS
                        Number of threads for snippy (default: 8)
  --mode {mdu,normal}, -m {mdu,normal}
                        If running for MDU service use 'mdu', else use
                        'normal' (default: normal)
  --positive_control POSITIVE_CONTROL, -pc POSITIVE_CONTROL
                        Path to positive control - REQUIRED if running for MDU
                        service (default: )
  --db_version DB_VERSION
                        The version of database being used. (default:
                        TBProfiler-20190820)
  --min_cov MIN_COV, -mc MIN_COV
                        Minimum coverage for quality checks, isolates with
                        coverage below this threshold will not be used in the
                        analysis. (default: 40)
  --min_aln MIN_ALN, -ma     MIN_ALN
                        Minimum alignment for phylogenetic analysis,
                        alignments lower than this threshold will not be
                        included in the calculation of core-genome. (default:
                        80)
```

