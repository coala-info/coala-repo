# sccmec CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sccmec | PASS |  |
| sccmec_sccmec-regions | PASS |  |
| sccmec_sccmec-targets | PASS |  |

## sccmec

### Tool Description
typing SCCmec cassettes in assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/sccmec:1.2.0--hdfd78af_0
- **Homepage**: https://github.com/rpetit3/sccmec
- **Package**: https://anaconda.org/channels/bioconda/packages/sccmec/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sccmec/overview
- **Total Downloads**: 2.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rpetit3/sccmec
- **Stars**: N/A
### Original Help Text
```text
Usage: sccmec-main [OPTIONS]                                                   
                                                                                
 sccmec - typing SCCmec cassettes in assemblies                                 
                                                                                
╭─ Required Options ───────────────────────────────────────────────────────────╮
│ *  --input         -i   TEXT  Input file in FASTA format to classify         │
│                               [required]                                     │
│ *  --yaml-targets  -yt  TEXT  YAML file documenting the targets and types    │
│                               [default:                                      │
│                               /usr/local/bin/../share/sccmec/sccmec-targets… │
│                               [required]                                     │
│ *  --yaml-regions  -yr  TEXT  YAML file documenting the regions and types    │
│                               [default:                                      │
│                               /usr/local/bin/../share/sccmec/sccmec-regions… │
│                               [required]                                     │
│ *  --targets       -t   TEXT  Query targets in FASTA format                  │
│                               [default:                                      │
│                               /usr/local/bin/../share/sccmec/sccmec-targets… │
│                               [required]                                     │
│ *  --regions       -r   TEXT  Query regions in FASTA format                  │
│                               [default:                                      │
│                               /usr/local/bin/../share/sccmec/sccmec-regions… │
│                               [required]                                     │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Filtering Options ──────────────────────────────────────────────────────────╮
│ --min-targets-pident      INTEGER  Minimum percent identity of targets to    │
│                                    count a hit                               │
│                                    [default: 90]                             │
│ --min-targets-coverage    INTEGER  Minimum percent coverage of targets to    │
│                                    count a hit                               │
│                                    [default: 80]                             │
│ --min-regions-pident      INTEGER  Minimum percent identity of regions to    │
│                                    count a hit                               │
│                                    [default: 85]                             │
│ --min-regions-coverage    INTEGER  Minimum percent coverage of regions to    │
│                                    count a hit                               │
│                                    [default: 83]                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────╮
│ --prefix   -p  TEXT  Prefix to use for output files [default: sccmec]        │
│ --outdir   -o  PATH  Directory to write output [default: ./]                 │
│ --force              Overwrite existing reports                              │
│ --verbose            Increase the verbosity of output                        │
│ --silent             Only critical errors will be printed                    │
│ --version            Print schema and camlhmp version                        │
│ --help               Show this message and exit.                             │
╰──────────────────────────────────────────────────────────────────────────────╯
```

## sccmec_sccmec-targets

### Tool Description
Classify SCCmec cassettes in assemblies using BLAST against individual genes (targets).

### Metadata
- **Docker Image**: quay.io/biocontainers/sccmec:1.2.0--hdfd78af_0
- **Homepage**: https://github.com/rpetit3/sccmec
- **Package**: https://anaconda.org/channels/bioconda/packages/sccmec/overview
- **Validation**: PASS

### Original Help Text
```text
                                                                                
 Usage: camlhmp-blast-targets [OPTIONS]                                         
                                                                                
 🐪 camlhmp-blast-targets 🐪 - Classify assemblies using BLAST against          
 individual genes or proteins                                                   
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input         -i  TEXT     Input file in FASTA format to classify       │
│                                 [required]                                   │
│ *  --yaml          -y  TEXT     YAML file documenting the targets and types  │
│                                 [default:                                    │
│                                 /usr/local/bin/../share/sccmec/sccmec-targe… │
│                                 [required]                                   │
│ *  --targets       -t  TEXT     Query targets in FASTA format                │
│                                 [default:                                    │
│                                 /usr/local/bin/../share/sccmec/sccmec-targe… │
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

## sccmec_sccmec-regions

### Tool Description
Classify SCCmec cassettes in assemblies using BLAST against larger genomic regions.

### Metadata
- **Docker Image**: quay.io/biocontainers/sccmec:1.2.0--hdfd78af_0
- **Homepage**: https://github.com/rpetit3/sccmec
- **Package**: https://anaconda.org/channels/bioconda/packages/sccmec/overview
- **Validation**: PASS

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
│                                 /usr/local/bin/../share/sccmec/sccmec-regio… │
│                                 [required]                                   │
│ *  --targets       -t  TEXT     Query targets in FASTA format                │
│                                 [default:                                    │
│                                 /usr/local/bin/../share/sccmec/sccmec-regio… │
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

