# matlock CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| matlock_bam2 | PASS |  |
| matlock_bamfilt | PASS | tool bug noted: matlock segfaults when -x is omitted, so the wrapper passes an empty exclude list by default; Hi-C reads aligned with bwa mem for the test |
| matlock_cutsites | PASS |  |

## matlock_bamfilt

### Tool Description
Filter a Hi-C BAM.

### Metadata
- **Docker Image**: quay.io/biocontainers/matlock:20181227--h665f8ca_8
- **Homepage**: https://github.com/phasegenomics/matlock
- **Package**: https://anaconda.org/channels/bioconda/packages/matlock/overview
- **Validation**: PASS

### Original Help Text
```text

    usage: matlock bamfilt [options] -i input.[cram|bam|sam] -o output.bam 

         Required:
    -i -         Input file.
    -o -         Ouput file.

         Options:
    -h -          Print help statement.
    -m - <INT>    MapQ filter. [20]    
    -e - <INT>    Max edit distance. [5]
    -l - <INT>    Min target seq-length. [0]
    -x - <STRING> Comma separated list of seqids to exclude/include. [exclude]
                  This option should be used with the binary flag 64 (-f 64).
    -y -          incude -x rather than exclude [exclude]
    -f - <INT>    Binary flag filter:

                  SAME_SEQID  =  2
                  LOW_MAPQ    =  4
                  XA_SA       =  8
                  NM          = 16
                  SMALLCONTIG = 32
                  EXCLUDE     = 64
                  SA_ONLY     = 128
                  UNMAPPED    = 256
                  DUPLICATE   = 1024
                  The default is 1300 =  LOW_MAPQ | NM | DUPLICATE | UNMAPPED
```

## matlock_bam2

### Tool Description
Convert Hi-C alignments to several useful Hi-C formats (binmat, lachesis, juicer, counts).

### Metadata
- **Docker Image**: quay.io/biocontainers/matlock:20181227--h665f8ca_8
- **Homepage**: https://github.com/phasegenomics/matlock
- **Package**: https://anaconda.org/channels/bioconda/packages/matlock/overview
- **Validation**: PASS

### Original Help Text
```text

usage: matlock <command> [options] 


commands:
 - bam2 - converts alignments to several useful hi-c formats.
   + usage: matlock bam2 [binmat|lachesis|juicer|counts] input output
   + details: 
      The input file format is automatically determined [cram|bam|sam].
      The output is written to the fineame provided, no extention.

        
 - bamfilt - filter a hi-c bam.
   + usage: matlock bamfilt input.[cram|bam|sam] output.bam

        
 - cutsites - count cutsites per seqid.
   + usage: matlock cutsites input.fasta ATGC TGCA ...
```

## matlock_cutsites

### Tool Description
Count cut sites (motifs) per sequence id of a fasta file.

### Metadata
- **Docker Image**: quay.io/biocontainers/matlock:20181227--h665f8ca_8
- **Homepage**: https://github.com/phasegenomics/matlock
- **Package**: https://anaconda.org/channels/bioconda/packages/matlock/overview
- **Validation**: PASS

### Original Help Text
```text

usage: matlock <command> [options] 


commands:
 - bam2 - converts alignments to several useful hi-c formats.
   + usage: matlock bam2 [binmat|lachesis|juicer|counts] input output
   + details: 
      The input file format is automatically determined [cram|bam|sam].
      The output is written to the fineame provided, no extention.

        
 - bamfilt - filter a hi-c bam.
   + usage: matlock bamfilt input.[cram|bam|sam] output.bam

        
 - cutsites - count cutsites per seqid.
   + usage: matlock cutsites input.fasta ATGC TGCA ...
```
