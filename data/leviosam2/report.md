# leviosam2 CWL Generation Report

## leviosam2_lift

### Tool Description
lift over alignments using a chain file

### Metadata
- **Docker Image**: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
- **Homepage**: https://github.com/milkschen/leviosam2
- **Package**: https://anaconda.org/channels/bioconda/packages/leviosam2/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/leviosam2/overview
- **Total Downloads**: 18.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/milkschen/leviosam2
- **Stars**: N/A
### Original Help Text
```text
Program: leviosam2 (lift over alignments using a chain file)
Version: 0.5.0
Usage:   leviosam2 <command> [options]

Commands: index       Build a levioSAM2 index of a chain file.
          lift        Lift alignments in SAM/BAM/CRAM formats.
          bed         Lift intervals in BED format.
          collate     Collate lifted paired-end alignments.
          reconcile   Reconcile alignments.
Options:  -h          Print detailed usage.
          -V          Verbose level [0].
          --version   Print version.


Build a levioSAM2 index of a chain file.
Usage:   leviosam2 index -c <chain> -p <out_prefix> -F <fai>

Inputs:  -c path   Path to the chain file to index.
         -F path   Path to the FAI (FASTA index) file of the target reference.
         -p string Prefix of the output file.


Lift over using leviosam2.
Usage:   leviosam2 lift [options] -C <clft>

Inputs:  -C path   Path to an indexed ChainMap.
Options: -a path   Path to the SAM/BAM/CRAM file to be lifted. 
                   Leave empty or set to "-" to read from stdin.
         -t INT    Number of threads used.
                   If -t is not set, the value would be the sum of
                   --hts_threads and --lift_threads. [1] 
         --lift_threads INT Number of threads used for lifting reads. 
                            If -t is set, the value should be left unset.
                            The value would be inferred as `t - max(1, t/4)`. [1]
         --hts_threads INT Number of threads used to compress/decompress HTS files.
                           This can improve thread scaling.
                           If -t is set, the value should be left unset.
                           The value would be inferred as `max(1, t/4)`. [0]
         -m        Add MD and NM to output alignment records (requires -f)
         -f path   Path to the FASTA file of the target reference. 
         -x path   Re-alignment preset. [] 
         -G INT    Number of allowed CIGAR changes (in base pairs) for one alignment. [0]
         -T INT    Chunk size for each thread. [256] 
                   Each thread queries <-T> reads, lifts, and writes.
                   Setting a larger -T uses slightly more memory but might benefit thread scaling.

         Commit/defer rule options:
           -S string<:int/float> Key-value pair of a split rule. We allow appending multiple `-S` options.
                     Options: mapq:<int>, aln_score:<int>, isize:<int>, hdist:<int>, clipped_frac:<float>. lifted. [none]
                       * mapq          INT   Min MAPQ (pre-liftover) accepted for a committed read.
                       * aln_score     INT   Min AS:i (alignment score) (pre-liftover) accepted for a committed read.
                       * isize         INT   Max TLEN/isize (post-liftover) accepted for a committed read.
                       * hdist         INT   Max NM:i (Edit distance) (post-liftover) accepted for a committed read.
                                             `-m` and `-f` must be set.
                       * clipped_frac  FLOAT Max fraction of clipped bases (post-liftover) accepted for a committed read.
                                             A higher value results in fewer committed reads.
           Example: `-S mapq:20 -S aln_score:20` commits MQ>=20 and AS>=20 alignments.
           -r string Path to a BED file (source coordinates). Reads overlap with the regions are always committed. [none]
           -D string Path to a BED file (dest coordinates). Reads overlap with the regions are always deferred. [none]
           -B float  Threshold for BED record intersection. [0]
                     If <= 0: consider any overlap (>0 bp)
                     If > 1: consider >`-B`-bp overlap
                     If 1>=`-B`>0: consider overlap with a fraction of >`-B` of the alignment.
```


## leviosam2_bed

### Tool Description
Lift over a BED file

### Metadata
- **Docker Image**: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
- **Homepage**: https://github.com/milkschen/leviosam2
- **Package**: https://anaconda.org/channels/bioconda/packages/leviosam2/overview
- **Validation**: PASS

### Original Help Text
```text
[E::lift_bed_run] Argument -b/--bed_fname is required

Lift over a BED file
Version: 0.5.0
Usage:   leviosam2 bed [options] -b <bed> -C <clft> -p <prefix>

Inputs:  -b string   Path to the input BED.
         -C string   Path to an indexed ChainMap. See `leviosam2 index` for details.
         -p string   Prefix to the output files.
Options: -h          Print detailed usage.
         -G INT      Number of allowed gaps for an interval. [500]
         -V INT      Verbose level [0].
```


## leviosam2_collate

### Tool Description
Collate alignments to make sure reads are paired

### Metadata
- **Docker Image**: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
- **Homepage**: https://github.com/milkschen/leviosam2
- **Package**: https://anaconda.org/channels/bioconda/packages/leviosam2/overview
- **Validation**: PASS

### Original Help Text
```text
[E::collate_run] required argument missed.

Collate alignments to make sure reads are paired
Version: 0.5.0
Usage:   leviosam2 collate [options] -a <bam> {-b <bam> | -q <fastq>} -p <prefix>

Inputs:  -a string   Path to the input SAM/BAM.
         -b string   Path to the input deferred SAM/BAM.
         -q string   Path to the input singleton FASTQ.
         -p string   Prefix to the output files (1 BAM and a pair of gzipped FASTQs).
Options: -h          Print detailed usage.
         -V INT      Verbose level [0].
```


## leviosam2_reconcile

### Tool Description
Reconcile alignments to select the one with higher confidence

### Metadata
- **Docker Image**: quay.io/biocontainers/leviosam2:0.5.0--h9948957_1
- **Homepage**: https://github.com/milkschen/leviosam2
- **Package**: https://anaconda.org/channels/bioconda/packages/leviosam2/overview
- **Validation**: PASS

### Original Help Text
```text
[E::reconcile_run] required argument missed.

Reconcile alignments to select the one with higher confidence
Version: 0.5.0
Usage: leviosam2 reconcile [options] -s <label:input> -o <out>

Inputs:  -s string:string  Input label and file; separated by a colon, e.g.
                           `-s foo:foo.bam -s bar:bar.bam`
         -o string Path to the output SAM/BAM file
Options: -h        Print detailed usage.
         -c        Set to use conservative MAPQ [false]
         -m        Set to perform merging in pairs [false]
         -r INT    Random seed used by the program [0]
```

