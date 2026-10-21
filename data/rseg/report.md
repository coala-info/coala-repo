# rseg CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| rseg | PASS | BED reads work; the -bam option stops with 'reads not sorted' on a coordinate-sorted BAM |
| rseg_deadzones | PASS |  |
| rseg_rseg-diff | PASS |  |

## rseg

### Tool Description
rseg [OPTIONS] <mapped-read-locations>

### Metadata
- **Docker Image**: quay.io/biocontainers/rseg:0.4.9--he941832_1
- **Homepage**: https://github.com/yzhang/rseg
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rseg/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-08-05
- **GitHub**: https://github.com/yzhang/rseg
- **Stars**: N/A
### Original Help Text
```text
Usage: rseg [OPTIONS] <mapped-read-locations>

Options:
  -o, -out               domain output file 
      -score             Posterior scores file 
      -readcount         readcounts file 
      -boundary          domain boundary file 
      -boundary-score    boundary transition scores file 
  -c, -chrom             file with chromosome sizes (BED format) 
  -d, -deadzones         file of deadzones (BED format) 
  -B, -bam               Input reads file is BAM format 
      -param-in          Input parameters file 
      -param-out         Output parameters file 
  -i, -maxitr            maximum iterations for training 
  -b, -bin-size          bin size (default: based on data) 
      -bin-step          minimum bin size (default: 50) 
      -duplicates        keep duplicate reads 
      -fragment_length   Extend reads to fragment length (default not to 
                         extend) 
      -Waterman          use Waterman's method for bin size 
      -Hideaki           use Hideaki's method for bin size 
      -Hideaki-emp       use Hideaki's empirical method (default) 
      -smooth            Indicate whether the rate curve is assumed smooth 
      -max-dead          max deadzone proportion for retained bins 
  -s, -domain-size       expected domain size (default: 20000) 
  -S, -desert            desert size (default: 20000) 
  -F, -fg                foreground emission distribution 
  -B, -bg                background emission distribution 
  -P, -posterior         use posterior decoding (default: Viterbi) 
      -posterior-cutoff  posterior cutoff significance 
      -undefined         min size of unmappable region 
      -cutoff            cutoff in cdf for identified domains 
  -v, -verbose           print more run information 

Help options:
  -?, -help              print this help message 
      -about             print about message
```

## rseg_rseg-diff

### Tool Description
Identify differential chromatin-state domains between two read sets.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseg:0.4.9--he941832_1
- **Homepage**: https://smithlabresearch.org/software/rseg/
- **Package**: https://anaconda.org/channels/bioconda/packages/rseg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rseg-diff [OPTIONS] <mapped-read-locations-A> <mapped-read-locations-B>

Options:
  -o, -out               domain output file 
      -score             Posterior scores file 
      -readcount         readcounts file 
      -boundary          domain boundary file 
      -boundary-score    boundary transition scores file 
  -c, -chrom             file with chromosome sizes (BED format) 
  -d, -deadzones         file of deadzones (BED format) 
  -B, -bam               Input reads file is BAM format 
      -param-in          Input parameters file 
      -param-out         Output parameters file 
  -m, -mode              running mode 2:test-control; 3: test-test 
  -i, -maxitr            maximum iterations for training 
  -b, -bin-size          bin size (default: based on data) 
      -bin-step          minimum bin size (default: 50) 
      -duplicates        keep duplicate reads 
      -fragment_length   Extend reads to fragment length (default not to 
                         extend) 
      -Waterman          use Waterman's method for bin size 
      -Hideaki           use Hideaki's method for bin size 
      -Hideaki-emp       use Hideaki's empirical method (default) 
      -smooth            Indicate whether the rate curve is assumed smooth 
      -max-dead          max deadzone proportion for retained bins 
  -s, -domain-size       expected domain size (default: 20000) 
  -S, -desert            desert size (default: 20000) 
  -F, -fg                foreground emission distribution 
  -B, -bg                background emission distribution 
      -training-size     Max number of data points for training (default: all) 
  -P, -posterior         use posterior decoding (default: Viterbi) 
      -posterior-cutoff  Posterior threshold for signigicant bins 
      -undefined         min size of unmappable region 
      -cutoff            cutoff in cdf for identified domains 
  -v, -verbose           print more run information 

Help options:
  -?, -help              print this help message 
      -about             print about message
```

## rseg_deadzones

### Tool Description
Find unmappable regions (deadzones) of a genome from FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/rseg:0.4.9--he941832_1
- **Homepage**: https://smithlabresearch.org/software/rseg/
- **Package**: https://anaconda.org/channels/bioconda/packages/rseg/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: deadzones [OPTIONS] <1-or-more-FASTA-chrom-files>

Options:
  -o, -output   Name of output file (default: stdout) 
  -k, -kmer     Width of k-mers 
  -p, -prefix   prefix length (default 5) 
  -s, -suffix   suffix of FASTA files (assumes -c indicates dir) 
  -v, -verbose  print more run information 

Help options:
  -?, -help     print this help message 
      -about    print about message
```

