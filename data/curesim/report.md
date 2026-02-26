# curesim CWL Generation Report

## curesim

### Tool Description
CuReSim version 1.3

### Metadata
- **Docker Image**: quay.io/biocontainers/curesim:1.3--0
- **Homepage**: https://github.com/BenKearns/CureSim
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/curesim/overview
- **Total Downloads**: 7.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/BenKearns/CureSim
- **Stars**: N/A
### Original Help Text
```text
ERROR: you have to give an input file in fasta or fastq format

CuReSim version 1.3
Usage: java -jar simulator.jar [options] -f <input_file> [options]
-f file_name 	 [mandatory] genome fasta file or reads fastq file
-o file_name 	 [facultative] name of output fastq file [output.fastq]
-n int 	 [facultative] number of reads to generate [50000]
-m int 	 [facultative] read mean size [200]
-sd double 	 [facultative] standard deviation for read size [20.0]
-r int 	 [facultative] number of random reads [0]
-d double 	 [facultative] deletion rate [0.01]
-i double 	 [facultative] insertion rate [0.005]
-s double 	 [facultative] substitution rate [0.005]
-ui 	 [facultative] uniform distribution for indels [homopolymers]
-us 	 [facultative] uniform distribution for substitutions [exponential]
-q char 	 [facultative] quality encoding character ['5']
-N int 	 [facultative] maximum number of Ns allowed per read [0]
-v 	 [facultative] verbose mode, you need R software in this mode [false]
-skip 	 [facultative] skip the correction step [false]
-h 	 print this help
```


## Metadata
- **Skill**: generated
