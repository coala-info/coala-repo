# kegg-pathways-completeness CWL Generation Report

## kegg-pathways-completeness_give_completeness

### Tool Description
Script generates modules pathways completeness by given set of KOs

### Metadata
- **Docker Image**: quay.io/biocontainers/kegg-pathways-completeness:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool
- **Package**: https://anaconda.org/channels/bioconda/packages/kegg-pathways-completeness/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kegg-pathways-completeness/overview
- **Total Downloads**: 4.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool
- **Stars**: N/A
### Original Help Text
```text
usage: give_completeness [-h] [--version] (-i INPUT_FILE | -l INPUT_LIST |
                         -s LIST_SEPARATOR) [-g GRAPHS] [-a DEFINITIONS]
                         [-n NAMES] [-c CLASSES] [-o OUTDIR] [-r OUTPREFIX]
                         [-w] [-p] [-m] [-v]

Script generates modules pathways completeness by given set of KOs

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i, --input INPUT_FILE
                        Each line = pathway
  -l, --input-list INPUT_LIST
                        File with KOs comma separated
  -s, --list-separator LIST_SEPARATOR
                        Separator for list option (default: comma)
  -g, --graphs GRAPHS   graphs in pickle format
  -a, --definitions DEFINITIONS
                        All modules definitions
  -n, --names NAMES     Modules names
  -c, --classes CLASSES
                        Modules classes
  -o, --outdir OUTDIR   output directory
  -r, --outprefix OUTPREFIX
                        prefix for output filename
  -w, --include-weights
                        add weights for each KO in output
  -p, --plot-pathways   Create images with pathways completeness
  -m, --add-per-contig  Creates per-contig summary table (makes sense to use
                        if input table has information about contigs). Does
                        not work with --input-list option
  -v, --verbose         Print more logging
```


## kegg-pathways-completeness_plot_modules_graphs

### Tool Description
Script generates plots for each contig

### Metadata
- **Docker Image**: quay.io/biocontainers/kegg-pathways-completeness:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/EBI-Metagenomics/kegg-pathways-completeness-tool
- **Package**: https://anaconda.org/channels/bioconda/packages/kegg-pathways-completeness/overview
- **Validation**: PASS

### Original Help Text
```text
usage: plot_modules_graphs [-h] [--version] [-i INPUT_COMPLETENESS]
                           [-m INPUT_MODULES_LIST [INPUT_MODULES_LIST ...] |
                           -l INPUT_MODULES_FILE | -s LIST_SEPARATOR]
                           [-g GRAPHS] [-d PATHWAYS] [-o OUTDIR] [--use-pydot]

Script generates plots for each contig

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  -i, --input-completeness INPUT_COMPLETENESS
                        Output table from give_completeness.py
  -m, --modules INPUT_MODULES_LIST [INPUT_MODULES_LIST ...]
                        Space separated list of modules accessions
  -l, --modules-file INPUT_MODULES_FILE
                        File containing modules accessions
  -s, --file-separator LIST_SEPARATOR
                        Modules separator in file
  -g, --graphs GRAPHS   graphs in pickle format
  -d, --definitions PATHWAYS
                        Pathways of kos
  -o, --outdir OUTDIR   Path to output directory
  --use-pydot           Use pydot instead of graphviz
```

