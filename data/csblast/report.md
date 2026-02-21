# csblast CWL Generation Report

## csblast

### Tool Description
Search with an amino acid sequence against protein databases for locally similar sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/csblast:2.2.3--h9948957_4
- **Homepage**: http://wwwuser.gwdg.de/~compbiol/data/csblast/
- **Package**: https://anaconda.org/channels/bioconda/packages/csblast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/csblast/overview
- **Total Downloads**: 7.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
csblast version 2.2.3
Search with an amino acid sequence against protein databases for locally similar sequences.
Angermueller C, Biegert A, and Soeding J (2012), 
"Discriminative modelling of context-specific amino acid substitution probabilities", 
Bioinformatics, 28 (24), 3240-3247.
Biegert A, and Soeding J (2009), 
"Sequence context-specific profiles for homology searching", 
Proc Natl Acad Sci USA, 106 (10), 3770-3775.
Copyright (c) 2010-2013 Angermueller C, Biegert A, Soeding J, and LMU Munich

Usage: csblast -i <queryfile> -D <contextdata> --blast-path <psiblastdir> [options] [blastpgp options]

Options:
  -i, --infile <file>            Input file with query sequence
  -D, --context-data <file>      Path to profile library with context profiles
  -o, --outfile <file>           Output file with search results (def=stdout)
  -B, --alifile <file>           Input alignment file for CSI-BLAST restart
  -d, --database <dbname>        Protein database to search against (def=nr)
  -j, --iters [1,inf[            Maximum number of iterations to use in CSI-BLAST (def=1)
  -h, --incl-evalue [0,inf[      E-value threshold for inclusion in  CSI-BLAST (def=0.0020)
  -v, --descr [1,inf[            Number of sequences to show one-line descriptions for (def=500)
  -b, --alis [1,inf[             Number of sequences to show alignments for (def=250)
  -x, --pc-admix ]0,1]           Pseudocount admix for context-specific pseudocounts (def=0.90)
  -z, --pc-neff [1,inf[          Target Neff for pseudocounts admixture (def=0.00)
  -c, --pc-ali [0,inf[           Constant for alignment pseudocounts in CSI-BLAST (def=12.0)
      --pc-engine crf|lib        Specify engine for pseudocount generation (def=auto)
      --alignhits <file>         Write multiple alignment of hits in PSI format to file
      --weight-center [0,inf[    Weight of central profile column (def=1.60)
      --weight-decay [0,inf[     Parameter for exponential decay of window weights (def=0.85)
      --global-weights           Use global instead of position-specific sequence weights (def=off)
      --best                     Include only the best HSP per hit in alignment (def=off)
      --blast-path <path>        Path to directory with blastpgp executable (or set BLAST_PATH)
      --shift [-1,1]             Substitution score offset (def=-0.005)
```


## Metadata
- **Skill**: generated
