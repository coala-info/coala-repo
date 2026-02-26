# matlock CWL Generation Report

## matlock_The

### Tool Description
matlock <command> [options]

### Metadata
- **Docker Image**: quay.io/biocontainers/matlock:20181227--h665f8ca_8
- **Homepage**: https://github.com/phasegenomics/matlock
- **Package**: https://anaconda.org/channels/bioconda/packages/matlock/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/matlock/overview
- **Total Downloads**: 7.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phasegenomics/matlock
- **Stars**: N/A
### Original Help Text
```text
FATAL unknown command --help

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

