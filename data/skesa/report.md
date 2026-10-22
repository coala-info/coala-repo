# skesa CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| skesa | PASS |  |
| skesa_gfa_connector | PASS |  |
| skesa_kmercounter | PASS |  |
| skesa_saute | PASS |  |

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


## skesa_kmercounter

### Tool Description
Count k-mers in reads and write a de Bruijn graph, a text k-mer list or a histogram

### Metadata
- **Docker Image**: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
- **Homepage**: https://github.com/ncbi/SKESA
- **Package**: https://anaconda.org/channels/bioconda/packages/skesa/overview
- **Validation**: PASS

### Original Help Text
```text
kmercounter --help 

Options:
  -h [ --help ]                Produce help message
  -v [ --version ]             Print version
  --reads arg                  Input fasta/fastq file(s) (could be used 
                               multiple times for different runs) [string]
  --kmer arg (=21)             Kmer length [integer]
  --min_count arg (=2)         Minimal count for kmers retained for comparing 
                               alternate choices [integer]
  --vector_percent arg (=0.05) Percentage of reads containing 19-mer for the 
                               19-mer to be considered a vector (1. disables) 
                               [float (0,1]]
  --no_strand_info             Create graph with disabled directional filtering
                               [flag]
  --estimated_kmers arg (=100) Estimated number of distinct kmers for bloom 
                               filter (millions) for hash count [integer]
  --skip_bloom_filter          Don't do bloom filter; use --estimated_kmers as 
                               the hash table size for hash count [flag]
  --dbg_out arg                de Bruijn graph output
  --text_out arg               Text kmer output
  --hist arg                   File for histogram [string]
  --cores arg (=0)             Number of cores to use (default all) [integer]
```

## skesa_saute

### Tool Description
Assemble reads along reference target sequences and write a GFA graph of variants

### Metadata
- **Docker Image**: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
- **Homepage**: https://github.com/ncbi/SKESA
- **Package**: https://anaconda.org/channels/bioconda/packages/skesa/overview
- **Validation**: PASS

### Original Help Text
```text
saute --help 


General options:
  -h [ --help ]                        Produce help message
  -v [ --version ]                     Print version
  --cores arg (=0)                     Number of cores to use (default all) 
                                       [integer]
  --estimated_kmers arg (=1000)        Estimated number of distinct kmers for 
                                       bloom filter (millions) [integer]

Input/output options : target file, at least one input for reads and output for gfa must be specified:
  --gfa arg                            Output file for GFA graph [string]
  --all_variants arg                   Output file for sequences with all 
                                       variant combinations [string]
  --max_variants arg (=1000)           Restricts the number of variants 
                                       outputted in --all_variants [integer]
  --selected_variants arg              Output file for selected sequences 
                                       representing all graph elements [string]
  --targets arg                        Input file with reference sequences 
                                       [string]
  --reads arg                          Input fasta/fastq file(s) for reads 
                                       (could be used multiple times for 
                                       different runs, could be gzipped) 
                                       [string]
  --use_paired_ends                    Indicates that single (not comma 
                                       separated) fasta/fastq files contain 
                                       paired reads [flag]

Assembly options:
  --extend_ends                        Unambiguously extend graph ends using 
                                       de-novo assembly [flag]
  --kmer arg                           Kmer length for assembly (default 
                                       automatic) [integer]
  --secondary_kmer arg                 Shorter kmer length for low coverage 
                                       spots (default automatic) [integer]
  --secondary_kmer_threshold arg (=1)  Coverage threshold for using shorter 
                                       kmer [integer]
  --min_count arg (=2)                 Minimal count for kmers retained in 
                                       graph [integer]
  --vector_percent arg (=0.05)         Percentage of reads containing 19-mer 
                                       for the 19-mer to be considered a vector
                                       (1. disables) [float (0,1]]
  --fraction arg (=0.05)               Maximum noise to signal ratio acceptable
                                       for extension [float [0,1)]
  --word arg (=8)                      Word size for seeds [integer <= 16]
  --protect_reference_ends             Near the reference ends, don't check if 
                                       reads support some minimal extension of 
                                       the fork's branches [flag]
  --keep_subgraphs                     Don't remove redundant subgraphs [flag]
  --match arg (=2)                     Bonus for match [integer]
  --mismatch arg (=3)                  Penalty for mismatch [integer]
  --gap_open arg (=5)                  Penalty for gap opening [integer]
  --gap_extend arg (=3)                Penalty for gap extension [integer]
  --drop_off arg (=300)                Maximal decrease of score before 
                                       abandoning assembly path [integer]
  --kmer_complexity arg (=2000)        Hard mask reference areas with hight 
                                       kmer complexity (0 disables masking) 
                                       [integer]
  --max_fork_density arg (=0.1)        Maximal fork density averaged over 
                                       --buf_length before abandoning 
                                       assembling (0 disables) [float]
  --buf_length arg (=200)              Buffer length for fork density [integer]

Graph cleaning options:
  --not_aligned_len arg (=10)          Not aligned read length for break count 
                                       [integer]
  --not_aligned_count arg (=3)         Number of not aligned reads to make a 
                                       break [integer]
  --aligned_count arg (=2)             Number of aligned reads to confirm a 
                                       connection [integer]
  --target_coverage arg (=0.5)         Result is kept if has alignment to the 
                                       reference which is at least 
                                       target_coverage*(reference length) long 
                                       [float (0,1]]
  --min_hit_len arg                    If a path is shorter than 
                                       target_coverage*(reference length), use 
                                       this length threshold for keeping paths 
                                       (optional) [integer]
  --max_path arg (=1000)               Maximal number of path extensions 
                                       allowed for a single filtering check 
                                       [integer]
  --no_filter_by_reads                 Don't use full length reads for variants
                                       filtering [flag]
  --no_filter_by_pairs                 Don't use mate pairs for variants 
                                       filtering [flag]
  --remove_homopolymer_indels          Remove homopolymer indels [flag]
  --homopolymer_len arg (=4)           Minimal length of homopolymer [integer]
  --homopolymer_ratio arg (=0.33)      Coverage ratio threshold for removing 
                                       homopolymer indels [float]
  --use_ambiguous_na                   Use ambiguous nucleotide codes for SNPs 
                                       [flag]
```

## skesa_gfa_connector

### Tool Description
Connect contigs into a GFA graph using reads

### Metadata
- **Docker Image**: quay.io/biocontainers/skesa:2.5.1--h077b44d_3
- **Homepage**: https://github.com/ncbi/SKESA
- **Package**: https://anaconda.org/channels/bioconda/packages/skesa/overview
- **Validation**: PASS

### Original Help Text
```text
gfa_connector --help 


General options:
  -h [ --help ]                        Produce help message
  -v [ --version ]                     Print version
  --cores arg (=0)                     Number of cores to use (default all) 
                                       [integer]
  --estimated_kmers arg (=100)         Estimated number of distinct kmers for 
                                       bloom filter (millions) [integer]
  --skip_bloom_filter                  Don't do bloom filter; use 
                                       --estimated_kmers as the hash table size
                                       [flag]

Input/output options:
  --reads arg                          Input fasta/fastq file(s) (could be used
                                       multiple times for different runs, could
                                       be gzipped) [string]
  --use_paired_ends                    Indicates that single (not comma 
                                       separated) fasta/fastq files contain 
                                       paired reads [flag]
  --contigs arg                        Input file with contigs [string]
  --gfa arg                            GFA graph output (stdout if not 
                                       specified) [string]
  --dbg arg                            Input de Bruijn graph (optional) 
                                       [string]
  --csv arg                            CSV file ouput (optional) [string]
  --contig_color arg (=Purple)         Color for contigs [string]
  --connector_color arg (=Lime Green)  Color for connectors [string]

Assembly options:
  --kmer arg                           Kmer length for assembly [integer]
  --min_count arg (=2)                 Minimal count for kmers retained for 
                                       comparing alternate choices [integer]
  --vector_percent arg (=0.05)         Percentage of reads containing 19-mer 
                                       for the 19-mer to be considered a vector
                                       (1. disables) [float (0,1]]
  --fraction arg (=0.1)                Threshold for extension
  --entropy arg (=0.51)                Minimal entropy for a seed kmer [float]
  --ext_len arg (=2000)                Maximal length for extension

Graph cleaning options:
  --not_aligned_len arg (=10)          Not aligned read length for break count
  --not_aligned_count arg (=3)         Number of not aligned reads to make a 
                                       break
  --aligned_count arg (=2)             Number of aligned reads to confirm a 
                                       connection
  --max_path arg (=1000)               Maximal number of paths allowed in 1 
                                       step of filtering
  --no_filter_by_reads                 Don't use full length reads for variants
                                       filtering [flag]
  --no_filter_by_pairs                 Don't use mate pairs for variants 
                                       filtering [flag]
```

## Metadata
- **Skill**: generated
