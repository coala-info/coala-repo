# mugsy CWL Generation Report

## mugsy

### Tool Description
a multiple whole genome aligner

### Metadata
- **Docker Image**: quay.io/biocontainers/mugsy:1.2.3--hdfd78af_4
- **Homepage**: https://github.com/margyle/MugsyDev
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mugsy/overview
- **Total Downloads**: 51.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/margyle/MugsyDev
- **Stars**: N/A
### Original Help Text
```text
Need to specify valid input fasta file
NAME
    mugsy - a multiple whole genome aligner

USAGE
    mugsy [-p output prefix] multifasta_genome1.fsa multifasta_genome2.fsa
    ... multifasta_genomeN.fsa

SYNOPSIS
    Mugsy is multiple whole genome aligner. Mugsy uses Nucmer for pairwise
    alignment, a custom graph based segmentation procedure for identifying
    LCBs (synchain-mugsy), and a segment-based progressive multiple
    alignment strategy from Seqan::TCoffee. Mugsy accepts draft genomes in
    the form of multi-FASTA files. Mugsy does not require a reference genome
    and is robust in the presence of large scale genome flux and genome
    rearrangments. Mugsy performs best on closely related genomes and has
    been used to align several dozens bacterial genomes.

    Mugsy outputs a series of alignments in MAF format.

    See http://mugsy.sf.net for more information

INPUT
    Input is one or more (multi)FASTA files, one per genome. Each file
    should contain all the sequences for a single organism/species. The
    filename is used as the genome name.

    Limitations on FASTA input: input FASTA headers must not contain ':' or
    '-' ambiguity characters are converted to N in output

    Common options:

        -p|prefix       prefix for output files

        --directory directory used to store output and temporary
          files. Must be a absolute path

        -d|--distance   maximum distance along a single sequence (bp) for
         chaining anchors into locally colinear blocks (LCBs).  This is
         used by the segmentation step synchain-mugsy. Default is 1000bp.

        -c|--minlength minimum span of an aligned region in a colinear
         block (bp). This is used by the segmentation step
         synchain-mugsy. Default is 30bp.

        -duplications 1 - Detect and report duplications. 0 - Skip. Default is 0.

    Other options:

        -nucmeropts options passed through to the Nucmer
         package. Eg. -nucmeropts "-l 15" sets the minimum MUM length in
         NUCmer to 15. See the Nucmer documentation at
         http://mummer.sf.net for more information.  Default is -l 15.

        -allownestedlcbs. Default=false. Places each multi-genome anchor
         in exactly one LCB; the longest spanning LCB

        -plot output genome dot plots in GNUplot format. Overlays LCBS
         onto pairwise plots from mummerplot. Display of draft genomes in
         these plots is not supported.

        -fullsearch Run a complete all pairs Nucmer search with each
         sequence as a reference and query (n^2-1 total searches). Default
         is one direction only (n^2-1/2 searches).

        -refine run an second iteration of Mugsy on each LCB to refine the
         alignment using either Mugsy (--refine mugsy), FSA (--refine
         fsa), Pecan (--refine pecan), MLAGAN (--refine mlagan). Requires
         necessary tools are in your path:  
         fsa: fsa
         pecan: muscle,exonerate, in the path. classpath set for bp.pecan.Pecan.
         mlagan: mlagan.sh


        -debug           debug level. > 2 verbose

OUTPUT
    Primary output is MAF format.

    Utilities for parsing MAF are available at the UCSC genome browser and
    in the multiz,TBA toolkit. GMAJ is a popular visualization tool for MAF.

MORE INFO
    This script is a wrapper that invokes an all-against-all Nucmer search
    and the mugsy aligner. The two primary components of the aligner can
    also be run independently

    1) mugsyWGA

    Generates a whole genome alignment (WGA) from a library of pairwise
    alignments in XMFA format. Implemented with the refined segment graph
    and progressive consistency-based alignment procedure described in
    Seqan::TCoffee (Rausch et al 2008). Invokes synchain-mugsy to segment
    the input genomes into alignable regions.

    2) synchain-mugsy

    Derives a segmentation of genome anchors that fulfill --distance and
    --minlength criteria. Anchors can be any oriented features that span two
    or more of the input genomes. The output is a set of locally colinear
    blocks (LCBs)

Using Mugsy with other aligners
    Mugsy supports realignment of LCBs using FSA,Pecan, MLAGAN. For FSA,
    make sure FSA is in your PATH and run with --refine fsa

For more information
    http://www.sf.net/mugsy.

    AUTHOR: Sam Angiuoli angiuoli@cs.umd.edu 2009
```


## Metadata
- **Skill**: generated
