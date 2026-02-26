# arborist CWL Generation Report

## arborist

### Tool Description
Arborist: a method to rank SNV clonal trees using scDNA-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/arborist:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/VanLoo-lab/Arborist
- **Package**: https://anaconda.org/channels/bioconda/packages/arborist/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/arborist/overview
- **Total Downloads**: 54
- **Last updated**: 2025-12-04
- **GitHub**: https://github.com/VanLoo-lab/Arborist
- **Stars**: N/A
### Original Help Text
```text
usage: arborist [-h] -R READ_COUNTS -Y SNV_CLUSTERS -T TREES
                [--edge-delim EDGE_DELIM] [--add-normal] [--alpha ALPHA]
                [--max-iter MAX_ITER] [--prior PRIOR] [--pickle PICKLE]
                [-d DRAW] [-t TREE] [--ranking RANKING]
                [--cell-assign CELL_ASSIGN] [--snv-assign SNV_ASSIGN]
                [--q_y Q_Y] [--q_z Q_Z] [-j THREADS] [-v]

Arborist: a method to rank SNV clonal trees using scDNA-seq data.

options:
  -h, --help            show this help message and exit
  -R, --read_counts READ_COUNTS
                        Path to read counts CSV file with columns 'snv',
                        'cell', 'total', 'alt'
  -Y, --snv-clusters SNV_CLUSTERS
                        Path to SNV clusters CSV file with unlabeled columns
                        'snv', 'cluster'. The order of columns matters
  -T, --trees TREES     Path to file containing all candidate trees to be
                        ranked.
  --edge-delim EDGE_DELIM
                        edge delimiter in candidate tree file.
  --add-normal          flag to add a normal clone if input trees do not
                        already contain them
  --alpha ALPHA         Per base sequencing error
  --max-iter MAX_ITER   max number of iterations
  --prior PRIOR         prior (gamma) on input SNV cluster assignment
  --pickle PICKLE       path to where all pickled tree fits should be saved.
  -d, --draw DRAW       Path to where the tree visualization should be saved
  -t, --tree TREE       Path to save the top ranked tree as a txt file.
  --ranking RANKING     Path to where tree ranking output should be saved
  --cell-assign CELL_ASSIGN
                        Path to where the MAP cell-to-clone labels should be
                        saved
  --snv-assign SNV_ASSIGN
                        Path to where the MAP SNV-to-cluster labels should be
                        saved.
  --q_y Q_Y             Path to where the approximate SNV posterior should be
                        saved
  --q_z Q_Z             Path to where the approximate cell posterior should be
                        saved
  -j, --threads THREADS
                        Number of threads to use
  -v, --verbose         Print verbose output
```

