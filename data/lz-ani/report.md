# lz-ani CWL Generation Report

## lz-ani_all2all

### Tool Description
Tool for rapid determination of similarities among sets of DNA sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/lz-ani:1.2.3--h9ee0642_0
- **Homepage**: https://github.com/refresh-bio/lz-ani
- **Package**: https://anaconda.org/channels/bioconda/packages/lz-ani/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lz-ani/overview
- **Total Downloads**: 1.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/refresh-bio/lz-ani
- **Stars**: N/A
### Original Help Text
```text
Unknown parameter: --help
lz-ani 1.2.3 (2024-11-02) by Sebastian Deorowicz, Adam Gudys
Tool for rapid determination of similarities among sets of DNA sequences
Usage:
lz-ani <mode> [options]
Modes:
  all2all                        - all to all
Options - input specification:
      --in-fasta <file_name>     - FASTA file (for multisample-fasta mode)
      --in-txt <file_name>       - text file with FASTA file names
      --in-dir <path>            - directory with FASTA files
      --multisample-fasta <bool> - multi sample FASTA input (default: true)
      --flt-kmerdb <fn> <float>  - filtering file (kmer-db output) and threshold
Options - output specification:
  -o, --out <file_name>          - output file name
      --out-ids <file_name>      - output file name for ids file (optional)
      --out-alignment <file_name>- output file name for ids file (optional)
      --out-in-percent <bool>    - output in percent (default: false)
      --out-type <type>          - one of:
                                   tsv - two tsv files with: results defined by --out-format and sequence ids (default)
                                   single-txt - combined results in single txt file
      --out-format <type>        - comma-separated list of values: 
                                   query,reference,qidx,ridx,qlen,rlen,tani,gani,ani,qcov,rcov,len_ratio,nt_match,nt_mismatch,num_alns
                                   you can include also meta-names:
                                   complete=qidx,ridx,query,reference,tani,gani,ani,qcov,rcov,num_alns,len_ratio,qlen,rlen,nt_match,nt_mismatch
                                   lite=qidx,ridx,tani,gani,ani,qcov,num_alns,len_ratio
                                   standard=qidx,ridx,query,reference,tani,gani,ani,qcov,num_alns,len_ratio
                                   (default: standard)
      --out-filter <par> <float> - store only results with <par> (can be: tani, gani, ani, cov) at least <float>; can be used multiple times
Options - LZ-parsing-related:
  -a, --mal <int>                - min. anchor length (default: 11)
  -s, --msl <int>                - min. seed length (default: 7)
  -r, --mrd <int>                - max. dist. between approx. matches in reference (default: 40)
  -q, --mqd <int>                - max. dist. between approx. matches in query (default: 40)
  -g, --reg <int>                - min. considered region length (default: 35)
      --aw <int>                 - approx. window length (default: 15)
      --am <int>                 - max. no. of mismatches in approx. window (default: 7)
      --ar <int>                 - min. length of run ending approx. extension (default: 3)
Options - other:
  -t, --threads <int>            - no of threads; 0 means auto-detect (default: 0)
  -V, --verbose <int>            - verbosity level (default: 1)
```

