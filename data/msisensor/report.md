# msisensor CWL Generation Report

## msisensor_scan

### Tool Description
Scan for homopolymers and microsatellites in a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor:0.5--hc755212_3
- **Homepage**: https://github.com/ding-lab/msisensor
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msisensor/overview
- **Total Downloads**: 27.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ding-lab/msisensor
- **Stars**: N/A
### Original Help Text
```text
Usage:  msisensor scan [options] 

       -d   <string>   reference genome sequences file, *.fasta format
       -o   <string>   output homopolymer and microsatelittes file

       -l   <int>      minimal homopolymer size, default=5
       -c   <int>      context length, default=5
       -m   <int>      maximal homopolymer size, default=50
       -s   <int>      maximal length of microsate, default=5
       -r   <int>      minimal repeat times of microsate, default=3
       -p   <int>      output homopolymer only, 0: no; 1: yes, default=0
       
       -h   help
```


## msisensor_msi

### Tool Description
Calculate MSI score and distribution

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor:0.5--hc755212_3
- **Homepage**: https://github.com/ding-lab/msisensor
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  msisensor msi [options] 

       -d   <string>   homopolymer and microsates file
       -n   <string>   normal bam file
       -t   <string>   tumor  bam file
       -o   <string>   output distribution file

       -e   <string>   bed file, optional
       -f   <double>   FDR threshold for somatic sites detection, default=0.05
       -i   <double>   minimal comentropy threshold for somatic sites detection (just for tumor only data), default=1
       -c   <int>      coverage threshold for msi analysis, WXS: 20; WGS: 15, default=20
       -r   <string>   choose one region, format: 1:10000000-20000000
       -l   <int>      minimal homopolymer size, default=5
       -p   <int>      minimal homopolymer size for distribution analysis, default=10
       -m   <int>      maximal homopolymer size for distribution analysis, default=50
       -q   <int>      minimal microsates size, default=3
       -s   <int>      minimal microsates size for distribution analysis, default=5
       -w   <int>      maximal microstaes size for distribution analysis, default=40
       -u   <int>      span size around window for extracting reads, default=500
       -b   <int>      threads number for parallel computing, default=1
       -x   <int>      output homopolymer only, 0: no; 1: yes, default=0
       -y   <int>      output microsatellite only, 0: no; 1: yes, default=0
       
       -h   help
```


## Metadata
- **Skill**: generated

## msisensor

### Tool Description
homopolymer and miscrosatelite analysis using bam files

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor:0.5--hc755212_3
- **Homepage**: https://github.com/ding-lab/msisensor
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor/overview
- **Validation**: PASS
### Original Help Text
```text
Program: msisensor (homopolymer and miscrosatelite analysis using bam files)
Version: v0.5
Author: Beifang Niu && Kai Ye

Usage:   msisensor <command> [options]

Key commands:

 scan            scan homopolymers and miscrosatelites
 msi             msi scoring
```

