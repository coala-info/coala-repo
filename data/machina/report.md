# machina CWL Generation Report

## machina_cluster

### Tool Description
Cluster mutations based on their co-occurrence patterns.

### Metadata
- **Docker Image**: quay.io/biocontainers/machina:1.2--h21ec9f0_7
- **Homepage**: https://github.com/raphael-group/machina
- **Package**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/raphael-group/machina
- **Stars**: N/A
### Original Help Text
```text
Usage:
  cluster [--help|-h|-help] [-A] [-C str] [-FWR num] [-a num] [-b num] [-r]
     [-varLB int] R
Where:
  R
     Read matrix
  --help|-h|-help
     Print a short help message
  -A
     Output AncesTree input file
  -C str
     Clustering input filename
  -FWR num
     Family-wise error rate
  -a num
     Confidence interval used for clustering (default: 0.001)
  -b num
     Confidence interval used for pooled frequency matrix (default: 0.01)
  -r
     Relabel mutation clusters
  -varLB int
     Minimum number of variant reads (default: 3)
```


## machina_generatemigrationtrees

### Tool Description
Generates migration trees for anatomical sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/machina:1.2--h21ec9f0_7
- **Homepage**: https://github.com/raphael-group/machina
- **Package**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: generatemigrationtrees <ANATOMICAL_SITES>
```


## machina_pmh_sankoff

### Tool Description
Performs the Sankoff algorithm on a phylogenetic tree with leaf labelings.

### Metadata
- **Docker Image**: quay.io/biocontainers/machina:1.2--h21ec9f0_7
- **Homepage**: https://github.com/raphael-group/machina
- **Package**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  pmh_sankoff [--help|-h|-help] [-c str] [-o str] [-p str] T leaf_labeling
Where:
  T
     Clone tree
  leaf_labeling
     Leaf labeling
  --help|-h|-help
     Print a short help message
  -c str
     Color map file
  -o str
     Output prefix
  -p str
     Primary anatomical sites separated by commas (if omitted, every
     anatomical site will be considered iteratively as the primary)
```


## machina_pmh

### Tool Description
Machina PMH tool for phylogenetic analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/machina:1.2--h21ec9f0_7
- **Homepage**: https://github.com/raphael-group/machina
- **Package**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  pmh [--help|-h|-help] [-G str] [-OLD] [-UB_gamma int] [-UB_mu int]
     [-UB_sigma int] -c str [-e] [-g] [-l int] [-log] [-m str] [-o str]
     -p str [-t int] T leaf_labeling
Where:
  T
     Clone tree
  leaf_labeling
     Leaf labeling
  --help|-h|-help
     Print a short help message
  -G str
     Optional file with migration graphs
  -OLD
     Use old ILP (typically much slower)
  -UB_gamma int
     Upper bound on the comigration number (default: -1, disabled)
  -UB_mu int
     Upper bound on the migration number (default: -1, disabled)
  -UB_sigma int
     Upper bound on the seeding site number (default: -1, disabled)
  -c str
     Color map file
  -e
     Export ILP
  -g
     Output search graph
  -l int
     Time limit in seconds (default: -1, no time limit)
  -log
     Gurobi logging
  -m str
     Allowed migration patterns:
       0 : PS
       1 : PS, S
       2 : PS, S, M
       3 : PS, S, M, R
     If no pattern is specified, all allowed patterns will be enumerated.
  -o str
     Output prefix
  -p str
     Primary anatomical site
  -t int
     Number of threads (default: -1, #cores)
```


## machina_pmh_tr

### Tool Description
Parses a clone tree and leaf labeling to infer evolutionary scenarios.

### Metadata
- **Docker Image**: quay.io/biocontainers/machina:1.2--h21ec9f0_7
- **Homepage**: https://github.com/raphael-group/machina
- **Package**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  pmh_tr [--help|-h|-help] [-G str] [-OLD] [-UB_gamma int] [-UB_mu int]
     [-UB_sigma int] -c str [-e] [-g] [-l int] [-log] [-m str] [-o str]
     -p str [-t int] T leaf_labeling
Where:
  T
     Clone tree
  leaf_labeling
     Leaf labeling
  --help|-h|-help
     Print a short help message
  -G str
     Optional file with migration graphs
  -OLD
     Use old ILP (typically much slower)
  -UB_gamma int
     Upper bound on the comigration number (default: -1, disabled)
  -UB_mu int
     Upper bound on the migration number (default: -1, disabled)
  -UB_sigma int
     Upper bound on the seeding site number (default: -1, disabled)
  -c str
     Color map file
  -e
     Export ILP
  -g
     Output search graph
  -l int
     Time limit in seconds (default: -1, no time limit)
  -log
     Gurobi logging
  -m str
     Allowed migration patterns:
       0 : PS
       1 : PS, S
       2 : PS, S, M
       3 : PS, S, M, R
     If no pattern is specified, all allowed patterns will be
     enumerated (default: '0,1,2,3')
  -o str
     Output prefix
  -p str
     Primary anatomical site
  -t int
     Number of threads (default: -1, #cores)
```


## machina_pmh_ti

### Tool Description
Parses mutation trees and migration graphs to infer phylogenetic relationships.

### Metadata
- **Docker Image**: quay.io/biocontainers/machina:1.2--h21ec9f0_7
- **Homepage**: https://github.com/raphael-group/machina
- **Package**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  pmh_ti [--help|-h|-help] -F str [-G str] [-N int] [-OLD] [-UB_gamma int]
     [-UB_mu int] [-UB_sigma int] -barT str -c str [-e] [-g] [-l int] [-log]
     [-m str] [-mutTreeIdx int] [-noPR] [-o str] -p str [-s int] [-t int]
     [-useBounds]
Where:
  --help|-h|-help
     Print a short help message
  -F str
     Frequencies file
  -G str
     Optional file with migration graphs
  -N int
     Number of mutation trees to consider (default: -1, all)
  -OLD
     Use old ILP (typically much slower)
  -UB_gamma int
     Upper bound on the comigration number (default: -1, disabled)
  -UB_mu int
     Upper bound on the migration number (default: -1, disabled)
  -UB_sigma int
     Upper bound on the seeding site number (default: -1, disabled)
  -barT str
     Mutation trees
  -c str
     Color map file
  -e
     Export ILP
  -g
     Output search graph
  -l int
     Time limit in seconds for the ILP (default: -1, unlimited)
  -log
     Gurobi logging
  -m str
     Allowed migration patterns:
       0 : PS
       1 : PS, S
       2 : PS, S, M
       3 : PS, S, M, R
     If no pattern is specified, all allowed patterns will be
     enumerated (default: '0,1,2,3')
  -mutTreeIdx int
     Mutation tree index (default: -1)
  -noPR
     Disable polytomy resolution
  -o str
     Output prefix
  -p str
     Primary anatomical site
  -s int
     Random number generator seed (default: 0)
  -t int
     Number of threads (default: -1, #cores)
  -useBounds
     Only retain optimal solution
```


## machina_visualizeclonetree

### Tool Description
Visualize a clone tree with optional leaf and vertex labeling, and custom color maps.

### Metadata
- **Docker Image**: quay.io/biocontainers/machina:1.2--h21ec9f0_7
- **Homepage**: https://github.com/raphael-group/machina
- **Package**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  visualizeclonetree [--help|-h|-help] [-c str] [-l str] T leaf_labeling
Where:
  T
     Clone tree
  leaf_labeling
     Leaf labeling
  --help|-h|-help
     Print a short help message
  -c str
     Color map file
  -l str
     Vertex labeling
```


## machina_visualizemigrationgraph

### Tool Description
Visualize the migration graph of a clone tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/machina:1.2--h21ec9f0_7
- **Homepage**: https://github.com/raphael-group/machina
- **Package**: https://anaconda.org/channels/bioconda/packages/machina/overview
- **Validation**: PASS

### Original Help Text
```text
Usage:
  visualizemigrationgraph [--help|-h|-help] [-c str] T leaf_labeling
     vertex_labeling
Where:
  T
     Clone tree
  leaf_labeling
     Leaf labeling
  vertex_labeling
     Vertex labeling
  --help|-h|-help
     Print a short help message
  -c str
     Color map file
```


## Metadata
- **Skill**: generated
