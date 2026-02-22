# annembed CWL Generation Report

## annembed_hnsw

### Tool Description
Build HNSW graph

### Metadata
- **Docker Image**: quay.io/biocontainers/annembed:0.2.6--h3dc2dae_0
- **Homepage**: https://github.com/jean-pierreBoth/gsearch
- **Package**: https://anaconda.org/channels/bioconda/packages/annembed/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/annembed/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-10-06
- **GitHub**: https://github.com/jean-pierreBoth/gsearch
- **Stars**: 57
### Original Help Text
```text
Build HNSW graph

Usage: annembed --csv <csvfile> hnsw [OPTIONS] --dist <dist> --nbconn <nbconn> --ef <ef> --knbn <knbn>

Options:
  -d, --dist <dist>                    Distance type is required, must be one of   "DistL1" , "DistL2", "DistCosine" and "DistJeyffreys"  
      --nbconn <nbconn>                Maximum number of build connections allowed (M in HNSW)
      --ef <ef>                        Build factor ef_construct in HNSW
      --scale_modify_f <scale_modify>  Hierarchy scale modification factor in HNSW, must be in [0.2,1] [default: 1.0]
      --knbn <knbn>                    Number of k-nearest neighbours to be retrieved for embedding
  -h, --help                           Print help
```


## Metadata
- **Skill**: generated
