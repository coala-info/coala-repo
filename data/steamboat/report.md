# steamboat CWL Generation Report

## steamboat_gisaid-batch

### Tool Description
Format data for GISAID submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/steamboat:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/rpetit3/steamboat-py
- **Package**: https://anaconda.org/channels/bioconda/packages/steamboat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/steamboat/overview
- **Total Downloads**: 270
- **Last updated**: 2025-08-11
- **GitHub**: https://github.com/rpetit3/steamboat-py
- **Stars**: N/A
### Original Help Text
```text
Usage: gisaid-batch [OPTIONS]                                                  
                                                                                
 gisaid-batch - Format data for GISAID submission.                              
                                                                                
╭─ Required Options ───────────────────────────────────────────────────────────╮
│ *  --results     -r  TEXT                        A CSV or TSV file with the  │
│                                                  results of pipeline         │
│                                                  analysis                    │
│                                                  [required]                  │
│ *  --assemblies  -a  TEXT                        Directory of FASTA          │
│                                                  assemblies to be uploaded   │
│                                                  [required]                  │
│ *  --metadata    -m  TEXT                        A TSV or CSV file of        │
│                                                  metadata associated with    │
│                                                  input samples               │
│                                                  [required]                  │
│ *  --sequencer   -s  [clearlabs|iseq|hiseq|mise  Sequencer used to generate  │
│                      q|nextseq|ont]              sequences.                  │
│                                                  [required]                  │
│ *  --yaml        -y  TEXT                        A YAML formatted file       │
│                                                  containing constant         │
│                                                  information for GISAID      │
│                                                  fields.                     │
│                                                  [required]                  │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Filtering Options ──────────────────────────────────────────────────────────╮
│ --min-coverage    FLOAT    Minimum percent coverage to count a hit           │
│                            [default: 70.0]                                   │
│ --max-ns          INTEGER  Minimum percent identity to count a hit           │
│                            [default: 7500]                                   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────╮
│ --prefix   -p  TEXT  Prefix to use for output files [default: gisaid-batch]  │
│ --outdir   -o  PATH  Directory to write output [default: ./]                 │
│ --force              Overwrite existing reports                              │
│ --verbose            Increase the verbosity of output                        │
│ --silent             Only critical errors will be printed                    │
│ --version            Print version                                           │
│ --help               Show this message and exit.                             │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --pipeline       -p  [cecret|titan]  Pipeline used for analysis.             │
│                                      [default: cecret]                       │
│ --extension      -e  TEXT            The extension used for assemblies.      │
│                                      [default: consensus.fa]                 │
│ --sample-prefix      TEXT            Add this to the beginning on sample     │
│                                      names in the metadata file.             │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## steamboat_nwss-batch

### Tool Description
Format data for NWSS submission.

### Metadata
- **Docker Image**: quay.io/biocontainers/steamboat:1.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/rpetit3/steamboat-py
- **Package**: https://anaconda.org/channels/bioconda/packages/steamboat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: nwss-batch [OPTIONS]                                                    
                                                                                
 nwss-batch - Format data for NWSS submission.                                  
                                                                                
╭─ Required Options ───────────────────────────────────────────────────────────╮
│ *  --results  -r  TEXT  A TSV (or CSV) file with the dPCR results [required] │
│ *  --yaml     -y  TEXT  A YAML formatted file containing constant            │
│                         information for NWSS fields.                         │
│                         [required]                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Additional Options ─────────────────────────────────────────────────────────╮
│ --prefix   -p  TEXT  Prefix to use for output files [default: nwss-batch]    │
│ --outdir   -o  PATH  Directory to write output [default: ./]                 │
│ --force              Overwrite existing reports                              │
│ --verbose            Increase the verbosity of output                        │
│ --silent             Only critical errors will be printed                    │
│ --version            Print version                                           │
│ --help               Show this message and exit.                             │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
