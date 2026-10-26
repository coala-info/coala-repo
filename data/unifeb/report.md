# unifeb CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| unifeb | PASS | new CWL for the default mode without subcommand |
| unifeb_hnsw | PASS | fixed: global options now come before the hnsw subcommand; added all global options |

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

## unifeb

### Tool Description
UniFrac Embedding via Approxiamte Nearest Neighbor Graph.

### Metadata
- **Docker Image**: quay.io/biocontainers/unifeb:0.1.1--h3ab6199_0
- **Homepage**: https://github.com/jianshu93/unifeb
- **Package**: https://anaconda.org/channels/bioconda/packages/unifeb/overview
- **Validation**: PASS

### Original Help Text
```text

 ************** initializing logger *****************

UniFrac Embedding via Approxiamte Nearest Neighbor Graph

Usage: unifeb [OPTIONS] --tree <tree> --feature-table <featuretable> [COMMAND]

Commands:
  hnsw  Build HNSW/HubNSW graph
  help  Print this message or the help of the given subcommand(s)

Options:
  -t, --tree <tree>                   Newick tree filename
  -f, --feature-table <featuretable>  Feature table with rows=features, columns=samples
      --weighted                      Use Weighted UniFrac (otherwise unweighted)
  -o, --out <outfile>                 Output CSV file for embedded results [default: embedded.csv]
      --batch <batch>                 Number of gradient batches [default: 20]
      --nbsample <nbsample>           Number of edge samplings per batch [default: 10]
  -l, --layer <hierarchy>             If >0, use hierarchical approach in embedding [default: 0]
      --scale <scale>                 Rho scale factor for the gradient descent [default: 1.0]
  -d, --dim <dimension>               Dimension of embedding [default: 2]
  -q, --quality <quality>             Sampling fraction for quality estimation, <=1.0
  -h, --help                          Print help
  -V, --version                       Print version
```

