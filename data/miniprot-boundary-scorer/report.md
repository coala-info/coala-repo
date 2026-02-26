# miniprot-boundary-scorer CWL Generation Report

## miniprot-boundary-scorer_miniprot_boundary_scorer

### Tool Description
The program parses the result of miniprot's "--aln" output. The input is read from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/miniprot-boundary-scorer:1.0.1--h9948957_0
- **Homepage**: https://github.com/tomasbruna/miniprot-boundary-scorer
- **Package**: https://anaconda.org/channels/bioconda/packages/miniprot-boundary-scorer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/miniprot-boundary-scorer/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-06-08
- **GitHub**: https://github.com/tomasbruna/miniprot-boundary-scorer
- **Stars**: N/A
### Original Help Text
```text
Usage: miniprot_boundary_scorer < input -o output_file -s matrix_file [-w integer] [-k kernel] [-e min_exon_score] [-x min_initial_exon_score] [-i min_initial_intron_score] [-g gap_penalty] [-f boundary_frameshift_penalty] [-F exon_frameshift_stop_penalty]

The program parses the result of miniprot's "--aln" output. The input is read from stdin.


Options:
   -o Where to save output file
   -s Path to amino acid scoring matrix
   -w Width of a scoring window around introns. Default = 10
   -k Specify type of weighting kernel used. Available opti-
      ons are "triangular", "box", "parabolic" and 
      "triweight". Triangular kernel is the default option.
   -e Minimum exon score. Exons with lower scores (as wells as int-
      rons bordering such low-scoring exons and starts/stops inside
      them are not printed). Initial exons are treated separately.
      See the options -x and -i for details. Default = report all 
      exons.
   -x Minimum initial exon score. Initial exons with lower scores
      (as well as introns bordering such low-scoring exons and starts
      inside them) are not printed. Initial exons with scores between
      (-e and -x) must also define an initial intron which passes the
      -i filter. Default = report all initial exons.
   -i Minimum initial intron score. Initial introns bordering
      initial exons with scores < -e that have lower intron scores
      (as well as initial exons bordering such low-scoring
      introns and starts in those exons) are not printed.
      Default = report all initial introns.
   -g Penalty for gaps, both in exons and around intron boundaries.
      Default = 4
   -f Penalty for frameshifts around exon boundaries. After
      a frameshift is detected, the rest of the exon boundary
      is scored (still using the weighted score) by this penlalty,
      regardless of the actual matches in the alignment.
      Default = 4
   -F Penalty for frameshifts and read-through stop codons in 
      exons. Default = 20
```

