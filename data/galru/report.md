# galru CWL Generation Report

## galru

### Tool Description
Spoligotyping from uncorrected long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/galru:1.0.0--py_0
- **Homepage**: https://github.com/quadram-institute-bioscience/galru
- **Package**: https://anaconda.org/channels/bioconda/packages/galru/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/galru/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/quadram-institute-bioscience/galru
- **Stars**: N/A
### Original Help Text
```text
usage: galru [options] uncorrected_long_reads.fastq

Spoligotyping from uncorrected long reads

positional arguments:
  input_file            Input FASTQ file of uncorrected long reads (optionally
                        gzipped)

optional arguments:
  -h, --help            show this help message and exit
  --db_dir DB_DIR, -d DB_DIR
                        Base directory for species databases, defaults to
                        bundled (default: None)
  --cas_fasta CAS_FASTA, -c CAS_FASTA
                        Cas gene FASTA file (optionally gzipped), defaults to
                        bundled (default: None)
  --technology {map-ont,map-pb,ava-pb,ava-ont}, -y {map-ont,map-pb,ava-pb,ava-ont}
                        Sequencing technology (default: map-ont)
  --threads THREADS, -t THREADS
                        No. of threads to use (default: 1)
  --output_file OUTPUT_FILE, -o OUTPUT_FILE
                        Output filename, defaults to STDOUT (default: None)
  --extended_results, -x
                        Output extended results (default: False)
  --gene_start_offset GENE_START_OFFSET, -g GENE_START_OFFSET
                        Only count CRISPR reads which cover this base
                        (default: 30)
  --min_mapping_quality MIN_MAPPING_QUALITY, -m MIN_MAPPING_QUALITY
                        Minimum mapping quality score (default: 10)
  --qcov_margin QCOV_MARGIN, -q QCOV_MARGIN
                        Maximum perc coverage difference between CRISPR and
                        read (default: 100)
  --min_bitscore MIN_BITSCORE, -b MIN_BITSCORE
                        Minimum blast bitscore (default: 38)
  --min_identity MIN_IDENTITY, -i MIN_IDENTITY
                        Minimum blast identity (default: 95)
  --species SPECIES, -s SPECIES
                        Species name, use galru_species to see all available
                        (default: Mycobacterium_tuberculosis)
  --debug               Turn on debugging and save intermediate files
                        (default: False)
  --verbose, -v         Turn on verbose output (default: False)
  --version             show program's version number and exit
```

