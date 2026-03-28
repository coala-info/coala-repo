# malva CWL Generation Report

## malva_MALVA

### Tool Description
MALVA is a tool for variant calling in sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/malva:2.0.0--h7071971_4
- **Homepage**: https://algolab.github.io/malva/
- **Package**: https://anaconda.org/channels/bioconda/packages/malva/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/malva/overview
- **Total Downloads**: 29.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
ERROR: Wrong number of arguments.


Usage: MALVA [-k KMER-SIZE] [-r REF-KMER-SIZE] [-c MAX-COV]  <reference> <variants> <sample>

Arguments:
     -h              print this help and exit
     -k              size of the kmers to index (default:35)
     -r              size of the reference kmers to index (default:43)
     -e              expected sample error rate (default:0.001)
     -s              file containing the list of (VCF) samples to consider (default:-, i.e. all samples)
     -f              a priori frequency key in the INFO column of the input VCF (default:AF)
     -c              maximum coverage for variant alleles (default:200)
     -b              bloom filter size in GB (default:4)
     -m              max amount of RAM in GB - KMC parameter (default:4)
     -p              strip \"chr\" from sequence names (dafault:false)
     -u              use uniform a priori probabilities (default:false)
     -v              output COVS and GTS in INFO column (default: false)
     -1              run MALVA in haploid mode (default: false)

Positional arguments:
     <reference>     reference file in FASTA format
     <variants>      variants file in VCF format
     <sample>        sample file in FASTA/FASTQ format
```


## malva_kmc

### Tool Description
K-Mer Counter (KMC)

### Metadata
- **Docker Image**: quay.io/biocontainers/malva:2.0.0--h7071971_4
- **Homepage**: https://algolab.github.io/malva/
- **Package**: https://anaconda.org/channels/bioconda/packages/malva/overview
- **Validation**: PASS

### Original Help Text
```text
K-Mer Counter (KMC) ver. 3.1.1 (2019-05-19)
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
  -p<par> - signature length (5, 6, 7, 8, 9, 10, 11); default: 9
  -f<a/q/m/bam> - input in FASTA format (-fa), FASTQ format (-fq), multi FASTA (-fm) or BAM (-fbam); default: FASTQ
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
Example:
kmc -k27 -m24 NA19238.fastq NA.res /data/kmc_tmp_dir/
kmc -k27 -m24 @files.lst NA.res /data/kmc_tmp_dir/
```


## malva_malva-geno

### Tool Description
Top notch description of this tool

### Metadata
- **Docker Image**: quay.io/biocontainers/malva:2.0.0--h7071971_4
- **Homepage**: https://algolab.github.io/malva/
- **Package**: https://anaconda.org/channels/bioconda/packages/malva/overview
- **Validation**: PASS

### Original Help Text
```text
malva missing arguments
Usage: malva-geno [-k KMER-SIZE] [-r REF-KMER-SIZE] [-c MAX-COV] <reference.fa> <variants.vcf> <kmc_output_prefix>

Top notch description of this tool

      -h, --help                        display this help and exit
      -k, --kmer-size                   size of the kmers to index (default:35)
      -r, --ref-kmer-size               size of the reference kmers to index (default:43)
      -e, --error-rate                  expected sample error rate (default:0.001)
      -s, --samples                     file containing the list of (VCF) samples to consider (default:-, i.e. all samples)
      -f, --freq-key                    a priori frequency key in the INFO column of the input VCF (default:AF)
      -c, --max-coverage                maximum coverage for variant alleles (default:200)
      -b, --bf-size                     bloom filter size in GB (default:4)
      -p, --strip-chr                   strip "chr" from sequence names (default:false)
      -u, --uniform                     use uniform a priori probabilities (default:false)
      -v, --verbose                     output COVS and GTS in INFO column (default: false)
      -1, --haploid                     run MALVA in haploid mode (default: false)
```


## Metadata
- **Skill**: generated
