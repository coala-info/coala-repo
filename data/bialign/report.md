# bialign CWL Generation Report

## bialign_bialign.py

### Tool Description
Bialignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/bialign:0.3--py310hec16e2b_0
- **Homepage**: https://github.com/s-will/BiAlign
- **Package**: https://anaconda.org/channels/bioconda/packages/bialign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bialign/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/s-will/BiAlign
- **Stars**: N/A
### Original Help Text
```text
usage: bialign.py [-h] [--strA STRA] [--strB STRB] [--nameA NAMEA]
                  [--nameB NAMEB] [-v] [--type TYPE] [--nodescription]
                  [--outmode OUTMODE]
                  [--sequence_match_similarity SEQUENCE_MATCH_SIMILARITY]
                  [--sequence_mismatch_similarity SEQUENCE_MISMATCH_SIMILARITY]
                  [--structure_weight STRUCTURE_WEIGHT]
                  [--gap_opening_cost GAP_OPENING_COST] [--gap_cost GAP_COST]
                  [--shift_cost SHIFT_COST] [--max_shift MAX_SHIFT]
                  [--fileinput] [--version] [--simmatrix SIMMATRIX]
                  seqA seqB

Bialignment.

positional arguments:
  seqA                  sequence A
  seqB                  sequence B

options:
  -h, --help            show this help message and exit
  --strA STRA           structure A
  --strB STRB           structure B
  --nameA NAMEA         name A
  --nameB NAMEB         name B
  -v, --verbose         Verbose
  --type TYPE           Type of molecule: RNA or Protein
  --nodescription       Don't prefix the strings in output alignment with
                        descriptions
  --outmode OUTMODE     Output mode [call --outmode help for a list of
                        options]
  --sequence_match_similarity SEQUENCE_MATCH_SIMILARITY
                        Similarity of matching nucleotides
  --sequence_mismatch_similarity SEQUENCE_MISMATCH_SIMILARITY
                        Similarity of mismatching nucleotides
  --structure_weight STRUCTURE_WEIGHT
                        Weighting factor for structure similarity
  --gap_opening_cost GAP_OPENING_COST
                        Similarity of opening a gap (turns on affine gap cost
                        if not 0)
  --gap_cost GAP_COST   Similarity of a single gap position
  --shift_cost SHIFT_COST
                        Similarity of shifting the two scores against each
                        other
  --max_shift MAX_SHIFT
                        Maximal number of shifts away from the diagonal in
                        either direction
  --fileinput           Read sequence and structure input from file
  --version             show program's version number and exit
  --simmatrix SIMMATRIX
                        Similarity matrix
```

