# snap CWL Generation Report

## snap

### Tool Description
The general form of the snap command line is:
snap <HMM file> <FASTA file> [options]
HMM file:
The most convenient way to specify the HMM file is by name. This requires
that the ZOE environment variable is set. In this case, snap will look
for the HMM file in $ZOE/HMM. You may also specify the HMM file by an
explicit path. The following are equivalent if $ZOE is in /usr/local:
    snap C.elegans.hmm ...
    snap /usr/local/Zoe/HMM/C.elegans.hmm ...
    snap worm ...  # there are a few convenient aliases in $ZOE/HMM
FASTA file:
If you have several sequences to analyze, it is more efficient to run
snap on a concatenated FASTA file rather than separate runs on single
sequence files. The seqeuence may be in a compressed format
If sequences have been masked with lowercase letters, use -lcmask to
prevent exons from appearing in masked DNA.
Output:
Annotation is reported to stdout in a non-standard format (ZFF). You can
change to GFF or ACEDB with the -gff or -ace options. Proteins and
transcripts are reported to FASTA files with the -aa and -tx options.
External definitions:
SNAP allows you to adjust the score of any sequence model at any point
in a sequence. This behavior is invoked by giving a ZFF file to SNAP:
    snap <hmm> <sequence> -xdef <ZFF file>
Each feature description uses the 'group' field to issue a command:
    SET     set the score
    ADJ     adjust the score up or down
    OK      set non-cannonical scores
 >FOO
 Acceptor 120 120 + +50 . . . SET  (sets an Acceptor to 50)
 Donor    212 212 + -20 . . . ADJ  (lowers a Donor by -20)
 Inter    338 579 +  -2 . . . ADJ  (lowers Inter by -2 in a range)
 Coding   440 512 -  +3 . . . ADJ  (raises Coding by +3 in a range)
 Donor    625 638 +  -5 . . . OK   (sets range of odd Donors to -5)

### Metadata
- **Docker Image**: quay.io/biocontainers/snap:2017_03_01--h7b50bb2_0
- **Homepage**: https://github.com/SnapKit/SnapKit
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/snap/overview
- **Total Downloads**: 27.7K
- **Last updated**: 2025-07-08
- **GitHub**: https://github.com/SnapKit/SnapKit
- **Stars**: N/A
### Original Help Text
```text
The general form of the snap command line is:

    snap <HMM file> <FASTA file> [options]

HMM file:

    The most convenient way to specify the HMM file is by name. This requires
    that the ZOE environment variable is set. In this case, snap will look
    for the HMM file in $ZOE/HMM. You may also specify the HMM file by an
    explicit path. The following are equivalent if $ZOE is in /usr/local:

        snap C.elegans.hmm ...
        snap /usr/local/Zoe/HMM/C.elegans.hmm ...
        snap worm ...  # there are a few convenient aliases in $ZOE/HMM

FASTA file:

    If you have several sequences to analyze, it is more efficient to run
    snap on a concatenated FASTA file rather than separate runs on single
    sequence files. The seqeuence may be in a compressed format

    If sequences have been masked with lowercase letters, use -lcmask to
    prevent exons from appearing in masked DNA.

Output:

    Annotation is reported to stdout in a non-standard format (ZFF). You can
    change to GFF or ACEDB with the -gff or -ace options. Proteins and
    transcripts are reported to FASTA files with the -aa and -tx options.

External definitions:

    SNAP allows you to adjust the score of any sequence model at any point
    in a sequence. This behavior is invoked by giving a ZFF file to SNAP:

        snap <hmm> <sequence> -xdef <ZFF file>

    Each feature description uses the 'group' field to issue a command:

        SET     set the score
        ADJ     adjust the score up or down
        OK      set non-cannonical scores

     >FOO
     Acceptor 120 120 + +50 . . . SET  (sets an Acceptor to 50)
     Donor    212 212 + -20 . . . ADJ  (lowers a Donor by -20)
     Inter    338 579 +  -2 . . . ADJ  (lowers Inter by -2 in a range)
     Coding   440 512 -  +3 . . . ADJ  (raises Coding by +3 in a range)
     Donor    625 638 +  -5 . . . OK   (sets range of odd Donors to -5)

If the output has scrolled off your screen, try 'snap -help | more'
```

