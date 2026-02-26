# yaha CWL Generation Report

## yaha

### Tool Description
YAHA is a fast and sensitive DNA sequence aligner.

### Metadata
- **Docker Image**: quay.io/biocontainers/yaha:0.1.83--h1b792b2_3
- **Homepage**: https://github.com/jannson/yaha
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yaha/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jannson/yaha
- **Stars**: N/A
### Original Help Text
```text
YAHA version 0.1.83
--help is not a valid option.

Usage (Default parameter values shown in parenthesis):

To create an index:
yaha -g genomeFilename [-H maxHits (65525)] [-L wordLen (15)] [-S Skip-distance (1)]
The genome file can be a FASTA file, or a nib2 file (created by a previous yaha index operation).

To align queries:
yaha -x yahaIndexFile [-q queryFile|(stdin)] [-o8|(-osh)|-oss outputFile|(stdout)][AdditionalOptions]
The query file can be either a FASTA file or a FASTQ file.
-o8     produces alignment output in modified Blast8 format.
-osh    produces alignment output in SAM format with hard clipping.
-oss    produces alignment output in SAM format with soft clipping.
[-t numThreads (1)]

Additional General Alignment Options:
    [-BW BandWidth (5)] [-G maxGap (50)] [-H maxHits (650)] [-M minMatch (25)]
    [-MD MaxDesert (50)] [-P minPercent-identity (0.9)] [-X Xdropoff (25)]

[-AGS (Y)|N] controls use of Affine Gap Scoring.
If -AGS is off, a simple edit distance calculation is done.  If on, the following are used:
    [-GEC GapExtensionCost (2)] [-GOC GapOpenCost (5)] [-MS MatchScore (1)] [-RC ReplacementCost (3)]

[-OQC (Y)|N] controls use of the Optimal Query Coverage Algorithm.
If -OQC if off, all alignments meeting above criteria are output.
If on, a set of "primary" alignments are found that optimally cover the length of the query, using the following options:
    [-BP BreakpointPenalty (5)] [-MGDP MaxGenomicDistancePenalty (5)] [-MNO MinNonOverlap (minMatch)]
The cost of inserting a breakpoint in the Optimal Coverage Set is BP*MIN(MGDP, Log10(genomic distance between reference loci)).

[-FBS Y|(N)] controls inclusion of "secondary" alignments similar to a primary alignment found using OQC.
If -FBS is on, the following are used.  A "secondary" alignemnt must satisfy BOTH criteria.
    [-PRL PercentReciprocalLength (0.9)] [-PSS PercentSimilarScore (0.9)]

For a more detailed help message, type yaha -xh.
```

