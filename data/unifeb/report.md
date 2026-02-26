# unifeb CWL Generation Report

## unifeb_hnsw

### Tool Description
Build HNSW/HubNSW graph

### Metadata
- **Docker Image**: quay.io/biocontainers/unifeb:0.1.1--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/unifeb.git
- **Package**: https://anaconda.org/channels/bioconda/packages/unifeb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/unifeb/overview
- **Total Downloads**: 469
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jianshu93/unifeb
- **Stars**: N/A
### Original Help Text
```text
************** initializing logger *****************

Build HNSW/HubNSW graph

Usage: unifeb --tree <tree> --feature-table <featuretable> hnsw [OPTIONS] --nbconn <nbconn> --knbn <knbn> --ef <ef>

Options:
      --nbconn <nbconn>                Number of neighbours by layer
      --knbn <knbn>                    Number of neighbours to keep in final adjacency
      --ef <ef>                        Search factor for HNSW construction
      --scale_modify_f <scale_modify>  scale modification factor in HNSW or HubNSW, must be in [0.2,1] [default: 0.25]
  -h, --help                           Print help
```

