# krocus CWL Generation Report

## krocus

### Tool Description
Multi-locus sequence typing (MLST) from uncorrected long reads. Please cite:
Andrew J. Page, Jacqueline A. Keane. (2018) Rapid multi-locus sequence typing
direct from uncorrected long reads using Krocus. PeerJ 6:e5233
https://doi.org/10.7717/peerj.5233

### Metadata
- **Docker Image**: quay.io/biocontainers/krocus:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/andrewjpage/krocus
- **Package**: https://anaconda.org/channels/bioconda/packages/krocus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/krocus/overview
- **Total Downloads**: 23.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/andrewjpage/krocus
- **Stars**: N/A
### Original Help Text
```text
usage: krocus [options] allele_directory input.fastq

Multi-locus sequence typing (MLST) from uncorrected long reads. Please cite:
Andrew J. Page, Jacqueline A. Keane. (2018) Rapid multi-locus sequence typing
direct from uncorrected long reads using Krocus. PeerJ 6:e5233
https://doi.org/10.7717/peerj.5233

positional arguments:
  allele_directory      Allele directory
  input_fastq           Input FASTQ file (optionally gzipped)

options:
  -h, --help            show this help message and exit
  --filtered_reads_file FILTERED_READS_FILE, -f FILTERED_READS_FILE
                        Filename to save matching reads to (default: None)
  --output_file OUTPUT_FILE, -o OUTPUT_FILE
                        Output file [STDOUT] (default: None)
  --max_gap MAX_GAP     Maximum gap for blocks to be contigous, measured in
                        multiples of the k-mer size (default: 4)
  --margin MARGIN       Flanking region around a block to use for mapping
                        (default: 50)
  --min_block_size MIN_BLOCK_SIZE
                        Minimum block size in bases (default: 150)
  --min_fasta_hits MIN_FASTA_HITS, -m MIN_FASTA_HITS
                        Minimum No. of kmers matching a read (default: 10)
  --min_kmers_for_onex_pass MIN_KMERS_FOR_ONEX_PASS
                        Minimum No. of kmers matching a read in 1st pass
                        (default: 10)
  --max_kmers MAX_KMERS, -r MAX_KMERS
                        Dont count kmers occuring more than this many times
                        (default: 10)
  --print_interval PRINT_INTERVAL, -p PRINT_INTERVAL
                        Print ST every this number of reads (default: 500)
  --kmer KMER, -k KMER  k-mer size (default: 11)
  --divisible_by_3, -d  Genes which are not divisible by 3 are excluded
                        (default: False)
  --target_st TARGET_ST
                        For performance testing print time to find given ST
                        (default: None)
  --verbose, -v         Turn on debugging [False]
  --version             show program's version number and exit
```

