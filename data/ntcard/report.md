# ntcard CWL Generation Report

## ntcard

### Tool Description
Estimates k-mer coverage histogram in FILE(S).

### Metadata
- **Docker Image**: quay.io/biocontainers/ntcard:1.2.2--pl5321h077b44d_7
- **Homepage**: https://github.com/bcgsc/ntCard
- **Package**: https://anaconda.org/channels/bioconda/packages/ntcard/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ntcard/overview
- **Total Downloads**: 24.6K
- **Last updated**: 2025-07-31
- **GitHub**: https://github.com/bcgsc/ntCard
- **Stars**: N/A
### Original Help Text
```text
Usage: ntCard [OPTION]... FILE(S)...
Estimates k-mer coverage histogram in FILE(S).

Acceptable file formats: fastq, fasta, sam, bam and in compressed formats gz, bz, zip, xz.
A list of files containing file names in each row can be passed with @ prefix.

 Options:

  -t, --threads=N	use N parallel threads [1] (N>=2 should be used when input files are >=2)
  -k, --kmer=N	the length of kmer 
  -g, --gap=N	the length of gap in the gap seed [0]. g mod 2 must equal k mod 2 unless g == 0
           	-g does not support multiple k currently.
  -c, --cov=N	the maximum coverage of kmer in output [1000]
  -p, --pref=STRING    the prefix for output file name(s)
  -o, --output=STRING	the name for output file name (used when output should be a single file)
      --help	display this help and exit
      --version	output version information and exit

Report bugs to https://github.com/bcgsc/ntCard/issues
```

