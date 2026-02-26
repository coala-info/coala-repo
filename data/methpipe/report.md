# methpipe CWL Generation Report

## methpipe_format_reads

### Tool Description
convert SAM/BAM mapped bs-seq reads to standard methpipe format

### Metadata
- **Docker Image**: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
- **Homepage**: https://github.com/smithlabcode/methpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/methpipe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/methpipe/overview
- **Total Downloads**: 3.9K
- **Last updated**: 2025-08-11
- **GitHub**: https://github.com/smithlabcode/methpipe
- **Stars**: N/A
### Original Help Text
```text
Usage: format_reads [OPTIONS] <sam/bam-file>

Options:
  -f, -format    input format (abismal, bsmap, bismark)  
  -o, -output    output file name  
  -s, -suff      read name suffix length (default: 1) [1] 
  -L, -max-frag  maximum allowed insert size [10000] 
  -B, -buf-size  maximum buffer size [10000] 
  -v, -verbose   print more information  

Help options:
  -?, -help      print this help message  
      -about     print about message  

PROGRAM: format_reads
convert SAM/BAM mapped bs-seq reads to standard methpipe format
```


## methpipe_methcounts

### Tool Description
get methylation levels from mapped WGBS reads

### Metadata
- **Docker Image**: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
- **Homepage**: https://github.com/smithlabcode/methpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/methpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: methcounts [OPTIONS] -c <chroms> <mapped-reads>

Options:
  -o, -output    Name of output file (default: stdout) 
  -c, -chrom     file or dir of chroms (FASTA format; .fa suffix) 
                 [required] 
  -s, -suffix    suffix of FASTA files (assumes -c specifies dir) 
  -n, -cpg-only  print only CpG context cytosines 
  -v, -verbose   print more run info 

Help options:
  -?, -help      print this help message 
      -about     print about message 

PROGRAM: methcounts
get methylation levels from mapped WGBS reads
```


## methpipe_hmr

### Tool Description
Identify HMRs in methylomes. Methylation must be provided in the methcounts format (chrom, position, strand, context, methylation, reads). This program assumes only data at CpG sites and that strands are collapsed so only the positive site appears in the file.

### Metadata
- **Docker Image**: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
- **Homepage**: https://github.com/smithlabcode/methpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/methpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hmr [OPTIONS] <methylation-file>

Options:
  -o, -out         output file (default: stdout)  
  -d, -desert      max dist btwn covered cpgs in HMR [1000] 
  -i, -itr         max iterations [10] 
  -v, -verbose     print more run info  
      -partial     identify PMRs instead of HMRs  
      -post-hypo   output file for single-CpG posterior hypomethylation 
                   probability (default: none)  
      -post-meth   output file for single-CpG posteiror methylation 
                   probability (default: none)  
  -P, -params-in   HMM parameter file (override training)  
  -p, -params-out  write HMM parameters to this file (default: none)  
  -s, -seed        specify random seed [408] 

Help options:
  -?, -help        print this help message  
      -about       print about message  

PROGRAM: hmr
Identify HMRs in methylomes. Methylation must be provided in the
methcounts format (chrom, position, strand, context, methylation,
reads). See the methcounts documentation for details. This program
assumes only data at CpG sites and that strands are collapsed so only
the positive site appears in the file.
```


## methpipe_pmd

### Tool Description
Identify PMDs in methylomes. Methylation must be provided in the methcounts file format (chrom, position, strand, context, methylation, reads). This program assumes only data at CpG sites and that strands are collapsed so only the positive site appears in the file, but reads counts are from both strands.

### Metadata
- **Docker Image**: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
- **Homepage**: https://github.com/smithlabcode/methpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/methpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pmd [OPTIONS] <methcount-files>

Options:
  -o, -out             output file (default: stdout) 
  -d, -desert          max dist between bins with data in PMD 
  -f, -fixedbin        Fixed bin size 
  -b, -bin             Starting bin size 
  -a, -arraymode       All samples are array 
  -i, -itr             max iterations 
  -v, -verbose         print more run info 
  -D, -debug           print more run info 
  -P, -params-in       HMM parameter files for individual methylomes 
                       (separated with comma) 
  -r, -posteriors-out  write out posterior probabilities in methcounts 
                       format 
  -p, -params-out      write HMM parameters to this file 
  -s, -seed            specify random seed 

Help options:
  -?, -help            print this help message 
      -about           print about message 

PROGRAM: pmd
Identify PMDs in methylomes. Methylation must be provided in the
methcounts file format (chrom, position, strand, context, methylation,
reads). See the methcounts documentation for details. This program
assumes only data at CpG sites and that strands are collapsed so only
the positive site appears in the file, but reads counts are from both
strands.
```


## methpipe_hypermr

### Tool Description
A program for segmenting DNA methylation data

### Metadata
- **Docker Image**: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
- **Homepage**: https://github.com/smithlabcode/methpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/methpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: hypermr [OPTIONS]

Options:
  -o, -out         output file (BED format)  
  -s, -scores      output file for posterior scores  
  -t, -tolerance   Tolerance [0.000000] 
  -d, -desert      desert size [1000] 
  -i, -itr         max iterations [10] 
  -V, -viterbi     Use Viterbi decoding  
  -M, -min-meth    min cumulative methylation level in HypeMR 
                   [4.000000] 
  -v, -verbose     print more run info  
  -P, -params-in   HMM parameters file  
  -p, -params-out  HMM parameters file  

Help options:
  -?, -help        print this help message  
      -about       print about message  

PROGRAM: hypermr
A program for segmenting DNA methylation data<cpg-BED-file>
```


## methpipe_radmeth

### Tool Description
calculate differential methylation scores

### Metadata
- **Docker Image**: quay.io/biocontainers/methpipe:5.0.1--h76b9af2_6
- **Homepage**: https://github.com/smithlabcode/methpipe
- **Package**: https://anaconda.org/channels/bioconda/packages/methpipe/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: radmeth [OPTIONS] <design-matrix> <data-matrix>

Options:
  -o, -out      output file (default: stdout)  
  -v, -verbose  print more run info  
  -f, -factor   a factor to test [required] 

Help options:
  -?, -help     print this help message  
      -about    print about message  

PROGRAM: radmeth
calculate differential methylation scores
```

