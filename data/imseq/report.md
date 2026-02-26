# imseq CWL Generation Report

## imseq

### Tool Description
imseq is a tool for the analysis of T- and B-cell receptor chain
    sequences. It can be used to analyse either single-read data, where the
    reads cover the V-CDR3-J region sufficiently for an identification, or
    paired-end data where one read covers the V-region and one read covers the
    J- and CDR3-region. The latter read has do cover only a small fraction of
    the V-segment, sufficient for the localization of the Cys-104 motif.

### Metadata
- **Docker Image**: quay.io/biocontainers/imseq:1.1.0--h077b44d_8
- **Homepage**: http://www.imtools.org/
- **Package**: https://anaconda.org/channels/bioconda/packages/imseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/imseq/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
imseq
=====

SYNOPSIS
    imseq -ref <segment reference> [OPTIONS] <VDJ reads>
    imseq -ref <segment reference> [OPTIONS] <V reads> <VDJ reads>

DESCRIPTION
    imseq is a tool for the analysis of T- and B-cell receptor chain
    sequences. It can be used to analyse either single-read data, where the
    reads cover the V-CDR3-J region sufficiently for an identification, or
    paired-end data where one read covers the V-region and one read covers the
    J- and CDR3-region. The latter read has do cover only a small fraction of
    the V-segment, sufficient for the localization of the Cys-104 motif.

    The following options exist:

    -h, --help
          Display the help message.
    --version
          Display version information.

  The following switch must be specified:
    -ref, --reference FILE
          FASTA file with gene segment reference sequences.

  Output files. At least one of the following switches must be specified:
    -oa, --out-amino STR
          Output file path for translated clonotypes.
    -on, --out-nuc STR
          Output file path for untranslated clonotypes.
    -o, --out STR
          Output file path for verbose output per analyzed read.

  Read preprocessing:
    -r, --reverse
          By default, V-reads are read as they are and V(D)J-reads are reverse
          complemented. Use this switch for the opposite behaviour.
    -tr, --truncate-reads NUM
          Truncate reads to the specified length. 0 leaves them at their
          original lengths. Default: 0.

  Additional output settings:
    -rlog, --reject-log FILE
          Log file for rejected reads. If empty, no log file is written.
    -al, --with-alleles
          Keep allele information in detailed output file specified with -o.

  V/J segment alignment:
    -ev, --v-err-rate NUM
          Maximum error rate allowed within the V segment alignment In range
          [0..inf]. Default: 0.05.
    -ej, --j-err-rate NUM
          Maximum error rate allowed within the J segment alignment In range
          [0..inf]. Default: 0.15.

  V/J segment alignment (paired-end):
    -pve, --paired-v-error NUM
          Maximum error rate in the alignment between the forward-read
          identified V segment and the reverse read. Default: Use value from
          -ev. In range [0..1].
    -vcr, --v-read-crop NUM
          Crop NUM bases from the beginning of the V read before processing it
          In range [0..inf]. Default: 0.

  V/J segment alignment (Expert settings):
    -jcl, --j-core-length NUM
          Length of the J core fragment. In range [5..20]. Default: 12.
    -jco, --j-core-offset NUM
          Offset of the V core fragment. Default: -6.
    -vcl, --v-core-length NUM
          Length of the V core fragment. Default: Automatically select value
          between 10 and 20 based on minimum observed read length. In range
          [5..inf].
    -vco, --v-core-offset NUM
          Offset of the V core fragment. Default: 0.
    -vce, --v-core-errors NUM
          Maximum number of errors when matching the V core fragments. In
          range [0..inf]. Default: 1.
    -jce, --j-core-errors NUM
          Maximum number of errors when matching the J core fragments. In
          range [0..inf]. Default: 2.

  Quality control:
    -mq, --min-qual NUM
          Minimum average read phred score. In paired end mode, this is
          applied to both reads. See '-sfb'. In range [0..60]. Default: 30.
    -mcq, --min-clust-qual NUM
          Minimum average cluster phred score. In range [0..60]. Default: 30.
    -mrl, --min-read-length NUM
          Minimum read length. In paired end mode, this is applied to both
          reads. See '-sfb'. In range [0..inf]. Default: 75.
    -mcl, --min-cdr3-length NUM
          Minimum CDR3 length in amino acids. In range [0..inf]. Default: 5.
    -sfb, --single-end-fallback
          Fall back to single end analysis based on VDJ read if V read fails
          -mq or -mrl.

  Barcoding:
    -bvdj, --barcode-vdj
          In paired end mode: Read the barcode from the VDJ read instead of
          the V read.
    -bse, --bcseq-max-err NUM
          Maximum number of errors allowed in the barcode sequence In range
          [0..inf]. Default: 1.
    -bmq, --bc-min-qual NUM
          Minimum per base quality in molecular barcode region In range
          [0..60]. Default: 30.
    -bcl, --barcode-length NUM
          Length of random barcode at the beginning of the read. A value of
          '0' disables barcode based correction. In range [0..inf]. Default:
          0.
    -ber, --barcode-err-rate NUM
          Maximum error rate between reads in order to be merged based on
          barcode sequence In range [0..1]. Default: 0.05.
    -bfr, --barcode-freq-rate NUM
          Inclusive maximum frequency ratio between smaller and larger cluster
          during barcode clustering In range [0..1]. Default: 0.2.
    -bst, --barcode-stats FILE
          Path to barcode stats output file. If empty, no file is written.
          Ignored if -bcl is 0.
    -oab, --out-amino-bc FILE
          Output file path for translated clonotypes with barcode corrected
          counts. Ignored if -bcl is 0.
    -onb, --out-nuc-bc FILE
          Output file path for untranslated clonotypes with barcode corrected
          counts. Ignored if -bcl is 0.

  Postprocessing / Clustering:
    -ma, --merge-ambiguous-seg
          Merge clonotypes with identical CDR3 sequences separated by
          ambiguous segment identification
    -qc, --qual-clust
          Enable quality score based clustering.
    -sc, --simple-clust
          Enable simple distance-based clustering
    -qcme, --max-err-hq NUM
          Maximum edit-distance for two clusters to be clustered without low
          quality correlation In range [0..inf]. Default: 4.
    -qcsd, --min-sd-diff NUM
          How many standard deviations must an error positions quality value
          be below the mean to be considered for clustering. Default: 1.
    -scme, --max-err-lq NUM
          Maximum edit-distance for two clusters to be potentially clustered
          without low quality correlation In range [0..inf]. Default: 2.
    -mcr, --max-clust-ratio NUM
          Maximum abundance ratio for two clonotypes to be clustered In range
          [0..1]. Default: 1.

  Performance:
    -j, --jobs NUM
          Number of parallel jobs (threads). Default: 1.

  Other options:
    -pa, --print-alignments
          Print the V/J alignments for each read. Implies -j 1.

VERSION
    Last update: March 2016
    imseq version: 1.1.0-custom
    SeqAn version: 2.1.0
```

