# kmc CWL Generation Report

## kmc

### Tool Description
K-Mer Counter

### Metadata
- **Docker Image**: quay.io/biocontainers/kmc:3.2.4--h5ca1c30_4
- **Homepage**: https://github.com/refresh-bio/kmc
- **Package**: https://anaconda.org/channels/bioconda/packages/kmc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmc/overview
- **Total Downloads**: 119.8K
- **Last updated**: 2025-09-25
- **GitHub**: https://github.com/refresh-bio/kmc
- **Stars**: N/A
### Original Help Text
```text
K-Mer Counter (KMC) ver. 3.2.4 (2024-02-09)
Usage:
 kmc [options] <input_file_name> <output_file_name> <working_directory>
 kmc [options] <@input_file_names> <output_file_name> <working_directory>
Parameters:
  input_file_name - single file in specified (-f switch) format (gziped or not)
  @input_file_names - file name with list of input files in specified (-f switch) format (gziped or not)
Options:
  -v - verbose mode (shows all parameter settings); default: false
  -k<len> - k-mer length (k from 1 to 256; default: 25)
  -m<size> - max amount of RAM in GB (from 1 to 1024); default: 12
  -sm - use strict memory mode (memory limit from -m<n> switch will not be exceeded)
  -hc - count homopolymer compressed k-mers (approximate and experimental)
  -p<par> - signature length (5, 6, 7, 8, 9, 10, 11); default: 9
  -f<a/q/m/bam/kmc> - input in FASTA format (-fa), FASTQ format (-fq), multi FASTA (-fm) or BAM (-fbam) or KMC (-fkmc); default: FASTQ
  -ci<value> - exclude k-mers occurring less than <value> times (default: 2)
  -cs<value> - maximal value of a counter (default: 255)
  -cx<value> - exclude k-mers occurring more of than <value> times (default: 1e9)
  -b - turn off transformation of k-mers into canonical form
  -r - turn on RAM-only mode 
  -n<value> - number of bins 
  -t<value> - total number of threads (default: no. of CPU cores)
  -sf<value> - number of FASTQ reading threads
  -sp<value> - number of splitting threads
  -sr<value> - number of threads for 2nd stage
  -j<file_name> - file name with execution summary in JSON format
  -w - without output
  -o<kmc/kff> - output in KMC of KFF format; default: KMC
  -hp - hide percentage progress (default: false)
  -e - only estimate histogram of k-mers occurrences instead of exact k-mer counting
  --opt-out-size - optimize output database size (may increase running time)
Example:
kmc -k27 -m24 NA19238.fastq NA.res /data/kmc_tmp_dir/
kmc -k27 -m24 @files.lst NA.res /data/kmc_tmp_dir/
```

