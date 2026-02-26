# cawlign CWL Generation Report

## cawlign

### Tool Description
perform a pairwise alignment between a reference sequence and a set of other sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/cawlign:0.1.16--he91c24d_0
- **Homepage**: https://github.com/veg/cawlign
- **Package**: https://anaconda.org/channels/bioconda/packages/cawlign/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cawlign/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2026-01-15
- **GitHub**: https://github.com/veg/cawlign
- **Stars**: N/A
### Original Help Text
```text
usage: cawlign [-h] [-v] [-o OUTPUT] [-r REFERENCE] [-s SCORE] [-t DATATYPE] [-c GENETIC_CODE] [-l LOCAL_ALIGNMENT] [-f FORMAT] [-S SPACE] [-a] [-q] [-I] [-R] [FASTA]

perform a pairwise alignment between a reference sequence and a set of other sequences

optional arguments:
  -h, --help               show this help message and exit
  -v, --version            show "cawlign" version 
  -o OUTPUT                direct the output to a file named OUTPUT (default=stdout)
  -r REFERENCE             read the reference sequence from this file (default="HXB2_pol")
                           first checks to see if the filepath exists, if not looks inside the res/references directory
                           relative to the install path (/usr/local/share/cawlign by default).
                           If not a file, it is treated as a literal sequence.
  -s SCORE                 read the scoring matrices and options from this file (default="Nucleotide-BLAST")
                           first checks to see if the filepath exists, if not looks inside the res/scoring directory
                           relative to the install path (/usr/local/share/cawlign by default)
                           see INSERT URL later for how to read and create alignment scoring files
  -t DATATYPE              datatype (default=nucleotide)
                           nucleotide : align sequences in the nucleotide space;
                           protein    : align sequences in the protein space;
                           codon: align sequences in the codon space (reference must be in frame; stop codons are defined in the scoring file);
  -c GENETIC_CODE          genetic code identifier (NCBI code like 1, 2, 4, or a name like standard);
  -R REVERSE_COMPLEMENT    options of reverse complementation [rc] (default=none)
                           none       : do not consider reverse complements of sequences;
                           silent     : align both the sequence and its rc to the reference, select the one with the highest score and report it;
                           annotated  : align both the sequence and its rc to the reference, select the one with the highest score and report it
                                        annotate sequences whose reverse complements were reported in the FASTA by appending '|RC' to the sequence name;
  -l LOCAL_ALIGNMENT       global/local alignment (default=trim)
                           global : full string alignment; all gaps in the alignments are scored the same
                           local  : partial string local (smith-waterman type) alignment which maximizes the alignment score
  -f FORMAT                controls the format of the output (default=refmap)
                           refmap   : aligns query sequences to the reference and does NOT retain instertions relative to the reference;
                           refalign : aligns query sequences to the reference and DOES retain instertions relative to the reference;
                                      no MSA is generated, but rather individual alignments to reference with likely different lengths are reported ;
                           pairwise : aligns query sequences to the reference and DOES retain instertions relative to the reference;
                                      no MSA is generated, but rather pair-wise alignments are all reported (2x the number of sequences);
  -S SPACE                 which version of the algorithm to use (an integer >0, default=quadratic):
                           quadratic : build the entire dynamic programming matrix (NxM);
                           linear    : use the divide and conquer recursion to keep only 6 columns in memory (~ max (N,M));
                                       NOT IMPLEMENTED FOR CODON DATA
  -a                       do NOT use affine gap scoring (use by default)
  -I                       write out the reference sequence for refmap and refalign output options (default = no) 
  FASTA                    read sequences to compare from this file (default=stdin)
```

