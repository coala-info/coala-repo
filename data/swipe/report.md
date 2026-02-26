# swipe CWL Generation Report

## swipe

### Tool Description
SWIPE 2.1.1 [Dec 14 2024 05:52:37]

Reference: T. Rognes (2011) Faster Smith-Waterman database searches
with inter-sequence SIMD parallelisation, BMC Bioinformatics, 12:221.

### Metadata
- **Docker Image**: quay.io/biocontainers/swipe:2.1.1--hf1d56f0_5
- **Homepage**: http://dna.uio.no/swipe
- **Package**: https://anaconda.org/channels/bioconda/packages/swipe/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/swipe/overview
- **Total Downloads**: 16.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/torognes/swipe
- **Stars**: N/A
### Original Help Text
```text
SWIPE 2.1.1 [Dec 14 2024 05:52:37]

Reference: T. Rognes (2011) Faster Smith-Waterman database searches
with inter-sequence SIMD parallelisation, BMC Bioinformatics, 12:221.

Usage: swipe [OPTIONS]
  -h, --help                 show help
  -d, --db=FILE              sequence database base name (required)
  -i, --query=FILE           query sequence filename (stdin)
  -M, --matrix=NAME/FILE     score matrix name or filename (BLOSUM62)
  -q, --penalty=NUM          penalty for nucleotide mismatch (-3)
  -r, --reward=NUM           reward for nucleotide match (1)
  -G, --gapopen=NUM          gap open penalty (11)
  -E, --gapextend=NUM        gap extension penalty (1)
  -v, --num_descriptions=NUM sequence descriptions to show (250)
  -b, --num_alignments=NUM   sequence alignments to show (100)
  -e, --evalue=REAL          maximum expect value of sequences to show (10.0)
  -k, --minevalue=REAL       minimum expect value of sequences to show (0.0)
  -c, --min_score=NUM        minimum score of sequences to show (1)
  -u, --max_score=NUM        maximum score of sequences to show (inf.)
  -a, --num_threads=NUM      number of threads to use [1-256] (1)
  -m, --outfmt=NUM           output format [0,7-9=plain,xml,tsv,tsv+] (0)
  -I, --show_gis             show gi numbers in results (no)
  -p, --symtype=NAME/NUM     symbol type/translation [0-4] (1)
  -S, --strand=NAME/NUM      query strands to search [1-3] (3)
  -Q, --query_gencode=NUM    query genetic code [1-23] (1)
  -D, --db_gencode=NUM       database genetic code [1-23] (1)
  -x, --taxidlist=FILE       taxid list filename (none)
  -N, --dump=NUM             dump database [0-2=no,yes,split headers] (0)
  -H, --show_taxid           show taxid etc in results (no)
  -o, --out=FILE             output file (stdout)
  -z, --dbsize=NUM           set effective database size (0)
```

