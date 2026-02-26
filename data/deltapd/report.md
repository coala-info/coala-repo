# deltapd CWL Generation Report

## deltapd

### Tool Description
Compares a query phylogenetic tree to a reference tree and identifies outlier taxa.

### Metadata
- **Docker Image**: quay.io/biocontainers/deltapd:0.1.5--py39h918f1d6_7
- **Homepage**: https://github.com/Ecogenomics/DeltaPD
- **Package**: https://anaconda.org/channels/bioconda/packages/deltapd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/deltapd/overview
- **Total Downloads**: 10.6K
- **Last updated**: 2025-06-24
- **GitHub**: https://github.com/Ecogenomics/DeltaPD
- **Stars**: N/A
### Original Help Text
```text
Usage: deltapd [-h] [--r_tree R_TREE] [--q_tree Q_TREE] [--metadata METADATA]
               [--msa_file MSA_FILE] [--out_dir OUT_DIR] [--max_taxa MAX_TAXA]
               [--qry_sep QRY_SEP] [--influence_thresh INFLUENCE_THRESH]
               [--diff_thresh DIFF_THRESH] [--k K] [--plot]
               [--ete3_scale ETE3_SCALE] [--cpus CPUS] [--debug]

optional arguments:
  -h, --help            show this help message and exit

I/O arguments (required):
  --r_tree R_TREE       path to the reference tree
  --q_tree Q_TREE       path to the query tree
  --metadata METADATA   path to the metadata file
  --msa_file MSA_FILE   path to the msa file used to infer the query tree
  --out_dir OUT_DIR     path to output directory

Query tree arguments (optional):
  --max_taxa MAX_TAXA   if a ref taxon represents more than this number of qry
                        taxa, ignore it
  --qry_sep QRY_SEP     query taxon separator in query tree, e.g.
                        taxon___geneid

Outlier arguments (optional):
  --influence_thresh INFLUENCE_THRESH
                        outlier influence threshold value [0,inf)
  --diff_thresh DIFF_THRESH
                        minimum change to base model to be considered an
                        outlier
  --k K                 consider the query taxa represented by the ``k``
                        nearest neighbours for each representative taxon

Plotting arguments (optional):
  --plot                generate outlier plots (slow)
  --ete3_scale ETE3_SCALE
                        pixels per branch length unit

Program arguments (optional):
  --cpus CPUS           number of CPUs to use
  --debug               output debugging information
```


## Metadata
- **Skill**: generated
