# crumble CWL Generation Report

## crumble

### Tool Description
Lossy quality score compression for SAM/BAM/CRAM files by quantising quality values based on consensus agreement.

### Metadata
- **Docker Image**: quay.io/biocontainers/crumble:0.9.1--h577a1d6_4
- **Homepage**: https://github.com/jkbonfield/crumble
- **Package**: https://anaconda.org/channels/bioconda/packages/crumble/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crumble/overview
- **Total Downloads**: 22.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jkbonfield/crumble
- **Stars**: N/A
### Original Help Text
```text
Crumble version 0.9.1

Usage: crumble [options] in-file out-file

Options:
-I fmt(,opt...)   Input format and format-options [auto].
-O fmt(,opt...)   Output format and format-options [SAM].
-v                Increase verbosity
-z                Do not add an @PG SAM header line
-c qual_cutoff    In highly confident regions, quality values above/below
-l qual_lower         'qual_cutoff' [25] are quantised to 'qual_lower' [5]
-u qual_upper         and 'qual_upper' [40] based on agreement to consensus.
-U qual_max       The maximum quality cap used in all bases (even if kept [60])
-S                Quantise qualities (with -[clu] options) in soft-clips too.
-m min_mqual      Keep qualities for seqs with mapping quality <= mqual [0].
-L bool           Whether mismatching bases can have qualities lowered [1]
-B                If set, replace quals in good regions with low/high [unset]
-i STR_mul,add    Adjust indel size by (STR_size+add)*mul [1.0,2]
-s STR_mul,add    Adjust SNP size by (STR_size+add)*mul [0.0,0]
-r region         Limit input to region chr:pos(-pos) []
-R keep.bed       Keep quality in regions contained in the supplied bed []
-t tag_list       Comma separated list of aux tags to keep []
-T tag_list       Comma separated list of aux tags to discard []
-b out.bed        Output suspicious regions to out.bed []
-P float          Keep qual if local depth >= [999.0] times deeper than expected
-Y float          Fraction of reads with indel to trigger STR analysis [0.00]

(Preserving whole read qualities; values are fractions of read coverage)
-C float          Keep if >= [0.20] reads have soft-clipping
-M float          Keep if >= [1.00] reads have low mapping quality
-Z float          Keep if >= [1.00] indel sizes do not fit bi-modal dist.
-V float          Keep if <  [0.00] reads span indel

(Calling while ignoring mapping quality)
-q int            Minimum snp call confidence [0]
-d int            Minimum indel call confidence [50]
-x float          Minimum discrepancy score [2.0]

(Calling with use of mapping quality)
-Q int            Minimum snp call confidence [70]
-D int            Minimum indel call confidence [125]
-X float          Minimum discrepancy score [1.5]

(Horizontal quality smoothing via P-block)
-p int            P-block algorithm; quality values +/- 'int' [0]

(BD and BI aux tag binary-binning; off by default)
-f qual_cutoff    Quantise BD:Z: tags to two values (or one if both equal).
-g qual_upper       If >= 'qual_cutoff' [0] replace by 'qual_upper' [0]
-e qual_lower       otherwise replace by 'qual_lower' [0].
-F qual_cutoff    Quantise BI:Z: tags to two values (or one if both equal).
-G qual_upper       If >= 'qual_cutoff' [0] replace by 'qual_upper' [0]
-E qual_lower       otherwise replace by 'qual_lower' [0].
-k qual           Preserve quality value if any diffs present
-K qual           Preserve quality value regardless of diffs
-N                Store entire column when preserved qualities are present
-y machine        Standard options application to machine type:
                    Machine types are limited now to:
    illumina        [NOP: use default parameters]
    pbccs           -m40 -u60 -X0.8 -Y0.1 -p16 -k93 -N

(Standard compression levels combining the above. Use as 1st option)
-1,-3,-5,-7,-8,-9 Combination of options for compression level.
Level -9 is the default level.  Options used per level are:
     -1: -p0 -Q75 -D150 -X1  - M0.5 -Z0.1 -V0.5 -P3.0 -s1.0,5 -i2.0,1 -m5
     -3: -p0 -Q75 -D150 -X1   -M0.5 -Z0.1 -V0.5 -P3.0 -s1.0,0 -i1.1,2 -m0
     -5: -p0 -Q75 -D150 -X1   -M0.5 -Z0.1 -V0.5 -P3.0 -s0.0,0 -i1.1,2 -m0
     -7: -p0 -Q75 -D150 -X1   -M1   -Z1   -V0   -P999 -s0.0,0 -i1.1,2 -m0
     -8: -p0 -Q70 -D125 -X1.5 -M1   -Z1   -V0   -P999 -s0.0,0 -i1.0,2 -m0
     -9: -p8 -Q70 -D125 -X1.5 -M1   -Z1   -V0   -P999 -s0.0,0 -i1.0,2 -m0

Standard htslib format options apply.  So to create a CRAM file with lossy
template names enabled and a larger number of sequences per slice, try:

    crumble -O cram,lossy_names,seqs_per_slice=100000

The lossy quality encoding works by running two distinct heterozygous consensus
calling algorithms; with and without the use of mapping qualities.  Use -q 0
or -Q 0 to disable one of these if only the other is needed.  When operating,
any sufficiently high quality SNP (above -q / -Q) with have the qualities for
the bases adjusted to 'qual_lower' or 'qual_upper'.  Similarly for any high
quality indel.  An lower quality indel will causes neighbouring bases for
all sequences at that site to be kept, for the region as large as the indel
plus an extension along any short tandem repeats (STR), multiplied by 
'indel_mult' plus an additional 'STR_add'.
```


## Metadata
- **Skill**: generated
