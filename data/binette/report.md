# binette CWL Generation Report

## binette

### Tool Description
Binette 1.2.1: fast and accurate binning refinement tool to constructs high quality MAGs from the output of multiple binning tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/binette:1.2.1--pyh7e72e81_0
- **Homepage**: https://github.com/genotoul-bioinfo/binette
- **Package**: https://anaconda.org/channels/bioconda/packages/binette/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/binette/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2025-11-10
- **GitHub**: https://github.com/genotoul-bioinfo/binette
- **Stars**: N/A
### Original Help Text
```text
Usage: binette [OPTIONS]                                                       
                                                                                
 Binette 1.2.1: fast and accurate binning refinement tool to constructs high    
 quality MAGs from the output of multiple binning tools.                        
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --version            Show version and exit.                                  │
│ --help     -h        Show this message and exit.                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Input Arguments ────────────────────────────────────────────────────────────╮
│    --bin_dirs           -d      PATH  List of bin folders containing each    │
│                                       bin in a fasta file.                   │
│    --contig2bin_tables  -b      PATH  List of contig2bin tables with two     │
│                                       columns: contig, bin.                  │
│ *  --contigs            -c      PATH  Contigs in FASTA format. [required]    │
│    --proteins           -p      PATH  FASTA file of predicted proteins in    │
│                                       Prodigal format (>contigID_geneID).    │
│                                       Skips the gene prediction step if      │
│                                       provided.                              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Output and Runtime Control ─────────────────────────────────────────────────╮
│ --outdir            -o                         PATH     Output directory.    │
│                                                         [default: results]   │
│ --prefix                                       TEXT     Prefix to add to     │
│                                                         final bin names      │
│                                                         (e.g. '--prefix      │
│                                                         sample1' will        │
│                                                         produce              │
│                                                         'sample1_bin1.fa',   │
│                                                         'sample1_bin2.fa').  │
│                                                         [default: binette]   │
│ --threads           -t                         INTEGER  Number of threads to │
│                                                         use.                 │
│                                                         [default: 1]         │
│ --verbose           -v                                  Enable verbose mode  │
│                                                         (show detailed debug │
│                                                         information).        │
│ --quiet             -q                                  Enable quiet mode    │
│                                                         (only show warnings  │
│                                                         and errors).         │
│ --debug                 --no-debug                      Activate debug mode. │
│                                                         [default: no-debug]  │
│ --progress              --no-progress                   Show progress bar    │
│                                                         while fetching       │
│                                                         pangenomes (disable  │
│                                                         with --no-progress). │
│                                                         [default: progress]  │
│ --write-fasta-bins      --no-write-fasta-b…             Write final selected │
│                                                         bins as FASTA files  │
│                                                         (disable with        │
│                                                         --no-write-fasta-bi… │
│                                                         [default:            │
│                                                         write-fasta-bins]    │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Bin Filtering and Scoring ──────────────────────────────────────────────────╮
│ --min_completeness              INTEGER  Minimum completeness required for   │
│                                          intermediate bin creation and final │
│                                          bin selection.                      │
│                                          [default: 40]                       │
│ --max_contamination             INTEGER  Maximum contamination allowed for   │
│                                          intermediate bin creation and final │
│                                          bin selection.                      │
│                                          [default: 10]                       │
│ --min_length                    INTEGER  Minimum length (bp) required for    │
│                                          intermediate bin creation and final │
│                                          bin selection.                      │
│                                          [default: 200000]                   │
│ --max_length                    INTEGER  Maximum length (bp) allowed for     │
│                                          intermediate bin creation and final │
│                                          bin selection.                      │
│                                          [default: 10000000]                 │
│ --contamination_weight  -w      FLOAT    Bins are scored as: completeness -  │
│                                          weight * contamination. A lower     │
│                                          weight favors completeness over low │
│                                          contamination.                      │
│                                          [default: 2.0]                      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Advanced Options ───────────────────────────────────────────────────────────╮
│ --fasta_extensions  -e                 TEXT  FASTA file extensions to search │
│                                              for in bin directories (used    │
│                                              with --bin_dirs).               │
│                                              [default: .fasta, .fa, .fna]    │
│ --checkm2_db                           PATH  Path to CheckM2 diamond         │
│                                              database. By default the        │
│                                              database set via <checkm2       │
│                                              database> is used.              │
│ --low_mem                                    Enable low-memory mode for      │
│                                              Diamond.                        │
│ --resume                --no-resume          Resume mode: reuse existing     │
│                                              temporary files if possible.    │
│                                              [default: no-resume]            │
╰──────────────────────────────────────────────────────────────────────────────╯
```

