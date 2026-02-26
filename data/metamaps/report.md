# metamaps CWL Generation Report

## metamaps_mapdirectly

### Tool Description
Simultaneous metagenomic classification and mapping.

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
MetaMaps v 0.1 

  Simultaneous metagenomic classification and mapping.

Usage:

  ./metamaps mapDirectly|classify|mapAgainstIndex|index

Parameters:

   ./metamaps COMMAND -h for help
```


## metamaps_classify

### Tool Description
Classify contigs based on sequence identity and length.

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
Simultaneous metagenomic classification and mapping.

### Metadata
- **Docker Image**: quay.io/biocontainers/metamaps:0.1.98102e9--h21ec9f0_2
- **Homepage**: https://github.com/DiltheyLab/MetaMaps
- **Package**: https://anaconda.org/channels/bioconda/packages/metamaps/overview
- **Validation**: PASS

### Original Help Text
```text
MetaMaps v 0.1 

  Simultaneous metagenomic classification and mapping.

Usage:

  ./metamaps mapDirectly|classify|mapAgainstIndex|index

Parameters:

   ./metamaps COMMAND -h for help
```


## metamaps_index

### Tool Description
Index a reference genome for mapping.

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

