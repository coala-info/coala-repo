# clippy CWL Generation Report

## clippy

### Tool Description
Call CLIP peaks.

### Metadata
- **Docker Image**: quay.io/biocontainers/clippy:1.5.0--pyh3cd468f_1
- **Homepage**: https://github.com/ulelab/clippy
- **Package**: https://anaconda.org/channels/bioconda/packages/clippy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clippy/overview
- **Total Downloads**: 12.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ulelab/clippy
- **Stars**: N/A
### Original Help Text
```text
usage: clippy [-h] [-v] -i INPUT_BED -o OUTPUT_PREFIX -a ANNOTATION -g
              GENOME_FILE [-n [WINDOW_SIZE]] [-w [WIDTH]]
              [-x [MIN_PROM_ADJUST]] [-mx [MIN_HEIGHT_ADJUST]]
              [-mg [MIN_GENE_COUNTS]] [-mb [MIN_PEAK_COUNTS]]
              [-alt [ALT_FEATURES]] [-up [UPSTREAM_EXTENSION]]
              [-down [DOWNSTREAM_EXTENSION]] [-nei]
              [-inter [INTERGENIC_PEAK_THRESHOLD]] [-t [THREADS]]
              [-cf [CHUNKSIZE_FACTOR]] [-int]

Call CLIP peaks.

required arguments:
  -i INPUT_BED, --input_bed INPUT_BED
                        bed file containing cDNA counts at each crosslink
                        position
  -o OUTPUT_PREFIX, --output_prefix OUTPUT_PREFIX
                        prefix for output files
  -a ANNOTATION, --annotation ANNOTATION
                        gtf annotation file
  -g GENOME_FILE, --genome_file GENOME_FILE
                        genome file containing chromosome lengths. Also known
                        as a FASTA index file, which usually ends in .fai.
                        This file is used by BEDTools for genomic operations

optional peak size arguments:
  Control the size of the peaks called

  -n [WINDOW_SIZE], --window_size [WINDOW_SIZE]
                        rolling mean window size [DEFAULT 10]
  -w [WIDTH], --width [WIDTH]
                        proportion of prominence to calculate peak widths at.
                        Smaller values will give narrow peaks and large values
                        will give wider peaks [DEFAULT 0.4]

optional peak filtering arguments:
  Control how peaks are filtered

  -x [MIN_PROM_ADJUST], --min_prom_adjust [MIN_PROM_ADJUST]
                        adjustment for minimum prominence threshold,
                        calculated as this value multiplied by the mean
                        [DEFAULT 1.0]
  -mx [MIN_HEIGHT_ADJUST], --min_height_adjust [MIN_HEIGHT_ADJUST]
                        adjustment for the minimum height threshold,
                        calculated as this value multiplied by the mean
                        [DEFAULT 1.0]
  -mg [MIN_GENE_COUNTS], --min_gene_counts [MIN_GENE_COUNTS]
                        minimum cDNA counts per gene to look for peaks
                        [DEFAULT 5]
  -mb [MIN_PEAK_COUNTS], --min_peak_counts [MIN_PEAK_COUNTS]
                        minimum cDNA counts per broad peak [DEFAULT 5]

optional annotation arguments:
  Control how the gene annotation is interpreted and used

  -alt [ALT_FEATURES], --alt_features [ALT_FEATURES]
                        A list of alternative GTF features to set individual
                        thresholds on in the comma-separated format
                        <alt_feature_name>-<gtf_key>-<search_pattern>
  -up [UPSTREAM_EXTENSION], --upstream_extension [UPSTREAM_EXTENSION]
                        upstream extension added to gene models [DEFAULT 0]
  -down [DOWNSTREAM_EXTENSION], --downstream_extension [DOWNSTREAM_EXTENSION]
                        downstream extension added to gene models [DEFAULT 0]
  -nei, --no_exon_info  Turn off individual exon and intron thresholds
  -inter [INTERGENIC_PEAK_THRESHOLD], --intergenic_peak_threshold [INTERGENIC_PEAK_THRESHOLD]
                        Intergenic peaks are called by first creating
                        intergenic regions and calling peaks on the regions as
                        though they were genes. The regions are made by
                        expanding intergenic crosslinks and merging the
                        result. This parameter is the threshold number of
                        summed cDNA counts required to include a region. If
                        set to zero, the default, no intergenic peaks will be
                        called. When using this mode, the intergenic regions
                        used will be output as a GTF file. [DEFAULT 0]

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -t [THREADS], --threads [THREADS]
                        number of threads to use. [DEFAULT 1]
  -cf [CHUNKSIZE_FACTOR], --chunksize_factor [CHUNKSIZE_FACTOR]
                        A factor used to control the number of jobs given to a
                        thread at a time. A larger number reduces the number
                        of jobs per chunk. Only increase if you experience
                        crashes [DEFAULT 16]
  -int, --interactive   starts a Dash server to allow for interactive
                        parameter tuning
```


## Metadata
- **Skill**: generated
