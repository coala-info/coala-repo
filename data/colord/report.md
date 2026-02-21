# colord CWL Generation Report

## colord_compress-ont

### Tool Description
compress ONT data

### Metadata
- **Docker Image**: quay.io/biocontainers/colord:1.1.0--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/colord
- **Package**: https://anaconda.org/channels/bioconda/packages/colord/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/colord/overview
- **Total Downloads**: 6.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/refresh-bio/colord
- **Stars**: N/A
### Original Help Text
```text
compress ONT data
Usage: /usr/local/bin/colord compress-ont [OPTIONS] input output

Positionals:
  input TEXT:FILE REQUIRED    input FASTQ/FASTA path (gzipped or not)
  output TEXT REQUIRED        archive path

Options:
  -h,--help                   Print this help message and exit
  -k,--kmer-len UINT:INT in [15 - 28]
                              k-mer length (default: auto adjust)
  -t,--threads UINT=32        number of threads
  -p,--priority TEXT:{balanced,memory,ratio}
                              compression quality
  -q,--qual TEXT:{2-avg,2-fix,4-avg,4-fix,5-avg,5-fix,avg,none,org}=4-avg
                              quality compression mode 
                               * org - original, 
                               * none - discard (Q1 for all bases), 
                               * avg - average over entire file, 
                               * 2-fix, 4-fix, 5-fix - 2/4/5 bins with fixed representatives, 
                               * 2-avg, 4-avg, 5-avg - 2/4/5 bins with averages as representatives.
  -T,--qual-thresholds UINT ...
                              quality thresholds, 
                               * single value for '2-fix' mode (default is 7), 
                               * single value for '2-avg' mode (default is 7), 
                               * three values for '4-fix' mode (default is 7 14 26), 
                               * three values for '4-avg' mode (default is 7 14 26), 
                               * four values for '5-fix' mode (default is 7 14 26 93), 
                               * four values for '5-avg' mode (default is 7 14 26 93), 
                               * not allowed for 'avg', 'org' and 'none' modes
  -D,--qual-values UINT ...   
                              quality values for decompression,
                               * single value for 'none' mode (default is 0), 
                               * two values for '2-fix' mode (default is 1 13), 
                               * four values for '4-fix' mode (default is 3 10 18 35), 
                               * five values for '5-fix' mode (default is 3 10 18 35 93), 
                               * not allowed for 'avg', 'org', '2-avg', '4-avg' and '5-avg' modes
  -G,--reference-genome TEXT:FILE
                              optional reference genome path (multi-FASTA gzipped or not), enables reference-based mode which provides better compression ratios
  -s,--store-reference        stores the reference genome in the archive, use only with `-G` flag
  -v,--verbose                verbose
  -a,--anchor-len UINT        anchor len (default: auto adjust)
  -L,--Lowest-count UINT=3    minimal k-mer count
  -H,--Highest-count UINT=100 maximal k-mer count
  -f,--filter-modulo UINT=9   k-mers for which hash(k-mer) mod f != 0 will be filtered out before graph building
  -c,--max-candidates UINT:POSITIVE=8
                              maximal number of reference reads considered as reference
  -e,--edit-script-mult FLOAT:POSITIVE=1
                              multipier for predicted cost of storing read part as edit script
  -r,--max-recurence-level UINT:NONNEGATIVE=5
                              maximal level of recurence when considering alternative reference reads
  --min-to-alt UINT:POSITIVE=48
                              minimum length of encoding part to consider using alternative read
  --min-mmer-frac FLOAT:NONNEGATIVE=0.5
                              if A is set of m-mers in encode read R then read is refused from encoding if |A| < min-mmer-frac * len(R)
  --min-mmer-force-enc FLOAT:NONNEGATIVE=0.9
                              if A is set of m-mers in encode read R then read is accepted to encoding always if |A| > min-mmer-force-enc * len(R)
  --max-matches-mult FLOAT:NONNEGATIVE=10
                              if the number of matches between encode read R and reference read is r, then read is refused from encoding if r > max-matches-mult * len(R)
  --fill-factor-filtered-kmers FLOAT:FLOAT in [0.1 - 0.99]=0.75
                              fill factor of filtered k-mers hash table
  --fill-factor-kmers-to-reads FLOAT:FLOAT in [0.1 - 0.99]=0.8
                              fill factor of k-mers to reads hash table
  --min-anchors UINT=1        if number of anchors common to encode read and reference candidate is lower than minAnchors candidate is refused
  -i,--identifier TEXT:{main,none,org}=org
                              header compression mode
  -R,--Ref-reads-mode TEXT:{all,sparse}=sparse
                              reference reads mode
  -g,--sparse-range FLOAT=2   sparse mode range. The propability of reference read acceptance is 1/pow(id/range_reads, exponent), where range_reads is determined based on the number of symbols, which in turn is determined by the number of trusted unique k-mers (estimated genome length) multiplied by the value of this parameter
  -x,--sparse-exponent FLOAT=1
                              sparse mode exponent
```


## colord_compress-pbraw

### Tool Description
compress PacBio Raw data

### Metadata
- **Docker Image**: quay.io/biocontainers/colord:1.1.0--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/colord
- **Package**: https://anaconda.org/channels/bioconda/packages/colord/overview
- **Validation**: PASS

### Original Help Text
```text
compress PacBio Raw data
Usage: /usr/local/bin/colord compress-pbraw [OPTIONS] input output

Positionals:
  input TEXT:FILE REQUIRED    input FASTQ/FASTA path (gzipped or not)
  output TEXT REQUIRED        archive path

Options:
  -h,--help                   Print this help message and exit
  -k,--kmer-len UINT:INT in [15 - 28]
                              k-mer length (default: auto adjust)
  -t,--threads UINT=32        number of threads
  -p,--priority TEXT:{balanced,memory,ratio}
                              compression quality
  -q,--qual TEXT:{2-avg,2-fix,4-avg,4-fix,5-avg,5-fix,avg,none,org}=none
                              quality compression mode 
                               * org - original, 
                               * none - discard (Q1 for all bases), 
                               * avg - average over entire file, 
                               * 2-fix, 4-fix, 5-fix - 2/4/5 bins with fixed representatives, 
                               * 2-avg, 4-avg, 5-avg - 2/4/5 bins with averages as representatives.
  -T,--qual-thresholds UINT ...
                              quality thresholds, 
                               * single value for '2-fix' mode (default is 7), 
                               * single value for '2-avg' mode (default is 7), 
                               * three values for '4-fix' mode (default is 7 14 26), 
                               * three values for '4-avg' mode (default is 7 14 26), 
                               * four values for '5-fix' mode (default is 7 14 26 93), 
                               * four values for '5-avg' mode (default is 7 14 26 93), 
                               * not allowed for 'avg', 'org' and 'none' modes
  -D,--qual-values UINT ...   
                              quality values for decompression,
                               * single value for 'none' mode (default is 0), 
                               * two values for '2-fix' mode (default is 1 13), 
                               * four values for '4-fix' mode (default is 3 10 18 35), 
                               * five values for '5-fix' mode (default is 3 10 18 35 93), 
                               * not allowed for 'avg', 'org', '2-avg', '4-avg' and '5-avg' modes
  -G,--reference-genome TEXT:FILE
                              optional reference genome path (multi-FASTA gzipped or not), enables reference-based mode which provides better compression ratios
  -s,--store-reference        stores the reference genome in the archive, use only with `-G` flag
  -v,--verbose                verbose
  -a,--anchor-len UINT        anchor len (default: auto adjust)
  -L,--Lowest-count UINT=3    minimal k-mer count
  -H,--Highest-count UINT=100 maximal k-mer count
  -f,--filter-modulo UINT=9   k-mers for which hash(k-mer) mod f != 0 will be filtered out before graph building
  -c,--max-candidates UINT:POSITIVE=8
                              maximal number of reference reads considered as reference
  -e,--edit-script-mult FLOAT:POSITIVE=1
                              multipier for predicted cost of storing read part as edit script
  -r,--max-recurence-level UINT:NONNEGATIVE=5
                              maximal level of recurence when considering alternative reference reads
  --min-to-alt UINT:POSITIVE=48
                              minimum length of encoding part to consider using alternative read
  --min-mmer-frac FLOAT:NONNEGATIVE=0.5
                              if A is set of m-mers in encode read R then read is refused from encoding if |A| < min-mmer-frac * len(R)
  --min-mmer-force-enc FLOAT:NONNEGATIVE=0.9
                              if A is set of m-mers in encode read R then read is accepted to encoding always if |A| > min-mmer-force-enc * len(R)
  --max-matches-mult FLOAT:NONNEGATIVE=10
                              if the number of matches between encode read R and reference read is r, then read is refused from encoding if r > max-matches-mult * len(R)
  --fill-factor-filtered-kmers FLOAT:FLOAT in [0.1 - 0.99]=0.75
                              fill factor of filtered k-mers hash table
  --fill-factor-kmers-to-reads FLOAT:FLOAT in [0.1 - 0.99]=0.8
                              fill factor of k-mers to reads hash table
  --min-anchors UINT=1        if number of anchors common to encode read and reference candidate is lower than minAnchors candidate is refused
  -i,--identifier TEXT:{main,none,org}=org
                              header compression mode
  -R,--Ref-reads-mode TEXT:{all,sparse}=sparse
                              reference reads mode
  -g,--sparse-range FLOAT=2   sparse mode range. The propability of reference read acceptance is 1/pow(id/range_reads, exponent), where range_reads is determined based on the number of symbols, which in turn is determined by the number of trusted unique k-mers (estimated genome length) multiplied by the value of this parameter
  -x,--sparse-exponent FLOAT=1
                              sparse mode exponent
```


## colord_compress-pbhifi

### Tool Description
compress PacBio HiFi data

### Metadata
- **Docker Image**: quay.io/biocontainers/colord:1.1.0--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/colord
- **Package**: https://anaconda.org/channels/bioconda/packages/colord/overview
- **Validation**: PASS

### Original Help Text
```text
compress PacBio HiFi data
Usage: /usr/local/bin/colord compress-pbhifi [OPTIONS] input output

Positionals:
  input TEXT:FILE REQUIRED    input FASTQ/FASTA path (gzipped or not)
  output TEXT REQUIRED        archive path

Options:
  -h,--help                   Print this help message and exit
  -k,--kmer-len UINT:INT in [15 - 28]
                              k-mer length (default: auto adjust)
  -t,--threads UINT=32        number of threads
  -p,--priority TEXT:{balanced,memory,ratio}
                              compression quality
  -q,--qual TEXT:{2-avg,2-fix,4-avg,4-fix,5-avg,5-fix,avg,none,org}=5-avg
                              quality compression mode 
                               * org - original, 
                               * none - discard (Q1 for all bases), 
                               * avg - average over entire file, 
                               * 2-fix, 4-fix, 5-fix - 2/4/5 bins with fixed representatives, 
                               * 2-avg, 4-avg, 5-avg - 2/4/5 bins with averages as representatives.
  -T,--qual-thresholds UINT ...
                              quality thresholds, 
                               * single value for '2-fix' mode (default is 7), 
                               * single value for '2-avg' mode (default is 7), 
                               * three values for '4-fix' mode (default is 7 14 26), 
                               * three values for '4-avg' mode (default is 7 14 26), 
                               * four values for '5-fix' mode (default is 7 14 26 93), 
                               * four values for '5-avg' mode (default is 7 14 26 93), 
                               * not allowed for 'avg', 'org' and 'none' modes
  -D,--qual-values UINT ...   
                              quality values for decompression,
                               * single value for 'none' mode (default is 0), 
                               * two values for '2-fix' mode (default is 1 13), 
                               * four values for '4-fix' mode (default is 3 10 18 35), 
                               * five values for '5-fix' mode (default is 3 10 18 35 93), 
                               * not allowed for 'avg', 'org', '2-avg', '4-avg' and '5-avg' modes
  -G,--reference-genome TEXT:FILE
                              optional reference genome path (multi-FASTA gzipped or not), enables reference-based mode which provides better compression ratios
  -s,--store-reference        stores the reference genome in the archive, use only with `-G` flag
  -v,--verbose                verbose
  -a,--anchor-len UINT        anchor len (default: auto adjust)
  -L,--Lowest-count UINT=3    minimal k-mer count
  -H,--Highest-count UINT=120 maximal k-mer count
  -f,--filter-modulo UINT=30  k-mers for which hash(k-mer) mod f != 0 will be filtered out before graph building
  -c,--max-candidates UINT:POSITIVE=10
                              maximal number of reference reads considered as reference
  -e,--edit-script-mult FLOAT:POSITIVE=1
                              multipier for predicted cost of storing read part as edit script
  -r,--max-recurence-level UINT:NONNEGATIVE=5
                              maximal level of recurence when considering alternative reference reads
  --min-to-alt UINT:POSITIVE=48
                              minimum length of encoding part to consider using alternative read
  --min-mmer-frac FLOAT:NONNEGATIVE=0.5
                              if A is set of m-mers in encode read R then read is refused from encoding if |A| < min-mmer-frac * len(R)
  --min-mmer-force-enc FLOAT:NONNEGATIVE=0.9
                              if A is set of m-mers in encode read R then read is accepted to encoding always if |A| > min-mmer-force-enc * len(R)
  --max-matches-mult FLOAT:NONNEGATIVE=10
                              if the number of matches between encode read R and reference read is r, then read is refused from encoding if r > max-matches-mult * len(R)
  --fill-factor-filtered-kmers FLOAT:FLOAT in [0.1 - 0.99]=0.75
                              fill factor of filtered k-mers hash table
  --fill-factor-kmers-to-reads FLOAT:FLOAT in [0.1 - 0.99]=0.8
                              fill factor of k-mers to reads hash table
  --min-anchors UINT=1        if number of anchors common to encode read and reference candidate is lower than minAnchors candidate is refused
  -i,--identifier TEXT:{main,none,org}=org
                              header compression mode
  -R,--Ref-reads-mode TEXT:{all,sparse}=sparse
                              reference reads mode
  -g,--sparse-range FLOAT=6   sparse mode range. The propability of reference read acceptance is 1/pow(id/range_reads, exponent), where range_reads is determined based on the number of symbols, which in turn is determined by the number of trusted unique k-mers (estimated genome length) multiplied by the value of this parameter
  -x,--sparse-exponent FLOAT=1
                              sparse mode exponent
```


## colord_decompress

### Tool Description
decompression mode

### Metadata
- **Docker Image**: quay.io/biocontainers/colord:1.1.0--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/colord
- **Package**: https://anaconda.org/channels/bioconda/packages/colord/overview
- **Validation**: PASS

### Original Help Text
```text
decompression mode
Usage: /usr/local/bin/colord decompress [OPTIONS] input output

Positionals:
  input TEXT:FILE REQUIRED    archive path
  output TEXT REQUIRED        output file path

Options:
  -h,--help                   Print this help message and exit
  -G,--reference-genome TEXT:FILE
                              optional reference genome path (multi-FASTA gzipped or not), required for reference-based archives with no reference genome embedded (`-G` compression without `-s` switch)
  -v,--verbose                verbose
```


## colord_info

### Tool Description
print archive informations

### Metadata
- **Docker Image**: quay.io/biocontainers/colord:1.1.0--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/colord
- **Package**: https://anaconda.org/channels/bioconda/packages/colord/overview
- **Validation**: PASS

### Original Help Text
```text
print archive informations
Usage: /usr/local/bin/colord info [OPTIONS] input

Positionals:
  input TEXT:FILE REQUIRED    archive path

Options:
  -h,--help                   Print this help message and exit
```


## Metadata
- **Skill**: generated
