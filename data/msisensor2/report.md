# msisensor2 CWL Generation Report

## msisensor2_scan

### Tool Description
Scan for homopolymers and microsatellites in a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor2:0.1--hd03093a_0
- **Homepage**: https://github.com/niu-lab/msisensor2
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/msisensor2/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-10-06
- **GitHub**: https://github.com/niu-lab/msisensor2
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


## msisensor2_msi

### Tool Description
Calculate MSI score from BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/msisensor2:0.1--hd03093a_0
- **Homepage**: https://github.com/niu-lab/msisensor2
- **Package**: https://anaconda.org/channels/bioconda/packages/msisensor2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:  msisensor2 msi [options] 

       -d   <string>   homopolymer and microsates file
       -n   <string>   normal bam file
       -t   <string>   tumor  bam file
       -M   <string>   models directory for tumor only data
       -o   <string>   output distribution file

       -e   <string>   bed file, optional
       -f   <double>   FDR threshold for somatic sites detection, default=0.05
       -c   <int>      coverage threshold for msi analysis, WXS: 20; WGS: 15, default=20
       -z   <int>      coverage normalization for paired tumor and normal data, 0: no; 1: yes, default=0
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

