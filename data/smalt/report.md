# smalt CWL Generation Report

## smalt_check

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: biocontainers/smalt:v0.7.6-8-deb_cv1
- **Homepage**: https://github.com/roquie/smalte
- **Package**: Not found
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/smalt/overview
- **Total Downloads**: 11.7K
- **Last updated**: 2025-09-18
- **GitHub**: https://github.com/roquie/smalte
- **Stars**: N/A
### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
# Command line:  smalt check --help
[0] smalt.c:1533 ERROR: failure
```


## smalt_index

### Tool Description
Index a reference genome for SMALT alignment.

### Metadata
- **Docker Image**: biocontainers/smalt:v0.7.6-8-deb_cv1
- **Homepage**: https://github.com/roquie/smalte
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
no input files specified.

SYNOPSIS:
  smalt index [-k <wordlen>] [-s <stepsiz>]  <index_name> <reference_file>


OPTIONS:
  -H       Print more extensive help on options.
  -k [INT] Length of the k-mer words indexed.
  -s [INT] Sample every <stepsiz>-th k-mer word (stride).
```


## smalt_map

### Tool Description
Map reads to an index

### Metadata
- **Docker Image**: biocontainers/smalt:v0.7.6-8-deb_cv1
- **Homepage**: https://github.com/roquie/smalte
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
no input files specified.

SYNOPSIS:
  smalt map [OPTIONS] <index_name> <query_file> [<mate_file>]

OPTIONS:
  -a       Add explicit alignments to output.
  -c [INT] Threshold of the number of bases covered by k-mer seeds.
  -d [INT] Threshold of the Smith-Waterman score relative to best.
  -f [STR] Output format [sam(default)|bam|cigar|gff|ssaha].
           Ext: [sam|bam]:nohead,x,clip.
  -F [STR] Input format [fastq (default)|sam|bam].
  -g [STR] Reads insert size distribution from file (see 'sample' task).
  -H       Print more extensive help on options.
  -i [INT] Maximum insert size for paired reads (default: 500).
  -j [INT] Minimum insert size for paired reads (default: 0).
  -l [STR] Type of paired read library [pe|mp|pp] (default: pe).
  -m [INT] Threshold of alignment score.
  -n [INT] Number of threads.
  -o [STR] Write aligments to specified file (default: stdout).
  -O       Preserve the order of the reads in the output (with '-n').
  -p       Report split alignments.
  -q [INT] Base quality threshold <= 10 (default 0).
  -r [INT] Random assignment of degen. mappings (mark 'unmapped' if < 0).
  -S [STR] Set alignment penalties,
           e.g 'match=1,mismatch=-2,gapopen=-4,gapext=-3' (default).
  -T [STR] Write temporary files do specified directory.
  -w       Use complexity weighted Smith-Waterman scores.
  -x       Exhaustive search for alignments (at the cost of speed).
  -y [FLT] Identity threshold (default: 0).
```


## smalt_sample

### Tool Description
Sample reads from query files based on an index.

### Metadata
- **Docker Image**: biocontainers/smalt:v0.7.6-8-deb_cv1
- **Homepage**: https://github.com/roquie/smalte
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
no input files specified.

SYNOPSIS:
  smalt sample [OPTIONS] <index_name> <query_file> [<mate_file>]

OPTIONS:
  -H       Print more extensive help on options.
  -F [STR] Input format [fastq (default)|sam|bam].
  -m [INT] Threshold of the alingment score.
  -n [INT] Run multi-threaded with this number of threads.
  -o [STR] Write output to specified file (default: stdout).
  -q [INT] Base quality threshold <= 10 (default 0).
  -T [STR] Write temporary files to specified directory.
  -u [INT] Map only every <nreads>-th read pair (default 100).
```


## Metadata
- **Skill**: generated
