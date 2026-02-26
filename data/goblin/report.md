# goblin CWL Generation Report

## goblin

### Tool Description
Generate trusted prOteins to supplement BacteriaL annotatIoN

### Metadata
- **Docker Image**: quay.io/biocontainers/goblin:1.0.0--hdfd78af_0
- **Homepage**: https://github.com/rpetit3/goblin
- **Package**: https://anaconda.org/channels/bioconda/packages/goblin/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/goblin/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rpetit3/goblin
- **Stars**: N/A
### Original Help Text
```text
Usage: goblin [OPTIONS]                                                        
                                                                                
 Generate trusted prOteins to supplement BacteriaL annotatIoN                   
                                                                                
╭─ Required ───────────────────────────────────────────────────────────────────╮
│ *  --query     TEXT  Download genomes for a given query (organism, taxid,    │
│                      file of accessions)                                     │
│                      [required]                                              │
│ *  --prefix    TEXT  Prefix to use to save outputs [required]                │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ ncbi-genome-download ───────────────────────────────────────────────────────╮
│ --assembly_level    [all|complete|chromosome|s  Assembly levels of genomes   │
│                     caffold|contig|complete,ch  to download                  │
│                     romosome|chromosome,comple  [default: complete]          │
│                     te]                                                      │
│ --limit             INTEGER                     Maximum number of genomes to │
│                                                 download                     │
│                                                 [default: 100]               │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ CD-HIT ─────────────────────────────────────────────────────────────────────╮
│ --identity        FLOAT    CD-HIT (-c) sequence identity threshold           │
│                            [default: 0.9]                                    │
│ --overlap         FLOAT    CD-HIT (-s) length difference cutoff              │
│                            [default: 0.8]                                    │
│ --max_memory      INTEGER  CD-HIT (-M) memory limit (in MB) (0 removes       │
│                            memory limits)                                    │
│                            [default: 0]                                      │
│ --fast_cluster             Use CD-HIT (-g 0) fast clustering algorithm       │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --version                  Show the version and exit.                        │
│ --is_taxid                 Given taxid should be treated as a taxid (not a   │
│                            species taxid)                                    │
│ --outdir          TEXT     Directory to save output files [default: ./]      │
│ --force                    Overwrite existing files                          │
│ --compress                 Compress final clustered proteins and log file    │
│ --cpus            INTEGER  Number of cpus to use [default: 1]                │
│ --keep_files               Keep all downloaded and intermediate files        │
│ --debug                    Print additional debug information                │
│ --check                    Check dependencies are installed, then exit       │
│ --help        -h           Show this message and exit.                       │
╰──────────────────────────────────────────────────────────────────────────────╯
```

