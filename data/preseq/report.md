# preseq CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| preseq_bound_pop | PASS | Estimated unseen species from the Shakespeare histogram in the preseq repo; table has median and confidence limits. |
| preseq_c_curve | PASS | Output matches the upstream test checksum (histogram input) and the Galaxy expected table (BAM input); wrong -o and -D flags fixed. |
| preseq_gc_extrap | Not completed | Runs on real BED data and is repeatable, but its checksum differs from the newer upstream test (-B flag needed); output could not be confirmed. |
| preseq_lc_extrap | PASS | Output matches the upstream test checksum (counts input) and the Galaxy expected table (BAM input). |
| preseq_pop_size | PASS | Estimated population size from the Shakespeare counts in the preseq repo; table has estimate and confidence limits. |
| preseq_to_mr | PASS | Converted the Galaxy test BAM to MR format; 219 KB of mapped-read lines with plausible coordinates. |

## Metadata
- **Skill**: generated

## preseq_c_curve

### Tool Description
The c_curve command in preseq computes the expected complexity curve (number of distinct reads vs. total number of reads) for a genomic sequencing library.

### Metadata
- **Docker Image**: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
- **Homepage**: https://github.com/smithlabcode/preseq
- **Package**: https://anaconda.org/channels/bioconda/packages/preseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: c_curve [OPTIONS] <input-file>

Options:
  -o, -output   yield output file (default: stdout)  
  -s, -step     step size in extrapolations [1000000.000000] 
  -v, -verbose  print more information  
  -P, -pe       input is paired end read file  
  -H, -hist     input is a text file containing the observed histogram  
  -V, -vals     input is a text file containing only the observed 
                counts  
  -B, -bam      input is in BAM format  
  -l, -seg_len  maximum segment length when merging paired end bam 
                reads [5000] 
  -r, -seed     seed for random number generator [408] 

Help options:
  -?, -help     print this help message  
      -about    print about message
```

## preseq_lc_extrap

### Tool Description
The lc_extrap command in preseq predicts the yield (number of distinct reads) for future sequencing of the same library.

### Metadata
- **Docker Image**: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
- **Homepage**: https://github.com/smithlabcode/preseq
- **Package**: https://anaconda.org/channels/bioconda/packages/preseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: lc_extrap [OPTIONS] <input-file>

Options:
  -o, -output   yield output file (default: stdout)  
  -e, -extrap   maximum extrapolation [10000000000.000000] 
  -s, -step     extrapolation step size [1000000.000000] 
  -n, -boots    number of bootstraps [100] 
  -c, -cval     level for confidence intervals [0.950000] 
  -x, -terms    maximum terms in estimator [100] 
  -v, -verbose  print more info  
  -B, -bam      input is in BAM format  
  -l, -seg_len  maximum segment length when merging paired end bam 
                reads [5000] 
  -P, -pe       input is paired end read file  
  -V, -vals     input is a text file containing only the observed 
                counts  
  -H, -hist     input is a text file containing the observed histogram  
  -Q, -quick    quick mode (no bootstraps) for confidence intervals  
  -D, -defects  no testing for defects  
  -r, -seed     seed for random number generator [408] 

Help options:
  -?, -help     print this help message  
      -about    print about message
```

## preseq_gc_extrap

### Tool Description
The gc_extrap command in preseq predicts the genome coverage of future sequencing of a low-input library.

### Metadata
- **Docker Image**: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
- **Homepage**: https://github.com/smithlabcode/preseq
- **Package**: https://anaconda.org/channels/bioconda/packages/preseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: gc_extrap [OPTIONS] <input-file>

Options:
  -o, -output      coverage yield output file (default: stdout)  
  -w, -max_width   max fragment length, set equal to read length for 
                   single end reads [10000] 
  -b, -bin_size    bin size [10] 
  -e, -extrap      maximum extrapolation in base pairs 
                   [1000000000000.000000] 
  -s, -step        step size in bases between extrapolations 
                   [100000000.000000] 
  -n, -bootstraps  number of bootstraps [100] 
  -c, -cval        level for confidence intervals [0.950000] 
  -x, -terms       maximum number of terms [100] 
  -v, -verbose     print more information  
  -B, -bed         input is in bed format without sequence information  
  -Q, -quick       quick mode: run gc_extrap without bootstrapping for 
                   confidence intervals  
  -D, -defects     defects mode to extrapolate without testing for 
                   defects  
  -r, -seed        seed for random number generator [408] 

Help options:
  -?, -help        print this help message  
      -about       print about message
```

## preseq_bound_pop

### Tool Description
The bound_pop command in preseq estimates a lower bound on the population size of a library.

### Metadata
- **Docker Image**: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
- **Homepage**: https://github.com/smithlabcode/preseq
- **Package**: https://anaconda.org/channels/bioconda/packages/preseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: bound_pop [OPTIONS] <input-file>

Options:
  -o, -output          species richness output file (default: stdout)  
  -p, -max_num_points  maximum number of points in quadrature estimates 
                       [10] 
  -t, -tolerance       numerical tolerance [0.000000] 
  -n, -bootstraps      number of bootstraps [500] 
  -c, -clevel          level for confidence intervals [0.950000] 
  -v, -verbose         print more information  
  -P, -pe              input is paired end read file  
  -H, -hist            input is a text file containing the observed 
                       histogram  
  -V, -vals            input is a text file containing only the 
                       observed duplicate counts  
  -B, -bam             input is in BAM format  
  -l, -seg_len         maximum segment length when merging paired end 
                       bam reads [5000] 
  -Q, -quick           quick mode, estimate without bootstrapping  
  -r, -seed            seed for random number generator [408] 

Help options:
  -?, -help            print this help message  
      -about           print about message
```

## preseq_pop_size

### Tool Description
The pop_size command in preseq estimates the number of unique species of a library.

### Metadata
- **Docker Image**: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
- **Homepage**: https://github.com/smithlabcode/preseq
- **Package**: https://anaconda.org/channels/bioconda/packages/preseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pop_size [OPTIONS] <input-file>

Options:
  -o, -output   yield output file (default: stdout)  
  -e, -extrap   maximum extrapolation [0.0] 
  -s, -steps    number of steps [50] 
  -n, -boots    number of bootstraps [100] 
  -c, -cval     level for confidence intervals [0.950000] 
  -x, -terms    maximum terms in estimator [100] 
  -v, -verbose  print more info  
  -B, -bam      input is in BAM format  
  -l, -seg_len  maximum segment length when merging paired end bam 
                reads [5000] 
  -P, -pe       input is paired end read file  
  -V, -vals     input is a text file containing only the observed 
                counts  
  -H, -hist     input is a text file containing the observed histogram  
  -Q, -quick    quick mode (no bootstraps) for confidence intervals  
  -D, -defects  no testing for defects  
  -r, -seed     seed for random number generator [408] 

Help options:
  -?, -help     print this help message  
      -about    print about message
```

## preseq_to_mr

### Tool Description
to-mr converts SAM/BAM output to the MethPipe mapped read (MR) format used by preseq.

### Metadata
- **Docker Image**: quay.io/biocontainers/preseq:3.2.0--hdcf5f25_6
- **Homepage**: https://github.com/smithlabcode/preseq
- **Package**: https://anaconda.org/channels/bioconda/packages/preseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: to-mr [OPTIONS] sam/bam_file

Options:
  -o, -output    Name of output file 
  -s, -suff      read name suffix length (default: 1) 
  -L, -max-frag  maximum allowed insert size 
  -v, -verbose   print more information 

Help options:
  -?, -help      print this help message 
      -about     print about message 

PROGRAM: to-mr
Convert the SAM/BAM output from to MethPipe mapped read format
```
