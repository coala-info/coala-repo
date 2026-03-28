# unikseq CWL Generation Report

## unikseq_unikseq.pl

### Tool Description
v2.0.0

### Metadata
- **Docker Image**: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/unikseq
- **Package**: https://anaconda.org/channels/bioconda/packages/unikseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unikseq/overview
- **Total Downloads**: 10.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bcgsc/unikseq
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/unikseq.pl v2.0.0
-----input files-----
 -r reference FASTA (required)
 -i ingroup FASTA (required)
 -o outgroup FASTA (required)
-----kmer uniqueness filters-----
 -k length (option, default: -k 25)
 -l [leniency] min. non-unique consecutive kmers allowed in outgroup (option, default: -l 0)
 -m max. [% entries] in outgroup tolerated to have a reference kmer (option, default: -m 0 % [original behaviour])
-----output filters-----
 -t print only first t bases in tsv output (option, default: -t [k])
 -c output conserved FASTA regions between reference and ingroup entries (option, -c 1==yes -c 0==no [default, original unikseq behaviour])
 -s min. reference FASTA region [size] (bp) to output (option, default: -s 100 bp)
 -p min. [-c 0:region average /-c 1: per position] proportion of ingroup entries (option, default: -p 0 %)
 -u min. [% unique] kmers in regions (option, default: -u 90 %)
```


## unikseq_writeBloom.pl

### Tool Description
Writes a bloom filter from sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
- **Homepage**: https://github.com/bcgsc/unikseq
- **Package**: https://anaconda.org/channels/bioconda/packages/unikseq/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/writeBloom.pl
-f  sequences to scaffold (Multi-FASTA format, required)
-k  k-mer value (default -k 25, optional)
```


## Metadata
- **Skill**: generated
