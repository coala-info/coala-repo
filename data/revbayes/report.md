# revbayes CWL Generation Report

## revbayes_rb

### Tool Description
Bayesian phylogenetic inference using probabilistic graphical models and an interpreted language

### Metadata
- **Docker Image**: quay.io/biocontainers/revbayes:1.3.2--hf316886_0
- **Homepage**: https://revbayes.github.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/revbayes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/revbayes/overview
- **Total Downloads**: 10.4K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/revbayes/revbayes
- **Stars**: N/A
### Original Help Text
```text
Bayesian phylogenetic inference using probabilistic graphical models and an 
interpreted language 

Usage: rb [options]
       rb [options] file [args]
       rb [options] -e expr [-e expr2 ...] [args]

OPTIONS:
  -h,      --help                  Print this help message and exit 
  -v,      --version               Show version and exit 
  -j,      --jupyter               Run in jupyter mode 
  -q,      --quiet                 Hide startup message (if no file or -e expr) 
  -i,      --interactive           Force interactive (with file or -e expr) 
  -c,      --continue              Continue after error (with file or -e expr) 
  -s,      --seed UINT             Random seed (unsigned integer) 
  -o,      --setOption TEXT ...    Set an option key=value (See ?setOption for 
                                   the list of available keys and their 
                                   associated values) 

Expressions (one or more '-e <expr>') may be used *instead* of 'file'. 
See http://revbayes.github.io for more information.
```

