# perl-retroseq CWL Generation Report

## perl-retroseq_retroseq.pl

### Tool Description
A tool for discovery of transposable elements from short read alignments

### Metadata
- **Docker Image**: quay.io/biocontainers/perl-retroseq:1.5--pl5321h7181c03_3
- **Homepage**: https://github.com/tk2/RetroSeq
- **Package**: https://anaconda.org/channels/bioconda/packages/perl-retroseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/perl-retroseq/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/tk2/RetroSeq
- **Stars**: N/A
### Original Help Text
```text
RetroSeq: A tool for discovery of transposable elements from short read alignments

Version: 1.5
Author: Thomas Keane (thomas.keane@sanger.ac.uk)

You did not specify an action!

Usage: /usr/local/bin/retroseq.pl -<command> options

            -discover       Takes a BAM and a set of reference TE (fasta) and calls candidate supporting read pairs (BED output)
            -call           Takes multiple output of discovery stage and a BAM and outputs a VCF of TE calls
            
NOTE: /usr/local/bin/retroseq.pl requires samtools, bcftools, exonerate, unix sort, bedtools to be in the default path

READ NAMES: This software assumes that reads that make up a pair have identical read names in the BAM file

RetroSeq finished successfully
```

