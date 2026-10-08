# metamaps CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| metamaps_classify | Failed | image problem: classify crashes with a Boost regex error ('uninitialized boost::match_results') while reading the NCBI taxonomy of the nf-core MetaMaps test database. |
| metamaps_index | PASS |  |
| metamaps_mapagainstindex | Failed | tool bug: mapAgainstIndex hangs with no CPU use (futex wait) right after loading a valid index, even with 30 reads and 1 thread, and writes an empty mapping file. |
| metamaps_mapdirectly | PASS |  |

## metamaps_mapdirectly

### Tool Description
Map long reads directly against a MetaMaps reference database FASTA (first step of simultaneous metagenomic classification and mapping).

### Metadata
- **Docker Image**: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
- **Homepage**: https://github.com/DiltheyLab/MetaMaps
- **Package**: https://anaconda.org/channels/bioconda/packages/metamaps/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/metamaps/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/DiltheyLab/MetaMaps
- **Stars**: N/A
### Original Help Text
```text
Available options
-----------------
-h, --help
    Print this help page

-r <value>, --reference <value>
    an input reference file (fasta/fastq)[.gz]

-k <value>, --kmer <value>
    kmer size <= 16 [default 16 (DNA)]

-p <value>, --pval <value>
    p-value cutoff, used to determine window/sketch sizes [default e-03]

--maxmemory <value>, --mm <value>
    maximum memory, in GB [default : not active]

-w <value>, --window <value>
    window size [default : computed using pvalue cutoff]
    P-value is not considered if a window value is provided. Lower window
    dow size implies denser sketch

-m <value>, --minReadLen <value>
    minimum read length to map [default : 1000]

--perc_identity <value>, --pi <value>
    threshold for identity [default : 80]

-t <value>, --threads <value>
    count of threads for parallel execution [default : 1]

-q <value>, --query <value>
    an input query file (fasta/fastq)[.gz]

--all
    report all the mapping locations for a read, default is to consider few
    best ones

-o <value>, --output <value>
    output file
```


## metamaps_classify

### Tool Description
Classify reads from a metamaps mapDirectly mapping file against a MetaMaps database (EM step).

### Metadata
- **Docker Image**: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
- **Homepage**: https://github.com/DiltheyLab/MetaMaps
- **Package**: https://anaconda.org/channels/bioconda/packages/metamaps/overview
- **Validation**: PASS

### Original Help Text
```text
Available options
-----------------
-h, --help
    Print this help page

--DB <value> [required]
    Path to DB

--mappings <value> [required]
    Path to mappings file

--minreads <value>
    Minimum number of reads per contig to be considered for fitting identity
    and length for the 'Unknown' functionality

-t <value>, --threads <value>
    count of threads for parallel execution [default : 1]
```


## metamaps_mapagainstindex

### Tool Description
Map long reads against an index built with metamaps index.

### Metadata
- **Docker Image**: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
- **Homepage**: https://github.com/DiltheyLab/MetaMaps
- **Package**: https://anaconda.org/channels/bioconda/packages/metamaps/overview
- **Validation**: PASS

### Original Help Text
```text
Available options
-----------------
-h, --help
    Print this help page

-i <value>, --index <value> [required]
    output prefix for

-q <value>, --query <value>
    an input query file (fasta/fastq)[.gz]

-o <value>, --output <value>
    output file

-t <value>, --threads <value>
    count of threads for parallel execution [default : 1]

--all
    report all the mapping locations for a read, default is to consider few
    best ones
```


## metamaps_index

### Tool Description
Build a MetaMaps index of a reference file, for use with metamaps mapAgainstIndex.

### Metadata
- **Docker Image**: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
- **Homepage**: https://github.com/DiltheyLab/MetaMaps
- **Package**: https://anaconda.org/channels/bioconda/packages/metamaps/overview
- **Validation**: PASS

### Original Help Text
```text
Available options
-----------------
-h, --help
    Print this help page

-r <value>, --reference <value>
    an input reference file (fasta/fastq)[.gz]

-k <value>, --kmer <value>
    kmer size <= 16 [default 16 (DNA)]

-p <value>, --pval <value>
    p-value cutoff, used to determine window/sketch sizes [default e-03]

--maxmemory <value>, --mm <value>
    maximum memory, in GB [default : not active]

-w <value>, --window <value>
    window size [default : computed using pvalue cutoff]
    P-value is not considered if a window value is provided. Lower window
    dow size implies denser sketch

-m <value>, --minReadLen <value>
    minimum read length to map [default : 1000]

--perc_identity <value>, --pi <value>
    threshold for identity [default : 80]

-t <value>, --threads <value>
    count of threads for parallel execution [default : 1]

-i <value>, --index <value> [required]
    output prefix for index
```


## Metadata
- **Skill**: generated
