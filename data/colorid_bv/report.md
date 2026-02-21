# colorid_bv CWL Generation Report

## colorid_bv_batch_id

### Tool Description
classifies batch of samples reads

### Metadata
- **Docker Image**: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
- **Homepage**: https://github.com/hcdenbakker/colorid_bv
- **Package**: https://anaconda.org/channels/bioconda/packages/colorid_bv/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/colorid_bv/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hcdenbakker/colorid_bv
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
colorid_bv-batch_id 0.2
Henk den Bakker. <henkcdenbakker@gmail.com>
classifies batch of samples reads

USAGE:
    colorid_bv batch_id [OPTIONS] --bigsi <bigsi> --query <query> --tag <tag>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -c, --batch <batch>
            Sets size of batch of reads to be processed in parallel (default 50,000)

    -b, --bigsi <bigsi>                          index to be used for search
    -B, --bitvector_sample <bitvector_sample>
            Collects matches for subset of kmers indicated (default=3), using this subset to more rapidly find hits for
            the remainder of the kmers
    -d, --down_sample <down_sample>
            down-sample k-mers used for read classification, default 1; increases speed at cost of decreased sensitivity 

    -p, --fp_correct <fp_correct>
            Parameter to correct for false positives, default 3 (= 0.001), maybe increased for larger searches. Adjust
            for larger datasets
    -Q, --quality <quality>
            kmers with nucleotides below this minimum phred score will be excluded from the analyses (default 15)

    -q, --query <query>
            tab-delimiteed file with samples to be classified [sample_name reads1 reads2 (optional)]

    -S, --supress_taxon <supress_taxon>          Taxon to be supressed, for modelling/training purposes
    -T, --tag <tag>                              tag to be include in output file names 
    -t, --threads <threads>
            number of threads to use, if not set the maximum available number threads will be used
```


## colorid_bv_build

### Tool Description
builds a bigsi

### Metadata
- **Docker Image**: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
- **Homepage**: https://github.com/hcdenbakker/colorid_bv
- **Package**: https://anaconda.org/channels/bioconda/packages/colorid_bv/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
colorid_bv-build 0.1
Henk C. den Bakker <henkcdenbakker@gmail.com>
builds a bigsi

USAGE:
    colorid_bv build [OPTIONS] --bigsi <bigsi> --kmer <k-mer_size> --bloom <length_bloom> --num_hashes <num_hashes> --refs <ref_file>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -c, --batch <batch>              Sets size of batch of accessions to be processed in parallel (default 300)
    -b, --bigsi <bigsi>              
    -f, --filter <filter>            minimum coverage kmer threshold (default automatically detected)
    -k, --kmer <k-mer_size>          Sets k-mer size
    -s, --bloom <length_bloom>       Sets the length of the bloom filter
    -m, --minimizer <minimizer>      build index with minimizers of set value
    -n, --num_hashes <num_hashes>    Sets number of hashes for bloom filter
    -Q, --quality <quality>          minimum phred score to keep basepairs within read (default 15)
    -r, --refs <ref_file>            Sets the input file to use
    -t, --threads <threads>          number of threads to use, if not set one thread will be used
```


## colorid_bv_info

### Tool Description
dumps index parameters and accessions

### Metadata
- **Docker Image**: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
- **Homepage**: https://github.com/hcdenbakker/colorid_bv
- **Package**: https://anaconda.org/channels/bioconda/packages/colorid_bv/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
colorid_bv-info 0.1
Henk den Bakker. <henkcdenbakker@gmail.com>
dumps index parameters and accessions

USAGE:
    colorid_bv info [OPTIONS] --bigsi <bigsi>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -b, --bigsi <bigsi>              index for which info is requested
    -c, --compressed <compressed>    If set to 'true', it is assumed a gz compressed index is used
```


## colorid_bv_merge

### Tool Description
merges (concatenates) indices

### Metadata
- **Docker Image**: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
- **Homepage**: https://github.com/hcdenbakker/colorid_bv
- **Package**: https://anaconda.org/channels/bioconda/packages/colorid_bv/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
colorid_bv-merge 0.1
Henk den Bakker. <henkcdenbakker@gmail.com>
merges (concatenates) indices

USAGE:
    colorid_bv merge --index_1 <index_1> --index_2 <index_2> --out_bigsi <out_bigsi>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -1, --index_1 <index_1>        index to which index 2 will be concatenated
    -2, --index_2 <index_2>        index to be concatenated to index 1
    -b, --out_bigsi <out_bigsi>    name output index
```


## colorid_bv_read_filter

### Tool Description
filters reads

### Metadata
- **Docker Image**: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
- **Homepage**: https://github.com/hcdenbakker/colorid_bv
- **Package**: https://anaconda.org/channels/bioconda/packages/colorid_bv/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
colorid_bv-read_filter 0.1
Henk den Bakker. <henkcdenbakker@gmail.com>
filters reads

USAGE:
    colorid_bv read_filter [FLAGS] --classification <classification> --files <files> --prefix <prefix> --taxon <taxon>

FLAGS:
    -e, --exclude    If set('-e or --exclude'), reads for which the classification contains the taxon name will be
                     excluded
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -c, --classification <classification>    tab delimited read classification file generated with the read_id
                                             subcommand
    -f, --files <files>                      query file(-s)fastq.gz
    -p, --prefix <prefix>                    prefix for output file(-s)
    -t, --taxon <taxon>                      taxon to be in- or excluded from the read file(-s)
```


## colorid_bv_read_id

### Tool Description
id's reads

### Metadata
- **Docker Image**: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
- **Homepage**: https://github.com/hcdenbakker/colorid_bv
- **Package**: https://anaconda.org/channels/bioconda/packages/colorid_bv/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
colorid_bv-read_id 0.2
Henk den Bakker. <henkcdenbakker@gmail.com>
id's reads

USAGE:
    colorid_bv read_id [FLAGS] [OPTIONS] --bigsi <bigsi> --prefix <prefix> --query <query>

FLAGS:
    -h, --help             Prints help information
    -H, --high_mem_load    When this flag is set, a faster, but less memory efficient method to load the index is used.
                           Loading the index requires approximately 2X the size of the index of RAM. 
    -V, --version          Prints version information

OPTIONS:
    -c, --batch <batch>
            Sets size of batch of reads to be processed in parallel (default 50,000)

    -b, --bigsi <bigsi>                          index to be used for search
    -B, --bitvector_sample <bitvector_sample>
            Collects matches for subset of kmers indicated (default=3), using this subset to more rapidly find hits for
            the remainder of the kmers
    -d, --down_sample <down_sample>
            down-sample k-mers used for read classification, default 1; increases speed at cost of decreased sensitivity 

    -p, --fp_correct <fp_correct>
            Parameter to correct for false positives, default 3 (= 0.001), maybe increased for larger searches. Adjust
            for larger datasets
    -n, --prefix <prefix>                        prefix for output file(-s)
    -Q, --quality <quality>
            kmers with nucleotides below this minimum phred score will be excluded from the analyses (default 15)

    -q, --query <query>                          query file(-s)fastq.gz
    -S, --supress_taxon <supress_taxon>          Taxon to be supressed, for modelling/training purposes
    -t, --threads <threads>
            number of threads to use, if not set the maximum available number threads will be used
```


## colorid_bv_search

### Tool Description
does a bigsi search on one or more fasta/fastq.gz files

### Metadata
- **Docker Image**: quay.io/biocontainers/colorid_bv:0.1.0--h3ab6199_2
- **Homepage**: https://github.com/hcdenbakker/colorid_bv
- **Package**: https://anaconda.org/channels/bioconda/packages/colorid_bv/overview
- **Validation**: PASS

### Original Help Text
```text
colorid_bv-search 0.1
Henk C. den Bakker <henkcdenbakker@gmail.com>
does a bigsi search on one or more fasta/fastq.gz files

USAGE:
    colorid_bv search [FLAGS] [OPTIONS] --bigsi <bigsi> --query <query>

FLAGS:
    -g, --gene_search       If set('-g'), the proportion of kmers from the query matching the entries in the index will
                            be reported
    -h, --help              Prints help information
    -m, --multi_fasta       If set('-m'), each accession in a multifasta will betreated as a separate query, currently
                            only with the -s option
    -s, --perfect_search    If ('-s') is set, the fast 'perfect match' algorithm will be used
    -V, --version           Prints version information
    -v, --verbose           If ('-v') the output will be verbose!

OPTIONS:
    -b, --bigsi <bigsi>              Sets the name of the index file for search
    -f, --filter <filter>            set minimum k-mer frequency 
    -Q, --quality <quality>          minimum phred score to keep basepairs within read (default 15)
    -q, --query <query>              query file(-s)fastq.gz
    -r, --reverse <reverse>          reverse file(-s)fastq.gz [default: none]
    -p, --p_shared <shared_kmers>    set minimum proportion of shared k-mers with a reference
```


## Metadata
- **Skill**: generated
