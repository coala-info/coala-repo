# slncky CWL Generation Report

## slncky

### Tool Description
sLNCky: a lncRNA discovery software for lncRNA annotation and ortholog discovery.

### Metadata
- **Docker Image**: quay.io/biocontainers/slncky:1.0.4--1
- **Homepage**: https://github.com/slncky/slncky
- **Package**: https://anaconda.org/channels/bioconda/packages/slncky/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/slncky/overview
- **Total Downloads**: 9.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/slncky/slncky
- **Stars**: N/A
### Original Help Text
```text
usage: slncky [-h] [--config CONFIG] [--no_orth_search] [--no_filter]
              [--overwrite] [--threads THREADS] [--min_overlap MIN_OVERLAP]
              [--min_cluster MIN_CLUSTER] [--min_coding MIN_CODING]
              [--no_overlap] [--no_collapse] [--no_dup] [--no_self]
              [--no_coding] [--min_noncoding MIN_NONCODING] [--no_bg]
              [--no_orf] [--bedtools BEDTOOLS] [--liftover LIFTOVER]
              [--minMatch MINMATCH] [--pad PAD] [--lastz LASTZ]
              [--gap_open GAP_OPEN] [--gap_extend GAP_EXTEND] [--web]
              bedfile assembly out_prefix

sLNCky: a lncRNA discovery software for lncRNA annotation and ortholog
discovery.

positional arguments:
  bedfile               bed12 file of transcripts
  assembly              assembly
  out_prefix            out_prefix

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG, -c CONFIG
                        path to assembly.config file. default uses config file
                        in same directory as slncky
  --no_orth_search, -1  flag if you only want to filter lncs but don't want to
                        search for orthologs
  --no_filter, -2       flag if you don't want lncs to be filtered before
                        searching for ortholog
  --overwrite, -o       forces overwrite of out_prefix.bed
  --threads THREADS, -n THREADS
                        number of threads. default = 5
  --min_overlap MIN_OVERLAP
                        remove any transcript that overlap annotated coding
                        gene > min_overlap%. default = 0%
  --min_cluster MIN_CLUSTER
                        min size of duplication clusters to remove. default=2
  --min_coding MIN_CODING
                        min exonic identity to filter out transcript that
                        aligns to orthologous coding gene. default is set by
                        learning coding alignment distribution from data
  --no_overlap          flag if you don't want to overlap with coding
  --no_collapse         flag if you don't want to collapse isoforms
  --no_dup              flag if don't want to align to duplicates
  --no_self             flag if you don't want to self-align for duplicates
  --no_coding           flag if you don't want to align to orthologous coding
  --min_noncoding MIN_NONCODING
                        min exonic identity to filter out transcript that
                        aligns to orthologous noncoding gene. default=0
  --no_bg               flag if you don't want to compare lnc-to-ortholog
                        alignments to a background. This flag may be useful if
                        you want to do a 'quick-and-dirty' run of the ortholog
                        search.
  --no_orf              flag if you don't want to search for orfs
  --bedtools BEDTOOLS   path to bedtools
  --liftover LIFTOVER   path to liftOver
  --minMatch MINMATCH   minMatch parameter for liftover. default=0.1
  --pad PAD             # of basepairs to search up- and down-stream when
                        lifting over lnc to ortholog
  --lastz LASTZ         path to lastz
  --gap_open GAP_OPEN
  --gap_extend GAP_EXTEND
  --web                 flag for if you want slncky to create a website
                        visualizing results
```


## Metadata
- **Skill**: generated
