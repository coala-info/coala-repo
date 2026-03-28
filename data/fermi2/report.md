# fermi2 CWL Generation Report

## fermi2_diff

### Tool Description
Compares two rld files.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fermi2/overview
- **Total Downloads**: 104.6K
- **Last updated**: 2025-09-09
- **GitHub**: https://github.com/lh3/fermi2
- **Stars**: N/A
### Original Help Text
```text
Usage: fermi2 diff [-k minK=25] [-K maxK=51] [-o minOcc=2] [-t nThreads=1] <query.rld> <ref.rld>
```


## fermi2_occflt

### Tool Description
Filter reads based on occurrence count.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fermi2 occflt [-k minK=25] [-K maxK=51] [-o minOcc=2] [-t nThreads=1] <query.rld>
```


## fermi2_sub

### Tool Description
Subsample reads from a RLD file.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
sub: invalid option -- '-'
sub: invalid option -- 'h'
sub: invalid option -- 'e'
sub: invalid option -- 'l'
sub: invalid option -- 'p'
Usage: fermi2 sub [-cs] [-t nThreads=1] <reads.rld> <bits.bin>
```


## fermi2_correct

### Tool Description
Correct sequencing errors in reads using an FMD index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
correct: option requires an argument -- 'h'

Usage:   fermi2 correct [options] index.fmd [reads.fq]

Options: -t INT     number of threads [1]
         -k INT     k-mer length [17]
         -o INT     min occurrence for a solid k-mer [3]
         -d INT     correct singletons out of INT bases [17]

         -h FILE    get solid k-mer list from FILE [null]
         -q INT     protect Q>INT bases unless they occur once [30]
         -w INT     no more than 4 corrections per INT-bp window [8]
         -D         drop error-prone reads
         -O         print the original read name

Notes: If reads.fq is absent, this command dumps the list of solid k-mers.
       The dump can be loaded later with option -h.
```


## fermi2_count

### Tool Description
Count k-mers in an FMD index

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi2 count [options] <in.fmd>

Options: -k INT      k-mer length [51]
         -o INT      min occurence [1]
         -t INT      number of threads [1]
         -b          only print bifurcating k-mers (force -2)
         -2          bidirectional counting
```


## fermi2_interleave

### Tool Description
Interleave two FASTQ files

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: fermi interleave <in1.fq> <in2.fq>
```


## fermi2_assemble

### Tool Description
Assemble reads into contigs

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi2 assemble [options] <reads.rld>

Options: -l INT      min match [31]
         -m INT      min merge length [0]
         -t INT      number of threads [1]
```


## fermi2_simplify

### Tool Description
Simplify a MAG graph

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi2 simplify [options] <in.mag>

Options: -N INT         read maximum INT neighbors per node [512]
         -O             read the graph without modifications
         -F             don't attempt to fix erroneous edges (force -O)
         -m INT         minimum overlap to merge [0]
         -d FLOAT       drop a neighbor if relative overlap ratio below FLOAT [0.60]

         -C             clean the graph
         -l INT         minimum tip length [300]
         -e INT         minimum tip read count [4]
         -i INT         minimum internal unitig read count [3]
         -o INT         minimum overlap [0]
         -R FLOAT       minimum relative overlap ratio [0.70]
         -A             aggressive bubble popping
         -S             skip bubble simplification
         -w FLOAT       minimum coverage to keep a bubble [10.00]
         -r FLOAT       minimum fraction to keep a bubble [0.15]

         -T INT1[,INT2] trim INT1-bp from an open end if DP below INT2 [0,6]
```


## fermi2_sa

### Tool Description
Builds a suffix array for an FMD-index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
sa: invalid option -- '-'
sa: invalid option -- 'h'
sa: invalid option -- 'e'
sa: invalid option -- 'l'
sa: invalid option -- 'p'
Usage: fermi2 sa [-t nThreads=1] [-s stepShift=6] <in.fmd>
```


## fermi2_match

### Tool Description
Finds SMEMs (Maximal Exact Matches) in a sequence file against an index.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage:   fermi2 match [options] <index.fmd> <seq.fa>

Options: -p        find SMEMs (req. both strands in one index)
         -d        discovery novel alleles (force -p)
         -k INT    k-mer length in the discovery mode (force -d) [61]
         -t INT    number of threads [1]
         -b INT    batch size [10000000]
         -s FILE   sampled suffix array [null]
         -m INT    show coordinate if the number of hits is no more than INT [10]
         -s INT    min occurrences [1]

Output format:

    SQ  seqName  seqLen
    EM  start  end  occurrence [positions]
    NS  start  leftLen  diffLen  rightLen  leftOcc  rightOcc  strand  seq  qual

  At an 'NS' line, the length of 'seq' always equals leftLen+diffLen+rightLen.
```


## Metadata
- **Skill**: not generated

## fermi2

### Tool Description
fermi2 is a tool for sequence assembly and analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/fermi2:r193--h577a1d6_10
- **Homepage**: https://github.com/lh3/fermi2
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Program: fermi2
Version: r178
Contact: http://hengli.uservoice.com/

Usage:   fermi2 <command> [arguments]

Command: diff        compare two FMD-indices
         occflt      pick up reads containing low-occurrence k-mers
         sub         subset FM-index
         unpack      unpack FM-index
         correct     error correction
         count       k-mer counting (inefficient for long k-mers)
         interleave  convert 2-file PE fastq to interleaved fastq
         assemble    assemble reads into a unitig graph
         simplify    simplify a unitig graph
         sa          generate sampled suffix array
         match       exact matches
```

