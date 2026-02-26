# vapor CWL Generation Report

## vapor_vapor.py

### Tool Description
Do some viral classification!

### Metadata
- **Docker Image**: quay.io/biocontainers/vapor:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/connor-lab/vapor
- **Package**: https://anaconda.org/channels/bioconda/packages/vapor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vapor/overview
- **Total Downloads**: 2.4K
- **Last updated**: 2025-08-28
- **GitHub**: https://github.com/connor-lab/vapor
- **Stars**: N/A
### Original Help Text
```text
usage: vapor.py [-h] [--return_seqs | -o [OUTPUT_PREFIX]] [-q]
                [--return_best_n RETURN_BEST_N] [-m [MIN_KMER_PROP]] [-k [K]]
                [-t [THRESHOLD]] [-c [MIN_KMER_COV]] [-fa FA]
                [-fq FQ [FQ ...]] [-s [SUBSAMPLE]] [-dbg [DEBUG_QUERY]]
                [-f [TOP_SEED_FRAC]] [--nocache] [-v] [--low_mem]

Do some viral classification!

options:
  -h, --help            show this help message and exit
  --return_seqs
  -o, --output_prefix [OUTPUT_PREFIX]
                        Prefix to write full output to, stout by default
  -q, --quiet
  --return_best_n RETURN_BEST_N
  -m, --min_kmer_prop [MIN_KMER_PROP]
                        Minimum proportion of matched kmers allowed for
                        queries [default=0.1]
  -k [K]                Kmer Length [5 > int > 30, default=21]
  -t, --threshold [THRESHOLD]
                        Read kmer filtering threshold [0 > float > 1,
                        default=0.2]
  -c, --min_kmer_cov [MIN_KMER_COV]
                        Minimum coverage kmer culling [default=5]
  -fa FA                Fasta file
  -fq FQ [FQ ...]       Fastq file/files
  -s, --subsample [SUBSAMPLE]
                        Number of reads to subsample [default=all reads]
  -dbg, --debug_query [DEBUG_QUERY]
                        Debug query [default=all reads]
  -f, --top_seed_frac [TOP_SEED_FRAC]
                        Fraction of best seeds to extend [default=0.2]
  --nocache
  -v, --version
  --low_mem
```

