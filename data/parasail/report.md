# parasail CWL Generation Report

## parasail

### Tool Description
FAIL to generate CWL: parasail not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/parasail:2.6.2--h5ca1c30_1
- **Homepage**: https://github.com/jeffdaily/parasail
- **Package**: https://anaconda.org/channels/bioconda/packages/parasail/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/parasail/overview
- **Total Downloads**: 3.0K
- **Last updated**: 2025-05-10
- **GitHub**: https://github.com/jeffdaily/parasail
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: parasail not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: parasail not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## parasail_parasail_aligner

### Tool Description
Sequence alignment tool using the parasail library

### Metadata
- **Docker Image**: quay.io/biocontainers/parasail:2.6.2--h5ca1c30_1
- **Homepage**: https://github.com/jeffdaily/parasail
- **Package**: https://anaconda.org/channels/bioconda/packages/parasail/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image

usage: parasail_aligner [-a funcname] [-c cutoff] [-x] [-e gap_extend] [-o gap_open] [-m matrix] [-t threads] [-d] [-M match] [-X mismatch] [-k band size (for nw_banded)] [-l AOL] [-s SIM] [-i OS] [-v] [-V] -f file [-q query_file] [-g output_file] [-O output_format {EMBOSS,SAM,SAMH,SSW}] [-b batch_size] [-r memory_budget] [-C] [-A alphabet_aliases] 

Defaults:
        funcname: sw_stats_striped_16
          cutoff: 7, must be >= 1, exact match length cutoff
              -x: if present, don't use suffix array filter
      gap_extend: 1, must be >= 0
        gap_open: 10, must be >= 0
          matrix: blosum62
              -d: if present, assume DNA alphabet ACGT
           match: 1, must be >= 0
        mismatch: 0, must be >= 0
      threads: system-specific default, must be >= 1
             AOL: 80, must be 0 <= AOL <= 100, percent alignment length
             SIM: 40, must be 0 <= SIM <= 100, percent exact matches
              OS: 30, must be 0 <= OS <= 100, percent optimal score
                                              over self score
              -v: verbose output, report input parameters and timing
              -V: verbose memory output, report memory use
            file: no default, must be in FASTA format
      query_file: no default, must be in FASTA format
     output_file: parasail.csv
   output_format: no default, must be one of {EMBOSS,SAM,SAMH,SSW}
      batch_size: 0 (calculate based on memory budget),
                  how many alignments before writing output
   memory_budget: 2GB or half available from system query (100.672 GB)
              -C: if present, use case sensitive alignments, matrices, etc.
alphabet_aliases: traceback will treat these pairs of characters as matches,
                  for example, 'TU' for one pair, or multiple pairs as 'XYab'
```

