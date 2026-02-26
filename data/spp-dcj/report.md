# spp-dcj CWL Generation Report

## spp-dcj_heuristic

### Tool Description
heuristic

### Metadata
- **Docker Image**: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/codialab/spp-dcj
- **Package**: https://anaconda.org/channels/bioconda/packages/spp-dcj/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spp-dcj/overview
- **Total Downloads**: 295
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/codialab/spp-dcj
- **Stars**: N/A
### Original Help Text
```text
usage: spp-dcj heuristic [-h] [-t] [-l] [--family-bounds FAMILY_BOUNDS]
                         [--set-circ-sing-handling {adaptive,enumerate,barbershop}]
                         [-s SEPARATOR] [-a ALPHA]
                         [--def-telomere-weight DEF_TELOMERE_WEIGHT] [-b BETA]
                         tree candidateAdjacencies idmap

positional arguments:
  tree                  phylogenetic tree as child->parent relation table
                        (Important: children must be in first column.)
  candidateAdjacencies  candidate adjacencies of the genomes in the phylogeny
  idmap                 Id map file (output of the main script)

options:
  -h, --help            show this help message and exit
  -t, --no_telomeres    don't add any additional telomeres. Overrides -at.
  -l, --all_telomeres   Add additional telomeres to all nodes.
  --family-bounds, -fmb FAMILY_BOUNDS
  --set-circ-sing-handling {adaptive,enumerate,barbershop}
  -s, --separator SEPARATOR
                        Separator of in gene names to split <family ID> and
                        <uniquifying identifier> in adjacencies file
  -a, --alpha ALPHA     linear weighting factor for adjacency weights vs DCJ
                        indel distance (alpha = 1 => maximize only DCJ indel
                        distance)
  --def-telomere-weight, -w DEF_TELOMERE_WEIGHT
                        Default weight for added telomeres. Has no effect if
                        -t is used. For most use cases this should be <= 0.
  -b, --beta BETA       Backwards compatible beta parameter from v1. Telomeres
                        will be re-weighted and the ILP scaled to be
                        equivalent to v1.
```


## spp-dcj_ilp

### Tool Description
Solves the Double-Cut-and-Join problem using Integer Linear Programming.

### Metadata
- **Docker Image**: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/codialab/spp-dcj
- **Package**: https://anaconda.org/channels/bioconda/packages/spp-dcj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: spp-dcj ilp [-h] [-t] [-l] [-m OUTPUT_ID_MAPPING] [-a ALPHA] [-b BETA]
                   [--def-telomere-weight DEF_TELOMERE_WEIGHT]
                   [--set-circ-sing-handling {adaptive,enumerate,barbershop}]
                   [-s SEPARATOR] [-ws WARM_START_SOL]
                   [-plb PAIRWISE_LOWER_BNDS] [--family-bounds FAMILY_BOUNDS]
                   tree candidateAdjacencies

positional arguments:
  tree                  phylogenetic tree as child->parent relation table
                        (Important: children must be in first column.)
  candidateAdjacencies  candidate adjacencies of the genomes in the phylogeny

options:
  -h, --help            show this help message and exit
  -t, --no_telomeres    don't add any additional telomeres. Overrides -at.
  -l, --all_telomeres   Add additional telomeres to all nodes.
  -m, --output_id_mapping OUTPUT_ID_MAPPING
                        writs a table with ID-to-gene extremity mapping
  -a, --alpha ALPHA     linear weighting factor for adjacency weights vs DCJ
                        indel distance (alpha = 1 => maximize only DCJ indel
                        distance)
  -b, --beta BETA       Backwards compatible beta parameter from v1. Telomeres
                        will be re-weighted and the ILP scaled to be
                        equivalent to v1.
  --def-telomere-weight, -w DEF_TELOMERE_WEIGHT
                        Default weight for added telomeres. Has no effect if
                        -t is used. For most use cases this should be <= 0.
  --set-circ-sing-handling {adaptive,enumerate,barbershop}
  -s, --separator SEPARATOR
                        Separator of in gene names to split <family ID> and
                        <uniquifying identifier> in adjacencies file
  -ws, --warm-start-sol WARM_START_SOL
  -plb, --pairwise-lower-bnds PAIRWISE_LOWER_BNDS
  --family-bounds, -fmb FAMILY_BOUNDS
```


## spp-dcj_sol2adj

### Tool Description
Converts a GUROBI solution file to an adjacency list representation.

### Metadata
- **Docker Image**: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/codialab/spp-dcj
- **Package**: https://anaconda.org/channels/bioconda/packages/spp-dcj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: spp-dcj sol2adj [-h] sol_file id_to_extremity_map

positional arguments:
  sol_file             solution file of GUROBI optimizer
  id_to_extremity_map  mapping between node IDs and extremities

options:
  -h, --help           show this help message and exit
```


## spp-dcj_newick2table

### Tool Description
Converts a Newick tree to a table format.

### Metadata
- **Docker Image**: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/codialab/spp-dcj
- **Package**: https://anaconda.org/channels/bioconda/packages/spp-dcj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: spp-dcj newick2table [-h] tree

positional arguments:
  tree        tree in newick format

options:
  -h, --help  show this help message and exit
```


## spp-dcj_draw

### Tool Description
Draws candidate adjacencies of the genomes in the phylogeny.

### Metadata
- **Docker Image**: quay.io/biocontainers/spp-dcj:2.0.0--pyh7e72e81_0
- **Homepage**: https://github.com/codialab/spp-dcj
- **Package**: https://anaconda.org/channels/bioconda/packages/spp-dcj/overview
- **Validation**: PASS

### Original Help Text
```text
usage: spp-dcj draw [-h] [-i HIGHLIGHT] candidateAdjacencies

positional arguments:
  candidateAdjacencies  candidate adjacencies of the genomes in the phylogeny

options:
  -h, --help            show this help message and exit
  -i, --highlight HIGHLIGHT
                        highlight adjacencies in visualization
```

