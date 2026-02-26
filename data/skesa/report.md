# skesa CWL Generation Report

## skesa

### Tool Description
SKESA (SK-EL-SA) is a de novo assembler for bacterial genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
- **Homepage**: https://ftp.ncbi.nlm.nih.gov/pub/agarwala/skesa
- **Package**: https://anaconda.org/channels/bioconda/packages/skesa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/skesa/overview
- **Total Downloads**: 47.9K
- **Last updated**: 2025-08-21
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
General options:
  -h [ --help ]                 Produce help message
  -v [ --version ]              Print version
  --cores arg (=0)              Number of cores to use (default all) [integer]
  --memory arg (=32)            Memory available (GB, only for sorted counter) 
                                [integer]
  --hash_count                  Use hash counter [flag]
  --estimated_kmers arg (=100)  Estimated number of distinct kmers for bloom 
                                filter (millions, only for hash counter) 
                                [integer]
  --skip_bloom_filter           Don't do bloom filter; use --estimated_kmers as
                                the hash table size (only for hash counter) 
                                [flag]

Input/output options : at least one input providing reads for assembly must be specified:
  --reads arg                   Input fasta/fastq file(s) for reads (could be 
                                used multiple times for different runs, could 
                                be gzipped) [string]
  --use_paired_ends             Indicates that single (not comma separated) 
                                fasta/fastq files contain paired reads [flag]
  --contigs_out arg             Output file for contigs (stdout if not 
                                specified) [string]

Assembly options:
  --kmer arg (=21)              Minimal kmer length for assembly [integer]
  --min_count arg               Minimal count for kmers retained for comparing 
                                alternate choices [integer]
  --max_kmer arg                Maximal kmer length for assembly [integer]
  --max_kmer_count arg          Minimum acceptable average count for estimating
                                the maximal kmer length in reads [integer]
  --vector_percent arg (=0.05)  Percentage of reads containing 19-mer for the 
                                19-mer to be considered a vector (1. disables) 
                                [float (0,1]]
  --insert_size arg             Expected insert size for paired reads (if not 
                                provided, it will be estimated) [integer]
  --steps arg (=11)             Number of assembly iterations from minimal to 
                                maximal kmer length in reads [integer]
  --fraction arg (=0.1)         Maximum noise to signal ratio acceptable for 
                                extension [float [0,1)]
  --max_snp_len arg (=150)      Maximal snp length [integer]
  --min_contig arg (=200)       Minimal contig length reported in output 
                                [integer]
  --allow_snps                  Allow additional step for snp discovery [flag]

Debugging options:
  --force_single_ends           Don't use paired-end information [flag]
  --seeds arg                   Input file with seeds [string]
  --all arg                     Output fasta for each iteration [string]
  --dbg_out arg                 Output kmer file [string]
  --hist arg                    File for histogram [string]
  --connected_reads arg         File for connected paired reads [string]
```


## Metadata
- **Skill**: generated
