# lordfast CWL Generation Report

## lordfast

### Tool Description
lordFAST is a sensitive tool for mapping long reads with high error rates. lordFAST is specially designed for aligning reads from PacBio sequencing technology but provides the user the ability to change alignment parameters depending on the reads and application.

### Metadata
- **Docker Image**: quay.io/biocontainers/lordfast:0.0.10--h5b5514e_3
- **Homepage**: https://github.com/vpc-ccg/lordfast
- **Package**: https://anaconda.org/channels/bioconda/packages/lordfast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lordfast/overview
- **Total Downloads**: 12.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/vpc-ccg/lordfast
- **Stars**: N/A
### Original Help Text
```text
lordFAST(1)                     lordfast Manual                    lordFAST(1)



[1mNAME[0m
       lordfast


[1mDESCRIPTION[0m
       lordFAST  is  a  sensitive  tool for mapping long reads with high error
       rates. lordFAST is specially designed for aligning  reads  from  PacBio
       sequencing  technology  but  provides  the  user  the ability to change
       alignment parameters depending on the reads and application.


[1mINSTALLATION[0m
       lordFast can be installed using conda  package  manager  (via  bioconda
       channel) using the following command:
       $ conda install -c bioconda lordfast

       In order to build from source, please download the latest release from
       https://github.com/vpc-ccg/lordfast/releases
       or alternatively clone the repository by running the following command:
       $ git clone https://github.com/vpc-ccg/lordfast.git

       Now  the  code  can  be  compiled easily by running "make" command line
       which builds the binary file "lordfast".
       $ cd lordfast
       $ make


[1mSYNOPSIS[0m
       lordfast --index FILE [OPTIONS]
       lordfast --search FILE --seq FILE [OPTIONS]


[1mOPTIONS[0m
   [1mIndexing options[0m
       [1m-I, --index [4m[22mSTR[0m
              Path to the reference genome file in FASTA format which is  sup-
              posed to be indexed. [required]

   [1mMapping options[0m
       [1m-S, --search [4m[22mSTR[0m
              Path to the reference genome file in FASTA format. [required]

       [1m-s, --seq [4m[22mSTR[0m
              Path  to  the file containing read sequences in FASTA/FASTQ for-
              mat. [required]

       [1m-o, --out [4m[22mSTR[0m
              Write output to [4mSTR[24m file rather than standard output. [stdout]

       [1m-t, --threads [4m[22mINT[0m
              Use [4mINT[24m number of CPU cores. Pass 0 to  use  all  the  available
              cores. [1]

   [1mAdvanced options[0m
       [1m-k, --minAnchorLen [4m[22mINT[0m
              Minimum required length of anchors to be considered. [14]

       [1m-n, --numMap [4m[22mINT[0m
              Perform alignment for at most [4mINT[24m candidates. [10]

       [1m-l, --minReadLen [4m[22mINT[0m
              Do  not  try to map any read shorter than [4mINT[24m bp and report them
              as unmapped. [1000]

       [1m-c, --anchorCount [4m[22mINT[0m
              Consider [4mINT[24m anchoring positions on the long read. [1000]

       [1m-m, --maxRefHit [4m[22mINT[0m
              Ignore anchoring positions with more than  [4mINT[24m  reference  hits.
              [1000]

       [1m-R, --readGroup [4m[22mSTR[0m
              SAM read group line in a format like '@RGID:fooSM:bar'. []

       [1m-a, --chainAlg [4m[22mINT[0m
              Chaining algorithm to use. Options are "dp-n2" and "clasp". [dp-
              n2]

       [1m--noSamHeader[0m
              Do not print sam header in the output.

   [1mOther options[0m
       [1m-h, --help[0m
              Print this help file.

       [1m-v, --version[0m
              Print the version of software.


[1mEXAMPLES[0m
       Indexing the reference genome:
       $ ./lordfast --index gen.fa

       Mapping to the reference genome:
       $ ./lordfast --search gen.fa --seq reads.fastq > map.sam
       $ ./lordfast --search gen.fa --seq reads.fastq --threads 4 > map.sam


[1mBUGS[0m
       Please report the bugs through lordfast's issues page at
       https://github.com/vpc-ccg/lordfast/issues


[1mCONTACT[0m
       Ehsan Haghshenas (ehaghshe@sfu.ca)


[1mCOPYRIGHT AND LICENSE[0m
       This software is released under  GNU General Public License (v3.0)
       Copyright (c) 2018 Simon Fraser University, All rights reserved.



lordFAST                  Last Updated: June 26, 2018              lordFAST(1)
```

