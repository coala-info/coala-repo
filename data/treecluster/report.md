# treecluster CWL Generation Report

## treecluster_TreeCluster.py

### Tool Description
TreeCluster.py is a Python script for clustering phylogenetic trees.

### Metadata
- **Docker Image**: quay.io/biocontainers/treecluster:1.0.5--pyh7e72e81_0
- **Homepage**: https://github.com/niemasd/TreeCluster
- **Package**: https://anaconda.org/channels/bioconda/packages/treecluster/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/treecluster/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/niemasd/TreeCluster
- **Stars**: N/A
### Original Help Text
```text
usage: TreeCluster.py [-h] [-i INPUT] [-o OUTPUT] -t THRESHOLD [-s SUPPORT]
                      [-m METHOD] [-tf THRESHOLD_FREE] [-v] [--version]

options:
  -h, --help            show this help message and exit
  -i, --input INPUT     Input Tree File (default: stdin)
  -o, --output OUTPUT   Output File (default: stdout)
  -t, --threshold THRESHOLD
                        Length Threshold (default: None)
  -s, --support SUPPORT
                        Branch Support Threshold (default: -inf)
  -m, --method METHOD   Clustering Method (options: avg_clade, leaf_dist_avg,
                        leaf_dist_max, leaf_dist_min, length, length_clade,
                        max, max_clade, med_clade, root_dist, single_linkage,
                        single_linkage_cut, single_linkage_union, sum_branch,
                        sum_branch_clade) (default: max_clade)
  -tf, --threshold_free THRESHOLD_FREE
                        Threshold-Free Approach (options: argmax_clusters)
                        (default: None)
  -v, --verbose         Verbose Mode (default: False)
  --version             Display Version (default: False)
```

