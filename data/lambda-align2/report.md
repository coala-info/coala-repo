# lambda-align2 CWL Generation Report

## lambda-align2_lambda2

### Tool Description
Lambda is a local aligner optimized for many query sequences and searches in protein space. It is compatible to BLAST, but much faster than BLAST and many other comparable tools.

### Metadata
- **Docker Image**: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
- **Homepage**: http://seqan.github.io/lambda/
- **Package**: https://anaconda.org/channels/bioconda/packages/lambda/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lambda-align2/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
lambda2 - Lambda, the Local Aligner for Massive Biological DataA
================================================================

SYNOPSIS
    lambda2 [OPTIONS] COMMAND [COMMAND-OPTIONS]

DESCRIPTION
    Lambda is a local aligner optimized for many query sequences and searches
    in protein space. It is compatible to BLAST, but much faster than BLAST
    and many other comparable tools.

    Detailed information is available in the wiki:
    <https://github.com/seqan/lambda/wiki>

REQUIRED ARGUMENTS
    COMMAND STRING
          The sub-program to execute. See below. One of searchp, searchn,
          mkindexp, and mkindexn.

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.
    --copyright
          Display long copyright information.

AVAILABLE COMMANDS
    searchp – Perform a protein search (BLASTP, BLASTX, TBLASTN, TBLASTX).

    searchn – Perform a nucleotide search (BLASTN, MEGABLAST).

    mkindexp – Create an index for protein searches.

    mkindexn – Create an index for nucleotide searches.

    To view the help page for a specific command, simply run 'lambda command
    --help'.

VERSION
    Last update: Jun  8 2019
    lambda2 version: 2.0.0
    SeqAn version: 2.4.0

LEGAL
    lambda2 Copyright: 2013-2019 Hannes Hauswedell, released under the GNU AGPL v3 (or later); 2016-2019 Knut Reinert and Freie Universität Berlin, released under the 3-clause-BSDL
    SeqAn Copyright: 2006-2015 Knut Reinert, FU-Berlin; released under the 3-clause BSDL.
    In your academic works please cite: Hauswedell et al (2014); doi: 10.1093/bioinformatics/btu439
    For full copyright and/or warranty information see --copyright.
```

