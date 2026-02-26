# clusterone CWL Generation Report

## clusterone

### Tool Description
ClusterONE (Clustering with Overlapping Neighborhood Expansion) is a tool for detecting overlapping protein complexes or functional modules in protein-protein interaction networks.

### Metadata
- **Docker Image**: quay.io/biocontainers/clusterone:1.0--hdfd78af_0
- **Homepage**: https://paccanarolab.org/cluster-one/
- **Package**: https://anaconda.org/channels/bioconda/packages/clusterone/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/clusterone/overview
- **Total Downloads**: 4.9K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
ClusterONE 1.0

usage: cl1 [-d <arg>] [--debug] [-f] [-F <arg>] [--fluff | --no-fluff]
       [-h] [--haircut <arg>] [--k-core <arg>] [--max-overlap <arg>]
       [--merge-method <arg>]  [--no-merge] [--penalty <arg>] [-s <arg>]
       [--seed-method <arg>] [--similarity <arg>] [-v]
 -d,--min-density <arg>     specifies the minimum density of clusters
                            (default: auto)
    --debug                 turns on the debug mode
 -f,--input-format          specifies the format of the input file (sif or
                            edge_list)
 -F,--output-format <arg>   specifies the format of the output file
                            (plain, genepro or csv)
    --fluff                 fluffs the clusters
 -h,--help                  shows this help message
    --haircut <arg>         specifies the haircut threshold for clusters
    --k-core <arg>          specifies the minimum k-core index of clusters
    --max-overlap <arg>     specifies the maximum allowed overlap between
                            two clusters
    --merge-method <arg>    specifies the cluster merging method to use
                            (single or multi)
    --no-fluff              don't fluff the clusters (default)
    --no-merge              don't merge highly overlapping clusters
    --penalty <arg>         set the node penalty value
 -s,--min-size <arg>        specifies the minimum size of clusters
    --seed-method <arg>     specifies the seed generation method to use
    --similarity <arg>      specifies the similarity function to use
                            (match, simpson, jaccard or dice)
 -v,--version               shows the version number
```


## Metadata
- **Skill**: generated
