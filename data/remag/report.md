# remag CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| remag | Failed | tool bug: remag 0.3.4 crashes in the main binning flow with TypeError (check_core_gene_duplications got an unexpected keyword use_header_cache); the CWL was rewritten from the help and the command line is accepted |

## remag

### Tool Description
No description available

### Metadata
- **Docker Image**: quay.io/biocontainers/remag:0.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/danielzmbp/remag
- **Package**: https://anaconda.org/channels/bioconda/packages/remag/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/remag/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2025-12-13
- **GitHub**: https://github.com/danielzmbp/remag
- **Stars**: N/A
### Original Help Text
```text
Usage: remag [OPTIONS] [FASTA_ARG]                                             
                                                                                
 Try running the '--help' flag for more information.                            
╭─ Error ──────────────────────────────────────────────────────────────────────╮
│ No such option: -e                                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```

