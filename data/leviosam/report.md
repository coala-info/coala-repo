# leviosam CWL Generation Report

## leviosam_lift

### Tool Description
lifting over alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
- **Homepage**: https://github.com/alshai/levioSAM
- **Package**: https://anaconda.org/channels/bioconda/packages/leviosam/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/leviosam/overview
- **Total Downloads**: 18.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/alshai/levioSAM
- **Stars**: N/A
### Original Help Text
```text
Program: leviosam (lifting over alignments)
Version: 5.2
Usage:   leviosam <command> [options]

Commands: index       Index a lift-over map (`serialize` also works).
          lift        Lift alignments.
          collate     Collate lifted paired-end alignments to make reads properly paired.
          bed         Lift BED intervals.
          reconcile   Reconcile alignments.
Options:  -h          Print detailed usage.
          -V          Verbose level [0].


Index a lift-over map using either a VCF or a chain file.
Usage:   leviosam index [options] {-v <vcf> | -c <chain>} -p <out_prefix> -F <fai> 
Options:
         VcfMap options:
           -v string Index a lift-over map from a VCF file.
           -s string The sample used to build leviosam index (-v needs to be set).
           -g 0/1    The haplotype used to index leviosam. [0] 
           -n string Path to a name map file.
                     This can be used to map '1' to 'chr1', or vice versa.
         ChainMap options:
           -c string Index a lift-over map from a chain file.

         -F string Path to the FAI (FASTA index) file of the dest reference.
         -p string The prefix of the output file.


Perform efficient lift-over using levioSAM.
Usage:   leviosam lift [options] {-v <vcf> | -l <vcfmap> | -c <chain> | -C <chainmap>}
Options:
         -a string Path to the SAM/BAM file to be lifted. 
                   Leave empty or set to "-" to read from stdin.
         -t INT    Number of threads used. [1] 
         -T INT    Chunk size for each thread. [256] 
                   Each thread queries <-T> reads, lifts, and writes.
                   Setting a higher <-T> uses slightly more memory but might benefit thread scaling.
         -m        add MD and NM to output alignment records (requires -f option)
         -f string Fasta reference that corresponds to input SAM/BAM (for use w/ -m option)
         -x string Alignment preset [illumina] 

         VcfMap options (one of -v or -l must be set to perform lift-over using a VcfMap):
           -v string If -l is not specified, can build indexes using a VCF file.
           -l string Path to an indexed VcfMap.
         ChainMap options (one of -c and -C must be set to perform lift-over using a ChainMap):
           -c string If -C is not specified, build a ChainMap from a chain file.
           -C string Path to an indexed ChainMap.
           -G INT    Number of allowed CIGAR changes for one alingment. [0]

         Commit/defer rule options:
           -S string<:int/float> Key-value pair of a split rule. We allow appending multiple `-S` options.
                     Options: mapq:<int>, aln_score:<int>, isize:<int>, hdist:<int>, clipped_frac:<float>, lifted. [none]
                       * mapq          INT   Min MAPQ to commit (pre-liftover). [30]
                       * aln_score     INT   Min AS:i (alignment score) to commit (pre-liftover). [100]
                       * isize         INT   Max TLEN/isize to commit (post-liftover). [1000]
                       * hdist         INT   Max NM:i (Hamming dist.) to commit (post-liftover). `-m` and `-f` must be set. [5]
                       * clipped_frac  FLOAT Min fraction of clipped to commit (post-liftover). [0.95]
           Example: `-S mapq:20 -S aln_score:20` commits MQ>=20 and AS>=20 alignments.
           -r string Path to a BED file (source coordinates). Reads overlap with the regions are always committed. [none]
           -D string Path to a BED file (dest coordinates). Reads overlap with the regions are always deferred. [none]

         The options for serialize can also be used here, if -v/-c is set.
```


## leviosam_collate

### Tool Description
Collate alignments to make sure reads are paired

### Metadata
- **Docker Image**: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
- **Homepage**: https://github.com/alshai/levioSAM
- **Package**: https://anaconda.org/channels/bioconda/packages/leviosam/overview
- **Validation**: PASS

### Original Help Text
```text
[E::collate_run] required argument missed.

Collate alignments to make sure reads are paired
Version: 5.2
Usage:   leviosam collate [options] -a <bam> {-b <bam> | -q <fastq>} -p <prefix>

Inputs:  -a string   Path to the input SAM/BAM.
         -b string   Path to the input deferred SAM/BAM.
         -q string   Path to the input singleton FASTQ.
         -p string   Prefix to the output files (1 BAM and a pair of gzipped FASTQs).
Options: -h          Print detailed usage.
         -V INT      Verbose level [0].
```


## leviosam_bed

### Tool Description
Lift over a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
- **Homepage**: https://github.com/alshai/levioSAM
- **Package**: https://anaconda.org/channels/bioconda/packages/leviosam/overview
- **Validation**: PASS

### Original Help Text
```text
[E::lift_bed_run] Argument -b/--bed_fname is required

Lift over a BED file
Version: %s
Usage:   leviosam bed [options] -b <bed> -C <clft> -p <prefix>

Inputs:  -b string   Path to the input BED.
         -C string   Path to the chain index.
         -p string   Prefix to the output files.
Options: -h          Print detailed usage.
         -G INT      Number of allowed gaps for an interval. [500]
         -V INT      Verbose level [0].
```


## leviosam_reconcile

### Tool Description
Reconcile multiple BAM files into a single BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/leviosam:5.2.1--h4ac6f70_2
- **Homepage**: https://github.com/alshai/levioSAM
- **Package**: https://anaconda.org/channels/bioconda/packages/leviosam/overview
- **Validation**: PASS

### Original Help Text
```text
[E::reconcile_run] required argument missed.

Usage: leviosam reconcile [options] -s <label:input> -o <out>

  -s <string:string>  Input label and file; separated by a colon, e.g.
                      `-s foo:foo.bam -s bar:bar.bam`
  -o <string> Path to the output SAM/BAM file

Options:
  -m          Set to perform merging in pairs [false]
  -r <int>    Random seed used by the program [0]
```


## Metadata
- **Skill**: generated
