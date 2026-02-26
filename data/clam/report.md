# clam CWL Generation Report

## clam_loci

### Tool Description
Calculate callable sites from depth statistics

### Metadata
- **Docker Image**: quay.io/biocontainers/clam:1.1.3--h79ce301_0
- **Homepage**: https://github.com/cademirch/clam
- **Package**: https://anaconda.org/channels/bioconda/packages/clam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clam/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2026-02-21
- **GitHub**: https://github.com/cademirch/clam
- **Stars**: N/A
### Original Help Text
```text
Calculate callable sites from depth statistics

Usage: clam loci [OPTIONS] --output <OUTPUT> [INPUT]...

Arguments:
  [INPUT]...  Input depth files. Not needed when using --samples, except a single zarr store can be combined with --samples for population override

Options:
  -o, --output <OUTPUT>
          Output path for callable sites zarr array
  -m, --min-depth <MIN_DEPTH>
          Minimum depth to consider a site callable for each individual [default: 0]
  -M, --max-depth <MAX_DEPTH>
          Maximum depth to consider a site callable for each individual [default: inf]
  -d, --min-proportion <MIN_PROPORTION>
          Proportion of samples that must pass thresholds at a site [default: 0]
      --min-mean-depth <MEAN_DEPTH_MIN>
          Minimum mean depth across all samples required at a site [default: 0]
      --max-mean-depth <MEAN_DEPTH_MAX>
          Maximum mean depth across all samples allowed at a site [default: inf]
      --chunk-size <CHUNK_SIZE>
          Chunk size for processing (base pairs) [default: 1000000]
      --per-sample
          Output per-sample masks instead of per-population counts
      --min-gq <MIN_GQ>
          Minimum gq to count depth (GVCF input only)
      --thresholds-file <THRESHOLD_FILE>
          Custom thresholds per chromosome. Tab-separated file: contig, min_depth, max_depth
  -t, --threads <THREADS>
          Number of threads to use for parallel processing [default: 1]
  -s, --samples <SAMPLES>
          Path to samples TSV file (with header). Columns: sample_name (required), file_path (required for collect; optional for loci with zarr input), population (optional). For loci/collect: input files are read from the TSV instead of positional arguments (unless input is a zarr store, in which case --samples provides population assignments only). For stat: provides population assignments (file_path column is not used)
  -p, --population-file <POPULATION_FILE>
          [DEPRECATED: use --samples] Path to file that defines populations. Tab separated: sample\tpopulation_name
  -x, --exclude <EXCLUDE>...
          Comma separated list of chromosomes to exclude
      --exclude-file <EXCLUDE_FILE>
          Path to file with chromosomes to exclude, one per line
  -i, --include <INCLUDE>...
          Comma separated list of chromosomes to include (restrict analysis to)
      --include-file <INCLUDE_FILE>
          Path to file with chromosomes to include, one per line
      --force-samples
          Only warn about samples not in population file; exclude them from analysis (only supported for 'stat' command)
  -h, --help
          Print help
```


## clam_stat

### Tool Description
Calculate population genetic statistics from VCF

### Metadata
- **Docker Image**: quay.io/biocontainers/clam:1.1.3--h79ce301_0
- **Homepage**: https://github.com/cademirch/clam
- **Package**: https://anaconda.org/channels/bioconda/packages/clam/overview
- **Validation**: PASS

### Original Help Text
```text
Calculate population genetic statistics from VCF

Usage: clam stat [OPTIONS] --outdir <OUTDIR> <VCF>

Arguments:
  <VCF>  Path to input VCF file (bgzipped and indexed)

Options:
  -o, --outdir <OUTDIR>
          Output directory for statistics files
  -c, --callable <CALLABLE>
          Path to callable sites zarr array (from clam loci)
  -r, --roh <ROH>
          Path to ROH regions BED file (sample name in 4th column)
  -w, --window-size <WINDOW_SIZE>
          Window size in base pairs
      --regions-file <REGIONS_FILE>
          BED file specifying regions to calculate statistics for
      --chunk-size <CHUNK_SIZE>
          Chunk size for parallel processing (base pairs) [default: 1000000]
  -t, --threads <THREADS>
          Number of threads to use for parallel processing [default: 1]
  -s, --samples <SAMPLES>
          Path to samples TSV file (with header). Columns: sample_name (required), file_path (required for collect; optional for loci with zarr input), population (optional). For loci/collect: input files are read from the TSV instead of positional arguments (unless input is a zarr store, in which case --samples provides population assignments only). For stat: provides population assignments (file_path column is not used)
  -p, --population-file <POPULATION_FILE>
          [DEPRECATED: use --samples] Path to file that defines populations. Tab separated: sample\tpopulation_name
  -x, --exclude <EXCLUDE>...
          Comma separated list of chromosomes to exclude
      --exclude-file <EXCLUDE_FILE>
          Path to file with chromosomes to exclude, one per line
  -i, --include <INCLUDE>...
          Comma separated list of chromosomes to include (restrict analysis to)
      --include-file <INCLUDE_FILE>
          Path to file with chromosomes to include, one per line
      --force-samples
          Only warn about samples not in population file; exclude them from analysis (only supported for 'stat' command)
  -h, --help
          Print help
```


## clam_collect

### Tool Description
Collect depth from multiple files into a Zarr store

### Metadata
- **Docker Image**: quay.io/biocontainers/clam:1.1.3--h79ce301_0
- **Homepage**: https://github.com/cademirch/clam
- **Package**: https://anaconda.org/channels/bioconda/packages/clam/overview
- **Validation**: PASS

### Original Help Text
```text
Collect depth from multiple files into a Zarr store

Usage: clam collect [OPTIONS] --output <OUTPUT> [INPUT]...

Arguments:
  [INPUT]...  Input depth files (not needed when using --samples)

Options:
  -o, --output <OUTPUT>
          Output path for callable sites zarr array
      --chunk-size <CHUNK_SIZE>
          Chunk size for processing (base pairs) [default: 1000000]
      --min-gq <MIN_GQ>
          Minimum gq to count depth (GVCF input only)
  -t, --threads <THREADS>
          Number of threads to use for parallel processing [default: 1]
  -s, --samples <SAMPLES>
          Path to samples TSV file (with header). Columns: sample_name (required), file_path (required for collect; optional for loci with zarr input), population (optional). For loci/collect: input files are read from the TSV instead of positional arguments (unless input is a zarr store, in which case --samples provides population assignments only). For stat: provides population assignments (file_path column is not used)
  -p, --population-file <POPULATION_FILE>
          [DEPRECATED: use --samples] Path to file that defines populations. Tab separated: sample\tpopulation_name
  -x, --exclude <EXCLUDE>...
          Comma separated list of chromosomes to exclude
      --exclude-file <EXCLUDE_FILE>
          Path to file with chromosomes to exclude, one per line
  -i, --include <INCLUDE>...
          Comma separated list of chromosomes to include (restrict analysis to)
      --include-file <INCLUDE_FILE>
          Path to file with chromosomes to include, one per line
      --force-samples
          Only warn about samples not in population file; exclude them from analysis (only supported for 'stat' command)
  -h, --help
          Print help
```

