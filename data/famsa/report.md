# famsa CWL Generation Report

## famsa

### Tool Description
FAMSA (Fast and Accurate Multiple Sequence Alignment) is a tool for multiple sequence alignment or profile-profile alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/famsa:2.4.1--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/FAMSA
- **Package**: https://anaconda.org/channels/bioconda/packages/famsa/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/famsa/overview
- **Total Downloads**: 110.0K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/refresh-bio/FAMSA
- **Stars**: N/A
### Original Help Text
```text
FAMSA (Fast and Accurate Multiple Sequence Alignment) 
  version 2.4.1-45c9b2b (2025-05-09)
  S. Deorowicz, A. Debudaj-Grabysz, A. Gudys

Usage:
  famsa [options] <input_file> [<input_file_2>] <output_file>

Positional parameters:
  input_file, input_file_2 - input files in FASTA format; action depends on the number of input files:
      * one input - multiple sequence alignment (input gaps, if present, are removed prior the alignment),
      * two inputs - profile-profile aligment (input gaps are preserved).
      First input can be replaced with STDIN string to read from standard input.
  output_file - output file (pass STDOUT when writing to standard output); available outputs:
      * alignment in FASTA format,
      * guide tree in Newick format (-gt_export option specified),
      * distance matrix in CSV format (-dist_export option specified),

Options:
  -help - print this message
  -t <value> - no. of threads, NOTE: exceeding number of physical (not logical) cores decreases performance,
      0 indicates half of all the logical cores (default: 0)
  -v - verbose mode, show timing information (default: disabled)

  -gt <sl | upgma | nj | import <file>> - guide tree method (default: sl):
      * sl - single linkage 
      * upgma - UPGMA
      * nj - neighbour joining
      * import <file> - imported from a Newick file
  -medoidtree - use MedoidTree heuristic for speeding up tree construction (default: disabled)
  -medoid_threshold <n_seqs> - if specified, medoid trees are used only for sets with <n_seqs> or more
  -gt_export - export a guide tree to output file in Newick format
  -dist_export - export a distance matrix to output file in CSV format
  -square_matrix - generate a square distance matrix instead of a default triangle
  -pid - generate pairwise identity (the number of matching residues divided by the shorter sequence length) instead of distance
  -keep-duplicates - keep duplicated sequences during alignment
                     (default: disabled - duplicates are removed prior and restored after the alignment).

  -gz - enable gzipped output (default: disabled)
  -gz-lev <value> - gzip compression level [0-9] (default: 7)
  -remove-rare-columns <value> - remove columns with less than <rare_column_threshold> fraction of non-gap characters
  -refine_mode <on | off | auto> - refinement mode (default: auto - the refinement is enabled for sets <= 1000 seq.)

Advanced options:
  -r <value> - no. of refinement iterations (default: 100)
  -sm <MIQS | PFASUM31 | PFASUM43 | PFASUM60> - scoring matrix (default: PFASUM43)
  -go <value> - gap open cost (default: -14850)
  -ge <value> - gap extension cost (default: -1250)
  -tgo <value> - terminal gap open cost (default: -660)
  -tge <value> - terminal gap extenstion cost (default: -660)
  -dist <measure> - pairwise distance measure:
      * indel_div_lcs (default)
      * indel075_div_lcs

  -gsd <value> - gap cost scaller div-term (default: 7)
  -gsl <value> - gap cost scaller log-term (default: 45)
  -dgr - disable gap cost rescaling (default: enabled)
  -dgo - disable gap optimization (default: enabled)
  -dsp - disable sum of pairs optimization during refinement (default: enabled)
```

