# local-cd-search CWL Generation Report

## local-cd-search_annotate

### Tool Description
Run the annotation pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/local-cd-search:0.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/apcamargo/local-cd-search
- **Package**: https://anaconda.org/channels/bioconda/packages/local-cd-search/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/local-cd-search/overview
- **Total Downloads**: 267
- **Last updated**: 2026-01-16
- **GitHub**: https://github.com/apcamargo/local-cd-search
- **Stars**: N/A
### Original Help Text
```text
Usage: local-cd-search annotate [OPTIONS] INPUT_FILE OUTPUT_FILE DB_DIR        
                                                                                
 Run the annotation pipeline.                                                   
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --evalue        -e  FLOAT RANGE [x>=0]  Maximum allowed E-value for hits.    │
│                                         [default: 0.01]                      │
│ --ns                                    Include non-specific hits in the     │
│                                         output results table.                │
│ --sf                                    Include superfamily hits in the      │
│                                         output results table.                │
│ --gs                                    Include generic site hits in the     │
│                                         output sites table.                  │
│ --quiet                                 Suppress non-error console output.   │
│ --tmp-dir           DIRECTORY           Directory to store intermediate      │
│                                         files. If not specified, temporary   │
│                                         files will be deleted after          │
│                                         execution.                           │
│ --threads           INTEGER             Number of threads to use for         │
│                                         rpsblast. [default: 0]               │
│ --data-mode     -m  [std|rep|full]      Redundancy level of domain hit data  │
│                                         passed to rpsbproc. 'rep' (best      │
│                                         model per region of the query),      │
│                                         'std' (best model per source per     │
│                                         region of the query), 'full' (all    │
│                                         models meeting E-value               │
│                                         significance). [default: std]        │
│ --sites-output  -s  PATH                Path to write functional site        │
│                                         annotations.                         │
│ --help          -h                      Show this message and exit.          │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## local-cd-search_download

### Tool Description
Download one or more PSSM databases and CDD metadata into DB_DIR.

### Metadata
- **Docker Image**: quay.io/biocontainers/local-cd-search:0.3.1--pyhdfd78af_0
- **Homepage**: https://github.com/apcamargo/local-cd-search
- **Package**: https://anaconda.org/channels/bioconda/packages/local-cd-search/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:                                                                         
 local-cd-search download                                                       
 [OPTIONS] DB_DIR {cdd|cdd_ncbi|cog|kog|pfam|prk|smart|tigr}...                 
                                                                                
 Download one or more PSSM databases and CDD metadata into DB_DIR.              
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --force      Force re-download even if files are present.                    │
│ --quiet      Suppress non-error console output.                              │
│ --help   -h  Show this message and exit.                                     │
╰──────────────────────────────────────────────────────────────────────────────╯
```

