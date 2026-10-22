# svdss CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| svdss_call | PASS | real COLO829 nanopore chr22 slice (nf-core) with hg38 chr22; DEL/INS calls match svim (SVDSS is designed for HiFi reads) |
| svdss_index | PASS | real COLO829 nanopore chr22 slice (nf-core) with hg38 chr22; DEL/INS calls match svim (SVDSS is designed for HiFi reads) |
| svdss_run_svdss | PASS | real COLO829 nanopore chr22 slice (nf-core) with hg38 chr22; genotyped DEL and INS written (SVDSS is designed for HiFi reads) |
| svdss_search | PASS | real COLO829 nanopore chr22 slice (nf-core) with hg38 chr22; DEL/INS calls match svim (SVDSS is designed for HiFi reads) |
| svdss_smooth | PASS | real COLO829 nanopore chr22 slice (nf-core) with hg38 chr22; DEL/INS calls match svim (SVDSS is designed for HiFi reads) |

## svdss_run_svdss

### Tool Description
Run SVDSS for structural variant detection.

### Metadata
- **Docker Image**: quay.io/biocontainers/svdss:2.1.0--h9013031_0
- **Homepage**: https://github.com/Parsoa/SVDSS
- **Package**: https://anaconda.org/channels/bioconda/packages/svdss/overview
- **Validation**: PASS

### Original Help Text
```text
ERROR: Wrong number of arguments.


Usage: run_svdss <reference.fa> <alignments.bam>

Arguments:
     -w                 output directory (default: .)
     -i                 use this FMD index/store it here (default: build FMD index and store to <reference.fa.fmd>)
     -q                 mapping quality (default: 20)
     -p                 accuracy percentile (default: 0.98)
     -s                 minimum support for calling (default: 2)
     -l                 minimum length for SV (default: 50)
     -t                 do not consider haplotagging information (default: consider it)
     -@                 number of threads (default: 4)
     -x                 path to SVDSS binary (default: SVDSS)
     -k                 path to kanpig binary (default: kanpig)
     -v                 print version
     -h                 print this help and exit

Positional arguments:
     <reference.fa>     reference file in FASTA format
     <alignments.bam>   alignments in BAM format
```


## svdss_index

### Tool Description
Build the FMD index of a reference genome (wrapper around ropebwt3 build)

### Metadata
- **Docker Image**: quay.io/biocontainers/svdss:2.1.0--h9013031_0
- **Homepage**: https://github.com/Parsoa/SVDSS
- **Package**: https://anaconda.org/channels/bioconda/packages/svdss/overview
- **Validation**: PASS

### Original Help Text
```text
[2026-10-22 16:32:38.564] [stderr] [info] We rely on 'ropebwt3 build' - just exposing it for convenience
Usage: ropebwt3 build [options] <in.fa> [...]
Options:
  Algorithm:
    -m NUM      batch size [7G]
    -t INT      total number of threads [4]
    -p INT      #threads for sais and run sais and merge together (more RAM) [0]
    -l INT      leaf block size in B+-tree [512]
    -n INT      max number children per internal node [64]
    -2          use the ropebwt2 algorithm (libsais by default)
    -s          build BWT in the reverse lexicographical order (RLO; force -2)
    -r          build BWT in RCLO (force -2)
  Input:
    -i FILE     read existing index from FILE []
    -L          one sequence per line in the input
    -F          no forward strand
    -R          no reverse strand
  Output:
    -o FILE     output to FILE [stdout]
    -d          dump in the fermi-delta format (FMD)
    -b          dump in the ropebwt format (FMR)
    -T          output the index in the Newick format (for debugging)
    -S FILE     save the current index to FILE after each input file []
[2026-10-22 16:32:38.564] [stderr] [info] All done! Runtime: 0 seconds
```

## svdss_smooth

### Tool Description
Smooth the reads of a BAM file against the reference

### Metadata
- **Docker Image**: quay.io/biocontainers/svdss:2.1.0--h9013031_0
- **Homepage**: https://github.com/Parsoa/SVDSS
- **Package**: https://anaconda.org/channels/bioconda/packages/svdss/overview
- **Validation**: PASS

### Original Help Text
```text
SVDSS smooth --reference <reference> --bam <bam>
      --min-mapq <INT>                 minimum mapping quality (default: 20)
      --accp <FLOAT>                   accuracy percentile for alignments filtering (default: 0.98)
      --threads <INT>                  number of threads to use (default: 4)
      --help                           print help message
```

## svdss_search

### Tool Description
Extract the sample-specific strings (SFS) from a BAM or FASTQ file

### Metadata
- **Docker Image**: quay.io/biocontainers/svdss:2.1.0--h9013031_0
- **Homepage**: https://github.com/Parsoa/SVDSS
- **Package**: https://anaconda.org/channels/bioconda/packages/svdss/overview
- **Validation**: PASS

### Original Help Text
```text
SVDSS search --index <index> [--bam <bam>|--fastq <fastq>]
      --bsize <INT>                    batch size (default: 10000)
      --noputative                     when input is smoothed bam, do not filter unsmoothed reads (default: putative)
      --noassemble                     do not assemble specific strings overlapping on a read (default: assemble)
      --threads <INT>                  number of threads to use (default: 4)
      --help                           print help message
```

## svdss_call

### Tool Description
Call SVs from the assembled superstrings

### Metadata
- **Docker Image**: quay.io/biocontainers/svdss:2.1.0--h9013031_0
- **Homepage**: https://github.com/Parsoa/SVDSS
- **Package**: https://anaconda.org/channels/bioconda/packages/svdss/overview
- **Validation**: PASS

### Original Help Text
```text
SVDSS call --reference <reference> --bam <bam> --sfs <sfs>
      --poa <FILE>                     store POA in .sam format to this file (default: do not store)
      --clusters <FILE>                store clusters to this file (default: do not store)
      --min-cluster-weight <INT>       minimum number of supporting superstrings for a call to be reported (default: 2)
      --min-sv-length <INT>            minimum length of reported SVs (default: 25)
      --noht                           do not use haplotagging information even if present
      --min-mapq                       minimum mapping quality (default: 20)
      --clipped                        calls SVs from clipped SFS (EXPERIMENTAL)
      --threads <INT>                  number of threads to use (default: 4)
      --help                           print help message
```

## Metadata
- **Skill**: generated
