# afragmenter CWL Generation Report

## afragmenter

### Tool Description
A tool for clustering and fragmenting protein structures based on AlphaFold PAE data using Leiden clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/afragmenter:0.0.6--pyhdfd78af_0
- **Homepage**: https://github.com/sverwimp/AFragmenter
- **Package**: https://anaconda.org/channels/bioconda/packages/afragmenter/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/afragmenter/overview
- **Total Downloads**: 663
- **Last updated**: 2025-09-29
- **GitHub**: https://github.com/sverwimp/AFragmenter
- **Stars**: N/A
### Original Help Text
```text
Usage: afragmenter [OPTIONS]                                                   
                                                                                
╭─ Input ──────────────────────────────────────────────────────────────────────╮
│ --json       -j  FILE  Path to the AlphaFold json file containing the PAE    │
│                        data [required: either --json or --afdb]              │
│ --structure  -s  FILE  Path to a PDB or mmCIF file containing the protein    │
│                        structure and sequence                                │
│ --afdb           TEXT  Uniprot identifier to fetch data from the AlphaFold   │
│                        database [required: either --json or --afdb]          │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Clustering options ─────────────────────────────────────────────────────────╮
│ --resolution          -r  FLOAT RANGE [x>0.0]  Resolution used with Leiden   │
│                                                clustering [default: 0.7 for  │
│                                                modularity, 0.3 for CPM]      │
│ --objective-function  -f  [modularity|cpm]     Objective function for Leiden │
│                                                clustering (not case          │
│                                                sensitive) [default:          │
│                                                modularity]                   │
│ --n-iterations        -n  INTEGER              Number of iterations for      │
│                                                Leiden clustering. Negative   │
│                                                values will run the algorithm │
│                                                until a stable iteration is   │
│                                                reached [default: -1]         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Fine tuning ────────────────────────────────────────────────────────────────╮
│ --threshold    -t  FLOAT RANGE [0.0<=x<=31.75]  Contrast thresold for the    │
│                                                 PAE values. This is a soft   │
│                                                 cut-off point to increase    │
│                                                 the contrast between low and │
│                                                 high PAE values. Values near │
│                                                 the threshold will           │
│                                                 transition more smoothly.    │
│                                                 [default: 2]                 │
│ --min-avg-pae      FLOAT RANGE [0.0<=x<=31.75]  Minimum average PAE for a    │
│                                                 cluster to be kept.          │
│                                                 [default: (None)]            │
│ --min-size     -m  INTEGER RANGE [x>=0]         Minimum size of partition to │
│                                                 be considered. Attempts to   │
│                                                 merge partitions that are    │
│                                                 too small with adjecent      │
│                                                 larger ones. Set to 0 to     │
│                                                 keep all partitions.         │
│                                                 [default: 10]                │
│ --no-merge                                      Do not attempt to merge      │
│                                                 small partitions with larger │
│                                                 paritions, just discard them │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Outputs ────────────────────────────────────────────────────────────────────╮
│ --save-result  FILE  Path to save the result table (csv) file. If not set,   │
│                      the result will be printed to the console               │
│ --plot-result  FILE  Path to save the result plot                            │
│ --save-fasta   FILE  Path to save the output fasta file (requires            │
│                      --structure if using --json)                            │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Misc ───────────────────────────────────────────────────────────────────────╮
│ --name  -N  TEXT  Name used to format fasta header and first column of the   │
│                   result table. Will be parsed from the structure file (if   │
│                   available) if set to 'auto'. Set to '' or "" to only show  │
│                   the cluster numbers. [default: auto]                       │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help     -h  Show this message and exit.                                   │
│ --version  -v  Show the version and exit.                                    │
╰──────────────────────────────────────────────────────────────────────────────╯
```

