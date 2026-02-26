# tiptoft CWL Generation Report

## tiptoft

### Tool Description
Plasmid replicon and incompatibility group prediction from uncorrected long reads

### Metadata
- **Docker Image**: quay.io/biocontainers/tiptoft:1.0.2--py310h4b81fae_4
- **Homepage**: https://github.com/andrewjpage/tiptoft
- **Package**: https://anaconda.org/channels/bioconda/packages/tiptoft/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tiptoft/overview
- **Total Downloads**: 18.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/andrewjpage/tiptoft
- **Stars**: N/A
### Original Help Text
```text
usage: tiptoft [options] input.fastq

Plasmid replicon and incompatibility group prediction from uncorrected long
reads

positional arguments:
  input_fastq           Input FASTQ file (optionally gzipped)

options:
  -h, --help            show this help message and exit

Optional input arguments:
  --plasmid_data PLASMID_DATA, -d PLASMID_DATA
                        FASTA file containing plasmid data from downloader
                        script, defaults to bundled database (default: None)
  --kmer KMER, -k KMER  k-mer size (default: 13)

Optional output arguments:
  --filtered_reads_file FILTERED_READS_FILE, -f FILTERED_READS_FILE
                        Filename to save matching reads to (default: None)
  --output_file OUTPUT_FILE, -o OUTPUT_FILE
                        Output file [STDOUT] (default: None)
  --print_interval PRINT_INTERVAL, -p PRINT_INTERVAL
                        Print results every this number of reads (default:
                        None)
  --verbose, -v         Turn on debugging [False]
  --version             show program's version number and exit

Optional advanced input arguments:
  --no_hc_compression   Turn off homoploymer compression of k-mers (default:
                        False)
  --no_gene_filter      Dont filter out lower coverage genes from same group
                        (default: False)
  --max_gap MAX_GAP     Maximum gap for blocks to be contigous, measured in
                        multiples of the k-mer size (default: 3)
  --max_kmer_count MAX_KMER_COUNT
                        Exclude k-mers which occur more than this number of
                        times in a sequence (default: 10)
  --margin MARGIN       Flanking region around a block to use for mapping
                        (default: 10)
  --min_block_size MIN_BLOCK_SIZE
                        Minimum block size in bases (default: 50)
  --min_fasta_hits MIN_FASTA_HITS, -m MIN_FASTA_HITS
                        Minimum No. of kmers matching a read (default: 8)
  --min_perc_coverage MIN_PERC_COVERAGE, -c MIN_PERC_COVERAGE
                        Minimum percentage coverage of typing sequence to
                        report (default: 85)
  --min_kmers_for_onex_pass MIN_KMERS_FOR_ONEX_PASS
                        Minimum No. of kmers matching a read in 1st pass
                        (default: 5)
```

