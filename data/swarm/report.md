# swarm CWL Generation Report

## swarm

### Tool Description
Swarm 3.1.6

### Metadata
- **Docker Image**: quay.io/biocontainers/swarm:3.1.6--h9948957_0
- **Homepage**: https://github.com/torognes/swarm
- **Package**: https://anaconda.org/channels/bioconda/packages/swarm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/swarm/overview
- **Total Downloads**: 62.8K
- **Last updated**: 2025-11-11
- **GitHub**: https://github.com/torognes/swarm
- **Stars**: N/A
### Original Help Text
```text
Swarm 3.1.6
Copyright (C) 2012-2025 Torbjorn Rognes and Frederic Mahe
https://github.com/torognes/swarm

Mahe F, Rognes T, Quince C, de Vargas C, Dunthorn M (2014)
Swarm: robust and fast clustering method for amplicon-based studies
PeerJ 2:e593 https://doi.org/10.7717/peerj.593

Mahe F, Rognes T, Quince C, de Vargas C, Dunthorn M (2015)
Swarm v2: highly-scalable and high-resolution amplicon clustering
PeerJ 3:e1420 https://doi.org/10.7717/peerj.1420

Mahe F, Czech L, Stamatakis A, Quince C, de Vargas C, Dunthorn M, Rognes T (2022)
Swarm v3: towards tera-scale amplicon clustering
Bioinformatics 38:1, 267-269 https://doi.org/10.1093/bioinformatics/btab493

Usage: swarm [OPTIONS] [FASTAFILE]

General options:
 -h, --help                          display this help and exit
 -t, --threads INTEGER               number of threads to use (1)
 -v, --version                       display version information and exit

Clustering options:
 -d, --differences INTEGER           resolution (1)
 -n, --no-otu-breaking               never break clusters (not recommended!)

Fastidious options (only when d = 1):
 -b, --boundary INTEGER              min mass of large clusters (3)
 -c, --ceiling INTEGER               max memory in MB for Bloom filter (unlim.)
 -f, --fastidious                    link nearby low-abundance swarms
 -y, --bloom-bits INTEGER            bits used per Bloom filter entry (16)

Input/output options:
 -a, --append-abundance INTEGER      value to use when abundance is missing
 -i, --internal-structure FILENAME   write internal cluster structure to file
 -j, --network-file FILENAME         dump sequence network to file
 -l, --log FILENAME                  log to file, not to stderr
 -o, --output-file FILENAME          output result to file (stdout)
 -r, --mothur                        output using mothur-like format
 -s, --statistics-file FILENAME      dump cluster statistics to file
 -u, --uclust-file FILENAME          output using UCLUST-like format to file
 -w, --seeds FILENAME                write cluster representatives to FASTA file
 -z, --usearch-abundance             abundance annotation in usearch style

Pairwise alignment advanced options (only when d > 1):
 -m, --match-reward INTEGER          reward for nucleotide match (5)
 -p, --mismatch-penalty INTEGER      penalty for nucleotide mismatch (4)
 -g, --gap-opening-penalty INTEGER   gap open penalty (12)
 -e, --gap-extension-penalty INTEGER gap extension penalty (4)
 -x, --disable-sse3                  disable SSE3 and later x86 instructions

See 'man swarm' for more details.
```

