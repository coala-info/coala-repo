# phylorank CWL Generation Report

## phylorank_outliers

### Tool Description
Create information for identifying taxonomic outliers

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Total Downloads**: 28.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dparks1134/PhyloRank
- **Stars**: N/A
### Original Help Text
```text
usage: phylorank outliers [-h] [--viral] [--fixed_root] [-t TRUSTED_TAXA_FILE]
                          [-m MIN_CHILDREN] [-s MIN_SUPPORT]
                          [--fmeasure_table FMEASURE_TABLE]
                          [--min_fmeasure MIN_FMEASURE]
                          [--fmeasure_mono FMEASURE_MONO]
                          [--highlight_polyphyly] [--mblet]
                          [-p PLOT_TAXA_FILE] [--plot_domain]
                          [--plot_dist_taxa_only]
                          [--highlight_taxa_file HIGHLIGHT_TAXA_FILE]
                          [--dpi DPI] [--verbose_table] [--skip_mpld3]
                          input_tree taxonomy_file output_dir

Create information for identifying taxonomic outliers

positional arguments:
  input_tree            decorated tree for inferring RED outliers
  taxonomy_file         taxonomy file for inferring RED outliers
  output_dir            desired output directory for generated files

options:
  -h, --help            show this help message and exit
  --viral               indicates a viral input tree and taxonomy
  --fixed_root          use single fixed root to infer outliers
  -t, --trusted_taxa_file TRUSTED_TAXA_FILE
                        file indicating trusted taxonomic groups to use for
                        inferring distribution (default: all taxa)
  -m, --min_children MIN_CHILDREN
                        minimum required child taxa to consider taxa when
                        inferring distribution (default: 2)
  -s, --min_support MIN_SUPPORT
                        minimum support value to consider taxa when inferring
                        distribution (default: 0) (default: 0.0)
  --fmeasure_table FMEASURE_TABLE
                        table indicating F-measure score for each taxa
  --min_fmeasure MIN_FMEASURE
                        minimum F-measure to consider taxa when inferring
                        distribution (default: 0.95)
  --fmeasure_mono FMEASURE_MONO
                        minimum F-measure to consider taxa monophyletic
                        (default: 0.95)
  --highlight_polyphyly
                        highlight taxa with an F-measure less than
                        --fmeasure_mono
  --mblet               calculate 'mean branch length to extent taxa' instead
                        of 'relative evolutionary distances'
  -p, --plot_taxa_file PLOT_TAXA_FILE
                        file indicating taxonomic groups to plot (default: all
                        taxa)
  --plot_domain         show domain rank in plot
  --plot_dist_taxa_only
                        only plot taxa used to infer distribution
  --highlight_taxa_file HIGHLIGHT_TAXA_FILE
                        file indicating taxa to highlight
  --dpi DPI             DPI of plots (default: 96)
  --verbose_table       add additional columns to output table
  --skip_mpld3          skip plots requiring mpld3
```


## phylorank_scale_tree

### Tool Description
Scale a phylogenetic tree using phylorank

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Matplotlib created a temporary config/cache directory at /tmp/matplotlib-eluwrt9h because the default path (/user/qianghu/.cache/matplotlib) is not a writable directory; it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
usage: phylorank scale_tree [-h] input_tree output_tree
phylorank scale_tree: error: the following arguments are required: input_tree, output_tree
```


## phylorank_compare_red

### Tool Description
Compare RED (Relative Evolutionary Divergence) tables and dictionaries.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Matplotlib created a temporary config/cache directory at /tmp/matplotlib-olq3mykt because the default path (/user/qianghu/.cache/matplotlib) is not a writable directory; it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
usage: phylorank compare_red [-h] [--viral]
                             red_table1 red_table2 red_dict2 output_table
phylorank compare_red: error: the following arguments are required: red_table1, red_table2, red_dict2, output_table
```


## phylorank_mark_tree

### Tool Description
Mark nodes with distribution information and predicted taxonomic ranks.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylorank mark_tree [-h] [-t THRESHOLDS] [-s MIN_SUPPORT] [-n]
                           [-l MIN_LENGTH] [--no_percentile]
                           [--no_relative_divergence] [--no_prediction]
                           input_tree output_tree

Mark nodes with distribution information and predicted taxonomic ranks.

positional arguments:
  input_tree            input tree to mark
  output_tree           output tree with assigned taxonomic ranks

options:
  -h, --help            show this help message and exit
  -t, --thresholds THRESHOLDS
                        relative divergence thresholds for taxonomic ranks
                        (default: {"d": 0.33, "p": 0.56, "c": 0.65, "o": 0.78,
                        "f": 0.92, "g": 0.99})
  -s, --min_support MIN_SUPPORT
                        only mark nodes above the specified support value
                        (default=0) (default: 0)
  -n, --only_named_clades
                        only mark nodes with an existing label
  -l, --min_length MIN_LENGTH
                        only mark nodes with a parent branch above the
                        specified length (default=0) (default: 0.0)
  --no_percentile       do not mark with percentile information
  --no_relative_divergence
                        do not mark with relative divergence information
  --no_prediction       do not mark with predicted rank information
```


## phylorank_rogue_test

### Tool Description
Perform rogue taxon testing within the phylorank suite.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Matplotlib created a temporary config/cache directory at /tmp/matplotlib-r72osup_ because the default path (/user/qianghu/.cache/matplotlib) is not a writable directory; it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
usage: phylorank rogue_test [-h] [--outgroup_taxon OUTGROUP_TAXON]
                            [--decorate]
                            input_tree_dir taxonomy_file output_dir
phylorank rogue_test: error: the following arguments are required: input_tree_dir, taxonomy_file, output_dir
```


## phylorank_decorate

### Tool Description
Place internal taxonomic labels on tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylorank decorate [-h] [--viral] [--skip_species] [--skip_rd_refine]
                          [--gtdb_metadata GTDB_METADATA]
                          [-t TRUSTED_TAXA_FILE] [-m MIN_CHILDREN]
                          [-s MIN_SUPPORT]
                          input_tree taxonomy_file output_tree

Place internal taxonomic labels on tree.

positional arguments:
  input_tree            tree to decorate
  taxonomy_file         file indicating taxonomy of extant taxa
  output_tree           decorated tree

options:
  -h, --help            show this help message and exit
  --viral               indicates a viral input tree and taxonomy
  --skip_species        skip decoration of species
  --skip_rd_refine      skip refinement of taxonomy based on relative
                        divergence information
  --gtdb_metadata GTDB_METADATA
                        GTDB metadata file (used to resolve ambiguous cases)
  -t, --trusted_taxa_file TRUSTED_TAXA_FILE
                        file indicating trusted taxonomic groups to use for
                        inferring distribution (default: all taxa)
  -m, --min_children MIN_CHILDREN
                        minimum required child taxa to consider taxa when
                        inferring distribution (default: 2)
  -s, --min_support MIN_SUPPORT
                        minimum support value to consider taxa when inferring
                        distribution (default: 0) (default: 0.0)
```


## phylorank_taxon_stats

### Tool Description
Calculate taxon statistics based on a taxonomy file.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Matplotlib created a temporary config/cache directory at /tmp/matplotlib-ufi2z_ik because the default path (/user/qianghu/.cache/matplotlib) is not a writable directory; it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
usage: phylorank taxon_stats [-h] taxonomy_file output_file
phylorank taxon_stats: error: the following arguments are required: taxonomy_file, output_file
```


## phylorank_rank_res

### Tool Description
Calculate rank results based on an input tree and taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Matplotlib created a temporary config/cache directory at /tmp/matplotlib-ozcq4c8_ because the default path (/user/qianghu/.cache/matplotlib) is not a writable directory; it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
usage: phylorank rank_res [-h] [--taxa_file TAXA_FILE]
                          input_tree taxonomy_file output_file
phylorank rank_res: error: the following arguments are required: input_tree, taxonomy_file, output_file
```


## phylorank_bl_dist

### Tool Description
Calculate distribution of branch lengths at each taxonomic rank.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylorank bl_dist [-h] [-t TRUSTED_TAXA_FILE] [-m MIN_CHILDREN]
                         [--taxonomy_file TAXONOMY_FILE]
                         input_tree output_dir

Calculate distribution of branch lengths at each taxonomic rank.

positional arguments:
  input_tree            input tree to calculate branch length distributions
  output_dir            desired output directory for generated files

options:
  -h, --help            show this help message and exit
  -t, --trusted_taxa_file TRUSTED_TAXA_FILE
                        file indicating trusted taxonomic groups to use for
                        inferring distribution (default: all taxa)
  -m, --min_children MIN_CHILDREN
                        minimum required child taxa to consider taxa when
                        inferring distribution (default: 2)
  --taxonomy_file TAXONOMY_FILE
                        read taxonomy from this file instead of directly from
                        tree
```


## phylorank_bl_optimal

### Tool Description
Determine branch length for best congruency with existing taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylorank bl_optimal [-h] [--min_dist MIN_DIST] [--max_dist MAX_DIST]
                            [--step_size STEP_SIZE]
                            input_tree {1,2,3,4,5,6} output_table

Determine branch length for best congruency with existing taxonomy.

positional arguments:
  input_tree            input tree to calculate branch length distributions
  {1,2,3,4,5,6}         rank of labels
  output_table          desired named of output table

options:
  -h, --help            show this help message and exit
  --min_dist MIN_DIST   minimum mean branch length value to evaluate (default:
                        0.5)
  --max_dist MAX_DIST   maximum mean branch length value to evaluate (default:
                        1.2)
  --step_size STEP_SIZE
                        step size of mean branch length values (default:
                        0.025)
```


## phylorank_bl_decorate

### Tool Description
Decorate tree using a mean branch length criterion.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
usage: phylorank bl_decorate [-h] [--retain_named_lineages] [--keep_labels]
                             [--prune]
                             input_tree taxonomy_file threshold {1,2,3,4,5,6}
                             output_tree

Decorate tree using a mean branch length criterion.

positional arguments:
  input_tree            input tree to decorate
  taxonomy_file         file with taxonomic information for each taxon
  threshold             mean branch length threshold
  {1,2,3,4,5,6}         rank of labels
  output_tree           decorate tree

options:
  -h, --help            show this help message and exit
  --retain_named_lineages
                        retain existing named lineages at the specified rank
  --keep_labels         keep all existing internal labels
  --prune               prune tree to preserve only the shallowest and deepest
                        taxa in each child lineage from newly decorated nodes
```


## phylorank_bl_table

### Tool Description
Generate a branch length table for a given input tree and taxon category.

### Metadata
- **Docker Image**: quay.io/biocontainers/phylorank:0.1.12--pyhdfd78af_0
- **Homepage**: https://github.com/dparks1134/PhyloRank
- **Package**: https://anaconda.org/channels/bioconda/packages/phylorank/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Matplotlib created a temporary config/cache directory at /tmp/matplotlib-kj6n93em because the default path (/user/qianghu/.cache/matplotlib) is not a writable directory; it is highly recommended to set the MPLCONFIGDIR environment variable to a writable directory, in particular to speed up the import of Matplotlib and to better support multiprocessing.
usage: phylorank bl_table [-h] [--step_size STEP_SIZE]
                          input_tree taxon_category output_table
phylorank bl_table: error: the following arguments are required: input_tree, taxon_category, output_table
```


## Metadata
- **Skill**: generated
