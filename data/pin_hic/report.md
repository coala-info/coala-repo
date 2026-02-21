# pin_hic CWL Generation Report

## pin_hic_link

### Tool Description
Collect Hi-C links from BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
- **Homepage**: https://github.com/dfguan/pin_hic/
- **Package**: https://anaconda.org/channels/bioconda/packages/pin_hic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pin_hic/overview
- **Total Downloads**: 4.4K
- **Last updated**: 2025-08-28
- **GitHub**: https://github.com/dfguan/pin_hic
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::main_hic_lnks] require at least one bam file!

Usage: pin_hic link [options] <BAM_FILE>
Options:
         -a    BOOL     collect all contacts [FALSE]
         -g    BOOL     use middle [FALSE]
         -q    INT      minimum alignment quality [10]
         -s    STR      sat file
         -d    BOOL     use minimum dist to normalize weight [FALSE]
         -o    STR      output file [stdout]
         -h             help
```


## pin_hic_build

### Tool Description
Build scaffolding graph using Hi-C links matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
- **Homepage**: https://github.com/dfguan/pin_hic/
- **Package**: https://anaconda.org/channels/bioconda/packages/pin_hic/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::main_bldg] require number of contig and links file!

Usage: /usr/local/bin/pin_hic build [<options>] <LINKS_MATRIX> 
Options:
         -1    BOOL     use MST to construct scaffolding graph [FALSE, only for pin_hic]
         -a    BOOL     Hi-C scaffolding in accurate mode [FALSE]
         -w    INT      minimum weight for links [10]
         -k    INT      maximum linking candiates [1]
         -c    FILE     reference index file [nul]
         -n    BOOL     normalize weight [false]
         -p    BOOL     use product of length [False]
         -g    BOOL     ignore middle part of contigs [false]
         -e    BOOL     use normalized weight as edge weight [TRUE]
         -f    FLOAT    minimum weight difference [0.95]
         -s    FILE     sat file [nul]
         -o    FILE     output file [stdout]
         -h             help
```


## pin_hic_gets

### Tool Description
Extract sequences from a SAT file

### Metadata
- **Docker Image**: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
- **Homepage**: https://github.com/dfguan/pin_hic/
- **Package**: https://anaconda.org/channels/bioconda/packages/pin_hic/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::main_get_seq] Require a SAT file
Usage: pin_hic gets [<options>] <SAT> ...
Options:
         -c    STR      fasta file
         -o    STR      output file [stdout]
         -l    STR      minimum output scaffolds length [0]
         -h             help
```


## pin_hic_break

### Tool Description
Identify breaks in a SAT file using Hi-C BAM files

### Metadata
- **Docker Image**: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
- **Homepage**: https://github.com/dfguan/pin_hic/
- **Package**: https://anaconda.org/channels/bioconda/packages/pin_hic/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::main_brks] require a SAT and bam files!

Usage: pin_hic [<options>] <SAT> <BAMs> ...
Options:
         -m    FLOAT    minimum coverage ratio between maximu coverage and the gap coverage [.3]
         -q    INT      minimum mapping quality [10]
         -O    STR      output directory [.]
         -p    STR      output file prefix [scaffs.bk]
         -h             help
```


## Metadata
- **Skill**: generated

## pin_hic_pin_hic_it

### Tool Description
A tool for Hi-C based scaffolding of genomic contigs.

### Metadata
- **Docker Image**: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
- **Homepage**: https://github.com/dfguan/pin_hic/
- **Package**: https://anaconda.org/channels/bioconda/packages/pin_hic/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
[E::main] require at least one bam file!

Usage: pin_hic_it [options] <BAM_FILEs> ...
Options:
         -1    BOOL     use MST for scaffolding [FALSE]
         -i    INT      iteration times [3]
         -a    BOOL     accurate mode [FALSE]
         -g    BOOL     use middle part of contigs [FALSE]
         -p    BOOL     use product [FALSE]
         -O    STR      output directory [.]
         -q    INT      minimum mapping quality [10]
         -w    INT      minimum contact number [100]
         -m    FLOAT    minimum coverage ratio between maximu coverage and the gap coverage [.3]
         -n    BOOL     use unnormalized weight [FALSE]
         -d    FLOAT     minimum difference between best and secondary orientation [0.95]
         -b    BOOL     do not break at the final step [FALSE]
         -c    INT      candidate number [3]
         -e    BOOL     use unnormalized weight as edge weight [FALSE]
         -s    STR      sat file [nul]
         -x    STR      reference fa index file [nul]
         -r    STR      reference file [nul]
         -l    INT      minimum scaffold length [0]
         -v             print version
         -h             help
```

