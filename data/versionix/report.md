# versionix CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| versionix | PASS | versionix --registered lists the registered tools (DESeq2, aragorn, art_illumina, ...); versionix python prints 3.13.5, the Python version in the image |

## versionix

### Tool Description
Versionix returns the version of bioinformatics software.

### Metadata
- **Docker Image**: quay.io/biocontainers/versionix:0.99.3--pyhdfd78af_0
- **Homepage**: https://github.com/sequana/versionix
- **Package**: https://anaconda.org/channels/bioconda/packages/versionix/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: versionix [OPTIONS] [STANDALONE]                                        
                                                                                
 Versionix returns the version of bioinformatics software.                      
 ────────────────────────────────────────────────────────────────────────────── 
                                                                                
  versionix fastqc                                                              
                                                                                
                                                                                
 You can check the list of registered tools as follows                          
                                                                                
                                                                                
  versionix --registered                                                        
                                                                                
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ STANDALONE    TEXT  (TEXT)                                                   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --version                                     Show the version and exit.     │
│ --registered                                  Prints the list of registered  │
│                                               tools                          │
│ --logger-level    [INFO|DEBUG|WARNING|ERROR]  level for debugging            │
│                                               (INFO|DEBUG|WARNING|ERROR)     │
│ --help                                        Show this message and exit.    │
╰──────────────────────────────────────────────────────────────────────────────╯
```

