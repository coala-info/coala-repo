# microview CWL Generation Report

## microview

### Tool Description
MicroView, a reporting tool for taxonomic classification
MicroView agreggates reports from taxonomic classification tools, such as
Kaiju and Kraken.

### Metadata
- **Docker Image**: quay.io/biocontainers/microview:0.11.0--py312h031d066_0
- **Homepage**: https://github.com/jvfe/microview
- **Package**: https://anaconda.org/channels/bioconda/packages/microview/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/microview/overview
- **Total Downloads**: 1.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jvfe/microview
- **Stars**: N/A
### Original Help Text
```text
Usage: microview [OPTIONS]                                                     
                                                                                
 MicroView, a reporting tool for taxonomic classification                       
 MicroView agreggates reports from taxonomic classification tools, such as      
 Kaiju and Kraken.                                                              
 You can provide either a path to results in the -t argument or, with -df, a    
 path to a 2-column CSV file, the first column sample paths and the second      
 containing group names or contrasts.                                           
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --version              Show the version and exit.                            │
│ --taxonomy  -t   PATH  Path to taxonomy classification results               │
│ --csv-file  -df  PATH  2-column CSV table (sample,group) with taxonomy       │
│                        classification results paths                          │
│ --output    -o   PATH  Report file name                                      │
│ --help      -h         Show this message and exit.                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```

