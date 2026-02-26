# seqwin CWL Generation Report

## seqwin

### Tool Description
Seqwin is a tool for identifying and analyzing genomic sequences based on taxonomic and path-based filtering, with options for controlling k-mer analysis, output generation, and NCBI data downloads.

### Metadata
- **Docker Image**: quay.io/biocontainers/seqwin:0.2.2--pyhdfd78af_1
- **Homepage**: https://github.com/treangenlab/seqwin
- **Package**: https://anaconda.org/channels/bioconda/packages/seqwin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seqwin/overview
- **Total Downloads**: 351
- **Last updated**: 2026-02-22
- **GitHub**: https://github.com/treangenlab/seqwin
- **Stars**: N/A
### Original Help Text
```text
Usage: seqwin [OPTIONS]                                                        
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --tar-taxa       -t      TEXT     Target NCBI taxonomy name / ID. Must be    │
│                                   exact match. Repeat the option to pass     │
│                                   multiple values (-t <tax1> -t <tax2> ...). │
│ --neg-taxa       -n      TEXT     Non-target NCBI taxonomy name / ID. Must   │
│                                   be exact match. Repeat the option to pass  │
│                                   multiple values (-n <tax1> -n <tax2> ...). │
│ --tar-paths              PATH     A text file of paths to target genomes in  │
│                                   FASTA format (gzip supported), with one    │
│                                   path per line.                             │
│ --neg-paths              PATH     A text file of paths to non-target genomes │
│                                   in FASTA format (gzip supported), with one │
│                                   path per line.                             │
│ --prefix                 PATH     Path prefix for the output directory. Use  │
│                                   the current directory by default.          │
│                                   [default: /]                               │
│ --title          -o      TEXT     Name of the output directory.              │
│                                   [default: seqwin-out]                      │
│ --overwrite                       Overwrite existing output files.           │
│ --kmerlen        -k      INTEGER  K-mer length. [default: 21]                │
│ --windowsize     -w      INTEGER  Window size for minimizer sketch.          │
│                                   [default: 200]                             │
│ --penalty-th             FLOAT    Node penalty threshold (0-1).              │
│                                   Automatically computed if not provided.    │
│ --no-mash                         Do NOT run Mash to estimate node penalty   │
│                                   threshold. Instead, use minimizer sketches │
│                                   (faster but might be biased). Used only if │
│                                   --penalty-th is not provided (auto mode).  │
│ --stringency     -s      INTEGER  Stringency level (0-10) for the            │
│                                   sensitivity and specificity of output      │
│                                   signatures. Higher levels result in lower  │
│                                   estimated node penalty thresholds. Used    │
│                                   only if --penalty-th is not provided (auto │
│                                   mode).                                     │
│                                   [default: 5]                               │
│ --min-len                INTEGER  Min length of output signatures.           │
│                                   [default: 200]                             │
│ --max-len                INTEGER  Max length of output signatures            │
│                                   (estimated). No explicit limit if not      │
│                                   provided.                                  │
│ --no-blast                        Do NOT evaluate (BLAST) signature          │
│                                   sequences.                                 │
│ --seed                   INTEGER  Random seed for reproducibility.           │
│                                   [default: 42]                              │
│ --threads        -p      INTEGER  Number of parallel processes (CPU cores)   │
│                                   to use.                                    │
│                                   [default: 4]                               │
│ --level                  TEXT     NCBI download option. Limit to genomes ≥   │
│                                   this assembly level (contig < scaffold <   │
│                                   chromosome < complete).                    │
│                                   [default: contig]                          │
│ --source                 TEXT     NCBI download option. Genome source        │
│                                   ('genbank' or 'refseq').                   │
│                                   [default: genbank]                         │
│ --annotated                       NCBI download option. Only include         │
│                                   annotated genomes.                         │
│ --exclude-mag                     NCBI download option. Exclude              │
│                                   metagenome-assembled genomes (MAGs).       │
│ --no-gzip                         NCBI download option. Do NOT download      │
│                                   genomes as gzipped FASTA.                  │
│ --download-only                   Only download genome sequences without     │
│                                   running Seqwin.                            │
│ --version                         Show Seqwin version and exit.              │
│ --help           -h               Show this message and exit.                │
╰──────────────────────────────────────────────────────────────────────────────╯
```

