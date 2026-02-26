# pasty CWL Generation Report

## pasty

### Tool Description
Classify assemblies using BLAST against larger genomic regions

### Metadata
- **Docker Image**: quay.io/biocontainers/pasty:2.2.1--hdfd78af_0
- **Homepage**: https://github.com/rpetit3/pasty
- **Package**: https://anaconda.org/channels/bioconda/packages/pasty/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pasty/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rpetit3/pasty
- **Stars**: N/A
### Original Help Text
```text
Usage: camlhmp-blast-regions [OPTIONS]                                         
                                                                                
 🐪 camlhmp-blast-regions 🐪 - Classify assemblies using BLAST against larger   
 genomic regions                                                                
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input         -i  TEXT     Input file in FASTA format to classify       │
│                                 [required]                                   │
│ *  --yaml          -y  TEXT     YAML file documenting the targets and types  │
│                                 [default:                                    │
│                                 /usr/local/bin/../share/pasty/pa-osa.yaml]   │
│                                 [required]                                   │
│ *  --targets       -t  TEXT     Query targets in FASTA format                │
│                                 [default:                                    │
│                                 /usr/local/bin/../share/pasty/pa-osa.fasta]  │
│                                 [required]                                   │
│    --outdir        -o  PATH     Directory to write output [default: ./]      │
│    --prefix        -p  TEXT     Prefix to use for output files               │
│                                 [default: camlhmp]                           │
│    --min-pident        INTEGER  Minimum percent identity to count a hit      │
│                                 [default: 95]                                │
│    --min-coverage      INTEGER  Minimum percent coverage to count a hit      │
│                                 [default: 95]                                │
│    --force                      Overwrite existing reports                   │
│    --verbose                    Increase the verbosity of output             │
│    --silent                     Only critical errors will be printed         │
│    --version                    Print schema and camlhmp version             │
│    --help                       Show this message and exit.                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```

