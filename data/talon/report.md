# talon CWL Generation Report

## talon

### Tool Description
TALON takes transcripts from one or more long read datasets (SAM format) and assigns them transcript and gene identifiers based on a database-bound annotation. Novel events are assigned new identifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/talon:6.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/mortazavilab/TALON
- **Package**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/talon/overview
- **Total Downloads**: 8.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/mortazavilab/TALON
- **Stars**: N/A
### Original Help Text
```text
usage: talon [-h] [--f CONFIG_FILE] [--cb] [--db FILE,] [--build STRING,]
             [--threads THREADS] [--cov MIN_COVERAGE]
             [--identity MIN_IDENTITY] [--nsg] [--tmpDir TMP_DIR]
             [--verbosity VERBOSITY] [--o OUTPREFIX]

TALON takes transcripts from one or more long read datasets (SAM format) and
assigns them transcript and gene identifiers based on a database-bound
annotation. Novel events are assigned new identifiers.

optional arguments:
  -h, --help            show this help message and exit
  --f CONFIG_FILE       Dataset config file: dataset name, sample description,
                        platform, sam file (comma-delimited)
  --cb                  Use CB tag in input SAM file instead of including a
                        dataset name in your config file
  --db FILE,            TALON database. Created using
                        talon_initialize_database
  --build STRING,       Genome build (i.e. hg38) to use. Must be in the
                        database.
  --threads THREADS, -t THREADS
                        Number of threads to run program with.
  --cov MIN_COVERAGE, -c MIN_COVERAGE
                        Minimum alignment coverage in order to use a SAM
                        entry. Default = 0.9
  --identity MIN_IDENTITY, -i MIN_IDENTITY
                        Minimum alignment identity in order to use a SAM
                        entry. Default = 0.8
  --nsg, --create_novel_spliced_genes
                        Make novel genes with the intergenic novelty label for
                        transcripts that don't share splice junctions with any
                        other models
  --tmpDir TMP_DIR      Path to directory for tmp files. Default =
                        `talon_tmp/`
  --verbosity VERBOSITY, -v VERBOSITY
                        Verbosity of TALON output. Higher numbers = more
                        verbose.
  --o OUTPREFIX         Prefix for output files
```

